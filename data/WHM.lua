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
  state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
  state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
	state.Buff['Divine Caress'] = buffactive['Divine Caress'] or false

	state.AutoCaress = M(true, 'Auto Caress Mode')
	state.Gambanteinn = M(false, 'Gambanteinn Cursna Mode')
	state.BlockLowDevotion = M(true, 'Block Low Devotion')

	autows = 'Mystic Boon'
	autofood = 'Miso Ramen'
  mpthreshold = 50

	state.ElementalMode = M{['description'] = 'Elemental Mode','Light','Dark','Fire','Ice','Wind','Earth','Lightning','Water',}

	update_combat_form()

	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoNukeMode","AutoWSMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoBuffMode",},{"Weapons","OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","ElementalMode","CastingMode","TreasureMode",})
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
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
			gear.default.obi_waist = gear.obi_nuke_waist
			gear.default.obi_back = gear.obi_nuke_back
    --[[
		elseif spellMap == 'StatusRemoval' and not (spell.english == "Erase" or spell.english == "Esuna" or spell.english == "Sacrifice") then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			if abil_recasts[32] == 0 and not silent_check_amnesia() and state.AutoCaress.value then
				eventArgs.cancel = true
				windower.chat.input('/ja "Divine Caress" <me>')
				windower.chat.input:schedule(1,'/ma "'..spell.english..'" '..spell.target.raw..'')
				return
			end
    ]]--
		end
	elseif spell.type == 'JobAbility' then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if spell.english == 'Devotion' and state.BlockLowDevotion.value and abil_recasts[28] == 0 and player.hpp < 50 then
			eventArgs.cancel = true
			add_to_chat(123,'Abort: Blocking Devotion under 50% HP to prevent inefficient use.')
		end
	end

  if state.CastingMode.value == 'Proc' then
      classes.CustomClass = 'Proc'
  end
end

function job_post_precast(spell, spellMap, eventArgs)

end

function job_post_midcast(spell, spellMap, eventArgs)
  if spell.action_type == 'Magic' then
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' then
  		if state.Buff['Divine Caress'] then
  			equip(sets.buff['Divine Caress'])
  		end
  		if spell.english == 'Cursna' then
  			if (player.sub_job == 'NIN' or player.sub_job == 'DNC') and sets.midcast.DWCursna then
  				equip(sets.midcast.DWCursna)
  			elseif state.Gambanteinn.value and item_available('Gambanteinn') then
  				equip({main="Gambanteinn"})
  			end
  		end
    end
  end
end

function job_aftercast(spell, spellMap, eventArgs)
  if not spell.interrupted then
    if state.UseCustomTimers.value and spell.english == 'Sleep' or spell.english == 'Sleepga' then
      send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
    if state.DisplayMode.value then update_job_states()	end
    end
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    --- Currently used variant
    if spell.action_type == 'Magic' then
		if default_spell_map == 'Curaga' then
      if state.OffenseMode.value ~= 'None' then
        if world.weather_element == 'Light' or world.day_element == 'Light' then
					return 'MeleeLightWeatherCuraga'
				else
					return 'MeleeCuraga'
				end
			else
        if world.weather_element == 'Light' or world.day_element == 'Light' then
          if player.mpp > mpthreshold then
            return 'LightWeatherCuragaHighMP'
          else
            return 'LightWeatherCuraga'
          end
        elseif player.mpp > mpthreshold then
          return 'CuragaHighMP'
        end
		  end

		elseif default_spell_map == 'Cure' then
			if state.OffenseMode.value ~= 'None' then
				if state.Buff['Afflatus Solace'] then
					if world.weather_element == 'Light' or world.day_element == 'Light' then
						return '"MeleeLightWeatherCureSolace'
					else
						return "MeleeCureSolace"
					end
				elseif world.weather_element == 'Light' or world.day_element == 'Light' then
					return 'MeleeLightWeatherCure'
				else
					return 'MeleeCure'
				end
			elseif state.Buff['Afflatus Solace'] then
				if world.weather_element == 'Light' or world.day_element == 'Light' then
          if player.mpp > mpthreshold then
					  return 'LightWeatherCureSolaceHighMP'
          else
            return 'LightWeatherCureSolace'
          end
				else
          if player.mpp > mpthreshold then
            return "CureSolaceHighMP"
          else
            return "CureSolace"
          end
				end
			elseif world.weather_element == 'Light' or world.day_element == 'Light' then
        if player.mpp > mpthreshold then
          return 'LightWeatherCureHighMP'
        else
          return 'LightWeatherCure'
        end
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
end


