-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    ExtraSongsMode may take one of three values: None, Dummy, FullLength

    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy

    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.


    Simple macro to cast a dummy Daurdabla song:
    /console gs c set ExtraSongsMode Dummy
    /ma "Mage's Ballad" <me>

    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    include('Sel-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

  state.ExtraSongsMode = M{['description']='Extra Songs','None','Dummy','Dummy Lock','Full Length','Full Length Lock'}

  state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
  state.Buff['Pianissimo'] = buffactive['Pianissimo'] or false
  state.Buff['Nightingale'] = buffactive['Nightingale'] or false
  state.RecoverMode = M('35%', '60%', 'Always', 'Never')

	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Rudra\'s Storm'}

	autows = "Rudra's Storm"
	autofood = 'Pear Crepe'

    -- For tracking current recast timers via the Timers plugin.
    custom_timers = {}
	update_combat_form()
	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoNukeMode","AutoWSMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoBuffMode",},{"Weapons","OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","ExtraSongsMode","CastingMode","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)
    if spell.type == 'BardSong' and not spell.targets.Enemy then
		if spell.target.raw == '<t>' and (player.target.type == 'NONE' or player.target.type == "MONSTER") and not state.Buff['Pianissimo'] then
			change_target('<me>')
			return
		end
    end
end

function job_filter_precast(spell, spellMap, eventArgs)
    if spell.type == 'BardSong' and not spell.targets.Enemy then
		local spell_recasts = windower.ffxi.get_spell_recasts()

        -- Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and not state.Buff['Pianissimo'] then
            if spell_recasts[spell.recast_id] < 10 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.1; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            -- layer general gear on first, then let default handler add song-specific gear.
            local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end
        end
    end
end

function job_post_precast(spell, spellMap, eventArgs)

	if spell.type == 'BardSong' then

		if state.Buff['Nightingale'] then

			-- Replicate midcast in precast for nightingale including layering.
            local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end

			if sets.midcast[spell.english] then
				equip(sets.midcast[spell.english])
			elseif sets.midcast[get_spell_map(spell, default_spell_map)] then
				equip(sets.midcast[get_spell_map(spell, default_spell_map)])
			end

			if state.ExtraSongsMode.value == 'Full Length' or state.ExtraSongsMode.value == 'Full Length Lock' then
				equip(sets.midcast.Daurdabla)
			end

		end

	elseif spell.type == 'WeaponSkill' then
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 and moonshade_ws:contains(spell.english) then

			if check_ws_acc():contains('Acc') or (state.Buff['Sneak Attack'] or state.Buff['Trick Attack']) then
				if sets.AccMaxTP then
					equip(sets.AccMaxTP)
				end
			else
				if sets.MaxTP then
					equip(sets.MaxTP)
				end
			end
		end
	end

end

function job_post_midcast(spell, spellMap, eventArgs)
    if spell.type == 'BardSong' then
		if state.ExtraSongsMode.value == 'Full Length' or state.ExtraSongsMode.value == 'Full Length Lock' then
            equip(sets.midcast.Daurdabla)
        end

        if not (state.ExtraSongsMode.value == 'Dummy Lock' or state.ExtraSongsMode.value == 'Full Length Lock') then
			state.ExtraSongsMode:reset()
		end

		if state.DisplayMode.value then update_job_states()	end

    elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        if state.MagicBurstMode.value ~= 'Off' then equip(sets.MagicBurst) end
		if spell.element == world.weather_element or spell.element == world.day_element then
			if state.CastingMode.value == 'Fodder' then
				if item_available('Twilight Cape') and not state.Capacity.value then
					sets.TwilightCape = {back="Twilight Cape"}
					equip(sets.TwilightCape)
				end
				if spell.element == world.day_element then
					if item_available('Zodiac Ring') then
						sets.ZodiacRing = {ring2="Zodiac Ring"}
						equip(sets.ZodiacRing)
					end
				end
			end
		end

		if spell.element == 'Wind' and sets.WindNuke then
			equip(sets.WindNuke)
		elseif spell.element == 'Ice' and sets.IceNuke then
			equip(sets.IceNuke)
		end

		if state.RecoverMode.value == 'Always' then equip(sets.RecoverMP)
		elseif state.RecoverMode.value == 'Never' then
		elseif state.RecoverMode.value == '60%' then
			if player.mpp <60 then equip(sets.RecoverMP) end
		elseif state.RecoverMode.value == '35%' then
			if player.mpp <35 then equip(sets.RecoverMP) end
		end
    end
end

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, spellMap, eventArgs)
    if spell.type == 'BardSong' and not spell.interrupted then
        if spell.target and spell.target.type == 'SELF' then
            adjust_timers(spell, spellMap)
        end
	elseif spell.skill == 'Elemental Magic' and state.MagicBurstMode.value == 'Single' then
		state.MagicBurstMode:reset()
		if state.DisplayMode.value then update_job_states()	end
    end
