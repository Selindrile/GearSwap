--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- __________.__                                ________                          __               .__.__  __      __  .__    .__           _____.__.__              
-- \______   |  |   ____ _____    ______ ____   \______ \   ____     ____   _____/  |_    ____   __| _|___/  |_  _/  |_|  |__ |__| ______ _/ ____|__|  |   ____      
--  |     ___|  | _/ __ \\__  \  /  ____/ __ \   |    |  \ /  _ \   /    \ /  _ \   __\ _/ __ \ / __ ||  \   __\ \   __|  |  \|  |/  ___/ \   __\|  |  | _/ __ \     
--  |    |   |  |_\  ___/ / __ \_\___ \\  ___/   |    `   (  <_> ) |   |  (  <_> |  |   \  ___// /_/ ||  ||  |    |  | |   Y  |  |\___ \   |  |  |  |  |_\  ___/     
--  |____|   |____/\___  (____  /____  >\___  > /_______  /\____/  |___|  /\____/|__|    \___  \____ ||__||__|    |__| |___|  |__/____  >  |__|  |__|____/\___  > /\ 
--                     \/     \/     \/     \/          \/              \/                   \/     \/                      \/        \/                      \/  \/ 
--
--	Please do not edit this file!							Please do not edit this file!							Please do not edit this file!
--
--	Editing this file will cause you to be unable to use Github Desktop to update!
--
--	Any changes you wish to make in this file you should be able to make by overloading. That is Re-Defining the same variables or functions in another file, by copying and
--	pasting them to a file that is loaded after the original file, all of my library files, and then job files are loaded first.
--	The last files to load are the ones unique to you. User-Globals, Charactername-Globals, Charactername_Job_Gear, in that order, so these changes will take precedence.
--
--	You may wish to "hook" into existing functions, to add functionality without losing access to updates or fixes I make, for example, instead of copying and editing
--	status_change(), you can instead use the function user_status_change() in the same manner, which is called by status_change() if it exists, most of the important 
--  gearswap functions work like this in my files, and if it's unique to a specific job, user_job_status_change() would be appropriate instead.
--
--  Variables and tables can be easily redefined just by defining them in one of the later loaded files: autofood = 'Miso Ramen' for example.
--  States can be redefined as well: state.HybridMode:options('Normal','PDT') though most of these are already redefined in the gear files for editing there.
--	Commands can be added easily with: user_self_command(commandArgs, eventArgs) or user_job_self_command(commandArgs, eventArgs)
--
--	If you're not sure where is appropriate to copy and paste variables, tables and functions to make changes or add them:
--		User-Globals.lua - 			This file loads with all characters, all jobs, so it's ideal for settings and rules you want to be the same no matter what.
--		Charactername-Globals.lua -	This file loads with one character, all jobs, so it's ideal for gear settings that are usable on all jobs, but unique to this character.
--		Charactername_Job_Gear.lua-	This file loads only on one character, one job, so it's ideal for things that are specific only to that job and character.
--
--
--	If you still need help, feel free to contact me on discord or ask in my chat for help: https://discord.gg/ug6xtvQ
--  !Please do NOT message me in game about anything third party related, though you're welcome to message me there and ask me to talk on another medium.
--
--  Please do not edit this file!							Please do not edit this file!							Please do not edit this file!
-- __________.__                                ________                          __               .__.__  __      __  .__    .__           _____.__.__              
-- \______   |  |   ____ _____    ______ ____   \______ \   ____     ____   _____/  |_    ____   __| _|___/  |_  _/  |_|  |__ |__| ______ _/ ____|__|  |   ____      
--  |     ___|  | _/ __ \\__  \  /  ____/ __ \   |    |  \ /  _ \   /    \ /  _ \   __\ _/ __ \ / __ ||  \   __\ \   __|  |  \|  |/  ___/ \   __\|  |  | _/ __ \     
--  |    |   |  |_\  ___/ / __ \_\___ \\  ___/   |    `   (  <_> ) |   |  (  <_> |  |   \  ___// /_/ ||  ||  |    |  | |   Y  |  |\___ \   |  |  |  |  |_\  ___/     
--  |____|   |____/\___  (____  /____  >\___  > /_______  /\____/  |___|  /\____/|__|    \___  \____ ||__||__|    |__| |___|  |__/____  >  |__|  |__|____/\___  > /\ 
--                     \/     \/     \/     \/          \/              \/                   \/     \/                      \/        \/                      \/  \/ 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    include('Sel-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

    state.Buff.Saboteur = buffactive.Saboteur or false
	state.Buff.Spontaneity = buffactive.Spontaneity or false
	state.Buff.Stymie = buffactive.Stymie or false
	state.Buff['Elemental Seal'] = buffactive['Elemental Seal'] or false
	state.Buff.Chainspell = buffactive.Chainspell or false
	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
	
	state.AutoBuffMode 		  = M{['description'] = 'Auto Buff Mode','Off','Auto','AutoMelee','AutoMage'}
	
	-- Whether to swap weapons for Temper/Phalanx under a certain tp threshhold even when weapons are locked.
	state.BuffWeaponsMode = M{'Never','500','1000','Always'}
	
    LowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga'}
	
	state.RecoverMode = M('35%', '60%', 'Always', 'Never')
	
	autows = "Savage Blade"
	autofood = 'Grape Daifuku'
	enspell = ''
	
	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoNukeMode","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoStunMode","AutoDefenseMode"},{"AutoBuffMode","AutoSambaMode","Weapons","OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","RecoverMode","ElementalMode","CastingMode","TreasureMode"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)
	if spell.type == 'WeaponSkill' then
		local available_ws = S(windower.ffxi.get_abilities().weapon_skills)
		-- WS 112 is Double Thrust, meaning a Spear is equipped.
		if available_ws:contains(160) then
            if spell.english == "Savage Blade" then
				windower.chat.input('/ws "Black Halo" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Shining Blade" then
                send_command('@input /ws "Shining Strike" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Flat Blade" then
                send_command('@input /ws "Brainshaker" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Chant Du Cygne" then
                send_command('@input /ws "True Strike" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Sanguine Blade" then
                send_command('@input /ws "Starlight" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            end
		elseif available_ws:contains(16) then
            if spell.english == "Savage Blade" then
				windower.chat.input('/ws "Exenterator" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Circle Blade" then
                send_command('@input /ws "Aeolian Edge" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Chant Du Cygne" then
                send_command('@input /ws "Evisceration" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Sanguine Blade" then
                send_command('@input /ws "Energy Drain" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            end		
        end
	end
end

function job_pretarget(spell, spellMap, eventArgs)
	if spell.english == 'Phalanx' and spell.target.type == 'PLAYER' then
		windower.chat.input('/ma "Phalanx II" '..spell.target.raw)
		cancel_spell()
		eventArgs.cancel = true
	end
end

function job_precast(spell, spellMap, eventArgs)
	if spell.english:startswith('Temper') or (spell.english:startswith('Phalanx') and spell.target.type =='SELF') then
		if state.BuffWeaponsMode.value ~= 'Never' and (state.BuffWeaponsMode.value == 'Always' or tonumber(state.BuffWeaponsMode.value) > player.tp) then
			enable('main','sub','range','ammo')
		end
	end
end

function job_post_precast(spell, spellMap, eventArgs)

	if spell.action_type == 'Magic' then
		if state.Buff.Chainspell or state.Buff.Spontaneity then
			equip(get_midcast_set(spell, spellMap))
		end
	elseif spell.type == 'WeaponSkill' then
		local WSset = standardize_set(get_precast_set(spell, spellMap))
		local wsacc = check_ws_acc()
		
		if (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			-- Replace Moonshade Earring if we're at cap TP
			if get_effective_player_tp(spell, WSset) > 3200 then
				if wsacc:contains('Acc') and not buffactive['Sneak Attack'] and sets.AccMaxTP then
					equip(sets.AccMaxTP[spell.english] or sets.AccMaxTP)
				elseif sets.MaxTP then
					equip(sets.MaxTP[spell.english] or sets.MaxTP)
				else
				end
			end
		end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, spellMap, eventArgs)

	if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' and spell.english ~= 'Impact' then
		if state.MagicBurstMode.value ~= 'Off' then
			if state.CastingMode.value:contains('Resistant') and sets.ResistantMagicBurst then
				equip(sets.ResistantMagicBurst)
			else
				equip(sets.MagicBurst)
			end
		end
		
		if spell.element == world.weather_element or spell.element == world.day_element then
			if state.CastingMode.value == 'Fodder' then
				-- if item_available('Twilight Cape') and not LowTierNukes:contains(spell.english) and not state.Capacity.value then
					-- sets.TwilightCape = {back="Twilight Cape"}
					-- equip(sets.TwilightCape)
				-- end
				if spell.element == world.day_element then
					if item_available('Zodiac Ring') then
						sets.ZodiacRing = {ring2="Zodiac Ring"}
						equip(sets.ZodiacRing)
					end
				end
			end
		end
		
		if spell.element and sets.element[spell.element] then
			equip(sets.element[spell.element])
		end
		
		if state.RecoverMode.value ~= 'Never' and (state.RecoverMode.value == 'Always' or tonumber(state.RecoverMode.value:sub(1, -2)) > player.mpp) then
			if state.MagicBurstMode.value ~= 'Off' then
				if state.CastingMode.value:contains('Resistant') and sets.ResistantRecoverBurst then
					equip(sets.ResistantRecoverBurst)
				elseif sets.RecoverBurst then
					equip(sets.RecoverBurst)
				elseif sets.RecoverMP then
					equip(sets.RecoverMP)
				end
			elseif sets.RecoverMP then
				equip(sets.RecoverMP)
			end
		end
		
    elseif spell.skill == 'Enfeebling Magic' then
		if state.Buff.Stymie and state.CastingMode.value:contains('Resistant') then
			if sets.midcast[spell.english] and sets.midcast[spell.english].Fodder then
				equip(sets.midcast[spell.english].Fodder)
			elseif sets.midcast[spell.english] then
				equip(sets.midcast[spell.english])
			elseif sets.midcast['Enfeebling Magic'].Fodder then
				equip(sets.midcast['Enfeebling Magic'].Fodder)
			else
				equip(sets.midcast['Enfeebling Magic'])
			end
		end
		
		if state.Buff.Saboteur then
			equip(sets.buff.Saboteur)
		end

	elseif spell.skill == 'Enhancing Magic' then
		equip(sets.midcast['Enhancing Magic'])
	
		if buffactive.Composure and spell.target.type == 'PLAYER' then
			equip(sets.buff.ComposureOther)
		end
		
		if sets.midcast[spell.english] then
			equip(sets.midcast[spell.english])
			
			if can_dual_wield and sets.midcast[spell.english].DW then
				equip(sets.midcast[spell.english].DW)
			end
		elseif sets.midcast[spellMap] then
			equip(sets.midcast[spellMap])
			
			if can_dual_wield and sets.midcast[spellMap].DW then
				equip(sets.midcast[spellMap].DW)
			end
		end
		
		if spell.english:startswith('Phalanx') and spell.target.type =='SELF' and sets.Self_Phalanx then
			equip(sets.Self_Phalanx)

			if can_dual_wield and sets.Self_Phalanx.DW then
				equip(sets.Self_Phalanx.DW)
			end
		end
    end
end

function job_aftercast(spell, spellMap, eventArgs)
	if spell.english:startswith('Temper') or (spell.english:startswith('Phalanx') and spell.target.type =='SELF') then
		if state.BuffWeaponsMode.value ~= 'Never' and not state.UnlockWeapons.value and state.Weapons.value ~= 'None' and sets.weapons[state.Weapons.Value] then
			equip(sets.weapons[state.Weapons.Value])
			disable('main','sub')
			if sets.weapons[state.Weapons.value] then
				if  (sets.weapons[state.Weapons.value].range or sets.weapons[state.Weapons.value].ranged) then
					disable('range')
				end
				if sets.weapons[state.Weapons.value].ammo then
					disable('ammo')
				end
			end
		end
	end
end

function job_buff_change(buff, gain)
	if buff == enspell and not gain then
		enspell = ''
	end
	update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
	update_melee_groups()
end

    -- Allow jobs to override this code
function job_self_command(commandArgs, eventArgs)
	if commandArgs[1]:lower() == 'elemental' then
		handle_elemental(commandArgs)
		eventArgs.handled = true			
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
    if buffactive['Sublimation: Activated'] then
        if (state.IdleMode.value == 'Normal' or state.IdleMode.value:contains('Sphere')) and sets.buff.Sublimation then
            idleSet = set_combine(idleSet, sets.buff.Sublimation)
        elseif state.IdleMode.value:contains('DT') and sets.buff.DTSublimation then
            idleSet = set_combine(idleSet, sets.buff.DTSublimation)
        end
    end

    if state.IdleMode.value == 'Normal' or state.IdleMode.value:contains('Sphere') then
		if player.mpp < 51 then
			if sets.latent_refresh then
				idleSet = set_combine(idleSet, sets.latent_refresh)
			end
			
			if (state.Weapons.value == 'None' or state.UnlockWeapons.value) and idleSet.main then
				local main_table = get_item_table(idleSet.main)

				if  main_table and main_table.skill == 12 and sets.latent_refresh_grip then
					idleSet = set_combine(idleSet, sets.latent_refresh_grip)
				end
				
				if player.tp > 10 and sets.TPEat then
					idleSet = set_combine(idleSet, sets.TPEat)
				end
			end
		end
   end
    
    return idleSet
end

function job_customize_melee_set(meleeSet)
	if state.Weapons.value:contains('Enspell') and enspell ~= '' then
		local enspell_element = data.elements.enspells_lookup[enspell]
		if sets.element.enspell and sets.element.enspell[enspell_element] then
			meleeSet = set_combine(meleeSet, sets.element.enspell[enspell_element])
		end

		local single_obi_intensity = 0
		local orpheus_intensity = 0
		local hachirin_intensity = 0

		if item_available("Orpheus's Sash") then
			orpheus_intensity = 15
		end

		if item_available(data.elements.obi_of[enspell_element]) then
			if enspell_element == world.weather_element then
				single_obi_intensity = single_obi_intensity + data.weather_bonus_potency[world.weather_intensity]
			end
			if enspell_element == world.day_element then
				single_obi_intensity = single_obi_intensity + 10
			end
		end
		
		if item_available('Hachirin-no-Obi') then
			if enspell_element == world.weather_element then
				hachirin_intensity = hachirin_intensity + data.weather_bonus_potency[world.weather_intensity]
			elseif enspell_element == data.elements.weak_to[world.weather_element] then
				hachirin_intensity = hachirin_intensity - data.weather_bonus_potency[world.weather_intensity]
			end
			if enspell_element == world.day_element then
				hachirin_intensity = hachirin_intensity + 10
			elseif enspell_element == data.elements.weak_to[world.day_element] then
				hachirin_intensity = hachirin_intensity - 10
			end
		end
	
		if single_obi_intensity >= hachirin_intensity and single_obi_intensity >= orpheus_intensity and single_obi_intensity >= 5 then
			meleeSet = set_combine(meleeSet, {waist=data.elements.obi_of[enspell_element]})
		elseif hachirin_intensity >= orpheus_intensity and hachirin_intensity >= 5 then
			meleeSet = set_combine(meleeSet, {waist="Hachirin-no-Obi"})
		elseif orpheus_intensity >= 5 then
			meleeSet = set_combine(meleeSet, {waist="Orpheus's Sash"})
		end

	end

    return meleeSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	if  default_spell_map == 'Cure' or default_spell_map == 'Curaga'  then
		if world.weather_element == 'Light' then
                return 'LightWeatherCure'
		elseif world.day_element == 'Light' then
                return 'LightDayCure'
        end
	end	
	
	if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        if LowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
    end	
end

-- Handling Elemental spells within Gearswap.
-- Format: gs c elemental <nuke, helix, skillchain1, skillchain2, weather>
function handle_elemental(cmdParams)
    -- cmdParams[1] == 'elemental'
    -- cmdParams[2] == ability to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No elemental command given.')
        return
    end
    local command = cmdParams[2]:lower()

	if command == 'spikes' then
		windower.chat.input('/ma "'..data.elements.spikes_of[state.ElementalMode.value]..' Spikes" <me>')
		return
	elseif command == 'enspell' then
		if  (player.sub_job == 'NIN' or player.sub_job == 'DNC') then 
			windower.chat.input('/ma "En'..data.elements.enspell_of[state.ElementalMode.value]..'" <me>')
		else
			windower.chat.input('/ma "En'..data.elements.enspell_of[state.ElementalMode.value]..' II" <me>')
		end
		return
	elseif command == 'weather' then
		if player.sub_job ~= 'SCH' then
			windower.chat.input('/ma "Phalanx" <me>')
		else
			local spell_recasts = windower.ffxi.get_spell_recasts()
			if (player.target.type == 'SELF' or not player.target.in_party) and buffactive[data.elements.storm_of[state.ElementalMode.value]] and not buffactive['Klimaform'] and spell_recasts[287] < spell_latency then
				windower.chat.input('/ma "Klimaform" <me>')
			else
				windower.chat.input('/ma "'..data.elements.storm_of[state.ElementalMode.value]..'"')
			end
		end
		return
	end

	local target = '<t>'
	if cmdParams[3] then
		if tonumber(cmdParams[3]) then
			target = tonumber(cmdParams[3])
		else
			target = table.concat(cmdParams, ' ', 3)
			target = get_closest_mob_id_by_name(target) or '<t>'
		end
	end

    if command == 'nuke' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		if state.ElementalMode.value == 'Light' then
			if spell_recasts[29] < spell_latency and actual_cost(get_spell_table_by_name('Banish II')) < player.mp then
				windower.chat.input('/ma "Banish II" '..target..'')
			elseif spell_recasts[28] < spell_latency and actual_cost(get_spell_table_by_name('Banish')) < player.mp then
				windower.chat.input('/ma "Banish" '..target..'')
			else
				add_to_chat(123,'Abort: Banishes on cooldown or not enough MP.')
			end

		elseif state.ElementalMode.value == 'Dark' then
			if spell_recasts[219] < spell_latency and actual_cost(get_spell_table_by_name('Comet')) < player.mp then
				windower.chat.input('/ma "Comet" '..target..'')
			else
				add_to_chat(123,'Abort: Comet on cooldown or not enough MP.')
			end

		else
			if player.job_points[(res.jobs[player.main_job_id].ens):lower()].jp_spent > 99 and spell_recasts[get_spell_table_by_name(data.elements.nuke_of[state.ElementalMode.value]..' V').id] < spell_latency and actual_cost(get_spell_table_by_name(data.elements.nuke_of[state.ElementalMode.value]..' V')) < player.mp then
				windower.chat.input('/ma "'..data.elements.nuke_of[state.ElementalMode.value]..' V" '..target..'')
			else
				local tiers = {' IV',' III',' II',''}
				for k in ipairs(tiers) do
					if spell_recasts[get_spell_table_by_name(data.elements.nuke_of[state.ElementalMode.value]..''..tiers[k]..'').id] < spell_latency and actual_cost(get_spell_table_by_name(data.elements.nuke_of[state.ElementalMode.value]..''..tiers[k]..'')) < player.mp then
						windower.chat.input('/ma "'..data.elements.nuke_of[state.ElementalMode.value]..''..tiers[k]..'" '..target..'')
						return
					end
				end
				add_to_chat(123,'Abort: All '..data.elements.nuke_of[state.ElementalMode.value]..' nukes on cooldown or or not enough MP.')
			end
		end

	elseif command == 'ninjutsu' then
		windower.chat.input('/ma "'..data.elements.ninjutsu_nuke_of[state.ElementalMode.value]..': Ni" '..target..'')
		
	elseif command == 'smallnuke' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
	
		local tiers = {' II',''}
		for k in ipairs(tiers) do
			if spell_recasts[get_spell_table_by_name(data.elements.nuke_of[state.ElementalMode.value]..''..tiers[k]..'').id] < spell_latency and actual_cost(get_spell_table_by_name(data.elements.nuke_of[state.ElementalMode.value]..''..tiers[k]..'')) < player.mp then
				windower.chat.input('/ma "'..data.elements.nuke_of[state.ElementalMode.value]..''..tiers[k]..'" '..target..'')
				return
			end
		end
		add_to_chat(123,'Abort: All '..data.elements.nuke_of[state.ElementalMode.value]..' nukes on cooldown or or not enough MP.')
		
	elseif command:contains('tier') then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local tierlist = {['tier1']='',['tier2']=' II',['tier3']=' III',['tier4']=' IV',['tier5']=' V',['tier6']=' VI'}
		
		windower.chat.input('/ma "'..data.elements.nuke_of[state.ElementalMode.value]..tierlist[command]..'" '..target..'')
		
	elseif command == 'ara' then
		windower.chat.input('/ma "'..data.elements.nukera_of[state.ElementalMode.value]..'ra" '..target..'')
		
	elseif command == 'aga' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		if state.ElementalMode.value == 'Wind' and spell_recasts[185] < spell_latency and actual_cost(get_spell_table_by_name('Aero II')) < player.mp then
			windower.chat.input('/ma "Aeroga II" '..target..'')
		elseif state.ElementalMode.value == 'Earth' and spell_recasts[190] < spell_latency and actual_cost(get_spell_table_by_name('Stonega II')) < player.mp then
			windower.chat.input('/ma "Stonega II" '..target..'')
		elseif state.ElementalMode.value == 'Water' and spell_recasts[200] < spell_latency and actual_cost(get_spell_table_by_name('Waterga II')) < player.mp then
			windower.chat.input('/ma "Waterga II" '..target..'')
		else
			windower.chat.input('/ma "'..data.elements.nukega_of[state.ElementalMode.value]..'ga" '..target..'')
		end
		
	elseif command == 'helix' then
		windower.chat.input('/ma "'..data.elements.helix_of[state.ElementalMode.value]..'helix" '..target..'')
		
	elseif command == 'enfeeble' then
		windower.chat.input('/ma "'..data.elements.elemental_enfeeble_of[state.ElementalMode.value]..'" '..target..'')
	
	elseif command == 'bardsong' then
		windower.chat.input('/ma "'..data.elements.threnody_of[state.ElementalMode.value]..' Threnody" '..target..'')
    else
        add_to_chat(123,'Unrecognized elemental command.')
    end
end

function job_tick()
	if check_arts() then return true end
	if check_buffup() then return true end
	if check_buff() then return true end
	return false
end

function check_arts()	
	if buffup ~= '' or (not data.areas.cities:contains(world.area) and ((state.AutoArts.value and in_combat) or state.AutoBuffMode.value ~= 'Off')) then

 		local abil_recasts = windower.ffxi.get_ability_recasts()	

 		if not buffactive.Composure then	
			local abil_recasts = windower.ffxi.get_ability_recasts()	
			if abil_recasts[50] < latency then	
				windower.chat.input('/ja "Composure" <me>')	
				add_tick_delay()
				return true	
			end	
		end	

 		if player.sub_job == 'SCH' and not (state.Buff['SJ Restriction'] or arts_active()) and abil_recasts[228] < latency then	
			windower.chat.input('/ja "Light Arts" <me>')	
			add_tick_delay()
			return true	
		end	

 	end	

 	return false	
end

function update_melee_groups()
	classes.CustomMeleeGroups:clear()
	
	if enspell ~= '' then
		if enspell:endswith('II') then
			classes.CustomMeleeGroups:append('Enspell2')
		else
			classes.CustomMeleeGroups:append('Enspell')
		end
	end
	
	if player.equipment.main and player.equipment.main == "Murgleis" and state.Buff['Aftermath: Lv.3'] then
		classes.CustomMeleeGroups:append('AM')
	end	
end

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Refresh III',	Buff='Refresh',		SpellID=894,	When='Always'},
		{Name='Haste II',		Buff='Haste',		SpellID=511,	When='Always'},
		{Name='Aurorastorm',	Buff='Aurorastorm',	SpellID=119,	When='Idle'},
		{Name='Reraise',		Buff='Reraise',		SpellID=135,	When='Always'},
	},
	
	AutoMelee = {
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	When='Always'},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	When='Always'},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	When='Always'},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	When='Always'},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	When='Always'},
	},
	
	AutoMage = {
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	When='Always'},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	When='Always'},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	When='Always'},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	When='Always'},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	When='Always'},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		When='Always'},
		{Name='Blink',			Buff='Blink',			SpellID=53,		When='Always'},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		When='Always'},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		When='Always'},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		When='Always'},
	},
	
	Default = {
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Gain-MND',		Buff='MND Boost',		SpellID=491,	Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},

	MageBuff = {
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},
	
	FullMeleeBuff = {
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Gain-STR',		Buff='STR Boost',		SpellID=486,	Reapply=false},
		{Name='Enthunder',		Buff='Enthunder',		SpellID=104,	Reapply=false},
		{Name='Shock Spikes',	Buff='Shock Spikes',	SpellID=251,	Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
		{Name='Barblizzard',	Buff='Barblizzard',		SpellID=61,		Reapply=false},
		{Name='Barparalyze',	Buff='Barparalyze',		SpellID=74,		Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},		
		{Name='Regen II',		Buff='Regen',			SpellID=110,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
	},
	
	MeleeBuff = {
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Gain-STR',		Buff='STR Boost',		SpellID=486,	Reapply=false},
		{Name='Enthunder',		Buff='Enthunder',		SpellID=104,	Reapply=false},
		{Name='Shock Spikes',	Buff='Shock Spikes',	SpellID=251,	Reapply=false},
	},

	Odin = {
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Regen II',		Buff='Regen',			SpellID=110,	Reapply=false},
		{Name='Enaero',			Buff='Enaero',			SpellID=102,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},
	
	HybridCleave = {
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	Reapply=false},
		{Name='Enthunder II',	Buff='Enthunder II',	SpellID=316,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},
}