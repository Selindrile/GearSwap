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

    state.Buff.Saboteur = buffactive.Saboteur or false
	state.Buff.Stymie = buffactive.Stymie or false
	state.Buff.Chainspell = buffactive.Chainspell or false
	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
	
    LowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga'}
	
	state.RecoverMode = M('35%', '60%', 'Always', 'Never')
	
	autows = "Chant Du Cygne"
	autofood = 'Pear Crepe'
	
	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoNukeMode","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoBuffMode",},{"AutoSambaMode","Weapons","OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","RecoverMode","ElementalMode","CastingMode","TreasureMode",})
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
		if state.Buff.Chainspell then
			eventArgs.handled = true
		end
		if spellMap == 'Cure' or spellMap == 'Curaga' then
			gear.default.obi_back = gear.obi_cure_back
			gear.default.obi_waist = gear.obi_cure_waist
		elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
			if LowTierNukes:contains(spell.english) then
				gear.default.obi_back = gear.obi_low_nuke_back
				gear.default.obi_waist = gear.obi_low_nuke_waist
			else
				gear.default.obi_back = gear.obi_high_nuke_back
				gear.default.obi_waist = gear.obi_high_nuke_waist
			end
		elseif spell.english == 'Phalanx II' and (spell.target.type == 'SELF' or buffactive.Accession) then
			windower.chat.input('/ma "Phalanx" <me>')
			cancel_spell()
			eventArgs.cancel = true
		elseif spell.english == 'Phalanx' and (spell.target.type ~= 'SELF') then
			windower.chat.input('/ws "Phalanx II" '..spell.target.raw)
			cancel_spell()
			eventArgs.cancel = true
		end
		
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end

end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, spellMap, eventArgs)

	if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' and spell.english ~= 'Impact' then
		if state.MagicBurstMode.value ~= 'Off' then
			if state.CastingMode.value:contains('Resistant') and sets.ResistantMagicBurst then
				equip(sets.ResistantMagicBurst)
			else
				equip(sets.MagicBurst)
			end
		end
		if spell.element == world.weather_element or spell.element == world.day_element then
			if state.CastingMode.value == 'Fodder' then
				-- if item_available('Twilight Cape') and not LowTierNukes:contains(spell.english) and not state.Capacity.value then
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
		
		if state.RecoverMode.value ~= 'Never' and (state.RecoverMode.value == 'Always' or tonumber(state.RecoverMode.value:sub(1, -2)) > player.mpp) then
			if state.MagicBurstMode.value ~= 'Off' then
				if state.CastingMode.value:contains('Resistant') and sets.ResistantRecoverBurst then
					equip(sets.ResistantRecoverBurst)
				elseif sets.RecoverBurst then
					equip(sets.RecoverBurst)
				end
			elseif sets.RecoverMP then
				equip(sets.RecoverMP)
			end
		end
		
    elseif spell.skill == 'Enfeebling Magic' then
		if state.Buff.Stymie and state.CastingMode.value:contains('Resistant') then
			if sets.midcast[spell.english] and sets.midcast[spell.english].Fodder then
				equip(sets.midcast[spell.english].Fodder)
			elseif sets.midcast[spell.english] then
				equip(sets.midcast[spell.english])
			elseif sets.midcast['Enfeebling Magic'].Fodder then
				equip(sets.midcast['Enfeebling Magic'].Fodder)
			else
				equip(sets.midcast['Enfeebling Magic'])
			end
		end
		
		if state.Buff.Saboteur then
			equip(sets.buff.Saboteur)
		end
    elseif spell.skill == 'Enhancing Magic' then
		equip(sets.midcast['Enhancing Magic'])
	
		if buffactive.Composure and spell.target.type == 'PLAYER' then
			equip(sets.buff.ComposureOther)
		end
		
		if sets.midcast[spell.english] then
			equip(sets.midcast[spell.english])
		elseif sets.midcast[spellMap] then
			equip(sets.midcast[spellMap])
		end
		
    end
end

function job_aftercast(spell, spellMap, eventArgs)
    if not spell.interrupted then
        if state.UseCustomTimers.value and spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif state.UseCustomTimers.value and spell.english == 'Sleep II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        elseif spell.skill == 'Elemental Magic' and state.MagicBurstMode.value == 'Single' then
            state.MagicBurstMode:reset()
			if state.DisplayMode.value then update_job_states()	end
        end
    end
end

function job_buff_change(buff, gain)
	update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
	update_melee_groups()
end

    -- Allow jobs to override this code
