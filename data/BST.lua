-------------------------------------------------------------------------------------------------------------------
-- Last Revised: May 7th, 2015 (Added a 'PetOnly' Mode - 'Windows Key'+F8 cycles Pet Modes.
-- And a new rule for equipping TP Bonus Hands for TP-based moves.)
--
-- alt+F8 cycles through designated Jug Pets
-- ctrl+F8 toggles Monster Correlation between Neutral and Favorable
-- 'Windows Key'+F8 switches between Pet stances for Master/Pet hybrid gearsets
-- alt+= cycles through Pet Food types
-- ctrl+= can swap in the usage of Chaac Belt for Treasure Hunter on common subjob abilities.
-- ctrl+F11 cycles between Magical Defense Modes
--
-- General Gearswap Commands:
-- F9 cycles Accuracy modes
-- ctrl+F9 cycles Hybrid modes
-- 'Windows Key'+F9 cycles Weapon Skill modes
-- F10 equips Physical Defense
-- alt+F10 toggles Kiting on or off
-- ctrl+F10 cycles Physical Defense modes
-- F11 equips Magical Defense
-- alt+F12 turns off Defense modes
-- ctrl+F12 cycles Idle modes
--
-- Keep in mind that any time you Change Jobs/Subjobs, your Pet/Pet Food/etc. reset to default options.
-- F12 will list your current options.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
        -- Load and initialize the include file.
        include('Sel-Include.lua')
end

