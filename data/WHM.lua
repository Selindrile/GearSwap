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
<<<<<<< HEAD
=======

	update_combat_form()
>>>>>>> a6261fdb27f42ae86a9094e98c85455d397a997c

	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoNukeMode","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoBuffMode",},{"Weapons","OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","ElementalMode","CastingMode","TreasureMode",})
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
<<<<<<< HEAD
		if spellMap == 'Cure' or spellMap == 'Curaga' then
			gear.default.obi_waist = gear.obi_cure_waist
			gear.default.obi_back = gear.obi_cure_back
		elseif spell.english == 'Holy II' then
			gear.default.obi_waist = gear.obi_high_nuke_waist
		elseif spell.english == 'Holy' or (spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble') then
=======
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
>>>>>>> a6261fdb27f42ae86a9094e98c85455d397a997c
			gear.default.obi_waist = gear.obi_nuke_waist
			gear.default.obi_back = gear.obi_nuke_back
    --[[
		elseif spellMap == 'StatusRemoval' and not (spell.english == "Erase" or spell.english == "Esuna" or spell.english == "Sacrifice") then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			if abil_recasts[32] < latency and not silent_check_amnesia() and state.AutoCaress.value then
				eventArgs.cancel = true
				windower.chat.input('/ja "Divine Caress" <me>')
				windower.chat.input:schedule(1,'/ma "'..spell.english..'" '..spell.target.raw..'')
				return
			end
    ]]--
		end
	elseif spell.type == 'JobAbility' then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if spell.english == 'Devotion' and state.BlockLowDevotion.value and abil_recasts[28] < latency and player.hpp < 50 then
			eventArgs.cancel = true
			add_to_chat(123,'Abort: Blocking Devotion under 50% HP to prevent inefficient use.')
		end
	end

  if state.CastingMode.value == 'Proc' then
      classes.CustomClass = 'Proc'
  end
end

function job_post_precast(spell, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' then
		local WSset = standardize_set(get_precast_set(spell, spellMap))
		
		if (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			-- Replace Moonshade Earring if we're at cap TP
			if sets.MaxTP and get_effective_player_tp(spell, WSset) > 3200 then
				equip(sets.MaxTP[spell.english] or sets.MaxTP)
			end
		end
	end
end

function job_post_midcast(spell, spellMap, eventArgs)
  if spell.action_type == 'Magic' then
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' then
<<<<<<< HEAD
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
		
	elseif spellMap == 'BarElement' then
		if (buffactive['Light Arts'] or buffactive['Addendum: White']) and sets.midcast.BarElement and sets.midcast.BarElement.LightArts then
			equip(sets.midcast.BarElement.LightArts)
		end
    elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' and spell.english ~= 'Impact' then
        if state.MagicBurstMode.value ~= 'Off' then equip(sets.MagicBurst) end
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
=======
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
>>>>>>> a6261fdb27f42ae86a9094e98c85455d397a997c
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
			if state.Weapons.value ~= 'None' then
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
	if cmdParams[1] == 'user' then check_arts() end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
  display_current_caster_state()
  eventArgs.handled = true
end

    -- Allow jobs to override this code
function job_self_command(commandArgs, eventArgs)
<<<<<<< HEAD
    if commandArgs[1]:lower() == 'smartcure' then
		eventArgs.handled = true
		local cureTarget = '<t>'
		local missingHP
		local spell_recasts = windower.ffxi.get_spell_recasts()

		-- If curing ourself, get our exact missing HP
		if player.target.type == "SELF" or player.target.type == 'MONSTER' or player.target.type == 'NONE' then
			missingHP = player.max_hp - player.hp
			cureTarget = '<me>'
		elseif player.target.status:contains('Dead') then
			windower.chat.input('/ma "Arise" '..cureTarget..'')
			return
		-- If curing someone in our alliance, we can estimate their missing HP
		elseif player.target.isallymember then
			local target = find_player_in_alliance(player.target.name)
			local est_max_hp = target.hp / (target.hpp/100)
			missingHP = math.floor(est_max_hp - target.hp)
		else
			if player.target.hpp > 94 then
				if spell_recasts[1] < spell_latency then
					windower.chat.input('/ma "Cure" <t>')
				elseif spell_recasts[2] < spell_latency then
					windower.chat.input('/ma "Cure II" <t>')
				else
					add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
				end
			elseif player.target.hpp > 84 then
				if spell_recasts[2] < spell_latency then
					windower.chat.input('/ma "Cure II" <t>')
				elseif spell_recasts[3] < spell_latency then
					windower.chat.input('/ma "Cure III" <t>')
				elseif spell_recasts[1] < spell_latency then
					windower.chat.input('/ma "Cure" <t>')
				else
					add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
				end
			elseif player.target.hpp > 55 then
				if spell_recasts[3] < spell_latency then
					windower.chat.input('/ma "Cure III" <t>')
				elseif spell_recasts[4] < spell_latency then
					windower.chat.input('/ma "Cure IV" <t>')
				elseif spell_recasts[5] < spell_latency then
					windower.chat.input('/ma "Cure V" <t>')
				else
					add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
				end
			elseif player.target.hpp > 25 then
				if spell_recasts[5] < spell_latency then
					windower.chat.input('/ma "Cure V" <t>')
				elseif spell_recasts[4] < spell_latency then
					windower.chat.input('/ma "Cure IV" <t>')
				elseif spell_recasts[6] < spell_latency then
					windower.chat.input('/ma "Cure VI" <t>')
				elseif spell_recasts[3] < spell_latency then
					windower.chat.input('/ma "Cure III" <t>')
				else
					add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
				end
			else
				if spell_recasts[6] < spell_latency then
					windower.chat.input('/ma "Cure VI" <t>')
				elseif spell_recasts[5] < spell_latency then
					windower.chat.input('/ma "Cure V" <t>')
				elseif spell_recasts[4] < spell_latency then
					windower.chat.input('/ma "Cure IV" <t>')
				elseif spell_recasts[3] < spell_latency then
					windower.chat.input('/ma "Cure III" <t>')
				else
					add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
				end
			end
			return
		end
		
		if missingHP < 250 then
			if spell_recasts[1] < spell_latency then
				windower.chat.input('/ma "Cure" '..cureTarget..'')
			elseif spell_recasts[2] < spell_latency then
				windower.chat.input('/ma "Cure II" '..cureTarget..'')
=======
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
>>>>>>> a6261fdb27f42ae86a9094e98c85455d397a997c
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		elseif missingHP < 400 then
			if spell_recasts[2] < spell_latency then
				windower.chat.input('/ma "Cure II" '..cureTarget..'')
			elseif spell_recasts[3] < spell_latency then
				windower.chat.input('/ma "Cure III" '..cureTarget..'')
			elseif spell_recasts[1] < spell_latency then
				windower.chat.input('/ma "Cure" '..cureTarget..'')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		elseif missingHP < 900 then
			if spell_recasts[3] < spell_latency then
				windower.chat.input('/ma "Cure III" '..cureTarget..'')
			elseif spell_recasts[4] < spell_latency then
				windower.chat.input('/ma "Cure IV" '..cureTarget..'')
			elseif spell_recasts[5] < spell_latency then
				windower.chat.input('/ma "Cure V" '..cureTarget..'')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		elseif missingHP < 1400 then
			if spell_recasts[5] < spell_latency then
				windower.chat.input('/ma "Cure V" '..cureTarget..'')
			elseif spell_recasts[4] < spell_latency then
				windower.chat.input('/ma "Cure IV" '..cureTarget..'')
			elseif spell_recasts[6] < spell_latency then
				windower.chat.input('/ma "Cure VI" '..cureTarget..'')
			elseif spell_recasts[3] < spell_latency then
				windower.chat.input('/ma "Cure III" '..cureTarget..'')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		else
			if spell_recasts[6] < spell_latency then
				windower.chat.input('/ma "Cure VI" '..cureTarget..'')
			elseif spell_recasts[5] < spell_latency then
				windower.chat.input('/ma "Cure V" '..cureTarget..'')
			elseif spell_recasts[4] < spell_latency then
				windower.chat.input('/ma "Cure IV" '..cureTarget..'')
			elseif spell_recasts[3] < spell_latency then
				windower.chat.input('/ma "Cure III" '..cureTarget..'')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		end
	elseif commandArgs[1]:lower() == 'elemental' then
		handle_elemental(commandArgs)
		eventArgs.handled = true	
	end
end

function job_tick()
	if check_arts() then return true end
	if check_buff() then return true end
	if check_buffup() then return true end
	return false
end

function check_arts()
	if buffup ~= '' or (not areas.Cities:contains(world.area) and ((state.AutoArts.value and player.in_combat) or state.AutoBuffMode.value)) then
		local abil_recasts = windower.ffxi.get_ability_recasts()

		if abil_recasts[29] < latency and not state.Buff['Afflatus Solace'] and not state.Buff['Afflatus Misery'] then
			send_command('@input /ja "Afflatus Solace" <me>')
			tickdelay = os.clock() + 1
			return true

		elseif player.sub_job == 'SCH' and not arts_active() and abil_recasts[228] < latency then
			send_command('@input /ja "Light Arts" <me>')
			tickdelay = os.clock() + 1
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
    local command = cmdParams[2]:lower()

	if command == 'nuke' or command == 'smallnuke' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
<<<<<<< HEAD
	
		if command == 'nuke' and state.ElementalMode.value == 'Light' then
			local tiers = {'Holy II','Holy','Banish III','Banish II','Banish'}
			for k in ipairs(tiers) do
				if spell_recasts[get_spell_table_by_name(tiers[k]).id] < spell_latency and actual_cost(get_spell_table_by_name(tiers[k])) < player.mp then
					windower.chat.input('/ma "'..tiers[k]..'" <t>')
					return
				end
			end
		else
			local tiers = {' II',''}
			for k in ipairs(tiers) do
				if spell_recasts[get_spell_table_by_name(elements.nuke[state.ElementalMode.value]..''..tiers[k]..'').id] < spell_latency and actual_cost(get_spell_table_by_name(elements.nuke[state.ElementalMode.value]..''..tiers[k]..'')) < player.mp then
					windower.chat.input('/ma "'..elements.nuke[state.ElementalMode.value]..''..tiers[k]..'" <t>')
					return
				end
=======

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
>>>>>>> a6261fdb27f42ae86a9094e98c85455d397a997c
			end
		end
<<<<<<< HEAD
		add_to_chat(123,'Abort: All '..elements.nuke[state.ElementalMode.value]..' nukes on cooldown or or not enough MP.')
		
	elseif command:contains('tier') then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local tierlist = {['tier1']='',['tier2']=' II',['tier3']=' III',['tier4']=' IV',['tier5']=' V',['tier6']=' VI'}
		
		windower.chat.input('/ma "'..elements.nuke[state.ElementalMode.value]..tierlist[command]..'" <t>')
		
	elseif command == 'ara' then
		windower.chat.input('/ma "'..elements.nukera[state.ElementalMode.value]..'ra" <t>')
		
	elseif command == 'aga' then
		windower.chat.input('/ma "'..elements.nukega[state.ElementalMode.value]..'ga" <t>')
		
	elseif command == 'helix' then
		windower.chat.input('/ma "'..elements.helix[state.ElementalMode.value]..'helix" <t>')
	
	elseif command == 'enfeeble' then
		windower.chat.input('/ma "'..elements.enfeeble[state.ElementalMode.value]..'" <t>')
	
	elseif command == 'bardsong' then
		windower.chat.input('/ma "'..elements.threnody[state.ElementalMode.value]..' Threnody" <t>')
		
	elseif command == 'spikes' then
		windower.chat.input('/ma "'..elements.spikes[state.ElementalMode.value]..' Spikes" <me>')
		
	elseif command == 'enspell' then
			windower.chat.input('/ma "En'..elements.enspell[state.ElementalMode.value]..'" <me>')
	
	--Leave out target, let shortcuts auto-determine it.
	elseif command == 'weather' then
		if player.sub_job == 'RDM' then
			windower.chat.input('/ma "Phalanx" <me>')
		else
			local spell_recasts = windower.ffxi.get_spell_recasts()
			if (player.target.type == 'SELF' or not player.target.in_party) and buffactive[elements.storm_of[state.ElementalMode.value]] and not buffactive['Klimaform'] and spell_recasts[287] < spell_latency then
				windower.chat.input('/ma "Klimaform" <me>')
=======

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
>>>>>>> a6261fdb27f42ae86a9094e98c85455d397a997c
			else
				windower.chat.input('/ma "'..elements.storm_of[state.ElementalMode.value]..'"')
			end
		end
<<<<<<< HEAD
		
=======

>>>>>>> a6261fdb27f42ae86a9094e98c85455d397a997c
    else
        add_to_chat(123,'Unrecognized elemental command.')
    end
end

function check_buff()
	if state.AutoBuffMode.value and not areas.Cities:contains(world.area) then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		for i in pairs(buff_spell_lists['Auto']) do
			if not buffactive[buff_spell_lists['Auto'][i].Buff] and (buff_spell_lists['Auto'][i].When == 'Always' or (buff_spell_lists['Auto'][i].When == 'Combat' and (player.in_combat or being_attacked)) or (buff_spell_lists['Auto'][i].When == 'Engaged' and player.status == 'Engaged') or (buff_spell_lists['Auto'][i].When == 'Idle' and player.status == 'Idle') or (buff_spell_lists['Auto'][i].When == 'OutOfCombat' and not (player.in_combat or being_attacked))) and spell_recasts[buff_spell_lists['Auto'][i].SpellID] < latency and silent_can_use(buff_spell_lists['Auto'][i].SpellID) then
				windower.chat.input('/ma "'..buff_spell_lists['Auto'][i].Name..'" <me>')
				tickdelay = os.clock() + 2
				return true
			end
		end
	else
		return false
	end
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
				tickdelay = os.clock() + 2
				return true
			end
		end
		
		return false
	else
		return false
	end
end
<<<<<<< HEAD

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Reraise IV',		Buff='Reraise',		SpellID=848,	When='Always'},
		{Name='Haste',			Buff='Haste',		SpellID=57,		When='Always'},
		{Name='Aurorastorm',	Buff='Aurorastorm',	SpellID=119,	When='Always'},
		{Name='Refresh',		Buff='Refresh',		SpellID=109,	When='Always'},
		{Name='Stoneskin',		Buff='Stoneskin',	SpellID=54,		When='Always'},
	},
	
	Default = {
		{Name='Reraise IV',		Buff='Reraise',		SpellID=848,	Reapply=false},
		{Name='Haste',			Buff='Haste',		SpellID=57,		Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',	SpellID=55,		Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',	SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',		SpellID=53,		Reapply=false},
		{Name='Regen IV',		Buff='Regen',		SpellID=477,	Reapply=false},
		{Name='Phalanx',		Buff='Phalanx',		SpellID=106,	Reapply=false},
		{Name='Boost-MND',		Buff='MND Boost',	SpellID=484,	Reapply=false},
		{Name='Shellra V',		Buff='Shell',		SpellID=134,	Reapply=false},
		{Name='Protectra V',	Buff='Protect',		SpellID=129,	Reapply=false},
		{Name='Barthundra',		Buff='Barthunder',	SpellID=70,		Reapply=false},
		{Name='Barparalyzra',	Buff='Barparalyze',	SpellID=88,		Reapply=false},
	},
	Melee = {
		{Name='Reraise IV',		Buff='Reraise',		SpellID=848,	Reapply=false},
		{Name='Haste',			Buff='Haste',		SpellID=57,		Reapply=false},
		{Name='Boost-STR',		Buff='STR Boost',	SpellID=479,	Reapply=false},
		{Name='Shellra V',		Buff='Shell',		SpellID=134,	Reapply=false},
		{Name='Protectra V',	Buff='Protect',		SpellID=129,	Reapply=false},
		{Name='Auspice',		Buff='Auspice',		SpellID=96,		Reapply=false},
	},
}
=======
>>>>>>> a6261fdb27f42ae86a9094e98c85455d397a997c
