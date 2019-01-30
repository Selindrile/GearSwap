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
	state.Buff['Spirit Surge'] = buffactive['Spirit Surge'] or false
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
	state.Stance = M{['description']='Stance','Hasso','Seigan','None'}
	state.AutoJumpMode = M(false, 'Auto Jump Mode')
	
	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Stardiver'}

	autows = 'Stardiver'
	autofood = 'Soy Ramen'

	Breath_HPP = 60
	
	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoJumpMode","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoBuffMode",},{"AutoSambaMode","Weapons","OffenseMode","WeaponskillMode","Stance","IdleMode","Passive","RuneElement","TreasureMode",})
end

function job_precast(spell, spellMap, eventArgs)

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
    end

end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, spellMap, eventArgs)

	if spell.action_type == 'Magic' and player.hpp > 25 and player.hpp < Breath_HPP and pet.isvalid then
		equip(sets.midcast.HB_Trigger)
	end

end

-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, spellMap, eventArgs)

end

function job_aftercast(spell, spellMap, eventArgs)
	if pet.isvalid then
		if (spell.action_type == 'Magic' and player.hpp < Breath_HPP) then
			eventArgs.handled = true
			equip(sets.HealingBreath)
		elseif (spell.english == 'Restoring Breath' or spell.english == 'Smiting Breath' or spell.english == 'Steady Wing') then
			eventArgs.handled = true
		end
	end
end

function job_buff_change(buff, gain)
	update_melee_groups()
end

function job_update(cmdParams, eventArgs)
    update_melee_groups()
	find_breath_hpp()
	
	if player.sub_job ~= 'SAM' and state.Stance.value ~= "None" then
		state.Stance:set("None")
	end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if areas.Adoulin:contains(world.area) and buffactive.Ionis then
		classes.CustomMeleeGroups:append('Adoulin')
    end
	
	if player.equipment.main and player.equipment.main == "Ryunohige" and state.Buff['Aftermath: Lv.3'] then
		classes.CustomMeleeGroups:append('AM')
	end
    
  -- Spirit Surge modifies the custom melee groups
    if state.Buff['Spirit Surge'] then
        classes.CustomMeleeGroups:append('SpiritSurge')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(commandArgs, eventArgs)

end

function job_tick()
	if check_hasso() then return true end
	if check_jump() then return true end
	if check_buff() then return true end
	return false
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)
    return meleeSet
end

function check_hasso()
	if not (state.Stance.value == 'None' or state.Buff.Hasso or state.Buff.Seigan) and player.sub_job == 'SAM' and player.status == 'Engaged' then
		
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

function check_jump()
    if state.AutoJumpMode.value and player.status == 'Engaged' and player.tp < 501 then

        local abil_recasts = windower.ffxi.get_ability_recasts()

        if abil_recasts[166] < latency then
            windower.chat.input('/ja "Spirit Jump" <t>')
            tickdelay = (framerate * 1.8)
            return true
        elseif abil_recasts[167] < latency then
            windower.chat.input('/ja "Soul Jump" <t>')
            tickdelay = (framerate * 1.8)
            return true
        elseif abil_recasts[158] < latency then
            windower.chat.input('/ja "Jump" <t>')
            tickdelay = (framerate * 1.8)
            return true
        elseif abil_recasts[159] < latency then
            windower.chat.input('/ja "High Jump" <t>')
            tickdelay = (framerate * 1.8)
            return true
        elseif pet.isvalid and abil_recasts[162] < latency and pet.tp > 350 then
            windower.chat.input('/ja "Spirit Link" <me>')
            tickdelay = (framerate * 1.8)
            return true
        else
            return false
        end
    end
end

function check_buff()
	if state.AutoBuffMode.value and player.in_combat then
		
		local abil_recasts = windower.ffxi.get_ability_recasts()

		if player.sub_job == 'DRK' and not buffactive['Last Resort'] and abil_recasts[87] < latency then
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
		
	return false
end

function find_breath_hpp()
	if S{'WHM','BLM','RDM','SMN','BLU','SCH','GEO'}:contains(player.sub_job) then
		if sets.midcast.HB_Trigger and (sets.midcast.HB_Trigger.head:contains('Vishap') or sets.midcast.HB_Trigger.head:contains('Drachen')) then
			Breath_HPP = 65
		else
			Breath_HPP = 45
		end
	elseif S{'PLD','DRK','BRD','NIN','RUN'}:contains(player.sub_job) then
		if sets.midcast.HB_Trigger and (sets.midcast.HB_Trigger.head:contains('Vishap') or sets.midcast.HB_Trigger.head:contains('Drachen')) then
			Breath_HPP = 45
		else
			Breath_HPP = 35
		end
	end
end