-- NOTE: I do not play run, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()

	-- Load and initialize the include file.
	include('Sel-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()

	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
	state.Buff['Valiance'] = buffactive['Valiance'] or false
	state.Buff['Vallation'] = buffactive['Vallation'] or false
	state.Buff['Embolden'] = buffactive['Embolden'] or false
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
	state.Stance = M{['description']='Stance','Hasso','Seigan','None'}

	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Chant du Cygne', 'Savage Blade','Requiescat','Resolution','Ruinator'}
	
	autows = 'Resolution'
	autofood = 'Miso Ramen'
	
	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoTankMode","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoNukeMode","AutoStunMode","AutoDefenseMode","AutoBuffMode",},{"AutoSambaMode","Weapons","OffenseMode","WeaponskillMode","Stance","IdleMode","Passive","RuneElement","PhysicalDefenseMode","MagicalDefenseMode","ResistDefenseMode","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filter_precast(spell, spellMap, eventArgs)

	if spell.english == 'Valiance' then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if abil_recasts[113] > 0 and not state.Buff['Valiance'] and abil_recasts[23] < latency then
			eventArgs.cancel = true
			send_command('@input /ja "Vallation" <me>')
		end
	end
	
end

function job_precast(spell, spellMap, eventArgs)

	if spell.english == 'Vivacious Pulse' then
		equip(sets.precast.JA['Vivacious Pulse'][state.RuneElement.value])
		return
	end

	if spell.type == 'WeaponSkill' and state.AutoBuffMode.value then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if player.sub_job == 'SAM' and player.tp > 1850 and abil_recasts[140] < latency then
			eventArgs.cancel = true
			windower.chat.input('/ja "Sekkanoki" <me>')
			windower.chat.input:schedule(1,'/ws "'..spell.english..'" '..spell.target.raw..'')
			return
		elseif player.sub_job == 'SAM' and abil_recasts[134] < latency then
			eventArgs.cancel = true
			windower.chat.input('/ja "Meditate" <me>')
			windower.chat.input:schedule(1,'/ws "'..spell.english..'" '..spell.target.raw..'')
			return
		end
	end
	
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
    
	elseif spell.english == 'Lunge' or spell.english == 'Swipe' then
        if weather_rune_match() then
			if item_available('Hachirin-no-Obi') then
				sets.HachiObi = {waist="Hachirin-no-Obi"}
				equip(sets.HachiObi)
			end
        end
		if spell.element and sets.element[spell.element] then
			equip(sets.element[spell.element])
		end
    end
	
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and state.Buff.Embolden and sets.buff.Embolden then
        equip(sets.buff.Embolden)
    end
end


function job_aftercast(spell)

end

function job_buff_change(buff, gain)
	update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

	if buffactive['Battuta'] and sets.buff.Battuta then 
		meleeSet = set_combine(meleeSet, sets.buff.Battuta)
	end

    return meleeSet

end

function job_customize_idle_set(idleSet)

    return idleSet
end

function job_customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' and state.DefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end

	if buffactive['Battuta'] and sets.buff.Battuta and player.status == 'Engaged' and state.DefenseMode.value == 'Physical' and (not state.PhysicalDefenseMode.value:contains('NoParry')) and (player.target and player.target.distance < (3.2 + player.target.model_size)) then 
		defenseSet = set_combine(defenseSet, sets.buff.Battuta)
	end
	
    return defenseSet
end

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
    if player.mpp < 51 and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') and state.DefenseMode.value == 'None' then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

function job_update(cmdParams, eventArgs)
	update_melee_groups()
	
	if player.sub_job ~= 'SAM' and state.Stance.value ~= "None" then
		state.Stance:set("None")
	end
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(commandArgs, eventArgs)
	if commandArgs[1]:lower() == 'runeelement' then
		windower.chat.input('/ja "'..state.RuneElement.value..'" <me>')

	elseif commandArgs[1]:lower() == 'subjobenmity' then

		if player.target.type ~= "MONSTER" then
			add_to_chat(123,'Abort: You are not targeting a monster.')
			return
	
		elseif player.sub_job == 'BLU' then
			local spell_recasts = windower.ffxi.get_spell_recasts()
					
			if spell_recasts[584] < spell_latency then
				windower.chat.input('/ma "Sheep Song" <t>')
			elseif spell_recasts[598] < spell_latency then
				windower.chat.input('/ma "Soporific" <t>')
			elseif spell_recasts[605] < spell_latency then
				windower.chat.input('/ma "Geist Wall" <t>')
			elseif spell_recasts[575] < spell_latency then
				windower.chat.input('/ma "Jettatura" <t>')
			elseif spell_recasts[592] < spell_latency then
				windower.chat.input('/ma "Blank Gaze" <t>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Blue Magic on cooldown.') end
			end
			
		elseif player.sub_job == 'DRK' then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			local spell_recasts = windower.ffxi.get_spell_recasts()
			
			if (state.HybridMode.value ~= 'Normal' or state.DefenseMode.value ~= 'None')  and buffactive['Souleater'] then
				send_command('cancel souleater')
			end
			
			if (state.HybridMode.value ~= 'Normal' or state.DefenseMode.value ~= 'None')  and buffactive['Last Resort'] then
				send_command('cancel last resort')
			end
			
			if spell_recasts[252] < spell_latency and not silent_check_silence() then
				windower.chat.input('/ma "Stun" <t>')
			elseif abil_recasts[85] < latency then
				windower.chat.input('/ja "Souleater" <me>')
			elseif abil_recasts[87] < latency then
				windower.chat.input('/ja "Last Resort" <me>')
			elseif abil_recasts[88] < latency then
				windower.chat.input('/ja "Weapon Bash" <t>')
			elseif abil_recasts[86] < latency then
				windower.chat.input('/ja "Arcane Circle" <me>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Dark Knight abillities on cooldown.') end
			end
					
		elseif player.sub_job == 'WAR' then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			
			if (state.HybridMode.value ~= 'Normal' or state.DefenseMode.value ~= 'None')  and buffactive['Berserk'] then
				send_command('cancel berserk')
			end
			
			if abil_recasts[5] < latency then
				windower.chat.input('/ja "Provoke" <t>')
			elseif abil_recasts[2] < latency then
				windower.chat.input('/ja "Warcry" <me>')
			elseif abil_recasts[3] < latency then
				windower.chat.input('/ja "Defender" <me>')
			elseif abil_recasts[4] < latency then
				windower.chat.input('/ja "Aggressor" <me>')
			elseif abil_recasts[1] < latency then
				windower.chat.input('/ja "Berserk" <me>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Warrior Job Abilities on cooldown.') end
			end
			
		elseif player.sub_job == 'DNC' then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']
        
			if under3FMs then
				if abil_recasts[220] < latency then
				send_command('@input /ja "'..state.CurrentStep.value..'" <t>')
				state.CurrentStep:cycle()
				return
				end
			elseif abil_recasts[221] < latency then
				windower.chat.input('/ja "Animated Flourish" <t>')
				return
			elseif abil_recasts[220] < latency and not buffactive['Finishing Move 5'] then
				send_command('@input /ja "'..state.CurrentStep.value..'" <t>')
				state.CurrentStep:cycle()
				return
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'Dancer job abilities not needed.') end
			end
		end

	end

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function weather_rune_match()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    if weather_rune or day_rune then
		return true
	else
		return false
	end
