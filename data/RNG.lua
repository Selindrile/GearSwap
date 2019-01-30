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

	state.AutoAmmoMode = M(true,'Auto Ammo Mode')
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Double Shot'] = buffactive['Double Shot'] or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
	state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
	
	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Jishnu\'s Radiance','Empyreal Arrow','Last Stand'}
	
	autows = "Last Stand"
	rangedautows = "Last Stand"
	autofood = 'Soy Ramen'
	ammostock = 198
	
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoWSMode","AutoShadowMode","AutoFoodMode","RngHelper","AutoStunMode","AutoDefenseMode","AutoBuffMode",},{"AutoSambaMode","Weapons","OffenseMode","RangedMode","WeaponskillMode","IdleMode","Passive","RuneElement","TreasureMode",})
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
	if spell.action_type == 'Ranged Attack' then
		state.CombatWeapon:set(player.equipment.range)
	end

	if spell.action_type == 'Ranged Attack' or
	  (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
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
	elseif spell.action_type == 'Ranged Attack' and sets.precast.RA and buffactive.Flurry then
		if sets.precast.RA.Flurry and lastflurry == 1 then
			equip(sets.precast.RA.Flurry)
		elseif sets.precast.RA.Flurry and lastflurry == 2 then
			equip(sets.precast.RA.Flurry2)
		end
	end
end

function job_self_command(commandArgs, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		if state.Buff['Camouflage'] and sets.buff.Camouflage then
			if sets.buff['Camouflage'][state.RangedMode.value] then
				equip(sets.buff['Camouflage'][state.RangedMode.value])
			else
				equip(sets.buff['Camouflage'])
			end
		end
		if state.Buff['Double Shot'] and sets.buff['Double Shot'] then
			if sets.buff['Double Shot'][state.RangedMode.value] then
				equip(sets.buff['Double Shot'][state.RangedMode.value])
			else
				equip(sets.buff['Double Shot'])
			end
		end

		if state.Buff.Barrage and sets.buff.Barrage then
			equip(sets.buff.Barrage)
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
	if buff:contains('Aftermath') then
		classes.CustomRangedGroups:clear()
		if player.equipment.Ranged then
			if (player.equipment.Ranged == 'Armageddon' and (buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.3']))
			or (player.equipment.Ranged == 'Gandiva' and (buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.3']))
			or (player.equipment.Ranged == "Annihilator" and state.Buff['Aftermath'])
			or (player.equipment.Ranged == "Yoichinoyumi" and state.Buff['Aftermath']) then
				classes.CustomRangedGroups:append('AM')
			end
		end
	end
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        if not buffactive['Velocity Shot'] then
            send_command('@input /ja "Velocity Shot" <me>')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] or player.wardrobe2[U_Shot_Ammo[player.equipment.range]] or player.wardrobe3[U_Shot_Ammo[player.equipment.range]] or player.wardrobe4[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] or player.wardrobe2[DefaultAmmo[player.equipment.range]] or player.wardrobe3[DefaultAmmo[player.equipment.range]] or player.wardrobe4[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] or player.wardrobe2[DefaultAmmo[player.equipment.range]] or player.wardrobe3[DefaultAmmo[player.equipment.range]] or player.wardrobe4[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] or player.wardrobe2[DefaultAmmo[player.equipment.range]] or player.wardrobe3[DefaultAmmo[player.equipment.range]] or player.wardrobe4[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			end
		else
			if count_available_ammo(player.equipment.ammo) < 15 then
				add_to_chat(122,"Ammo '"..player.equipment.ammo.."' running low: ("..count_available_ammo(player.equipment.ammo)..") remaining.")
			end
		end
	end
end

function job_tick()
	if check_ammo() then return true end
	return false
end
