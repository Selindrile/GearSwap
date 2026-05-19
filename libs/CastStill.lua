------------------------------------------------------------
-- CastStill.lua — GearSwap include file
-- Author: Broguypal
-- Version: 1.1
------------------------------------------------------------
-- CastStill is a GearSwap-side movement gate that hooks precast and monitors
-- outgoing 0x15 position packets to determine when the server knows the player
-- has stopped moving. When a cast is initiated during or shortly after movement,
-- the library suppresses the action and re-sends it once two consecutive 0x15
-- packets confirm the same position, eliminating false movement interruptions.
------------------------------------------------------------
-- SETUP:
--   1. Place in 'addons/GearSwap/libs/' or 'addons/GearSwap/data/'
--   2. Add to your job lua: include('CastStill.lua')

------------------------------------------------------------
-- Config
------------------------------------------------------------
caststill = caststill or {}
caststill.recent_window = caststill.recent_window or 1.25
caststill.stop_window   = caststill.stop_window   or 0.35

------------------------------------------------------------
-- Internal state
------------------------------------------------------------
local cs = {
    -- 0x15 tracking
    last_reported    = nil, 
    prev_reported    = nil,   
    last_report_time = 0,
    last_move_time   = -999, 
    is_settled       = true, 

    -- Gate state
    pending_cmd      = nil,
    pending_time     = 0,
    bypass_until     = 0,

    -- Hook state
    hooked           = false,
}

------------------------------------------------------------
-- Helpers
------------------------------------------------------------
local function get_pos()
    local info = windower.ffxi.get_info()
    if not info or not info.logged_in or info.loading then return nil end
    local p = windower.ffxi.get_player()
    if not p then return nil end
    local me = windower.ffxi.get_mob_by_index(p.index)
    if me and me.x and me.y then
        return { x = me.x, y = me.y }
    end
    return nil
end

local function same_pos(p1, p2)
    if not p1 or not p2 then return false end
    return p1.x == p2.x and p1.y == p2.y
end

local function recently_moving()
    return (os.clock() - cs.last_move_time) <= caststill.recent_window
end

local function server_knows_pos()
    if not cs.last_reported then return false end
    local pos = get_pos()
    return same_pos(pos, cs.last_reported)
end

local function fire_pending()
    cs.bypass_until = os.clock() + 0.50
    local cmd = cs.pending_cmd
    cs.pending_cmd = nil
    windower.send_command('input ' .. cmd)
end

------------------------------------------------------------
-- Outgoing 0x15 hook 
------------------------------------------------------------
windower.raw_register_event('outgoing chunk', function(id, data)
    if id ~= 0x015 then return end

    local now = os.clock()
    local x = data:unpack('f', 5)
    local y = data:unpack('f', 13)

    local new_pos = { x = x, y = y }

    if cs.last_reported then
        if same_pos(cs.last_reported, new_pos) then
            cs.is_settled = true
        else
            cs.last_move_time = now
            cs.is_settled = false
        end
    end

    cs.prev_reported    = cs.last_reported
    cs.last_reported    = new_pos
    cs.last_report_time = now
end)

------------------------------------------------------------
-- Spell prefixes interrupted by movement
------------------------------------------------------------
local gated_prefixes = {
    ['/magic']    = true,
    ['/ninjutsu'] = true,
    ['/song']     = true,
    ['/trust']    = true,
    ['/item']     = true,
    ['/range']    = true,
}

------------------------------------------------------------
-- The gate check — called from precast wrapper
------------------------------------------------------------
local function caststill_check(spell)
    if os.clock() < cs.bypass_until then
        return false
    end

    if not gated_prefixes[spell.prefix] then
        return false
    end

    if not recently_moving() or cs.is_settled then
        return false
    end

    if cs.pending_cmd then
        return true
    end

    if spell.prefix == '/range' then
        cs.pending_cmd = spell.prefix .. ' ' .. spell.target.raw
    else
        cs.pending_cmd = spell.prefix .. ' "' .. spell.name .. '" ' .. spell.target.raw
    end
    cs.pending_time = os.clock()
    return true
end

------------------------------------------------------------
-- Prerender: hook precast + flush pending cast when safe
------------------------------------------------------------
windower.raw_register_event('prerender', function()
    ---- Hook: wrap precast after job lua defines it ----
    if not cs.hooked and precast then
        cs.hooked = true
        local orig_precast = precast
        precast = function(spell)
            if caststill_check(spell) then
                cancel_spell()
                return
            end
            return orig_precast(spell)
        end
    end

    ---- Flush pending cast ----
    if not cs.pending_cmd then return end

    -- FAST PATH: 0x15 confirms server knows our stopped position
    if cs.is_settled and server_knows_pos() then
        fire_pending()
        return
    end

    -- SAFETY FALLBACK: fire anyway after stop_window 
    if (os.clock() - cs.pending_time) >= caststill.stop_window then
        fire_pending()
    end
end)

windower.add_to_chat(8, 'CastStill v1.1 loaded.')