end

-- Get a count of the number of runes of a given type
function rune_count(rune)
    local count = 0
    local current_time = os.time()
    for _,entry in pairs(rune_timers) do
        if entry.rune == rune and entry.expires > current_time then
            count = count + 1
        end
    end
    return count
end

function job_tick()
	if check_hasso() then return true end
	if check_buff() then return true end
	if check_buffup() then return true end
	if state.AutoTankMode.value and player.target.type == "MONSTER" and not moving then
		if check_flash_foil() then return true end
		windower.send_command('gs c SubJobEnmity')
		tickdelay = (framerate * 1.5)
		return true
	end
	return false
end

function check_flash_foil()
	if silent_check_silence() then return false end
	local spell_recasts = windower.ffxi.get_spell_recasts()
	
	if not buffactive['Enmity Boost'] and spell_recasts[476] < spell_latency then
		windower.chat.input('/ma "Crusade" <me>')
		tickdelay = (framerate * 2)
		return true
	elseif spell_recasts[112] < spell_latency then
		windower.chat.input('/ma "Flash" <t>')
		tickdelay = (framerate * 2)
		return true
	elseif spell_recasts[840] < spell_latency then
		windower.chat.input('/ma "Foil" <me>')
		tickdelay = (framerate * 2)
		return true
	else
		return false
	end
