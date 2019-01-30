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

	state.Buff['Brazen Rush'] = buffactive['Brazen Rush'] or false
	state.Buff["Warrior's Charge"] = buffactive["Warrior's Charge"] or false
	state.Buff.Mighty = buffactive['Mighty Strikes']  or false
	state.Buff.Retaliation = buffactive['Retaliation'] or false
	state.Buff.Restraint = buffactive['Restraint'] or false
    state.Buff['Aftermath'] = buffactive['Aftermath'] or false
	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
	state.Stance = M{['description']='Stance','Hasso','Seigan','None'}
	
	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Savage Blade','Upheaval','Ruinator','Resolution','Rampage','Raging Rush',"Ukko's Fury",}

	autows = "Ukko's Fury"
	autofood = 'Soy Ramen'
	
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoBuffMode",},{"AutoSambaMode","Weapons","OffenseMode","WeaponskillMode","Stance","IdleMode","Passive","RuneElement","TreasureMode",})
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
		if available_ws:contains(48) then
            if spell.english == "Upheaval" then
				windower.chat.input('/ws "Resolution" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Ukko's Fury" then
                send_command('@input /ws "Ground Strike" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            end
        end
	end
end

function job_precast(spell, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' and state.AutoBuffMode.value then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if player.tp < 2250 and not buffactive['Blood Rage'] and abil_recasts[2] < latency then
			eventArgs.cancel = true
			windower.chat.input('/ja "Warcry" <me>')
			windower.chat.input:schedule(1,'/ws "'..spell.english..'" '..spell.target.raw..'')
			return
		elseif player.sub_job == 'SAM' and player.tp > 1850 and abil_recasts[140] < latency then
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

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

	if not state.OffenseMode.value:contains('Acc') and state.HybridMode.value == 'Normal' and buffactive['Retaliation'] then
		meleeSet = set_combine(meleeSet, sets.buff.Retaliation)
	end
	
	if not state.OffenseMode.value:contains('Acc') and state.HybridMode.value == 'Normal' and buffactive['Restraint'] then
		meleeSet = set_combine(meleeSet, sets.buff.Restraint)
	end
	
    return meleeSet
end

-- Run after the general precast() is done.
function job_post_precast(spell, spellMap, eventArgs)

	if spell.type == 'WeaponSkill' then

		local WSset = get_precast_set(spell, spellMap)
		if not WSset.ear1 then WSset.ear1 = WSset.left_ear or '' end
		if not WSset.ear2 then WSset.ear2 = WSset.right_ear or '' end
		
		local wsacc = check_ws_acc()

        -- Replace Moonshade Earring if we're at cap TP
		if player.tp > 2950 and (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			if wsacc:contains('Acc') and not buffactive['Sneak Attack'] and sets.AccMaxTP then
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
			if wsacc:contains('Acc') and not buffactive['Sneak Attack'] and (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayWSEars then
				equip(sets.AccDayWSEars)
			elseif (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayWSEars then
				equip(sets.DayWSEars)
			end
		end

		if wsacc:contains('Acc') and not buffactive['Sneak Attack'] then
			if state.Buff.Charge and state.Buff.Mighty and sets.ACCWSMightyCharge then
				equip(sets.ACCWSMightyCharge)
			elseif state.Buff.Charge and sets.ACCWSCharge then
				equip(sets.ACCWSCharge)
			elseif state.Buff.Mighty and sets.ACCWSMighty then
				equip(sets.AccWSMighty)
			end
		else
			if state.Buff.Charge and state.Buff.Mighty and sets.WSMightyCharge then
				equip(sets.WSMightyCharge)
			elseif state.Buff.Charge and sets.WSCharge then
				equip(sets.WSCharge)
			elseif state.Buff.Mighty and sets.WSMighty then
				equip(sets.WSMighty)
			end
		end

	end

end

function job_tick()
	if check_hasso() then return true end
	if check_buff() then return true end
	return false
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_melee_groups()
	
	if player.sub_job ~= 'SAM' and state.Stance.value ~= "None" then
		state.Stance:set("None")
	end
end

function job_buff_change(buff, gain)
	update_melee_groups()
end

function update_melee_groups()
    if player then
		classes.CustomMeleeGroups:clear()
		
		if areas.Adoulin:contains(world.area) and buffactive.Ionis then
			classes.CustomMeleeGroups:append('Adoulin')
		end
		
		if state.Buff['Brazen Rush'] or state.Buff["Warrior's Charge"] then
			classes.CustomMeleeGroups:append('Charge')
		end
		
		if state.Buff.Mighty then
			classes.CustomMeleeGroups:append('Mighty')
		end
		
		if (player.equipment.main == "Conqueror" and buffactive['Aftermath: Lv.3']) or ((player.equipment.main == "Bravura" or player.equipment.main == "Ragnarok") and state.Buff['Aftermath']) then
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
		else
			return false
		end
	end

	return false
end

function check_buff()
	if state.AutoBuffMode.value and player.in_combat then
		
		local abil_recasts = windower.ffxi.get_ability_recasts()

		if not buffactive.Retaliation and abil_recasts[8] < latency then
			windower.chat.input('/ja "Retaliation" <me>')
			tickdelay = (framerate * 1.8)
			return true		
		elseif not buffactive.Restraint and abil_recasts[9] < latency then
			windower.chat.input('/ja "Restraint" <me>')
			tickdelay = (framerate * 1.8)
			return true
		elseif not buffactive['Blood Rage'] and abil_recasts[11] < latency then
			windower.chat.input('/ja "Blood Rage" <me>')
			tickdelay = (framerate * 1.8)
			return true
		elseif not buffactive.Berserk and abil_recasts[1] < latency then
			windower.chat.input('/ja "Berserk" <me>')
			tickdelay = (framerate * 1.8)
			return true
		elseif not buffactive.Aggressor and abil_recasts[4] < latency then
			windower.chat.input('/ja "Aggressor" <me>')
			tickdelay = (framerate * 1.8)
			return true
		else
			return false
		end
	end
		
	return false
end