end

function job_buff_change(buff, gain)
	update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
  update_combat_form()
	update_melee_groups()
end


-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
    if player.mpp < 51 and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') and state.DefenseMode.value == 'None' then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'ResistantSongDebuff'
        else
            return 'SongDebuff'
        end
    elseif state.ExtraSongsMode.value == 'Dummy' or state.ExtraSongsMode.value == 'Dummy Lock' then
        return 'DaurdablaDummy'
    else
        return 'SongEffect'
    end
end


-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_timers(spell, spellMap)
    if state.UseCustomTimers.value == false then
        return
    end

    local current_time = os.time()

    -- custom_timers contains a table of song names, with the os time when they
    -- will expire.

    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    for song_name,expires in pairs(custom_timers) do
        if expires < current_time then
            temp_timer_list[song_name] = true
        end
    end
    for song_name,expires in pairs(temp_timer_list) do
        custom_timers[song_name] = nil
    end

    local dur = calculate_duration(spell.name, spellMap)
    if custom_timers[spell.name] then
        -- Songs always overwrite themselves now, unless the new song has
        -- less duration than the old one (ie: old one was NT version, new
        -- one has less duration than what's remaining).

        -- If new song will outlast the one in our list, replace it.
        if custom_timers[spell.name] < (current_time + dur) then
            send_command('timers delete "'..spell.name..'"')
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        end
    else
        -- Figure out how many songs we can maintain.
        local maxsongs = 2
        if player.equipment.range == info.ExtraSongInstrument then
            maxsongs = maxsongs + info.ExtraSongs
        end
        if buffactive['Clarion Call'] then
            maxsongs = maxsongs + 1
        end
        -- If we have more songs active than is currently apparent, we can still overwrite
        -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
        if maxsongs < table.length(custom_timers) then
            maxsongs = table.length(custom_timers)
        end

        -- Create or update new song timers.
        if table.length(custom_timers) < maxsongs then
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        else
            local rep,repsong
            for song_name,expires in pairs(custom_timers) do
                if current_time + dur > expires then
                    if not rep or rep > expires then
                        rep = expires
                        repsong = song_name
                    end
                end
            end
            if repsong then
                custom_timers[repsong] = nil
                send_command('timers delete "'..repsong..'"')
                custom_timers[spell.name] = current_time + dur
                send_command('timers create "'..spell.name..'" '..dur..' down')
            end
        end
    end
end

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_timers(), which is only called on aftercast().
function calculate_duration(spellName, spellMap)
    local mult = 1
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall

    if player.equipment.main == "Carnwenhan" then mult = mult + 0.1 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
    if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end

    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
    if spellMap == 'Madrigal' and player.equipment.head == "Aoidos' Calot +2" then mult = mult + 0.1 end
    if spellMap == 'Minuet' and player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == 'Ad. Mnchtte. +2' then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Aoidos' Rhing. +2" then mult = mult + 0.1 end
    if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Aoidos' Cothrn. +2" then mult = mult + 0.1 end

    if buffactive.Troubadour then
        mult = mult*2
    end
    if spellName == "Sentinel's Scherzo" then
        if buffactive['Soul Voice'] then
            mult = mult*2
        elseif buffactive['Marcato'] then
            mult = mult*1.5
        end
    end

    local totalDuration = math.floor(mult*120)

    return totalDuration
end


-- Examine equipment to determine what our current TP weapon is.
function update_combat_form()
	if player.equipment.main and not (player.equipment.sub == 'empty' or player.equipment.sub:contains('Grip') or player.equipment.sub:contains('Strap')) and not player.equipment.sub:contains('Shield') then
			state.CombatForm:set('DW')
	else
			state.CombatForm:reset()
	end
end

function update_melee_groups()
	if player.equipment.main then
		classes.CustomMeleeGroups:clear()

		if player.equipment.main == "Carnwenhan" and state.Buff['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('AM')
		end
	end
end

-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end


windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)

    -- Allow jobs to override this code
function job_self_command(commandArgs, eventArgs)

end

function job_tick()
	if check_song() then return true end
	return false
end

function check_song()
	if state.AutoBuffMode.value and not moving and not areas.Cities:contains(world.area) then
		if not buffactive.march then
			windower.chat.input('/ma "Victory March" <me>')
			tickdelay = 90
			return true
		elseif not buffactive.madrigal then
			windower.chat.input('/ma "Blade Madrigal" <me>')
			tickdelay = 90
			return true
		elseif not buffactive.minuet then
			windower.send_command('gs c set ExtraSongsMode Dummy;input /ma "Valor Minuet V" <me>')
			tickdelay = 90
			return true
		else
			return false
		end
	else
		return false
	end
end