function job_setup()

	state.Buff['Killer Instinct'] = buffactive['Killer Instinct'] or false
	state.Buff["Unleash"] = buffactive["Unleash"] or false
	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false

	-- 'Out of Range' distance; WS will auto-cancel
	target_distance = 6

	-- Complete list of Ready moves to use with Sic & Ready Recast -5 Desultor Tassets.
	ready_moves_to_check = S{'Sic','Whirl Claws','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
        'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang',
        'Roar','Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit',
        'Numbing Noise','Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Power Attack',
        'Hi-Freq Field','Sandpit','Sandblast','Venom Spray','Mandibular Bite','Metallic Body','Bubble Shower',
        'Bubble Curtain','Scissor Guard','Big Scissors','Grapple','Spinning Top','Double Claw','Filamented Hold',
        'Frog Kick','Queasyshroom','Silence Gas','Numbshroom','Spore','Dark Spore','Shakeshroom','Blockhead',
        'Secretion','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics','??? Needles',
        'Needleshot','Chaotic Eye','Blaster','Scythe Tail','Ripper Fang','Chomp Rush','Intimidate','Recoil Dive',
        'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Spiral Spin','Noisome Powder','Wing Slap',
        'Beak Lunge','Suction','Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath',
        'Fantod','Charged Whisker','Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath',
        'Sensilla Blades','Tegmina Buffet','Molting Plumage','Swooping Frenzy','Pentapeck','Sweeping Gouge',
        'Zealous Snort','Somersault ','Tickling Tendrils','Stink Bomb','Nectarous Deluge','Nepenthic Plunge',
        'Pecking Flurry','Pestilent Plume','Foul Waters','Spider Web','Sickle Slash'}

	tp_based_ready_moves = S{'Sic','Somersault ','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
        'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Roar',
        'Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Geist Wall','Numbing Noise','Frogkick',
        'Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Hi-Freq Field','Sandpit','Sandblast',
        'Mandibular Bite','Metallic Body','Bubble Shower','Bubble Curtain','Scissor Guard','Grapple','Spinning Top',
        'Double Claw','Filamented Hold','Spore','Blockhead','Secretion','Fireball','Tail Blow','Plague Breath',
        'Brain Crush','Infrasonics','Needleshot','Chaotic Eye','Blaster','Ripper Fang','Intimidate','Recoil Dive',
        'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Noisome Powder','Wing Slap','Beak Lunge','Suction',
        'Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath','Fantod','Charged Whisker',
        'Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath','Sensilla Blades',
        'Tegmina Buffet','Sweeping Gouge','Zealous Snort','Tickling Tendrils','Pecking Flurry',
        'Pestilent Plume','Foul Waters','Spider Web'}

	-- List of Magic-based Ready moves to use with Pet MAB or Pet M.Acc gearset.
	magic_ready_moves = S{'Dust Cloud','Sheep Song','Scream','Dream Flower','Roar','Gloeosuccus','Palsy Pollen',
        'Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit','Numbing Noise','Spoil','Hi-Freq Field',
        'Sandpit','Sandblast','Venom Spray','Bubble Shower','Filamented Hold','Queasyshroom','Silence Gas',
        'Numbshroom','Spore','Dark Spore','Shakeshroom','Fireball','Plague Breath','Infrasonics','Chaotic Eye',
        'Blaster','Intimidate','Snow Cloud','Noisome Powder','TP Drainkiss','Jettatura','Charged Whisker',
        'Purulent Ooze','Corrosive Ooze','Aqua Breath','Molting Plumage','Stink Bomb','Nectarous Deluge',
        'Nepenthic Plunge','Pestilent Plume','Foul Waters','Spider Web'}

	-- List of abilities to reference for applying Treasure Hunter +1 via Chaac Belt.
	abilities_to_check = S{'Feral Howl','Quickstep','Box Step','Stutter Step','Desperate Flourish','Violent Flourish',
        'Animated Flourish','Provoke','Dia','Dia II','Flash','Bio','Bio II','Sleep','Sleep II',
        'Drain','Aspir','Dispel','Steal','Mug'}

	ready_moves = {}
	ready_moves.default =  {['DroopyDortwin']='Foot Kick',['PonderingPeter']='Foot Kick',['HeraldHenry']='Big Scissors',['CourierCarrie']='Big Scissors',
							['AgedAngus']='Big Scissors',['SunburstMalfik']='Big Scissors',['WarlikePatrick']='Fireball',['ScissorlegXerin']='Sensilla Blades',
							['BouncingBertha']='Sensilla Blades',['RhymingShizuna']='Lamb Chop',['AttentiveIbuki']='Swooping Frenzy',
							['SwoopingZhivago']='Swooping Frenzy',['AmiableRoche']='Recoil Dive',['BrainyWaluis']='Frogkick',['SuspiciousAlice']='Cyclotail',
							['HeadbreakerKen']='Somersault',['RedolentCandi']='Tickling Tendrils',['AlluringHoney']='Tickling Tendrils',
							['CaringKiyomaro']='Sweeping Gouge',['VivaciousVickie']='Sweeping Gouge',['AnklebiterJedd']='Double Claw',
							['HurlerPercival']='Power Attack',['BlackbeardRandy']='Razor Fang',['FleetReinhard']='Scythe Tail',
							['ColibriFamiliar']='Pecking Flurry',['ChoralLeera']='Pecking Flurry',['SpiderFamiliar']='Sickle Slash',
							['GussyHachirobe']='Sickle Slash',['ThreestarLynn']='Spiral Spin',['GenerousArthur']='Purulent Ooze',
							['CursedAnnabelle']='Mandibular Bite',['SurgingStorm']='Beak Lunge',['SubmergedIyo']='Beak Lunge',
							['SharpwitHermes']='Head Butt',['AcuexFamiliar']='Pestilent Plume',['FluffyBredo']='Pestilent Plume',
							['MosquitoFamiliar']='Infected Leech',['Left-HandedYoko']='Infected Leech',}

	ready_moves.aoe = 	   {['DroopyDortwin']='Whirl Claws',['PonderingPeter']='Whirl Claws',['HeraldHenry']='Bubble Shower',['CourierCarrie']='Bubble Shower',
							['AgedAngus']='Bubble Shower',['SunburstMalfik']='Bubble Shower',['WarlikePatrick']='Fireball',['ScissorlegXerin']='Tegmina Buffet',
							['BouncingBertha']='Tegmina Buffet',['RhymingShizuna']='Sheep Song',['AttentiveIbuki']='Molting Plumage',
							['SwoopingZhivago']='Molting Plumage',['AmiableRoche']='Recoil Dive',['BrainyWaluis']='Silence Gas',['SuspiciousAlice']='Cyclotail',
							['HeadbreakerKen']='Cursed Sphere',['RedolentCandi']='Nectarous Deluge',['AlluringHoney']='Nectarous Deluge',
							['AnklebiterJedd']='Spinning Top',['HurlerPercival']='Hi-Freq Field',['BlackbeardRandy']='Claw Cyclone',
							['SpiderFamiliar']='Spider Web',['GussyHachirobe']='Spider Web',['ThreestarLynn']='Spiral Spin',['GenerousArthur']='Purulent Ooze',
							['CursedAnnabelle']='Sandblast',['SharpwitHermes']='Scream',['AcuexFamiliar']='Pestilent Plume',['FluffyBredo']='Pestilent Plume',
							['MosquitoFamiliar']='Infected Leech',['Left-HandedYoko']='Infected Leech',}

	ready_moves.buff =     {['DroopyDortwin']='Wild Carrot',['PonderingPeter']='Wild Carrot',['HeraldHenry']='Scissor Guard',['CourierCarrie']='Scissor Guard',
							['AgedAngus']='Scissor Guard',['SunburstMalfik']='Scissor Guard',['WarlikePatrick']='Secretion',
							['RhymingShizuna']='Rage',['AmiableRoche']='Water Wall',['HurlerPercival']='Rhino Guard',
							['CaringKiyomaro']='Zealous Snort',['VivaciousVickie']='Zealous Snort'}

	ready_moves.debuff =   {['DroopyDortwin']='Dust Cloud',['PonderingPeter']='Dust Cloud',['HeraldHenry']='Bubble Shower',['CourierCarrie']='Bubble Shower',
							['AgedAngus']='Bubble Shower',['SunburstMalfik']='Bubble Shower',['WarlikePatrick']='Infrasonics',['ScissorlegXerin']='Tegmina Buffet',
							['BouncingBertha']='Tegmina Buffet',['RhymingShizuna']='Sheep Song',['AttentiveIbuki']='Swooping Frenzy',
							['SwoopingZhivago']='Swooping Frenzy',['AmiableRoche']='Intimidate',['BrainyWaluis']='Numbshroom',['SuspiciousAlice']='Geist Wall',
							['HeadbreakerKen']='Venom',['RedolentCandi']='Stink Bomb',['AlluringHoney']='Stink Bomb',
							['CaringKiyomaro']='Sweeping Gouge',['VivaciousVickie']='Sweeping Gouge',['AnklebiterJedd']='Filamented Hold',
							['HurlerPercival']='Hi-Freq Field',['BlackbeardRandy']='Roar',['FleetReinhard']='Chomp Rush',
							['SpiderFamiliar']='Spider Web',['GussyHachirobe']='Spider Web',['ThreestarLynn']='Noisome Powder',
							['GenerousArthur']='Corrosive Ooze',['CursedAnnabelle']='Sandpit',
							['SharpwitHermes']='Wild Oats',['AcuexFamiliar']='Pestilent Plume',['FluffyBredo']='Pestilent Plume',
							['MosquitoFamiliar']='Gloom Spray',['Left-HandedYoko']='Gloom Spray',}

	ready_moves.physical = {['DroopyDortwin']='Foot Kick',['PonderingPeter']='Foot Kick',['HeraldHenry']='Big Scissors',['CourierCarrie']='Big Scissors',
							['AgedAngus']='Big Scissors',['SunburstMalfik']='Big Scissors',['WarlikePatrick']='Tail Blow',['ScissorlegXerin']='Sensilla Blades',
							['BouncingBertha']='Sensilla Blades',['RhymingShizuna']='Lamb Chop',['AttentiveIbuki']='Swooping Frenzy',
							['SwoopingZhivago']='Swooping Frenzy',['AmiableRoche']='Recoil Dive',['BrainyWaluis']='Frogkick',['SuspiciousAlice']='Cyclotail',
							['HeadbreakerKen']='Somersault',['RedolentCandi']='Tickling Tendrils',['AlluringHoney']='Tickling Tendrils',
							['CaringKiyomaro']='Sweeping Gouge',['VivaciousVickie']='Sweeping Gouge',['AnklebiterJedd']='Double Claw',
							['HurlerPercival']='Power Attack',['BlackbeardRandy']='Razor Fang',['FleetReinhard']='Scythe Tail',
							['ColibriFamiliar']='Pecking Flurry',['ChoralLeera']='Pecking Flurry',['SpiderFamiliar']='Sickle Slash',
							['GussyHachirobe']='Sickle Slash',['ThreestarLynn']='Spiral Spin',['GenerousArthur']='Purulent Ooze',
							['CursedAnnabelle']='Mandibular Bite',['SurgingStorm']='Beak Lunge',['SubmergedIyo']='Beak Lunge',
							['SharpwitHermes']='Head Butt'}

	ready_moves.magical =  {['DroopyDortwin']='Dust Cloud',['PonderingPeter']='Dust Cloud',['HeraldHenry']='Bubble Shower',['CourierCarrie']='Bubble Shower',
							['AgedAngus']='Bubble Shower',['SunburstMalfik']='Bubble Shower',['WarlikePatrick']='Fireball',
							['AttentiveIbuki']='Molting Plumage',['SwoopingZhivago']='Molting Plumage',
							['BrainyWaluis']='Silence Gas',['HeadbreakerKen']='Cursed Sphere',['RedolentCandi']='Nepenthic Plunge',
							['AlluringHoney']='Nepenthic Plunge',['SpiderFamiliar']='Acid Spray',
							['GussyHachirobe']='Acid Spray',['GenerousArthur']='Purulent Ooze',
							['SharpwitHermes']='Head Butt',['AcuexFamiliar']='Pestilent Plume',['FluffyBredo']='Pestilent Plume',
							['MosquitoFamiliar']='Infected Leech',['Left-HandedYoko']='Infected Leech',}

	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Rampage','Calamity'}

	state.AutoFightMode = M(true, 'Auto Fight Mode')
	state.AutoReadyMode = M(false, 'Auto Ready Mode')
	state.AutoCallPet = M(false, 'Auto Call Pet')
	state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Zeta', 'Eta'}
  state.JugMode = M{['description']='Jug Mode', 'ScissorlegXerin', 'BlackbeardRandy', 'AttentiveIbuki', 'AgedAngus',
                'RedolentCandi','DroopyDortwin','WarlikePatrick','HeraldHenry','AlluringHoney','SwoopingZhivago','AcuexFamiliar'}

	UnleashLock = true
	UnleashLocked = false

	autows = 'Cloudsplitter'
	autofood = 'Akamochi'

	update_combat_form()
	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoWSMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoReadyMode","AutoBuffMode",},{"Weapons","OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","JugMode","RewardMode","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_filter_precast(spell, spellMap, eventArgs)
    if spell.english == "Bestial Loyalty" then

		local abil_recasts = windower.ffxi.get_ability_recasts()

		if abil_recasts[94] ~= 0 then
				send_command('@input /ja "Call Beast" <me>')
                eventArgs.cancel = true
				return
		end

    end
