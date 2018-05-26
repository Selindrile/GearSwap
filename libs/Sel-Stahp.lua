--Requires Gearswap and Motenten includes.

include('Sel-MonsterAbilities.lua')

state.AutoDefenseMode = M(false, 'Auto Defense Mode')
state.AutoEngageMode = M(false, 'Auto Engage Mode')
state.AutoStunMode = M(false, 'Auto Stun Mode')
state.BlockWarp = M(false, 'BlockWarp')

CureAbility = S{"Cure","Cure II","Cure III","Cure IV","Cure V","Cure VI","Magic Fruit","Wild Carrot","Plenilune Embrace","Curaga","Curaga II",
				"Curaga III","Curaga IV","Curaga V",
				 }

CuragaAbility = S{"Curaga","Curaga II","Curaga III","Curaga IV","Curaga V","Cura","Cura III","Cura III","White Wind",
				 }

ProshellAbility = S{"Protect","Protect II","Protect III","Protect IV","Protect V",
					"Shell","Shell II","Shell III","Shell IV","Shell V",
				 }

ProshellraAbility = S{"Protectra","Protectra II","Protectra III","Protectra IV","Protectra V",
					"Shellra","Shellra II","Shellra III","Shellra IV","Shellra V",
				 }

RefreshAbility = S{"Refresh","Refresh II", "Refresh III"
				 }

PhalanxAbility = S{"Phalanx II"
				 }

EnhancingAbility = S{"Haste","Haste II","Flurry","Flurry II","Adloquium",
				 }

