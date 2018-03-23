-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job.
function get_sets()
    -- Load and initialize the include file.
    include('Sel-Include.lua')
end

function job_setup()

	state.Buff['Mana Wall'] = buffactive['Mana Wall'] or false

  LowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
      'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
      'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga'}

  state.DeathMode   = M{['description'] = 'Death Mode', 'Off', 'Single', 'Lock'}
	state.RecoverMode = M('35%', '60%', 'Always', 'Never')
	autows = 'Vidohunir'
	autofood = 'Pear Crepe'

	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoNukeMode","AutoWSMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoBuffMode",},{"Weapons","OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","RecoverMode","ElementalMode","CastingMode","TreasureMode",})
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

	if spell.action_type == 'Magic' then
    --[[
		if spellMap == 'Cure' or spellMap == 'Curaga' then
			gear.default.obi_back = gear.obi_cure_back
			gear.default.obi_waist = gear.obi_cure_waist
		elseif spell.english == 'Death' or (spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble') then
			if LowTierNukes:contains(spell.english) then
				gear.default.obi_back = gear.obi_low_nuke_back
				gear.default.obi_waist = gear.obi_low_nuke_waist
			else
				gear.default.obi_back = gear.obi_high_nuke_back
				gear.default.obi_waist = gear.obi_high_nuke_waist
			end
		end
    ]]--
    if state.CastingMode.value == 'OccAcumen' then
      classes.CustomClass = 'OccAcumen'
    end
    if state.CastingMode.value == 'Proc' then
      classes.CustomClass = 'Proc'
    end
    if state.DeathMode.value ~= 'Off' then
      classes.CustomClass = 'Death'
    end
	end
end

function job_post_precast(spell, spellMap, eventArgs)

	if spell.action_type == 'Magic' and state.DeathMode.value ~= 'Off' then
		equip(sets.precast.FC.Death)
	end

	if state.Buff['Mana Wall'] and (state.IdleMode.value:contains('DT') or state.DefenseMode.value ~= 'None') then
		equip(sets.buff['Mana Wall'])
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

		elseif is_nuke(spell, spellMap) and spell.english ~= 'Impact' then
			if state.MagicBurstMode.value ~= 'Off' then equip(sets.MagicBurst) end

			if player.hpp < 75 and player.tp < 1000 and state.CastingMode.value == 'Fodder' then
				if item_available("Sorcerer's Ring") then
					sets.SorcRing = {ring1="Sorcerer's Ring"}
					equip(sets.SorcRing)
				end
			end

			if spell.element == world.weather_element or spell.element == world.day_element then
        -- adding obi back to this, since my base sets never include obi
        equip(sets.ElementalObi)
				if state.CastingMode.value == 'Fodder' then
          --[[
          -- Not worth gearing Twilight cape on nukes
					if item_available('Twilight Cape') and not state.Capacity.value then
						sets.TwilightCape = {back="Twilight Cape"}
						equip(sets.TwilightCape)
					end
					if spell.element == world.day_element then
						if item_available('Zodiac Ring') then
							sets.ZodiacRing = {ring2="Zodiac Ring"}
							equip(sets.ZodiacRing)
						end
					end
          ]]--
				end
			end

			if spell.element and sets.element[spell.element] then
				equip(sets.element[spell.element])
			end

			if state.RecoverMode.value == 'Always' or (state.RecoverMode.value == '60%' and player.mpp < 60) or (state.RecoverMode.value == '35%' and player.mpp < 35) then
				if state.MagicBurstMode.value ~= 'Off' and sets.RecoverBurst then
					equip(sets.RecoverBurst)
				else
					equip(sets.RecoverMP)
				end
			end
		end

		if state.Buff['Mana Wall'] and (state.IdleMode.value:contains('DT') or state.DefenseMode.value ~= 'None') then
			equip(sets.buff['Mana Wall'])
		end
	end
end

function job_aftercast(spell, spellMap, eventArgs)
  -- Lock feet after using Mana Wall.
  if not spell.interrupted then
    if spell.english == 'Sleep' or spell.english == 'Sleepga' then
      send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
    elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
      send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
    elseif spell.skill == 'Elemental Magic' and state.MagicBurstMode.value == 'Single' then
      state.MagicBurstMode:reset()
      if state.DisplayMode.value then
        update_job_states()
      end
      elseif spell.english == "Death" and state.DeathMode.value == 'Single' then
        state.DeathMode:reset()
        if state.DisplayMode.value then
          update_job_states()
        end
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
    if world.weather_element == 'Light' then
      return 'LightWeatherCure'
		elseif world.day_element == 'Light' then
      return 'LightDayCure'
    end

  elseif spell.skill == 'Elemental Magic' then
		if default_spell_map == 'ElementalEnfeeble' or spell.english:contains('helix') then
  		return
    elseif LowTierNukes:contains(spell.english) then
      return 'LowTierNuke'
    else
      return 'HighTierNuke'
    end

	elseif spell.skill == "Enfeebling Magic" then
		if spell.english:startswith('Dia') then
			return "Dia"
		elseif spell.type == "WhiteMagic" or spell.english:startswith('Frazzle') or spell.english:startswith('Distract') then
			return 'MndEnfeebles'
		else
			return 'IntEnfeebles'
		end
  end

end

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
  if player.mpp < 51 and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') and state.DefenseMode.value == 'None' then
    idleSet = set_combine(idleSet, sets.latent_refresh)
  end

	if state.DeathMode.value ~= 'Off' then
    idleSet = set_combine(idleSet, sets.idle.Death)
  end

  if state.Buff['Mana Wall'] then
		idleSet = set_combine(idleSet, sets.buff['Mana Wall'])
  end

  return idleSet
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

  if state.Buff['Mana Wall'] then
		meleeSet = set_combine(meleeSet, sets.buff['Mana Wall'])
  end

  return meleeSet
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
  display_current_caster_state()
  eventArgs.handled = true
end

function job_self_command(commandArgs, eventArgs)
	if commandArgs[1]:lower() == 'elemental' then
		handle_elemental(commandArgs)
		eventArgs.handled = true
	end
end

function job_tick()
	if player.sub_job == 'SCH' and check_arts() then return true end
	return false
end

function check_arts()
	if state.AutoArts.value and not moving and not areas.Cities:contains(world.area) and not arts_active() and player.in_combat then

  	local abil_recasts = windower.ffxi.get_ability_recasts()

  	if abil_recasts[232] == 0 then
  		windower.chat.input('/ja "Dark Arts" <me>')
  		tickdelay = 30
  		return true
  	end

	end

	return false
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
  local strategem = cmdParams[2]:lower()

  if strategem == 'nuke' then
	local spell_recasts = windower.ffxi.get_spell_recasts()

	if state.ElementalMode.value == 'Fire' then
		if spell_recasts[849] == 0 and player.job_points[(res.jobs[player.main_job_id].ens):lower()].jp_spent > 99 then
			send_command('input /ma "Fire VI" <t>')
		elseif spell_recasts[148] == 0 then
			send_command('input /ma "Fire V" <t>')
		elseif spell_recasts[147] == 0 then
			send_command('input /ma "Fire IV" <t>')
		elseif spell_recasts[146] == 0 then
			send_command('input /ma "Fire III" <t>')
		elseif spell_recasts[145] == 0 then
			send_command('input /ma "Fire II" <t>')
		elseif spell_recasts[144] == 0 then
			send_command('input /ma "Fire" <t>')
		end

	elseif state.ElementalMode.value == 'Wind' then
		if spell_recasts[851] == 0 and player.job_points[(res.jobs[player.main_job_id].ens):lower()].jp_spent > 99 then
			send_command('input /ma "Aero VI" <t>')
		elseif spell_recasts[158] == 0 then
			send_command('input /ma "Aero V" <t>')
		elseif spell_recasts[157] == 0 then
			send_command('input /ma "Aero IV" <t>')
		elseif spell_recasts[156] == 0 then
			send_command('input /ma "Aero III" <t>')
		elseif spell_recasts[155] == 0 then
			send_command('input /ma "Aero II" <t>')
		elseif spell_recasts[154] == 0 then
			send_command('input /ma "Aero" <t>')
		end

	elseif state.ElementalMode.value == 'Lightning' then
		if spell_recasts[853] == 0 and player.job_points[(res.jobs[player.main_job_id].ens):lower()].jp_spent > 99 then
			send_command('input /ma "Thunder VI" <t>')
		elseif spell_recasts[168] == 0 then
			send_command('input /ma "Thunder V" <t>')
		elseif spell_recasts[167] == 0 then
			send_command('input /ma "Thunder IV" <t>')
		elseif spell_recasts[166] == 0 then
			send_command('input /ma "Thunder III" <t>')
		elseif spell_recasts[165] == 0 then
			send_command('input /ma "Thunder II" <t>')
		elseif spell_recasts[164] == 0 then
			send_command('input /ma "Thunder" <t>')
		end

	elseif state.ElementalMode.value == 'Earth' then
		if spell_recasts[852] == 0 and player.job_points[(res.jobs[player.main_job_id].ens):lower()].jp_spent > 99 then
			send_command('input /ma "Stone VI" <t>')
		elseif spell_recasts[163] == 0 then
			send_command('input /ma "Stone V" <t>')
		elseif spell_recasts[162] == 0 then
			send_command('input /ma "Stone IV" <t>')
		elseif spell_recasts[161] == 0 then
			send_command('input /ma "Stone III" <t>')
		elseif spell_recasts[160] == 0 then
			send_command('input /ma "Stone II" <t>')
		elseif spell_recasts[159] == 0 then
			send_command('input /ma "Stone" <t>')
		end

	elseif state.ElementalMode.value == 'Ice' then
		if spell_recasts[850] == 0 and player.job_points[(res.jobs[player.main_job_id].ens):lower()].jp_spent > 99 then
			send_command('input /ma "Blizzard VI" <t>')
		elseif spell_recasts[153] == 0 then
			send_command('input /ma "Blizzard V" <t>')
		elseif spell_recasts[152] == 0 then
			send_command('input /ma "Blizzard IV" <t>')
		elseif spell_recasts[151] == 0 then
			send_command('input /ma "Blizzard III" <t>')
		elseif spell_recasts[150] == 0 then
			send_command('input /ma "Blizzard II" <t>')
		elseif spell_recasts[149] == 0 then
			send_command('input /ma "Blizzard" <t>')
		end

	elseif state.ElementalMode.value == 'Water' then
		if spell_recasts[854] == 0 and player.job_points[(res.jobs[player.main_job_id].ens):lower()].jp_spent > 99 then
			send_command('input /ma "Water VI" <t>')
		elseif spell_recasts[173] == 0 then
			send_command('input /ma "Water V" <t>')
		elseif spell_recasts[172] == 0 then
			send_command('input /ma "Water IV" <t>')
		elseif spell_recasts[171] == 0 then
			send_command('input /ma "Water III" <t>')
		elseif spell_recasts[170] == 0 then
			send_command('input /ma "Water II" <t>')
		elseif spell_recasts[169] == 0 then
			send_command('input /ma "Water" <t>')
		end

	elseif state.ElementalMode.value == 'Light' then
		if spell_recasts[29] == 0 then
			send_command('input /ma "Banish II" <t>')
		elseif spell_recasts[28] == 0 then
			send_command('input /ma "Banish" <t>')
		end

	elseif state.ElementalMode.value == 'Dark' then
		if spell_recasts[219] == 0 then
			send_command('input /ma "Comet" <t>')
		end
	end

elseif strategem == 'smallnuke' then
	local spell_recasts = windower.ffxi.get_spell_recasts()

	if state.ElementalMode.value == 'Fire' then
		if spell_recasts[145] == 0 then
			send_command('input /ma "Fire II" <t>')
		elseif spell_recasts[144] == 0 then
			send_command('input /ma "Fire" <t>')
		end

	elseif state.ElementalMode.value == 'Wind' then
		if spell_recasts[155] == 0 then
			send_command('input /ma "Aero II" <t>')
		elseif spell_recasts[154] == 0 then
			send_command('input /ma "Aero" <t>')
		end

	elseif state.ElementalMode.value == 'Lightning' then
		if spell_recasts[165] == 0 then
			send_command('input /ma "Thunder II" <t>')
		elseif spell_recasts[164] == 0 then
			send_command('input /ma "Thunder" <t>')
		end

	elseif state.ElementalMode.value == 'Earth' then
		if spell_recasts[160] == 0 then
			send_command('input /ma "Stone II" <t>')
		elseif spell_recasts[159] == 0 then
			send_command('input /ma "Stone" <t>')
		end

	elseif state.ElementalMode.value == 'Ice' then
		if spell_recasts[150] == 0 then
			send_command('input /ma "Blizzard II" <t>')
		elseif spell_recasts[149] == 0 then
			send_command('input /ma "Blizzard" <t>')
		end

	elseif state.ElementalMode.value == 'Water' then
		if spell_recasts[170] == 0 then
			send_command('input /ma "Water II" <t>')
		elseif spell_recasts[169] == 0 then
			send_command('input /ma "Water" <t>')
		end

	elseif state.ElementalMode.value == 'Light' then
		if spell_recasts[29] == 0 then
			send_command('input /ma "Banish II" <t>')
		elseif spell_recasts[28] == 0 then
			send_command('input /ma "Banish" <t>')
		end

	elseif state.ElementalMode.value == 'Dark' then
		add_to_chat(123,'Error: There are no dark nukes.')
	end

elseif strategem == 'tier1' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Fire" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Aero" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Thunder" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Stone" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Blizzard" <t>')
	elseif state.ElementalMode.value == 'Water' then

	elseif state.ElementalMode.value == 'Light' then
		send_command('input /ma "Banish" <t>')
	elseif state.ElementalMode.value == 'Dark' then
		send_command('input /ma "Bio" <t>')
	end

elseif strategem == 'tier2' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Fire II" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Aero II" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Thunder II" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Stone II" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Blizzard II" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Water II" <t>')
	elseif state.ElementalMode.value == 'Light' then
		send_command('input /ma "Banish II" <t>')
	elseif state.ElementalMode.value == 'Dark' then
		send_command('input /ma "Bio II" <t>')
	end

elseif strategem == 'tier3' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Fire III" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Aero III" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Thunder III" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Stone III" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Blizzard III" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Water III" <t>')
	elseif state.ElementalMode.value == 'Light' then
		add_to_chat(123,'Error: There is no light tier III.')
	elseif state.ElementalMode.value == 'Dark' then
		add_to_chat(123,'Error: There is no dark tier III.')
	end

elseif strategem == 'tier4' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Fire IV" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Aero IV" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Thunder IV" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Stone IV" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Blizzard IV" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Water IV" <t>')
	elseif state.ElementalMode.value == 'Light' then
		add_to_chat(123,'Error: There is no light tier IV.')
	elseif state.ElementalMode.value == 'Dark' then
		add_to_chat(123,'Error: There is no dark tier IV.')
	end

elseif strategem == 'tier5' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Fire V" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Aero V" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Thunder V" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Stone V" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Blizzard V" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Water V" <t>')
	elseif state.ElementalMode.value == 'Light' then
		add_to_chat(123,'Error: There is no light tier V.')
	elseif state.ElementalMode.value == 'Dark' then
		add_to_chat(123,'Error: There is no dark tier V.')
	end

elseif strategem == 'tier6' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Fire VI" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Aero VI" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Thunder VI" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Stone VI" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Blizzard VI" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Water VI" <t>')
	elseif state.ElementalMode.value == 'Light' then
		add_to_chat(123,'Error: There is no light tier VI.')
	elseif state.ElementalMode.value == 'Dark' then
		add_to_chat(123,'Error: There is no dark tier VI.')
	end

elseif strategem == 'aga' then
	local spell_recasts = windower.ffxi.get_spell_recasts()

	if state.ElementalMode.value == 'Fire' then
		if spell_recasts[496] == 0 then
			send_command('input /ma "Firaja" <t>')
		elseif spell_recasts[176] == 0 then
			send_command('input /ma "Firaga III" <t>')
		elseif spell_recasts[175] == 0 then
			send_command('input /ma "Firaga II" <t>')
		elseif spell_recasts[174] == 0 then
			send_command('input /ma "Firaga" <t>')
		end

	elseif state.ElementalMode.value == 'Wind' then
		if spell_recasts[498] == 0 then
			send_command('input /ma "Aeroja" <t>')
		elseif spell_recasts[186] == 0 then
			send_command('input /ma "Aeroga III" <t>')
		elseif spell_recasts[185] == 0 then
			send_command('input /ma "Aeroga II" <t>')
		elseif spell_recasts[184] == 0 then
			send_command('input /ma "Aeroga" <t>')
		end

	elseif state.ElementalMode.value == 'Lightning' then
		if spell_recasts[500] == 0 then
			send_command('input /ma "Thundaja" <t>')
		elseif spell_recasts[196] == 0 then
			send_command('input /ma "Thundaga III" <t>')
		elseif spell_recasts[195] == 0 then
			send_command('input /ma "Thundaga II" <t>')
		elseif spell_recasts[194] == 0 then
			send_command('input /ma "Thundaga" <t>')
		end

	elseif state.ElementalMode.value == 'Earth' then
		if spell_recasts[499] == 0 then
			send_command('input /ma "Stoneja" <t>')
		elseif spell_recasts[191] == 0 then
			send_command('input /ma "Stonega III" <t>')
		elseif spell_recasts[190] == 0 then
			send_command('input /ma "Stonega II" <t>')
		elseif spell_recasts[189] == 0 then
			send_command('input /ma "Stonega" <t>')
		end

	elseif state.ElementalMode.value == 'Ice' then
		if spell_recasts[497] == 0 then
			send_command('input /ma "Blizzaja" <t>')
		elseif spell_recasts[181] == 0 then
			send_command('input /ma "Blizzaga III" <t>')
		elseif spell_recasts[180] == 0 then
			send_command('input /ma "Blizzaga II" <t>')
		elseif spell_recasts[179] == 0 then
			send_command('input /ma "Blizzaga" <t>')
		end

	elseif state.ElementalMode.value == 'Water' then
		if spell_recasts[501] == 0 then
			send_command('input /ma "Waterja" <t>')
		elseif spell_recasts[201] == 0 then
			send_command('input /ma "Waterga III" <t>')
		elseif spell_recasts[200] == 0 then
			send_command('input /ma "Waterga II" <t>')
		elseif spell_recasts[199] == 0 then
			send_command('input /ma "Waterga" <t>')
		end

	elseif state.ElementalMode.value == 'Light' then
		add_to_chat(123,'Error: There are no light -ara spells.')
	elseif state.ElementalMode.value == 'Dark' then
		add_to_chat(123,'Error: There are no dark -ara spells.')
	end

elseif strategem == 'aga1' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Firaga" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Aeroga" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Thundaga" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Stonega" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Blizzaga" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Waterga" <t>')
	elseif state.ElementalMode.value == 'Light' then
		send_command('input /ma "Banishga" <t>')
	elseif state.ElementalMode.value == 'Dark' then
		add_to_chat(123,'Error: There is no dark -aja.')
	end

elseif strategem == 'aga2' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Firaga II" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Aeroga II" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Thundaga II" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Stonega II" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Blizzaga II" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Waterga II" <t>')
	elseif state.ElementalMode.value == 'Light' then
		send_command('input /ma "Banishga II" <t>')
	elseif state.ElementalMode.value == 'Dark' then
		add_to_chat(123,'Error: There is no dark -aja.')
	end

elseif strategem == 'aga3' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Firaga III" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Aeroga III" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Thundaga III" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Stonega III" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Blizzaga III" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Waterga III" <t>')
	elseif state.ElementalMode.value == 'Light' then
		send_command('input /ma "Diaga" <t>')
	elseif state.ElementalMode.value == 'Dark' then
		add_to_chat(123,'Error: There is no dark -aja.')
	end

elseif strategem == 'aja' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Firaja" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Aeroja" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Thundaja" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Stoneja" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Blizzaja" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Waterja" <t>')
	elseif state.ElementalMode.value == 'Light' then
		add_to_chat(123,'Error: There is no light -aja.')
	elseif state.ElementalMode.value == 'Dark' then
		add_to_chat(123,'Error: There is no dark -aja.')
	end

elseif strategem == 'helix' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Pyrohelix" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Anemohelix" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Ionohelix" <t>')
	elseif state.ElementalMode.value == 'Light' then
		send_command('input /ma "Luminohelix" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Geohelix" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Cryohelix" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Hydrohelix" <t>')
	elseif state.ElementalMode.value == 'Dark' then
		send_command('input /ma "Noctohelix" <t>')
	end

elseif strategem == 'ancientmagic' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Flare" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Tornado" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Burst" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Quake" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Freeze" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Flood" <t>')
	elseif state.ElementalMode.value == 'Light' then
		add_to_chat(123,'Error: There is no light ancient magic.')
	elseif state.ElementalMode.value == 'Dark' then
		add_to_chat(123,'Error: There is no dark ancient magic.')
	end

elseif strategem == 'ancientmagic2' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Flare II" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Tornado II" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Burst II" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Quake II" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Freeze II" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Flood II" <t>')
	elseif state.ElementalMode.value == 'Light' then
		add_to_chat(123,'Error: There is no light ancient magic.')
	elseif state.ElementalMode.value == 'Dark' then
		add_to_chat(123,'Error: There is no dark ancient magic.')
	end

elseif strategem == 'enfeeble' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Burn" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Choke" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Shock" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Rasp" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Frost" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Drown" <t>')
	elseif state.ElementalMode.value == 'Light' then
		send_command('input /ma "Dia II" <t>')
	elseif state.ElementalMode.value == 'Dark' then
		send_command('input /ma "Blind" <t>')
	end

elseif strategem == 'bardsong' then
	if state.ElementalMode.value == 'Fire' then
		send_command('input /ma "Ice Threnody" <t>')
	elseif state.ElementalMode.value == 'Wind' then
		send_command('input /ma "Earth Threnody" <t>')
	elseif state.ElementalMode.value == 'Lightning' then
		send_command('input /ma "Water Threnody" <t>')
	elseif state.ElementalMode.value == 'Earth' then
		send_command('input /ma "Ltng. Threnody" <t>')
	elseif state.ElementalMode.value == 'Ice' then
		send_command('input /ma "Wind Threnody" <t>')
	elseif state.ElementalMode.value == 'Water' then
		send_command('input /ma "Fire Threnody" <t>')
	elseif state.ElementalMode.value == 'Light' then
		send_command('input /ma "Dark Threnody" <t>')
	elseif state.ElementalMode.value == 'Dark' then
		send_command('input /ma "Light Threnody" <t>')
	end

--Leave out target, let shortcuts auto-determine it.
elseif strategem == 'weather' then
	if player.sub_job == 'RDM' then send_command('input /ma "Phalanx" <me>') return end
	local spell_recasts = windower.ffxi.get_spell_recasts()

	if state.ElementalMode.value == 'Fire' then
		if player.target.index == player.index and buffactive['Firestorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
			send_command('input /ma "Klimaform" <me>')
		else
			send_command('input /ma "Firestorm"')
		end
	elseif state.ElementalMode.value == 'Wind' then
		if player.target.index == player.index and buffactive['Windstorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
			send_command('input /ma "Klimaform" <me>')
		else
			send_command('input /ma "Windstorm"')
		end
	elseif state.ElementalMode.value == 'Lightning' then
		if player.target.index == player.index and buffactive['Thunderstorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
			send_command('input /ma "Klimaform" <me>')
		else
			send_command('input /ma "Thunderstorm"')
		end
	elseif state.ElementalMode.value == 'Light' then
		if player.target.index == player.index and buffactive['Aurorastorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
			send_command('input /ma "Klimaform" <me>')
		else
			send_command('input /ma "Aurorastorm"')
		end
	elseif state.ElementalMode.value == 'Earth' then
		if player.target.index == player.index and buffactive['Sandstorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
			send_command('input /ma "Klimaform" <me>')
		else
			send_command('input /ma "Sandstorm"')
		end
	elseif state.ElementalMode.value == 'Ice' then
		if player.target.index == player.index and buffactive['Hailstorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
			send_command('input /ma "Klimaform" <me>')
		else
			send_command('input /ma "Hailstorm"')
		end
	elseif state.ElementalMode.value == 'Water' then
		if player.target.index == player.index and buffactive['Rainstorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
			send_command('input /ma "Klimaform" <me>')
		else
			send_command('input /ma "Rainstorm"')
		end
	elseif state.ElementalMode.value == 'Dark' then
		if player.target.index == player.index and buffactive['Voidstorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
			send_command('input /ma "Klimaform" <me>')
		else
			send_command('input /ma "Voidstorm"')
		end
	end

  else
      add_to_chat(123,'Unrecognized elemental command.')
  end
end
