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
--	!Please do NOT message me in game about anything third party related, though you're welcome to message me there and ask me to talk on another medium.
--
--	Please do not edit this file!							Please do not edit this file!							Please do not edit this file!
-- __________.__                                ________                          __               .__.__  __      __  .__    .__           _____.__.__              
-- \______   |  |   ____ _____    ______ ____   \______ \   ____     ____   _____/  |_    ____   __| _|___/  |_  _/  |_|  |__ |__| ______ _/ ____|__|  |   ____      
--  |     ___|  | _/ __ \\__  \  /  ____/ __ \   |    |  \ /  _ \   /    \ /  _ \   __\ _/ __ \ / __ ||  \   __\ \   __|  |  \|  |/  ___/ \   __\|  |  | _/ __ \     
--  |    |   |  |_\  ___/ / __ \_\___ \\  ___/   |    `   (  <_> ) |   |  (  <_> |  |   \  ___// /_/ ||  ||  |    |  | |   Y  |  |\___ \   |  |  |  |  |_\  ___/     
--  |____|   |____/\___  (____  /____  >\___  > /_______  /\____/  |___|  /\____/|__|    \___  \____ ||__||__|    |__| |___|  |__/____  >  |__|  |__|____/\___  > /\ 
--                     \/     \/     \/     \/          \/              \/                   \/     \/                      \/        \/                      \/  \/ 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job.
function get_sets()
	-- Load and initialize the include file.
	include('Sel-Include.lua')
end

function job_setup()

	state.Buff['Mana Wall'] = buffactive['Mana Wall'] or false
	state.Buff['Manafont'] = buffactive['Manafont'] or false
	state.Buff['Manawell'] = buffactive['Manawell'] or false

	LowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
		'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
		'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga'}
		
	AutoManawellSpells = S{'Impact'}
	AutoManawellOccultSpells = S{'Impact','Meteor','Thundaja','Blizzaja','Firaja','Thunder VI','Blizzard VI',}

	state.DeathMode = M{['description'] = 'Death Mode', 'Off', 'Single', 'Lock'}
	state.AutoManawell = M(true, 'Auto Manawell Mode')
	state.RecoverMode = M('35%', '60%', 'Always', 'Never')

	autows = 'Myrkr'
	autofood = 'Pear Crepe'
	
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoNukeMode","AutoManawell","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoStunMode","AutoDefenseMode"},{"AutoBuffMode","Weapons","OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","RecoverMode","ElementalMode","CastingMode","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		if state.AutoManawell.value and (AutoManawellSpells:contains(spell.english) or (state.CastingMode.value == 'OccultAcumen' and AutoManawellOccultSpells:contains(spell.english) and actual_cost(spell) > player.mp)) then
			local abil_recasts = windower.ffxi.get_ability_recasts()

			if abil_recasts[35] < latency and not buffactive['amnesia'] then
				eventArgs.cancel = true
				cancel_spell()
				send_command('@input /ja "Manawell" <me>;wait 1;input /ma '..spell.english..' '..spell.target.raw..'')
				return
			end
		end
	end
end

function job_precast(spell, spellMap, eventArgs)

	if spell.action_type == 'Magic' then
		if spellMap == 'Cure' or spellMap == 'Curaga' then
			gear.default.obi_back = gear.obi_cure_back
			gear.default.obi_waist = gear.obi_cure_waist
		elseif (spell.english == 'Death' or spell.english == 'Comet') or (spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble') then
			if LowTierNukes:contains(spell.english) or spell.english:endswith('helix') then
				gear.default.obi_back = gear.obi_low_nuke_back
				gear.default.obi_waist = gear.obi_low_nuke_waist
			else
				gear.default.obi_back = gear.obi_high_nuke_back
				gear.default.obi_waist = gear.obi_high_nuke_waist
			end
		end

		if state.DeathMode.value ~= 'Off' then
			classes.CustomClass = 'Death'		
		elseif state.CastingMode.value == 'Proc' then
			classes.CustomClass = 'Proc'
		elseif state.CastingMode.value == 'OccultAcumen' then
			classes.CustomClass = 'OccultAcumen'
		end

	end
end

function job_post_precast(spell, spellMap, eventArgs)

	if spell.action_type == 'Magic' and state.DeathMode.value ~= 'Off' then
		if sets.precast.FC[spell.english] and sets.precast.FC[spell.english].Death then
			equip(sets.precast.FC[spell.english].Death)
		elseif sets.precast.FC[spellMap] and sets.precast.FC[spellMap].Death then
			equip(sets.precast.FC[spellMap].Death)
		elseif sets.precast.FC[spell.skill] and sets.precast.FC[spell.skill].Death then
			equip(sets.precast.FC[spell.skill].Death)
		else
			equip(sets.precast.FC.Death)
		end
	elseif spell.type == 'WeaponSkill' then
		local WSset = standardize_set(get_precast_set(spell, spellMap))
		
		if (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			-- Replace Moonshade Earring if we're at cap TP
			if sets.MaxTP and get_effective_player_tp(spell, WSset) > 3200 then
				equip(sets.MaxTP[spell.english] or sets.MaxTP)
			end
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		if state.DeathMode.value ~= 'Off' and spell.english ~= 'Death' then
			if sets.midcast[spell.english] and sets.midcast[spell.english].Death then
				equip(sets.midcast[spell.english].Death)
			elseif sets.midcast[spellMap] and sets.midcast[spellMap].Death then
				equip(sets.midcast[spellMap].Death)
			elseif sets.midcast[spell.skill] and sets.midcast[spell.skill].Death then
				equip(sets.midcast[spell.skill].Death)
			else
				equip(sets.precast.FC.Death)
			end

		elseif is_nuke(spell, spellMap) then
			if state.MagicBurstMode.value ~= 'Off' and state.CastingMode.value ~= 'Proc' then
				if state.CastingMode.value:contains('Resistant') and sets.ResistantMagicBurst then
					equip(sets.ResistantMagicBurst)
				else
					equip(sets.MagicBurst)
				end
			end

			if player.hpp < 75 and player.tp < 1000 and state.CastingMode.value == 'Fodder' then
				if item_available("Sorcerer's Ring") then
					sets.SorcRing = {ring1="Sorcerer's Ring"}
					equip(sets.SorcRing)
				end
			end
			
			if spell.element == world.weather_element or spell.element == world.day_element then
				if state.CastingMode.value == 'Fodder' then
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
			
			if state.RecoverMode.value ~= 'Never' and not (state.Buff['Manafont'] or state.Buff['Manawell']) and (state.RecoverMode.value == 'Always' or tonumber(state.RecoverMode.value:sub(1, -2)) > player.mpp) then
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
		end

		if state.Buff['Mana Wall'] and ((state.IdleMode.value:contains('DT') or state.IdleMode.value:contains('Tank')) and in_combat)then
			equip(sets.buff['Mana Wall'])
		end
	end
end

function job_aftercast(spell, spellMap, eventArgs)
	if not spell.interrupted then
		if spell.english == 'Sleep' or spell.english == 'Sleepga' then
			send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
		elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
			send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
		elseif spell.english == "Death" and state.DeathMode.value == 'Single' then
			state.DeathMode:reset()
			if state.DisplayMode.value then update_job_states()	end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	if default_spell_map == 'Cure' or default_spell_map == 'Curaga'  then
		if state.Weapons.value ~= 'None' and not state.UnlockWeapons.value then
			if world.weather_element == 'Light' then
				return 'MeleeLightWeatherCure'
			elseif world.day_element == 'Light' then
				return 'MeleeLightDayCure'
			else
				return 'MeleeCure'
			end
		elseif world.weather_element == 'Light' then
			return 'LightWeatherCure'
		elseif world.day_element == 'Light' then
			return 'LightDayCure'
		end
	elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' and not spell.english:contains('helix') then
		if LowTierNukes:contains(spell.english) then
			return 'LowTierNuke'
		else
			return 'HighTierNuke'
		end
	end
end

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
			end
		end
   end
	
	if state.DeathMode.value ~= 'Off' then
		idleSet = set_combine(idleSet, sets.idle.Death)
	end

	if state.Buff['Mana Wall'] then
		idleSet = set_combine(idleSet, sets.buff['Mana Wall'])
	end
	
	return idleSet
end

function job_customize_kiting_set(baseSet)

	if state.Buff['Mana Wall'] and ((state.IdleMode.value:contains('DT') or state.IdleMode.value:contains('Tank')) and in_combat)then
		if sets.buff['Mana Wall'] then
			baseSet = set_combine(baseSet, sets.buff['Mana Wall'])
		end
	end

	return baseSet
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

	if state.Buff['Mana Wall'] then
		meleeSet = set_combine(meleeSet, sets.buff['Mana Wall'])
	end

	return meleeSet
end

function job_customize_defense_set(defenseSet)

	if state.Buff['Mana Wall'] then
		defenseSet = set_combine(defenseSet, sets.buff['Mana Wall'])
	end

	return defenseSet
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	eventArgs.handled = true
end

function job_self_command(commandArgs, eventArgs)

end

function job_tick()
	if check_arts() then return true end
	if check_buffup() then return true end
	if check_buff() then return true end
	return false
end

function check_arts()
	if (player.sub_job == 'SCH' and not (state.Buff['SJ Restriction'] or arts_active())) and (buffup ~= '' or (not data.areas.cities:contains(world.area) and ((state.AutoArts.value and player.in_combat) or state.AutoBuffMode.value ~= 'Off'))) then
	
		local abil_recasts = windower.ffxi.get_ability_recasts()

		if abil_recasts[232] < latency then
			windower.chat.input('/ja "Dark Arts" <me>')
			add_tick_delay()
			return true
		end

	end
	
	return false
end

function handle_job_elemental(command, target)
	if command:endswith('nuke') then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		if state.ElementalMode.value == 'Light' then
			if spell_recasts[29] < spell_latency and actual_cost('Banish II') < player.mp then
				windower.chat.input('/ma "Banish II" '..target..'')
			elseif spell_recasts[28] < spell_latency and actual_cost('Banish') < player.mp then
				windower.chat.input('/ma "Banish" '..target..'')
			else
				add_to_chat(123,'Abort: Banishes on cooldown or not enough MP.')
			end
		else
			local spell_recasts = windower.ffxi.get_spell_recasts()
			local tiers = {' VI',' V',' IV',' III',' II',''}
			
			if command == 'smallnuke' then
				tiers = {' II',''}
			end

			for k in ipairs(tiers) do
				local spell_name = data.elements.nuke_of[state.ElementalMode.value]..tiers[k]
				local spell_id = get_spell_id_by_name(spell_name)

				if silent_can_cast(spell_name) and spell_recasts[spell_id] < spell_latency and actual_cost(spell_id) < player.mp then
					windower.chat.input('/ma "'..spell_name..'" '..target..'')
					return true
				end
			end
			add_to_chat(123,'Abort: All '..state.ElementalMode.value..' nukes on cooldown or or not enough MP.')
		end
		return true
	elseif command:startswith('ancient') then
		if command == 'ancientmagic2' then
			windower.chat.input('/ma "'..data.elements.ancient_nuke_of[state.ElementalMode.value]..' II" '..target..'')
		else
			windower.chat.input('/ma "'..data.elements.ancient_nuke_of[state.ElementalMode.value]..'" '..target..'')
		end
		return true
	elseif command == 'aga' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		if command == 'aga' then
			local tiers = {'ja','ga III','ga II','ga'}
			for k in ipairs(tiers) do
				local spell_name = data.elements.nukega_of[state.ElementalMode.value]..tiers[k]
				local spell_id = get_spell_id_by_name(spell_name)
				if silent_can_cast(spell_name) and spell_recasts[spell_id] < spell_latency and actual_cost(spell_id) < player.mp then
					windower.chat.input('/ma "'..spell_name..'" '..target..'')
					return true
				end
			end
			add_to_chat(123,'Abort: All '..state.ElementalMode.value..' aoe nukes on cooldown or or not enough MP.')
		end
		return true
	elseif command == 'aja' then
		windower.chat.input('/ma "'..data.elements.nukega_of[state.ElementalMode.value]..'ja" '..target..'')
	end
	return false
end

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Reraise',		Buff='Reraise',			SpellID=113,	When='Always'},
		{Name='Haste',			Buff='Haste',			SpellID=57,		When='Always'},
		{Name='Refresh',		Buff='Refresh',			SpellID=109,	When='Always'},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		When='Always'},
		{Name='Klimaform',		Buff='Klimaform',		SpellID=287,	When='Combat'},
	},
	
	Default = {
		{Name='Reraise',		Buff='Reraise',			SpellID=113,	Reapply=false},
		{Name='Haste',			Buff='Haste',			SpellID=57,		Reapply=false},
		{Name='Refresh',		Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Klimaform',		Buff='Klimaform',		SpellID=287,	Reapply=false},
		{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Regen',			Buff='Regen',			SpellID=108,	Reapply=false},
		{Name='Phalanx',		Buff='Phalanx',			SpellID=106,	Reapply=false},
	},
}