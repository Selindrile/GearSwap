-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    include('Sel-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

	-- Whether to use Compensator under a certain threshhold even when weapons are locked.
	state.CompensatorMode = M{'Never','300','1000','Always'}
	-- Whether to automatically generate bullets.
	state.AutoAmmoMode = M(true,'Auto Ammo Mode')
	-- Whether to use Luzaf's Ring
	state.LuzafRing = M(true, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Leaden Salute','Wildfire','Last Stand'}
	
	autows = 'Leaden Salute'
	rangedautows = 'Last Stand'
	autofood = 'Sublime Sushi'
	ammostock = 198

    define_roll_values()
	
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoWSMode","AutoShadowMode","AutoFoodMode","RngHelper","AutoStunMode","AutoDefenseMode","LuzafRing","AutoBuffMode",},{"AutoSambaMode","Weapons","OffenseMode","RangedMode","WeaponskillMode","ElementalMode","IdleMode","Passive","RuneElement","CompensatorMode","TreasureMode",})
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)
    if (spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill') and player.equipment.ammo == 'Animikii Bullet' then
		cancel_spell()
		add_to_chat(123,'Abort: Don\'t shoot your good ammo!')
    end
end

function job_precast(spell, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		state.CombatWeapon:set(player.equipment.range)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    elseif spell.type == 'CorsairShot' then
		if not player.inventory['Trump Card'] and player.satchel['Trump Card'] then
			send_command('get "Trump Card" satchel')
			eventArgs.cancel = true
			windower.chat.input:schedule(1,'/ja "'..spell.english..'" '..spell.target.raw..'')
			return
		end
    end
	
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end
end

function job_post_midcast(spell, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		if buffactive['Triple Shot'] and sets.buff['Triple Shot'] then
			if sets.buff['Triple Shot'][state.RangedMode.value] then
				equip(sets.buff['Triple Shot'][state.RangedMode.value])
			else
				equip(sets.buff['Triple Shot'])
			end
		end

		if state.Buff.Barrage and sets.buff.Barrage then
			equip(sets.buff.Barrage)
		end
	end
end

function job_self_command(commandArgs, eventArgs)
		if commandArgs[1]:lower() == 'elemental' and commandArgs[2]:lower() == 'quickdraw' then
			if state.ElementalMode.value == 'Fire' then
				windower.chat.input('/ma "Fire Shot" <t>')
			elseif state.ElementalMode.value == 'Wind' then
				windower.chat.input('/ma "Wind Shot" <t>')
			elseif state.ElementalMode.value == 'Lightning' then
				windower.chat.input('/ma "Thunder Shot" <t>')
			elseif state.ElementalMode.value == 'Earth' then
				windower.chat.input('/ma "Earth Shot" <t>')
			elseif state.ElementalMode.value == 'Ice' then
				windower.chat.input('/ma "Ice Shot" <t>')
			elseif state.ElementalMode.value == 'Water' then
				windower.chat.input('/ma "Water Shot" <t>')
			elseif state.ElementalMode.value == 'Light' then
				windower.chat.input('/ma "Light Shot" <t>')
			elseif state.ElementalMode.value == 'Dark' then
				windower.chat.input('/ma "Dark Shot" <t>')
			end

			eventArgs.handled = true			
		end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
		if state.CompensatorMode.value ~= 'Never' then
			if ((player.equipment.range and player.equipment.range == 'Compensator') or (player.equipment.ranged and player.equipment.ranged == 'Compensator')) and sets.weapons[state.Weapons.value] and sets.weapons[state.Weapons.value].range and sets.weapons[state.Weapons.value].range ~= 'Compensator' then
				enable('range')
				equip({range=sets.weapons[state.Weapons.value].range})
				disable('range')
			end
			if (player.equipment.main and player.equipment.main == 'Rostam') and sets.weapons[state.Weapons.value] and sets.weapons[state.Weapons.value].main and sets.weapons[state.Weapons.value].main ~= 'Rostam' then
				enable('main')
				equip({main=sets.weapons[state.Weapons.value].main})
				disable('main')
			end
		end
        display_roll_info(spell)
	elseif spell.type == 'CorsairShot' then
		equip({ammo=gear.RAbullet})
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end

function job_buff_change(buff, gain)
	if player.equipment.Ranged and buff:contains('Aftermath') then
		classes.CustomRangedGroups:clear()
		if (player.equipment.Ranged == 'Death Penalty' and buffactive['Aftermath: Lv.3']) or (player.equipment.Ranged == 'Armageddon' and (buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.3'])) then
			classes.CustomRangedGroups:append('AM')
		end
	end
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)
    return meleeSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
end

function job_post_precast(spell, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' then
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 and moonshade_ws:contains(spell.english) then
			if check_ws_acc():contains('Acc') then
				if sets.AccMaxTP then
					equip(sets.AccMaxTP)
				end
			elseif sets.MaxTP then
					equip(sets.MaxTP)
			end
		end
	elseif spell.type == 'CorsairShot' and not (spell.english == 'Light Shot' or spell.english == 'Dark Shot') then
		if state.WeaponskillMode.value == "Proc" and sets.precast.CorsairShot.Proc then
			equip(sets.precast.CorsairShot.Proc)
		elseif state.CastingMode.value == 'Fodder' and sets.precast.CorsairShot.Damage then
			equip(sets.precast.CorsairShot.Damage)
		end
	elseif spell.action_type == 'Ranged Attack' and sets.precast.RA and buffactive.Flurry then
		if sets.precast.RA.Flurry and lastflurry == 1 then
			equip(sets.precast.RA.Flurry)
		elseif sets.precast.RA.Flurry2 and lastflurry == 2 then
			equip(sets.precast.RA.Flurry2)
		end
	elseif spell.type == 'CorsairRoll' or spell.english == "Double-Up" then
		if state.LuzafRing.value and item_available("Luzaf's Ring") then
			equip(sets.precast.LuzafRing)
		end
		if spell.type == 'CorsairRoll' and state.CompensatorMode.value ~= 'Never' and (state.CompensatorMode.value == 'Always' or tonumber(state.CompensatorMode.value) > player.tp) then
			if item_available("Compensator") then
				enable('range')
				equip({range="Compensator"})
			end
			if item_available("Rostam") then
				enable('main')
				equip({main="Rostam"})
			end
		end
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 and sets.precast.FoldDoubleBust then
		equip(sets.precast.FoldDoubleBust)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=3, unlucky=7, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=4, unlucky=8, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
		["Naturalist's Roll"]   = {lucky=3, unlucky=7, bonus="Enhancing Duration"},
		["Runeist's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Evasion"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(217, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(217, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if elemental_obi_weaponskills:contains(spell.name) then
                -- magical weaponskills
                bullet_name = gear.MAbullet
            else
				-- physical weaponskills
				bullet_name = gear.WSbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
  
	local available_bullets = count_available_ammo(bullet_name)
	
  -- If no ammo is available, give appropriate warning and cancel.
    if not (available_bullets > 0) then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(217, 'No Quick Draw ammo available, using equipped ammo: ('..player.equipment.ammo..')')
            return
        elseif spell.type == 'WeaponSkill' and (player.equipment.ammo == gear.RAbullet or player.equipment.ammo == gear.WSbullet or player.equipment.ammo == gear.MAbullet) then
            add_to_chat(217, 'No weaponskill ammo available, using equipped ammo: ('..player.equipment.ammo..')')
            return
        else
            add_to_chat(217, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and (available_bullets <= bullet_min_count) then
        add_to_chat(217, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and (available_bullets > 0) and (available_bullets <= options.ammo_warning_limit) then
        local msg = '****  LOW AMMO WARNING: '..bullet_name..' ****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(217, border)
        add_to_chat(217, msg)
        add_to_chat(217, border)
    end
end

function job_tick()
	if check_ammo() then return true end
	return false
end