end

function job_precast(spell, spellMap, eventArgs)
        cancel_conflicting_buffs(spell, action, spellMap, eventArgs)

        if spell.type == "WeaponSkill" and spell.name ~= 'Mistral Axe' and spell.name ~= 'Bora Axe' and spell.target.distance > target_distance then
                eventArgs.cancel = true
                add_to_chat(123, spell.name..' Canceled: [Out of Range]')

		elseif spell.english == 'Reward' then
			equip(sets.precast.JA.Reward[state.RewardMode.value])

			if state.PetMode.value == 'PetOnly' then
				if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
					equip(sets.RewardAxesDW)
				else
					equip(sets.RewardAxe)
				end
			end

		elseif spell.english == 'Spur' then
			equip(sets.precast.JA.Spur)

			if state.PetMode.value == 'PetOnly' then
				if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
					equip(sets.SpurAxesDW)
				else
					equip(sets.SpurAxe)
				end
			end

		elseif spell.english == 'Bestial Loyalty' then
				if state.JugMode.value == 'DroopyDortwin' and item_available('Vis. Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].PonderingPeter)
				elseif state.JugMode.value == 'SunburstMalfik' and item_available('Ferm. Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].AgedAngus)
				elseif state.JugMode.value == 'ScissorlegXerin' and item_available('Bubbly Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].BouncingBertha)
				elseif state.JugMode.value == 'AttentiveIbuki' and item_available('Windy Greens') then
					equip(sets.precast.JA['Bestial Loyalty'].SwoopingZhivago)
				elseif state.JugMode.value == 'RedolentCandi' and item_available('Bug-Ridden Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].AlluringHoney)
				elseif state.JugMode.value == 'CaringKiyomaro' and item_available('Tant. Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].VivaciousVickie)
				elseif state.JugMode.value == 'ColibriFamiliar' and item_available('Glazed Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].ChoralLeera)
				elseif state.JugMode.value == 'SpiderFamiliar' and item_available('Slimy Webbing') then
					equip(sets.precast.JA['Bestial Loyalty'].GussyHachirobe)
				elseif state.JugMode.value == 'SurgingStorm' and item_available('Deepwater Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].SubmergedIyo)
				elseif state.JugMode.value == 'AcuexFamiliar' and item_available('Venomous Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].FluffyBredo)
				elseif state.JugMode.value == 'MosquitoFamiliar' and item_available('Heavenly Broth') then
					equip(sets.precast.JA['Bestial Loyalty']['Left-HandedYoko'])
				else
					equip(sets.precast.JA['Bestial Loyalty'][state.JugMode.value])
				end

		elseif spell.english == 'Call Beast' then
				equip(sets.precast.JA['Bestial Loyalty'][state.JugMode.value])

-- Define class for Sic and Ready moves.
        elseif spell.type == 'Monster' then
            classes.CustomClass = "WS"
            if state.PetMode.Value == 'PetOnly' and (player.sub_job == 'NIN' or player.sub_job == 'DNC') then
              equip(sets.midcast.Pet.ReadyRecastNE)
            else
              equip(sets.midcast.Pet.ReadyRecast)
            end
        end
end

function job_post_precast(spell, spellMap, eventArgs)

	-- Replace Moonshade Earring if we're at cap TP
	if spell.type == 'WeaponSkill' then
		local WSset = get_precast_set(spell, spellMap)
		if not WSset.ear1 then WSset.ear1 = WSset.left_ear or '' end
		if not WSset.ear2 then WSset.ear2 = WSset.right_ear or '' end
		local wsacc = check_ws_acc()
    -- Replace Moonshade Earring if we're at cap TP
    if player.tp > 2950 and (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			if wsacc:contains('Acc') and sets.AccMaxTP then
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
			if wsacc:contains('Acc') and (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayWSEars then
				equip(sets.AccDayWSEars)
			elseif (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayWSEars then
				equip(sets.DayWSEars)
			end
		end

		-- If Killer Instinct is active during WS, equip Ferine Gausape +2.
        if buffactive['Killer Instinct'] then
                equip(sets.buff['Killer Instinct'])
        end
	end


end

function job_pet_midcast(spell, spellMap, eventArgs)
  if state.PetMode.value == 'PetOnly' then
    if state.OffenseMode.value:contains('Acc') then
      equip(sets.midcast.Pet.ReadyNE.Acc)
    elseif state.OffenseMode.value == 'FullAcc' then
      equip(sets.midcast.Pet.FullAcc)
    else
      equip(set_combine(sets.midcast.Pet.ReadyNE, sets.midcast.Pet[state.CorrelationMode.value]))
    end
  else
    if state.OffenseMode.value:contains('Acc') then
      equip(sets.midcast.Pet.Acc)
    elseif state.OffenseMode.value == 'FullAcc' then
        equip(sets.midcast.Pet.ReadyNE.Acc)
    else
        equip(set_combine(sets.midcast.Pet.WS, sets.midcast.Pet[state.CorrelationMode.value]))
    end
  end

  if magic_ready_moves:contains(spell.name) then
          if state.PetMode.value == 'PetOnly' then
                  equip(sets.midcast.Pet.MagicReadyNE)
          else
                  equip(sets.midcast.Pet.MagicReady)
          end
  end

  -- If Pet TP, before bonuses, is less than a certain value then equip Nukumi Manoplas +1
  if tp_based_ready_moves:contains(spell.name) and PetJob == 'Warrior' then
          if pet.tp < 1900 then
                  equip(sets.midcast.Pet.TPBonus)
          end
  elseif tp_based_ready_moves:contains(spell.name) and PetJob ~= 'Warrior' then
          if pet.tp < 2400 then
                  equip(sets.midcast.Pet.TPBonus)
          end
  end
end

function job_post_pet_midcast(spell, spellMap, eventArgs)
	if state.Buff["Unleash"] and UnleashLock and not UnleashLocked then
		UnleashLocked = true
		disable('main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring','back','waist','legs','feet')
		add_to_chat(217, "Unleash is on, locking your current Ready set.")
	end
end

function job_pet_aftercast(spell, action, spellMap, eventArgs)
	send_command('@wait 1;gs c showcharge')
end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, spellMap, eventArgs)
	if pet_midaction() or (type(spell.type) == 'string' and (spell.type == 'Monster' or spell.english == "Bestial Loyalty" or spell.english == 'Call Beast')) then
		eventArgs.handled = true
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hook for idle sets.
-------------------------------------------------------------------------------------------------------------------

function job_customize_idle_set(idleSet)

        if  state.PetMode.value == 'PetOnly' then
           idleSet = set_combine(idleSet, sets.IdleAxesNE)
        end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

    if state.ExtraMeleeMode.value ~= 'None' then
        meleeSet = set_combine(meleeSet, sets[state.ExtraMeleeMode.value])
    end

    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Hooks for Reward, Correlation, Treasure Hunter, and Pet Mode handling.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
	update_melee_groups()
	if buff == 'Unleash' and UnleashLocked and not gain then
		UnleashLocked = false
		enable('main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring','back','waist','legs','feet')
		add_to_chat(217, "Unleash has worn, enabling all slots.")
	end
end

function job_state_change(stateField, newValue, oldValue)
        if stateField == 'Correlation Mode' then
                state.CorrelationMode:set(newValue)
        elseif stateField == 'Reward Mode' then
                state.RewardMode:set(newValue)
        elseif stateField == 'Treasure Mode' then
                state.TreasureMode:set(newValue)
        elseif stateField == 'Pet Mode' then
                state.CombatWeapon:set(newValue)
        elseif stateField == 'Jug Mode' then
                state.JugMode:set(newValue)
        end
end

function job_status_change(newStatus, oldStatus, eventArgs)
	if newStatus == "Engaged" and pet.isvalid and pet.status == "Idle" and player.target.type == "MONSTER" and state.AutoFightMode.value and player.target.distance < 20 then
		windower.chat.input('/pet Fight <t>')
	end
end

function get_custom_wsmode(spell, spellMap, default_wsmode)
        if default_wsmode ~= 'Fodder' then
                if spell.english == "Ruinator" and (world.day_element == 'Water' or world.day_element == 'Wind' or world.day_element == 'Ice') then
                        return 'Mekira'
                end
        end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	update_combat_form()
	update_melee_groups()

	if state.JugMode.value == 'FunguarFamiliar' then
			PetInfo = "Funguar, Plantoid"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'CourierCarrie' then
			PetInfo = "Crab, Aquan"
			PetJob = 'Paladin'
	elseif state.JugMode.value == 'AmigoSabotender' then
			PetInfo = "Cactuar, Plantoid"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'NurseryNazuna' then
			PetInfo = "Sheep, Beast"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'CraftyClyvonne' then
			PetInfo = "Coeurl, Beast"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'FleetReinhard' then
			PetInfo = "Raptor, Lizard"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'PrestoJulio' then
			PetInfo = "Flytrap, Plantoid"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'SwiftSieghard' then
			PetInfo = "Raptor, Lizard"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'MailbusterCetas' then
			PetInfo = "Fly, Vermin"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'AudaciousAnna' then
			PetInfo = "Lizard, Lizard"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'TurbidToloi' then
			PetInfo = "Pugil, Aquan"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'SlipperySilas' then
			PetInfo = "Toad, Aquan"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'LuckyLulush' then
			PetInfo = "Rabbit, Beast"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'DipperYuly' then
			PetInfo = "Ladybug, Vermin"
			PetJob = 'Thief'
	elseif state.JugMode.value == 'FlowerpotMerle' then
			PetInfo = "Mandragora, Plantoid"
			PetJob = 'Monk'
	elseif state.JugMode.value == 'DapperMac' then
			PetInfo = "Apkallu, Bird"
			PetJob = 'Monk'
	elseif state.JugMode.value == 'DiscreetLouise' then
			PetInfo = "Funguar, Plantoid"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'FatsoFargann' then
			PetInfo = "Leech, Amorph"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'FaithfulFalcorr' then
			PetInfo = "Hippogryph, Bird"
			PetJob = 'Thief'
	elseif state.JugMode.value == 'BugeyedBroncha' then
			PetInfo = "Eft, Lizard"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'BloodclawShasra' then
			PetInfo = "Lynx, Beast"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'GorefangHobs' then
			PetInfo = "Tiger, Beast"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'GooeyGerard' then
			PetInfo = "Slug, Amorph"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'CrudeRaphie' then
			PetInfo = "Adamantoise, Lizard"
			PetJob = 'Paladin'
	elseif state.JugMode.value == 'DroopyDortwin' then
			PetInfo = "Rabbit, Beast"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'PonderingPeter' then
			PetInfo = "HQ Rabbit, Beast"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'SunburstMalfik' then
			PetInfo = "Crab, Aquan"
			PetJob = 'Paladin'
	elseif state.JugMode.value == 'AgedAngus' then
			PetInfo = "HQ Crab, Aquan"
			PetJob = 'Paladin'
	elseif state.JugMode.value == 'WarlikePatrick' then
			PetInfo = "Lizard, Lizard"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'MosquitoFamiliar' then
			PetInfo = "Mosquito, Vermin"
			PetJob = 'Dark Knight'
	elseif state.JugMode.value == 'Left-HandedYoko' then
			PetInfo = "Mosquito, Vermin"
			PetJob = 'Dark Knight'
	elseif state.JugMode.value == 'ScissorlegXerin' then
			PetInfo = "Chapuli, Vermin"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'BouncingBertha' then
			PetInfo = "HQ Chapuli, Vermin"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'RhymingShizuna' then
			PetInfo = "Sheep, Beast"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'AttentiveIbuki' then
			PetInfo = "Tulfaire, Bird"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'SwoopingZhivago' then
			PetInfo = "HQ Tulfaire, Bird"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'AmiableRoche' then
			PetInfo = "Pugil, Aquan"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'HeraldHenry' then
			PetInfo = "Crab, Aquan"
			PetJob = 'Paladin'
	elseif state.JugMode.value == 'BrainyWaluis' then
			PetInfo = "Funguar, Plantoid"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'SuspiciousAlice' then
			PetInfo = "Eft, Lizard"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'HeadbreakerKen' then
			PetInfo = "Fly, Vermin"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'RedolentCandi' then
			PetInfo = "Snapweed, Plantoid"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'AlluringHoney' then
			PetInfo = "HQ Snapweed, Plantoid"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'CaringKiyomaro' then
			PetInfo = "Raaz, Beast"
			PetJob = 'Monk'
	elseif state.JugMode.value == 'SurgingStorm' then
			PetInfo = "Apkallu, Bird"
			PetJob = 'Monk'
	elseif state.JugMode.value == 'SubmergedIyo' then
			PetInfo = "Apkallu, Bird"
			PetJob = 'Monk'
	elseif state.JugMode.value == 'CursedAnnabelle' then
			PetInfo = "Antlion, Vermin"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'AnklebiterJedd' then
			PetInfo = "Diremite, Vermin"
			PetJob = 'Dark Knight'
	elseif state.JugMode.value == 'VivaciousVickie' then
			PetInfo = "HQ Raaz, Beast"
			PetJob = 'Monk'
	elseif state.JugMode.value == 'HurlerPercival' then
			PetInfo = "Beetle, Vermin"
			PetJob = 'Paladin'
	elseif state.JugMode.value == 'BlackbeardRandy' then
			PetInfo = "Tiger, Beast"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'GenerousArthur' then
			PetInfo = "Slug, Amorph"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'ThreestarLynn' then
			PetInfo = "Ladybug, Vermin"
			PetJob = 'Thief'
	elseif state.JugMode.value == 'BraveHeroGlenn' then
			PetInfo = "Frog, Aquan"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'SharpwitHermes' then
			PetInfo = "Mandragora, Plantoid"
			PetJob = 'Monk'
	elseif state.JugMode.value == 'ColibriFamiliar' then
			PetInfo = "Colibri, Bird"
			PetJob = 'Red Mage'
	elseif state.JugMode.value == 'ChoralLeera' then
			PetInfo = "HQ Colibri, Bird"
			PetJob = 'Red Mage'
	elseif state.JugMode.value == 'SpiderFamiliar' then
			PetInfo = "Spider, Vermin"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'GussyHachirobe' then
			PetInfo = "HQ Spider, Vermin"
			PetJob = 'Warrior'
	elseif state.JugMode.value == 'AcuexFamiliar' then
			PetInfo = "Acuex, Amorph"
			PetJob = 'Black Mage'
	elseif state.JugMode.value == 'FluffyBredo' then
			PetInfo = "HQ Acuex, Amorph"
			PetJob = 'Black Mage'
	end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = 'Melee'

    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end

    msg = msg .. ': '

    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    if state.ExtraMeleeMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraMeleeMode.value
    end

    msg = msg .. ', Reward: '..state.RewardMode.value..', Correlation: '..state.CorrelationMode.value

    if state.JugMode.value ~= 'None' then
        add_to_chat(8,'--- Jug Pet: '.. state.JugMode.value ..' --- ('.. PetInfo ..', '.. PetJob ..')')
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
	if player.equipment.main and (player.sub_job == 'NIN' or player.sub_job == 'DNC') and player.equipment.sub and not (player.equipment.sub == 'empty' or player.equipment.sub:contains('Grip') or player.equipment.sub:contains('Strap') or player.equipment.sub:contains('Shield')) then
			state.CombatForm:set('DW')
	else
			state.CombatForm:reset()
	end
end

function update_melee_groups()
	if player.equipment.main then
		classes.CustomMeleeGroups:clear()

		if player.equipment.main == "Aymur" and state.Buff['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('AM')
		end
	end
end

function job_self_command(commandArgs, eventArgs)

		if commandArgs[1]:lower() == 'showcharge' then
			add_to_chat(204, '~~~Current Ready Charges Available: ['..get_current_ready_count()..']~~~')

		elseif commandArgs[1]:lower() == 'unleashlock' then
			if UnleashLock == true then
				UnleashLock = false
				add_to_chat(122, "Unleash no longer locks gear.")
			elseif UnleashLock == false then
				UnleashLock = true
				add_to_chat(122, "Unleash now locks gear.")
			end

		elseif commandArgs[1]:lower() == 'ready' and pet.isvalid then

				if pet.status == "Idle" and player.target.type == "MONSTER" then
					windower.chat.input('/pet Fight <t>')
				else
					handle_ready(commandArgs)
				end

		end
end

function job_tick()
	if check_pet() then return true end
	if check_ready() then return true end
	return false
end

function check_pet()

	if pet.isvalid then
		if pet.hpp < 34 then
			local abil_recasts = windower.ffxi.get_ability_recasts()

			if abil_recasts[103] == 0 and not (buffactive.amnesia or buffactive.impairment) then
				if item_available('Pet Food '..state.RewardMode.value..'') then
					windower.chat.input('/ja "Reward" <me>')
					tickdelay = 30
					return true
				else
					return false
				end
			end
		end
	elseif state.AutoCallPet.value and not areas.Cities:contains(world.area) then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if abil_recasts[94] == 0 then
			send_command('@input /ja "Bestial Loyalty" <me>')
			tickdelay = 30
			return true
		elseif abil_recasts[104] == 0 then
			send_command('@input /ja "Call Beast" <me>')
			tickdelay = 30
			return true
		else
			return false
		end
	else
		return false
	end

end

function check_ready()
	if state.AutoReadyMode.value and not moving then
		if pet.isvalid then
			if pet.status == "Engaged" and get_current_ready_count() > 0 then
				windower.send_command('gs c ready')
				tickdelay = 85
				return true
			elseif pet.status == "Idle" and player.target.type == "MONSTER" then
				windower.chat.input('/pet Fight <t>')
				tickdelay = 60
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end

end

function get_current_ready_count()
    local abil_recasts = windower.ffxi.get_ability_recasts()
    local readyRecast = abil_recasts[102]

    local maxCharges = 3

	local ReadyChargeTimer = get_ready_charge_timer()

	-- The *# is your current recharge timer.
    local fullRechargeTime = 3*ReadyChargeTimer

    local currentCharges = math.floor(maxCharges - maxCharges * readyRecast / fullRechargeTime)

    return currentCharges
end

windower.register_event('zone change', function()
	state.AutoReadyMode:reset()
end)

function handle_ready(commandArgs)
    if areas.Cities:contains(world.area) then
        add_to_chat(123, 'Abort:You cannot use ready in town.')
        return
    end

    if not pet.isvalid then
        add_to_chat(123,'Abort: You do not have a pet.')
        return
    end

	if get_current_ready_count() == 0 then
		add_to_chat(123,'Abort: No pet charges!')
		return
	end

    if not commandArgs[2] then
		if ready_moves.default[pet.name] then
			windower.chat.input('/pet "'..ready_moves.default[pet.name]..'" <me>')
		else
			windower.chat.input('/pet "Sic" <me>')
		end
		return
    end

    local ready = commandArgs[2]:lower()

    if not ready_moves[ready] then
        add_to_chat(123,'Abort: Unknown ready type: '..tostring(ready))
        return
    end

    if ready_moves[ready][pet.name] then
		windower.chat.input('/pet "'..ready_moves[ready][pet.name]..'" <me>')
	elseif ready == 'default' then
		windower.chat.input('/pet "Sic" <me>')
    else
        add_to_chat(123,'Abort: No '..ready..' ready move for '..pet.name..'.')
    end
end

function get_ready_charge_timer()
	local chargetimer = 25

	if 	player.job_points[(res.jobs[player.main_job_id].ens):lower()].jp_spent > 100 then
		chargetimer = chargetimer - 5
	end

	if state.PetMode.Value == 'PetOnly' and (player.sub_job == 'NIN' or player.sub_job == 'DNC') then
		if sets.midcast.Pet.ReadyRecastNE.sub and sets.midcast.Pet.ReadyRecastNE.sub == "Charmer's Merlin" then
			chargetimer = chargetimer - 5
		end
		if sets.midcast.Pet.ReadyRecastNE.legs and sets.midcast.Pet.ReadyRecastNE.legs == "Desultor Tassets" then
			chargetimer = chargetimer - 5
		end
	else
		if sets.midcast.Pet.ReadyRecast.legs and sets.midcast.Pet.ReadyRecast.legs == "Desultor Tassets" then
			chargetimer = chargetimer - 5
		end
	end

	return chargetimer
end
