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

    -- List of pet weaponskills to check for
    petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar",
        "Chimera Ripper", "String Clipper",  "Cannibal Blade", "Bone Crusher", "String Shredder",
        "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}

    -- Map automaton heads to combat roles

	state.PartyChatWS = M(false, 'Report pet weaponskills in party chat.')

    -- Subset of modes that use magic
    magicPetModes = S{'Nuke','Heal','Magic'}

    -- Var to track the current pet mode.
    state.PetMode = M{['description']='Pet Mode', 'None','Melee','Ranged','Tank','LightTank','Magic','Heal','Nuke'}

	state.AutoPuppetMode = M(false, 'Auto Puppet Mode')
	state.AutoRepairMode = M(true, 'Auto Repair Mode')
	state.AutoDeployMode = M(true, 'Auto Deploy Mode')
	state.PetWSGear		 = M(true, 'Pet WS Gear')

    autows = "Victory Smite"
	autofood = 'Akamochi'
	lastpettp = 0
	deactivatehpp = 100
	repairhpp = 45

	update_pet_mode()
	update_melee_groups()
	init_job_states({"Capacity","AutoPuppetMode","PetWSGear","AutoRepairMode","AutoRuneMode","AutoTrustMode","AutoWSMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoBuffMode",},{"AutoSambaMode","Weapons","OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)

end

function job_precast(spell, spellMap, eventArgs)

end

function job_post_precast(spell, spellMap, eventArgs)

end

-- Called when pet is about to perform an action
function job_pet_midcast(spell, spellMap, eventArgs)
    if petWeaponskills:contains(spell.english) then
        classes.CustomClass = "Weaponskill"

		if sets.midcast.Pet.WeaponSkill[spell] then
			equip(sets.midcast.Pet.WeaponSkill[spell.english])
		else
			equip(sets.midcast.Pet.WeaponSkill)
		end
    end
end

function job_pet_aftercast(spell, spellMap, eventArgs)
    if petWeaponskills:contains(spell.english) then
        classes.CustomClass = "Weaponskill"
		if state.PartyChatWS.value then
			windower.chat.input('/p '..auto_translate('Automaton')..' '..auto_translate('Weapon Skill')..' '..spell.english..'')
		end
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	update_melee_groups()
end

-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(pet, gain)
    update_pet_mode()
end

-- Called when the pet's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
	if newStatus == "Engaged" and pet.isvalid and pet.status == "Idle" and player.target.type == "MONSTER" and state.AutoDeployMode.value and player.target.distance < 20 then
		windower.chat.input('/pet Deploy <t>')
	end

--[[
    if newStatus == 'Engaged' then
        display_pet_status()
    end
]]--
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_pet_mode()
	update_melee_groups()
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_pet_status()
end

function job_customize_idle_set(idleSet)
	if pet.isvalid and state.PetWSGear.value and pet.tp and pet.tp > 999 and sets.midcast.Pet then
		if sets.midcast.Pet.PetWSGear and sets.midcast.Pet.PetWSGear[state.PetMode.value] then
			idleSet = set_combine(idleSet, sets.midcast.Pet.PetWSGear[state.PetMode.value])
		elseif sets.midcast.Pet.PetWSGear then
			idleSet = set_combine(idleSet, sets.midcast.Pet.PetWSGear)
		end
	end
	return idleSet
end

function job_customize_melee_set(meleeSet)
	if pet.isvalid and state.PetWSGear.value and pet.tp and pet.tp > 999 and player.tp > 999 and sets.midcast.Pet then
		if sets.midcast.Pet.PetWSGear and sets.midcast.Pet.PetWSGear[state.PetMode.value] then
			meleeSet = set_combine(meleeSet, sets.midcast.Pet.PetWSGear[state.PetMode.value])
		elseif sets.midcast.Pet.PetWSGear then
			meleeSet = set_combine(meleeSet, sets.midcast.Pet.PetWSGear)
		end
	end

    return meleeSet
end
-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(commandArgs, eventArgs)
	if commandArgs[1] == 'maneuver' then
        if pet.isvalid then
            local man = defaultManeuvers[state.PetMode.value]
            if man and tonumber(commandArgs[2]) then
                man = man[tonumber(commandArgs[2])]
            end

            if man then
                send_command('input /pet "'..man..'" <me>')
            end
        else
            add_to_chat(123,'No valid pet.')
        end
    end
end

function job_tick()
	if check_repair() then return true end
	if check_auto_pet() then return true end
	if check_maneuver() then return true end

	if state.PetWSGear.value and pet.isvalid and pet.tp and pet.tp ~= lastpettp then
		if (pet.tp > 999 and lastpettp < 1000) or (pet.tp < 1000 and lastpettp > 999) then
			windower.send_command('gs c update')
		end
		lastpettp = pet.tp
	end

	return false
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Get the pet mode value based on the equipped frame of the automaton.
-- Returns nil if pet is not valid.
function get_pet_mode()
    if pet.isvalid then
		if pet.frame == 'Sharpshot Frame' then
			return 'Ranged'
		elseif pet.frame == 'Valoredge Frame' then
			if pet.head == 'Soulsoother Head' then
				return 'Tank'
			else
				return 'Melee'
			end
		elseif pet.head == 'Sharpshot Head' or pet.head == 'Stormwaker Head' then
			return 'Magic'
		elseif pet.head == 'Spiritreaver Head' then
			return 'Nuke'
		elseif pet.frame == 'Harlequin Frame' then
			if pet.head == 'Harlequin Head' then
				return 'Melee'
			else
				return 'LightTank'
			end
		else
				if pet.head == 'Soulsoother Head' then
					return 'Heal'
				elseif pet.head == 'Valoredge Head' then
					return 'Melee'
				else
					return 'Magic'
				end
		end
    else
        return 'None'
    end
end

-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()
    state.PetMode:set(get_pet_mode())
    update_custom_groups()
end

-- Update custom groups based on the current pet.
function update_custom_groups()
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        classes.CustomIdleGroups:append(state.PetMode.value)
    end
end

-- Display current pet status.
function display_pet_status()
    if pet.isvalid then
        local petInfoString = pet.name..' ['..pet.head..']['..pet.frame..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)

        if magicPetModes:contains(state.PetMode.value) then
            petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
        end

        add_to_chat(122,petInfoString)
    end
end

function update_melee_groups()
	if player.equipment.main then
		classes.CustomMeleeGroups:clear()

		if player.equipment.main == "Kenkonken" and state.Buff['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('AM')
		end
	end
end

function check_auto_pet()

	if not state.AutoPuppetMode.value or areas.Cities:contains(world.area) then return false end

	local abil_recasts = windower.ffxi.get_ability_recasts()

	if not pet.isvalid then

		if abil_recasts[205] == 0 then
			windower.chat.input('/ja "Activate" <me>')
			tickdelay = (framerate * .5)
			return true
		elseif abil_recasts[115] == 0 then
			windower.chat.input('/ja "Deus Ex Automata" <me>')
			tickdelay = (framerate * .5)
			return true
		end

	elseif pet.status == "Idle" then
		if pet.max_mp > 50 and pet.mpp < 10 and pet.hpp <= deactivatehpp and abil_recasts[208] == 0 then
			windower.chat.input('/pet "Deactivate" <me>')
			tickdelay = (framerate * .5)
			return true
		elseif player.target.type == "MONSTER" and abil_recasts[207] == 0 then
			windower.chat.input('/pet "Deploy" <t>')
			tickdelay = (framerate * .5)
			return true
		end
	end

	return false
end

function check_repair()

	if state.AutoRepairMode.value and pet.isvalid and pet.hpp < repairhpp then
		local abil_recasts = windower.ffxi.get_ability_recasts()

		if abil_recasts[206] == 0 and item_available('Automat. Oil +3') then
			windower.chat.input('/ja "Repair" <me>')
			tickdelay = (framerate * .5)
			return true
		end
	end

	return false
end

function check_maneuver()
	if state.AutoBuffMode.value and pet.isvalid and pet.status == 'Engaged' and windower.ffxi.get_ability_recasts()[210] == 0 then
		for i,maneuver in ipairs(defaultManeuvers[state.PetMode.value]) do
			if should_use_maneuver(maneuver) then
				windower.chat.input('/pet "'..maneuver..'" <me>')
				tickdelay = (framerate * .5)
				return true
			end
		end
	end

	return false
end

function should_use_maneuver(maneuver)
	if autoManeuvers then
		if not autoManeuvers[state.PetMode.Value][maneuver] then
			return false
		elseif autoManeuvers[state.PetMode.Value][maneuver] > 0 and not buffactive[maneuver] then
			return true
		else
			return buffactive[maneuver] < autoManeuvers[state.PetMode.Value][maneuver]
		end
	else
		return not buffactive[maneuver]
	end
end


function job_aftercast(spell, spellMap, eventArgs)
	if pet_midaction() or spell.english == 'Activate' or spell.english == 'Deus Ex Automata' then
		eventArgs.handled = true
	end
end