end

function update_melee_groups()
	if player.equipment.main then
		classes.CustomMeleeGroups:clear()
		
		if player.equipment.main == "Epeolatry" and state.Buff['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('AM')
		end
	end	
end

function check_hasso()
	if not (state.Stance.value == 'None' or state.Buff.Hasso or state.Buff.Seigan) and player.sub_job == 'SAM' and player.in_combat then
		
		local abil_recasts = windower.ffxi.get_ability_recasts()
		
		if state.Stance.value == 'Hasso' and abil_recasts[138] < latency then
			windower.chat.input('/ja "Hasso" <me>')
			tickdelay = (framerate * 1.8)
			return true
		elseif state.Stance.value == 'Seigan' and abil_recasts[139] < latency then
			windower.chat.input('/ja "Seigan" <me>')
			tickdelay = (framerate * 1.8)
			return true
		end
	
	end
		
	return false
end

function check_buff()
	if state.AutoBuffMode.value and not areas.Cities:contains(world.area) then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		for i in pairs(buff_spell_lists['Auto']) do
			if not buffactive[buff_spell_lists['Auto'][i].Buff] and spell_recasts[buff_spell_lists['Auto'][i].SpellID] < latency and silent_can_use(buff_spell_lists['Auto'][i].SpellID) then
				windower.chat.input('/ma "'..buff_spell_lists['Auto'][i].Name..'" <me>')
				tickdelay = (framerate * 2)
				return true
			end
		end
		
		if player.in_combat then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			
			if not buffactive['Swordplay'] and abil_recasts[24] < latency then
				windower.chat.input('/ja "Swordplay" <me>')
				tickdelay = (framerate * 1.8)
				return true
			elseif player.sub_job == 'DRK' and not buffactive['Last Resort'] and abil_recasts[87] < latency then
				windower.chat.input('/ja "Last Resort" <me>')
				tickdelay = (framerate * 1.8)
				return true
			elseif player.sub_job == 'WAR' and not buffactive.Berserk and abil_recasts[1] < latency then
				windower.chat.input('/ja "Berserk" <me>')
				tickdelay = (framerate * 1.8)
				return true
			elseif player.sub_job == 'WAR' and not buffactive.Aggressor and abil_recasts[4] < latency then
				windower.chat.input('/ja "Aggressor" <me>')
				tickdelay = (framerate * 1.8)
				return true
			else
				return false
			end
		end
	end
		
	return false
end

function check_buffup()
	if buffup ~= '' then
		local needsbuff = false
		for i in pairs(buff_spell_lists[buffup]) do
			if not buffactive[buff_spell_lists[buffup][i].Buff] and silent_can_use(buff_spell_lists[buffup][i].SpellID) then
				needsbuff = true
				break
			end
		end
	
		if not needsbuff then
			add_to_chat(217, 'All '..buffup..' buffs are up!')
			buffup = ''
			return false
		end
		
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		for i in pairs(buff_spell_lists[buffup]) do
			if not buffactive[buff_spell_lists[buffup][i].Buff] and silent_can_use(buff_spell_lists[buffup][i].SpellID) and spell_recasts[buff_spell_lists[buffup][i].SpellID] < latency then
				windower.chat.input('/ma "'..buff_spell_lists[buffup][i].Name..'" <me>')
				tickdelay = (framerate * 2)
				return true
			end
		end
		
		return false
	else
		return false
	end
end

buff_spell_lists = {
	Auto = {	
		{Name='Crusade',Buff='Enmity Boost',SpellID=476},
		{Name='Temper',Buff='Multi Strikes',SpellID=493},
		{Name='Phalanx',Buff='Phalanx',SpellID=106},
	},
	
	Default = {
		{Name='Crusade',Buff='Enmity Boost',SpellID=476},
		{Name='Temper',Buff='Multi Strikes',SpellID=493},
		{Name='Haste',Buff='Haste',SpellID=57},
		{Name='Refresh',Buff='Refresh',SpellID=109},
		{Name='Aquaveil',Buff='Aquaveil',SpellID=55},
		{Name='Stoneskin',Buff='Stoneskin',SpellID=54},
		{Name='Blink',Buff='Blink',SpellID=53},
		{Name='Regen',Buff='Regen',SpellID=108},
		{Name='Phalanx',Buff='Phalanx',SpellID=106},
	},
}