function job_customize_idle_set(idleSet)
    if player.mpp < 51 and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') and state.DefenseMode.value == 'None' then
      idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	update_combat_form()
	if cmdParams[1] == 'user' then check_arts() end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
  display_current_caster_state()
  eventArgs.handled = true
end

    -- Allow jobs to override this code
function job_self_command(commandArgs, eventArgs)
  if commandArgs[1]:lower() == 'smartcure' then
	eventArgs.handled = true
	local missingHP
	local spell_recasts = windower.ffxi.get_spell_recasts()

  	-- If curing ourself, get our exact missing HP
  	if player.target.type == 'NONE' then
  		add_to_chat(123,'Abort: You have no target.')
  		return
  	elseif player.target.type == "SELF" then
      if state.HighHP.value == 'on' then
        missingHP = 700
      else
  		  missingHP = player.max_hp - player.hp
      end
  	-- If curing someone in our alliance, we can estimate their missing HP
  	elseif player.target.isallymember then
  		local target = find_player_in_alliance(player.target.name)
  		local est_max_hp = target.hp / (target.hpp/100)
  		missingHP = math.floor(est_max_hp - target.hp)
  	elseif player.target.type == 'MONSTER' then
  		add_to_chat(123,'Abort: You are targetting a monster.')
  		return
  	else
  		if player.target.hpp > 94 then
  			if spell_recasts[1] == 0 then
  				windower.chat.input('/ma "Cure" <t>')
  			elseif spell_recasts[2] == 0 then
  				windower.chat.input('/ma "Cure II" <t>')
  			else
  				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
  			end
  		elseif player.target.hpp > 84 then
  			if spell_recasts[2] == 0 then
  				windower.chat.input('/ma "Cure II" <t>')
  			elseif spell_recasts[3] == 0 then
  				windower.chat.input('/ma "Cure III" <t>')
  			elseif spell_recasts[1] == 0 then
  				windower.chat.input('/ma "Cure" <t>')
  			else
  				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
  			end
  		elseif player.target.hpp > 55 then
  			if spell_recasts[3] == 0 then
  				windower.chat.input('/ma "Cure III" <t>')
  			elseif spell_recasts[4] == 0 then
  				windower.chat.input('/ma "Cure IV" <t>')
  			elseif spell_recasts[5] == 0 then
  				windower.chat.input('/ma "Cure V" <t>')
  			else
  				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
  			end
  		elseif player.target.hpp > 25 then
  			if spell_recasts[5] == 0 then
  				windower.chat.input('/ma "Cure V" <t>')
  			elseif spell_recasts[4] == 0 then
  				windower.chat.input('/ma "Cure IV" <t>')
  			elseif spell_recasts[6] == 0 then
  				windower.chat.input('/ma "Cure VI" <t>')
  			elseif spell_recasts[3] == 0 then
  				windower.chat.input('/ma "Cure III" <t>')
  			else
  				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
  			end
  		else
  			if spell_recasts[6] == 0 then
  				windower.chat.input('/ma "Cure VI" <t>')
  			elseif spell_recasts[5] == 0 then
  				windower.chat.input('/ma "Cure V" <t>')
  			elseif spell_recasts[4] == 0 then
  				windower.chat.input('/ma "Cure IV" <t>')
  			elseif spell_recasts[3] == 0 then
  				windower.chat.input('/ma "Cure III" <t>')
  			else
  				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
  			end
  		end
      return
  	end
		if missingHP < 170 then
			if spell_recasts[1] == 0 then
				windower.chat.input('/ma "Cure" <t>')
			elseif spell_recasts[2] == 0 then
				windower.chat.input('/ma "Cure II" <t>')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		elseif missingHP < 400 then
			if spell_recasts[2] == 0 then
				windower.chat.input('/ma "Cure II" <t>')
			elseif spell_recasts[3] == 0 then
				windower.chat.input('/ma "Cure III" <t>')
			elseif spell_recasts[1] == 0 then
				windower.chat.input('/ma "Cure" <t>')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		elseif missingHP < 900 then
			if spell_recasts[3] == 0 then
				windower.chat.input('/ma "Cure III" <t>')
			elseif spell_recasts[4] == 0 then
				windower.chat.input('/ma "Cure IV" <t>')
			elseif spell_recasts[5] == 0 then
				windower.chat.input('/ma "Cure V" <t>')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		elseif missingHP < 1400 then
			if spell_recasts[5] == 0 then
				windower.chat.input('/ma "Cure V" <t>')
			elseif spell_recasts[4] == 0 then
				windower.chat.input('/ma "Cure IV" <t>')
			elseif spell_recasts[6] == 0 then
				windower.chat.input('/ma "Cure VI" <t>')
			elseif spell_recasts[3] == 0 then
				windower.chat.input('/ma "Cure III" <t>')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		else
			if spell_recasts[6] == 0 then
				windower.chat.input('/ma "Cure VI" <t>')
			elseif spell_recasts[5] == 0 then
				windower.chat.input('/ma "Cure V" <t>')
			elseif spell_recasts[4] == 0 then
				windower.chat.input('/ma "Cure IV" <t>')
			elseif spell_recasts[3] == 0 then
				windower.chat.input('/ma "Cure III" <t>')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		end
	end