windower.raw_register_event('action', function(act)

	--Gather Info
    local curact = T(act)
    local actor = T{}
	local otherTarget = T{}

    actor.id = curact.actor_id
	-- Make sure it's something we actually care about reacting to.
	if curact.category == 1 and not state.AutoEngageMode.value then return end
	if not ((curact.category == 1 or curact.category == 3 or curact.category == 4 or curact.category == 7 or curact.category == 8 or curact.category == 11 or curact.category == 13)) then return end
	-- Make sure it's a mob that's doing something.
    if windower.ffxi.get_mob_by_id(actor.id) then
        actor = windower.ffxi.get_mob_by_id(actor.id)
    else
        return
    end

	-- Check if we're targetting it.
    if player and player.target and player.target.id and actor.id == player.target.id then
        isTarget = true
    else
		isTarget = false
    end

	if curact.targets[1].id == nil then
		targetsMe = false
		targetsSelf = false
		otherTarget.in_party = false
		otherTarget.in_alliance = false
		targetsDistance = 50
	elseif curact.targets[1].id == player.id then
		otherTarget.in_party = false
		otherTarget.in_alliance = false
		targetsMe = true
		targetsSelf = false
		targetsDistance = 0
	elseif curact.targets[1].id == actor.id	then
		if windower.ffxi.get_mob_by_id(curact.targets[1].id) then
			otherTarget = windower.ffxi.get_mob_by_id(curact.targets[1].id)
		else
			otherTarget.in_party = false
			otherTarget.in_alliance = false
			otherTarget.distance = 10000
		end
		targetsMe = false
		targetsSelf = true
		targetsDistance = math.sqrt(otherTarget.distance)
	else
		if windower.ffxi.get_mob_by_id(curact.targets[1].id) then
			otherTarget = windower.ffxi.get_mob_by_id(curact.targets[1].id)
		else
			otherTarget.in_party = false
			otherTarget.in_alliance = false
			otherTarget.distance = 10000
		end
		targetsSelf = false
		targetsMe = false
		targetsDistance = math.sqrt(otherTarget.distance)
	end

	if state.AutoEngageMode.value and curact.category == 1 and targetsMe and actor.race == 0 and player.status == 'Idle' and not moving then
		if player.target.type == "MONSTER" then
			windower.chat.input('/attack')
		elseif player.target.type ~= 'NONE' then
			send_command('setkey escape down; wait .2;setkey escape up')
		end
		return
	end

	-- Track buffs locally
	if curact.category == 4 then
		act_info = res.spells[curact.param]
		if curact.targets[1].actions[1].message == 230 then
			if EnhancingAbility:contains(act_info.name) then
				if act_info.name:endswith('II') then
					if act_info.name:startswith('Haste') then
						lasthaste = 2
					elseif act_info.name:startswith('Flurry') then
						lastflurry = 2
					end
				else
					if act_info.name:startswith('Haste') then
						lasthaste = 1
					elseif act_info.name:startswith('Flurry') then
						lastflurry = 1
					end
				end
			end
		end
	end

	-- Turn off Defense if needed for things we're targetting.
	if (curact.category == 3 or curact.category == 4 or curact.category == 11 or curact.category == 13) then
		if isTarget and player.target.type == "MONSTER" and state.AutoDefenseMode.value and state.DefenseMode.value ~= 'None' then
			if player.main_job == 'PLD' and state.EquipShield.value then
				if state.DefenseMode.value ~= 'Physical' then
					send_command('gs c set DefenseMode Physical')
				end
				return
			else
				send_command('gs c reset DefenseMode')
				return
			end
		elseif not midaction() and not pet_midaction() and (targetsMe or (otherTarget.in_alliance and targetsDistance < 10)) then
			send_command('gs c update')
			return
		end
	end

	-- Make sure it's not US from this point on!
	if actor.id == player.id then return end
    -- Make sure it's a WS or MA precast before reacting to it.
    if curact.category ~= 7 and curact.category ~= 8 then return end

    -- Get the name of the action.
    if curact.category == 7 then act_info = res.monster_abilities[curact.targets[1].actions[1].param] end
    if curact.category == 8 then act_info = res.spells[curact.targets[1].actions[1].param] end
	if act_info == nil then return end

	-- Reactions begin.
	if state.BlockWarp.value and ((targetsMe and (act_info.name == 'Warp II' or act_info.name == 'Retrace')) or (actor.in_party and (act_info.name:contains('Teleport') or act_info.name:contains('Recall')))) then
		local party = windower.ffxi.get_party()

		if party.party1_leader == player.id then
			windower.chat.input('/pcmd kick '..actor.name..'')
		else
			windower.chat.input('/pcmd leave')
		end

	elseif midaction() or curact.category ~= 8 or state.DefenseMode.value ~= 'None' then

	--[[
	elseif targetsMe then
		if CureAbility:contains(act_info.name) and player.hpp < 75 then
			if sets.Cure_Received then
				do_equip('sets.Cure_Received')
			elseif sets.Self_Healing then
				do_equip('sets.Self_Healing')
			end
			return
		elseif RefreshAbility:contains(act_info.name) then
			if sets.Refresh_Received then
				do_equip('sets.Refresh_Received')
			elseif sets.Self_Refresh then
				do_equip('sets.Self_Refresh')
			end
			return
		elseif PhalanxAbility:contains(act_info.name) then
			if sets.Phalanx_Received then
				do_equip('sets.Phalanx_Received')
			elseif sets.midcast.Phalanx then
				do_equip('sets.midcast.Phalanx')
			end
			return
		elseif ProshellAbility:contains(act_info.name) then
			if sets.Sheltered then do_equip('sets.Sheltered') return end
		end
	elseif actor.in_party and otherTarget.in_party and targetsDistance < 10 then
		if CuragaAbility:contains(act_info.name) and player.hpp < 75 then
			if sets.Cure_Received then
				do_equip('sets.Cure_Received')
			elseif sets.Self_Healing then
				do_equip('sets.Self_Healing')
			end
			return
		elseif ProshellraAbility:contains(act_info.name) and sets.Sheltered then
			do_equip('sets.Sheltered') return
		end

		]]--
	end

	-- Make sure this is our target. 	send_command('input /echo Actor:'..actor.id..' Target:'..player.target.id..'')
	if isTarget and state.AutoStunMode.value and player.target.type == "MONSTER" and not moving then
		if curact.param == 24931 then
			if StunAbility:contains(act_info.name) and not midaction() and not pet_midaction() then
				gearswap.refresh_globals(false)
				if not (buffactive.silence or  buffactive.mute or buffactive.Omerta) then
						local spell_recasts = windower.ffxi.get_spell_recasts()

					if player.main_job == 'BLM' or player.sub_job == 'BLM' or player.main_job == 'DRK' or player.sub_job == 'DRK' and spell_recasts[252] == 0 then
						windower.chat.input('/ma "Stun" <t>') return
					elseif player.main_job == 'BLU' and spell_recasts[692] == 0 then
						windower.chat.input('/ma "Sudden Lunge" <t>') return
					elseif player.sub_job == 'BLU' and spell_recasts[623] == 0 then
						windower.chat.input('/ma "Head Butt" <t>') return
					end
				end

				local abil_recasts = windower.ffxi.get_ability_recasts()

				if buffactive.amnesia or buffactive.impairment then return
				elseif (player.main_job == 'PLD' or player.sub_job == 'PLD') and abil_recasts[73] == 0 then
					windower.chat.input('/ja "Shield Bash" <t>') return
				elseif (player.main_job == 'DRK' or player.sub_job == 'DRK') and abil_recasts[88] == 0 then
					windower.chat.input('/ja "Weapon Bash" <t>') return
				elseif player.main_job == 'SMN' and pet.name == "Ramuh" and abil_recasts[174] == 0 then
					windower.chat.input('/pet "Shock Squall" <t>') return
				elseif not player.in_combat then
					add_to_chat(123,'No stuns ready! Good luck!') return
				elseif (player.main_job == 'DNC' or player.sub_job == 'DNC') and abil_recasts[221] == 0 then
					windower.chat.input('/ja "Violent Flourish" <t>') return
				end

				local available_ws = S(windower.ffxi.get_abilities().weapon_skills)

				if available_ws:contains(35) then
					windower.chat.input('/ws "Flat Blade" <t>') return
				elseif available_ws:contains(145) then
					windower.chat.input('/ws "Tachi Hobaku" <t>') return
				elseif available_ws:contains(2) then
					windower.chat.input('/ws "Shoulder Tackle" <t>') return
				elseif available_ws:contains(65) then
					windower.chat.input('/ws "Smash Axe" <t>') return
				elseif available_ws:contains(115) then
					windower.chat.input('/ws "Leg Sweep" <t>') return
				else
					add_to_chat(123,'No stuns ready! Good luck!')
				end
				return
			end
		end

	elseif state.AutoDefenseMode.value and (targetsMe or (((otherTarget.in_alliance and targetsDistance < 10) or targetsSelf) and AoEAbility:contains(act_info.name))) then
		if curact.param == 24931 then
			if PhysicalAbility:contains(act_info.name) and state.DefenseMode.value ~= 'Physical' then
				send_command('gs c set DefenseMode Physical')
			elseif MagicalAbility:contains(act_info.name) and state.DefenseMode.value ~= 'Magical'  then
				send_command('gs c set DefenseMode Magical')
			elseif ResistAbility:contains(act_info.name) and state.DefenseMode.value ~= 'Resist'  then
				send_command('gs c set DefenseMode Resist')
			end
		end
	end

end)
