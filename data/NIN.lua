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

	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
    state.Buff.Migawari = buffactive.Migawari or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false
	
	state.Stance = M{['description']='Stance','Innin','Yonin','None'}

	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Blade: Hi', 'Blade: Ten'}
	
	autows = "Blade: Shun"
	autofood = 'Soy Ramen'
	
	utsusemi_ni_cancel_delay = .1
	
	state.ElementalMode = M{['description'] = 'Elemental Mode','Fire','Water','Lightning','Earth','Wind','Ice','Light','Dark',}
	
	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoNukeMode","AutoStunMode","AutoDefenseMode","AutoBuffMode","ElementalWheel",},{"AutoSambaMode","Weapons","OffenseMode","WeaponskillMode","Stance","IdleMode","Passive","RuneElement","ElementalMode","CastingMode","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' and (player.equipment.ammo == 'Togakushi Shuriken' or player.equipment.ammo == 'Happo Shuriken') then
		cancel_spell()
		add_to_chat(123,'Abort: Don\'t throw your good ammo!')
    elseif spell.name == 'Sange' and (player.equipment.ammo == 'Togakushi Shuriken' or player.equipment.ammo == 'Happo Shuriken') then
		cancel_spell()
		add_to_chat(123,'Abort: Don\'t throw your good ammo!')
    end
end