function job_self_command(commandArgs, eventArgs)
	if commandArgs[1]:lower() == 'elemental' then
		handle_elemental(commandArgs)
		eventArgs.handled = true			
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
    if player.mpp < 51 and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') and state.DefenseMode.value == 'None' then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	if  default_spell_map == 'Cure' or default_spell_map == 'Curaga'  then
		if world.weather_element == 'Light' then
                return 'LightWeatherCure'
		elseif world.day_element == 'Light' then
                return 'LightDayCure'
        end
	end	
	
	if spell.skill == 'Enfeebling Magic' then
		if spell.english:startswith('Dia') then
			return "Dia"
		elseif spell.type == "WhiteMagic" or spell.english:startswith('Frazzle') or spell.english:startswith('Distract') then
			return 'MndEnfeebles'
        else
            return 'IntEnfeebles'
        end
    end
	
	if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        if LowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
    end
	
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
    local command = cmdParams[2]:lower()

    if command == 'nuke' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		if state.ElementalMode.value == 'Light' then
			if spell_recasts[29] < spell_latency and actual_cost(get_spell_table_by_name('Banish II')) < player.mp then
				windower.chat.input('/ma "Banish II" <t>')
			elseif spell_recasts[28] < spell_latency and actual_cost(get_spell_table_by_name('Banish')) < player.mp then
				windower.chat.input('/ma "Banish" <t>')
			else
				add_to_chat(123,'Abort: Banishes on cooldown or not enough MP.')
			end

		elseif state.ElementalMode.value == 'Dark' then
			if spell_recasts[219] < spell_latency and actual_cost(get_spell_table_by_name('Comet')) < player.mp then
				windower.chat.input('/ma "Comet" <t>')
			else
				add_to_chat(123,'Abort: Comet on cooldown or not enough MP.')
			end

		else
			if player.job_points[(res.jobs[player.main_job_id].ens):lower()].jp_spent > 99 and spell_recasts[get_spell_table_by_name(elements.nuke[state.ElementalMode.value]..' V').id] < spell_latency and actual_cost(get_spell_table_by_name(elements.nuke[state.ElementalMode.value]..' V')) < player.mp then
				windower.chat.input('/ma "'..elements.nuke[state.ElementalMode.value]..' V" <t>')
			else
				local tiers = {' IV',' III',' II',''}
				for k in ipairs(tiers) do
					if spell_recasts[get_spell_table_by_name(elements.nuke[state.ElementalMode.value]..''..tiers[k]..'').id] < spell_latency and actual_cost(get_spell_table_by_name(elements.nuke[state.ElementalMode.value]..''..tiers[k]..'')) < player.mp then
						windower.chat.input('/ma "'..elements.nuke[state.ElementalMode.value]..''..tiers[k]..'" <t>')
						return
					end
				end
				add_to_chat(123,'Abort: All '..elements.nuke[state.ElementalMode.value]..' nukes on cooldown or or not enough MP.')
			end
		end

	elseif command == 'ninjutsu' then
		windower.chat.input('/ma "'..elements.ninnuke[state.ElementalMode.value]..': Ni" <t>')
		
	elseif command == 'smallnuke' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
	
		local tiers = {' II',''}
		for k in ipairs(tiers) do
			if spell_recasts[get_spell_table_by_name(elements.nuke[state.ElementalMode.value]..''..tiers[k]..'').id] < spell_latency and actual_cost(get_spell_table_by_name(elements.nuke[state.ElementalMode.value]..''..tiers[k]..'')) < player.mp then
				windower.chat.input('/ma "'..elements.nuke[state.ElementalMode.value]..''..tiers[k]..'" <t>')
				return
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
		if  (player.sub_job == 'NIN' or player.sub_job == 'DNC') then 
			windower.chat.input('/ma "En'..elements.enspell[state.ElementalMode.value]..'" <me>')
		else
			windower.chat.input('/ma "En'..elements.enspell[state.ElementalMode.value]..' II" <me>')
		end
		
	elseif command == 'weather' then
		if player.sub_job ~= 'SCH' then
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

function job_tick()
	if check_arts() then return true end
	if check_buff() then return true end
	if check_buffup() then return true end
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

function check_arts()
	if buffup ~= '' or (state.AutoArts.value and not areas.Cities:contains(world.area) and (player.in_combat or state.AutoBuffMode.value)) then
	
		local abil_recasts = windower.ffxi.get_ability_recasts()
		
		if not buffactive.Composure then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			if abil_recasts[50] < latency then
				tickdelay = (framerate * 1)
				windower.chat.input('/ja "Composure" <me>')
				return true
			end
		end

		if player.sub_job == 'SCH' and not arts_active() and abil_recasts[228] < latency then
			send_command('@input /ja "Light Arts" <me>')
			tickdelay = (framerate * 1)
			return true
		end

	end
	
	return false
end

function update_melee_groups()
	if player.equipment.main then
		classes.CustomMeleeGroups:clear()
		
		if player.equipment.main == "Murgleis" and state.Buff['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('AM')
		end
	end	
end

buff_spell_lists = {
	Auto = {
		{Name='Refresh III',Buff='Refresh',SpellID=894},
		{Name='Haste II',Buff='Haste',SpellID=511},
		{Name='Aurorastorm',Buff='Aurorastorm',SpellID=119},
	},
	
	Default = {
		{Name='Refresh III',Buff='Refresh',SpellID=894},
		{Name='Haste II',Buff='Haste',SpellID=511},
		{Name='Stoneskin',Buff='Stoneskin',SpellID=54},
		{Name='Shell V',Buff='Shell',SpellID=52},
		{Name='Protect V',Buff='Protect',SpellID=47},
	},
	
	MeleeBuff = {
		{Name='Refresh III',Buff='Refresh',SpellID=894},
		{Name='Haste II',Buff='Haste',SpellID=511},
		{Name='Regen II',Buff='Regen',SpellID=110},
		{Name='Aquaveil',Buff='Aquaveil',SpellID=55},
		{Name='Phalanx',Buff='Phalanx',SpellID=106},
		{Name='Stoneskin',Buff='Stoneskin',SpellID=54},
		{Name='Blink',Buff='Blink',SpellID=53},
		{Name='Gain-INT',Buff='INT Boost',SpellID=490},
		{Name='Shell V',Buff='Shell',SpellID=52},
		{Name='Protect V',Buff='Protect',SpellID=47},
		{Name='Shock Spikes',Buff='Shock Spikes',SpellID=251},
		{Name='Enthunder II',Buff='Enthunder II',SpellID=316},
		{Name='Temper II',Buff='Multi Strikes',SpellID=895},
		{Name='Barfire',Buff='Barfire',SpellID=60},
		{Name='Barparalyze',Buff='Barparalyze',SpellID=74},
	},
}