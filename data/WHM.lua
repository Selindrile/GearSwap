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
	
	state.ElementalMode = M{['description'] = 'Elemental Mode','Light','Dark','Fire','Ice','Wind','Earth','Lightning','Water',}

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
		if spellMap == 'Cure' or spellMap == 'Curaga' then
			gear.default.obi_waist = gear.obi_cure_waist
			gear.default.obi_back = gear.obi_cure_back
		elseif spell.english == 'Holy II' then
			gear.default.obi_waist = gear.obi_high_nuke_waist
		elseif spell.english == 'Holy' or (spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble') then
			gear.default.obi_waist = gear.obi_nuke_waist
			gear.default.obi_back = gear.obi_nuke_back
		elseif spellMap == 'StatusRemoval' and not (spell.english == "Erase" or spell.english == "Esuna" or spell.english == "Sacrifice") then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			if abil_recasts[32] < latency and not silent_check_amnesia() and state.AutoCaress.value then
				eventArgs.cancel = true
				windower.chat.input('/ja "Divine Caress" <me>')
				windower.chat.input:schedule(1,'/ma "'..spell.english..'" '..spell.target.raw..'')
				return
			end
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

end

function job_post_midcast(spell, spellMap, eventArgs)
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
    end
	
end

function job_aftercast(spell, spellMap, eventArgs)
    if not spell.interrupted then
        if state.UseCustomTimers.value and spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.skill == 'Elemental Magic' and state.MagicBurstMode.value == 'Single' then
            state.MagicBurstMode:reset()
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
    if spell.action_type == 'Magic' then
		if default_spell_map == 'Curaga' then
			if world.weather_element == 'Light' then
				return 'LightWeatherCuraga'
			elseif world.day_element == 'Light' then
				return 'LightDayCuraga'	
			end
		elseif default_spell_map == 'Cure' then
			if state.Weapons.value ~= 'None' then
				if state.Buff['Afflatus Solace'] then
					if world.weather_element == 'Light' then
						return '"MeleeLightWeatherCureSolace'
					elseif world.day_element == 'Light' then
						return 'MeleeLightDayCureSolace'
					else
						return "MeleeCureSolace"
					end
				elseif world.weather_element == 'Light' then
					return 'MeleeLightWeatherCure'
				elseif world.day_element == 'Light' then
					return 'MeleeLightDayCure'
				else
					return 'MeleeCure'
				end
			elseif state.Buff['Afflatus Solace'] then
				if world.weather_element == 'Light' then
					return 'LightWeatherCureSolace'
				elseif world.day_element == 'Light' then
					return 'LightDayCureSolace'
				else
					return "CureSolace"
				end
			elseif world.weather_element == 'Light' then
                return 'LightWeatherCure'
			elseif world.day_element == 'Light' then
                return 'LightDayCure'
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
    if commandArgs[1]:lower() == 'smartcure' then
		eventArgs.handled = true
		local missingHP
		local spell_recasts = windower.ffxi.get_spell_recasts()

		-- If curing ourself, get our exact missing HP
		if player.target.type == 'NONE' then
			add_to_chat(123,'Abort: You have no target.')
			return
		elseif player.target.type == "SELF" then
			missingHP = player.max_hp - player.hp
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
				windower.chat.input('/ma "Cure" <t>')
			elseif spell_recasts[2] < spell_latency then
				windower.chat.input('/ma "Cure II" <t>')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		elseif missingHP < 400 then
			if spell_recasts[2] < spell_latency then
				windower.chat.input('/ma "Cure II" <t>')
			elseif spell_recasts[3] < spell_latency then
				windower.chat.input('/ma "Cure III" <t>')
			elseif spell_recasts[1] < spell_latency then
				windower.chat.input('/ma "Cure" <t>')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		elseif missingHP < 900 then
			if spell_recasts[3] < spell_latency then
				windower.chat.input('/ma "Cure III" <t>')
			elseif spell_recasts[4] < spell_latency then
				windower.chat.input('/ma "Cure IV" <t>')
			elseif spell_recasts[5] < spell_latency then
				windower.chat.input('/ma "Cure V" <t>')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		elseif missingHP < 1400 then
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
	if buffup ~= '' or (state.AutoArts.value and not areas.Cities:contains(world.area) and (player.in_combat or state.AutoBuffMode.value)) then
		local abil_recasts = windower.ffxi.get_ability_recasts()

		if abil_recasts[29] < latency and not state.Buff['Afflatus Solace'] and not state.Buff['Afflatus Misery'] then
			send_command('@input /ja "Afflatus Solace" <me>')
			tickdelay = (framerate * 1)
			return true

		elseif player.sub_job == 'SCH' and not arts_active() and abil_recasts[228] < latency then
			send_command('@input /ja "Light Arts" <me>')
			tickdelay = (framerate * 1)
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
			end
		end
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
			else
				windower.chat.input('/ma "'..elements.storm_of[state.ElementalMode.value]..'"')
			end
		end
		
    else
        add_to_chat(123,'Unrecognized elemental command.')
    end
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
		{Name='Reraise III',Buff='Reraise',SpellID=142},
		{Name='Haste',Buff='Haste',SpellID=57},
		{Name='Aurorastorm',Buff='Aurorastorm',SpellID=119},
		{Name='Refresh',Buff='Refresh',SpellID=109},
		{Name='Stoneskin',Buff='Stoneskin',SpellID=54},
	},
	
	Default = {
		{Name='Reraise III',Buff='Reraise',SpellID=142},
		{Name='Haste',Buff='Haste',SpellID=57},
		{Name='Aquaveil',Buff='Aquaveil',SpellID=55},
		{Name='Stoneskin',Buff='Stoneskin',SpellID=54},
		{Name='Blink',Buff='Blink',SpellID=53},
		{Name='Regen IV',Buff='Regen',SpellID=477},
		{Name='Phalanx',Buff='Phalanx',SpellID=106},
		{Name='Boost-MND',Buff='MND Boost',SpellID=484},
		{Name='Shellra V',Buff='Shell',SpellID=134},
		{Name='Protectra V',Buff='Protect',SpellID=129},
		{Name='Barthundra',Buff='Barthunder',SpellID=70},
		{Name='Barparalyzra',Buff='Barparalyze',SpellID=88},
	},
}