end

function job_tick()
	if player.sub_job == 'SCH' and check_arts() then return true end
	return false
end

function check_arts()
	if state.AutoArts.value and not moving and not areas.Cities:contains(world.area) and player.in_combat then

		local abil_recasts = windower.ffxi.get_ability_recasts()

		if abil_recasts[29] == 0 and not state.Buff['Afflatus Solace'] and not state.Buff['Afflatus Misery'] then
			send_command('@input /ja "Afflatus Solace" <me>')
			tickdelay = 30
			return true

		elseif not arts_active() and abil_recasts[228] == 0 then
			send_command('@input /ja "Light Arts" <me>')
			tickdelay = 30
			return true
		end

	end

	return false
end

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
			if spell_recasts[22] == 0 then
				send_command('input /ma "Holy II" <t>')
			elseif spell_recasts[21] == 0 then
				send_command('input /ma "Holy" <t>')
			elseif spell_recasts[30] == 0 then
				send_command('input /ma "Banish III" <t>')
			elseif spell_recasts[29] == 0 then
				send_command('input /ma "Banish II" <t>')
			elseif spell_recasts[28] == 0 then
				send_command('input /ma "Banish" <t>')
			end

		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There are no dark nukes.')
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
			send_command('input /ma "Water" <t>')
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


	elseif strategem == 'aga' then
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

	elseif strategem == 'spikes' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Blaze Spikes" <me>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('There are no wind spikes')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Shock Spikes" <me>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('There are no earth spikes')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Ice Spikes" <me>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('There are no water spikes')
		elseif state.ElementalMode.value == 'Light' then
			send_command('There are no light spikes')
		elseif state.ElementalMode.value == 'Dark' then
			send_command("White Mage can't cast Dread Spikes.")
		end

	elseif strategem == 'enspell' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Enfire" <me>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Enaero" <me>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Enthunder" <me>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Enstone" <me>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Enblizzard" <me>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Enwater" <me>')
		elseif state.ElementalMode.value == 'Light' then
			add_to_chat(123,'Error: There is no light enspell.')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There is no dark enspell.')
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

function update_combat_form()
	if player.equipment.main and not (player.equipment.sub == 'empty' or player.equipment.sub:contains('Grip') or player.equipment.sub:contains('Strap')) and not player.equipment.sub:contains('Shield') then
			state.CombatForm:set('DW')
	else
			state.CombatForm:reset()
	end
end