function job_post_precast(spell, spellMap, eventArgs)

	if spell.type == 'WeaponSkill' then
		local WSset = get_precast_set(spell, spellMap)
		if not WSset.ear1 then WSset.ear1 = WSset.left_ear or '' end
		if not WSset.ear2 then WSset.ear2 = WSset.right_ear or '' end
		local wsacc = check_ws_acc()
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp > 2950 and (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			if wsacc:contains('Acc') and sets.AccMaxTP then
				if not sets.AccMaxTP.ear1 then sets.AccMaxTP.ear1 = sets.AccMaxTP.left_ear or '' end
				if not sets.AccMaxTP.ear2 then sets.AccMaxTP.ear2 = sets.AccMaxTP.right_ear or '' end
				if (sets.AccMaxTP.ear1:startswith("Lugra Earring") or sets.AccMaxTP.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayMaxTPWSEars then
					equip(sets.AccDayMaxTPWSEars)
				else
					equip(sets.AccMaxTP)
				end
			elseif sets.MaxTP then
				if not sets.MaxTP.ear1 then sets.MaxTP.ear1 = sets.MaxTP.left_ear or '' end
				if not sets.MaxTP.ear2 then sets.MaxTP.ear2 = sets.MaxTP.right_ear or '' end
				if (sets.MaxTP.ear1:startswith("Lugra Earring") or sets.MaxTP.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayMaxTPWSEars then
					equip(sets.DayMaxTPWSEars)
				else
					equip(sets.MaxTP)
				end
			else
			end
		else
			if wsacc:contains('Acc') and (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayWSEars then
				equip(sets.AccDayWSEars)
			elseif (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayWSEars then
				equip(sets.DayWSEars)
			end
		end
	end
	
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, spellMap, eventArgs)
    if spellMap == 'ElementalNinjutsu' then
        if state.MagicBurstMode.value ~= 'Off' then equip(sets.MagicBurst) end
		if spell.element == world.weather_element or spell.element == world.day_element then
			if state.CastingMode.value == 'Normal' or state.CastingMode.value == 'Fodder' then
				-- if item_available('Twilight Cape') and not state.Capacity.value then
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
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, spellMap, eventArgs)
    
	if spell.interrupted then return
	elseif spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
	elseif spellMap == 'ElementalNinjutsu' then
            if state.MagicBurstMode.value == 'Single' then
				state.MagicBurstMode:reset()
			end
			if state.DisplayMode.value then update_job_states()	end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	update_melee_groups()
end

function job_status_change(new_status, old_status)

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end

    return idleSet
end

function job_customize_kiting_set(kitingSet)
	if player.status == 'Idle' and moving and state.DefenseMode.value == 'None' and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') then
		if classes.DuskToDawn and sets.DuskKiting then
		kitingSet = set_combine(idleSet, sets.DuskKiting)
		end
	end
	
	return kitingSet
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

	if state.Buff.Yonin then 
		if state.DefenseMode.value == 'None' or state.DefenseMode.value == 'Evasion' then
			meleeSet = set_combine(meleeSet, sets.buff.Yonin)
		end
	elseif state.Buff.Innin then
		if (state.OffenseMode.value == 'Normal' or state.OffenseMode.value == 'Fodder') and state.DefenseMode.value == 'None' then
			meleeSet = set_combine(meleeSet, sets.buff.Innin)
		end
    end
	
	if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end

    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
	update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

--[[function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end]]--Removed for now.

function job_self_command(commandArgs, eventArgs)
		if commandArgs[1]:lower() == 'elemental' then
			handle_elemental(commandArgs)
			eventArgs.handled = true			
		end
end

function job_tick()
	if check_stance() then return true end
	if check_buff() then return true end
	if check_buffup() then return true end
	return false
end

function handle_elemental(cmdParams)
    -- cmdParams[1] == 'elemental'
    -- cmdParams[2] == ability to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No elemental command given.')
        return
    end
    local command = cmdParams[2]:lower()

	local spell_recasts = windower.ffxi.get_spell_recasts()
	
	if command == 'nuke' then
		local tiers = {'San','Ni','Ichi'}
		for k in ipairs(tiers) do
			if spell_recasts[get_spell_table_by_name(elements.ninnuke[state.ElementalMode.value]..': '..tiers[k]..'').id] < spell_latency then
				windower.chat.input('/ma "'..elements.ninnuke[state.ElementalMode.value]..': '..tiers[k]..'" <t>')
				return
			end
		end
		add_to_chat(123,'Abort: All '..elements.nuke[state.ElementalMode.value]..' nukes on cooldown or or not enough MP.')
	elseif S{'San','Ni','Ichi'}:contains(command) then
		windower.chat.input('/ma "'..elements.ninnuke[state.ElementalMode.value]..': '..command..'" <t>')
	elseif command == 'proc' then
		windower.chat.input('/ma "'..elements.ninnuke[state.ElementalMode.value]..': Ni" <t>')
	end
end

function update_melee_groups()
	if player.equipment.main then
		classes.CustomMeleeGroups:clear()
		
		if player.equipment.main == "Nagi" and state.Buff['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('AM')
		end
	end	
end

function check_stance()
	if state.Stance.value ~= 'None' and not (state.Buff.Innin or state.Buff.Yonin) and player.in_combat then
		
		local abil_recasts = windower.ffxi.get_ability_recasts()
		
		if state.Stance.value == 'Innin' and abil_recasts[147] < latency then
			windower.chat.input('/ja "Innin" <me>')
			tickdelay = framerate
			return true
		elseif state.Stance.value == 'Yonin' and abil_recasts[146] < latency then
			windower.chat.input('/ja "Yonin" <me>')
			tickdelay = framerate
			return true
		else
			return false
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

			if player.sub_job == 'WAR' and not buffactive.Berserk and not is_defensive() and abil_recasts[1] < latency then
				windower.chat.input('/ja "Berserk" <me>')
				tickdelay = (framerate * 1.8)
				return true
			elseif player.sub_job == 'WAR' and not buffactive.Aggressor and not is_defensive() and abil_recasts[4] < latency then
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
		{Name='Migawari: Ichi',Buff='Migawari',SpellID=510},
	},
	
	Default = {
		{Name='Myoshu: Ichi',Buff='Subtle Blow Plus',SpellID=507},
		{Name='Kakka: Ichi',Buff='Store TP',SpellID=509},
	},
}