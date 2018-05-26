function user_setup()
	-- Options: Override default values
  state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc', 'Fodder')
  state.WeaponskillMode:options('Match','Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
  state.HybridMode:options('Normal', 'PDT','PDTOnly')
  state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Godhands','ProcStaff','ProcClub','None')

  state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}

  update_combat_form()
  update_melee_groups()

	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
  send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @` gs c cycle SkillchainMode')

	--select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose"}
	sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +1"}
	sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +1"}
	sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}
	sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +1"}
	sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate"}
	sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}
	sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +1"}

	sets.precast.JA['Chi Blast'] = {
    head="Hesychast's Crown +1",
    body="Otronif Harness +1",
    hands="Hesychast's Gloves +1",
    back="Tuilha Cape",
    legs="Hesychast's Hose",
    feet="Anchorite's Gaiters +1",
  }

	sets.precast.JA['Chakra'] = {
    ammo="Staunch Tathlum +1",
    head="Genmei Kabuto",
    body="Anchorite's Cyclas +1",
    hands="Hesychast's Gloves +1",
    legs="Mummu Kecks +1",
    feet="Ahosi Leggings",
    neck="Loricate Torque +1",
    waist="Moonbow Belt +1",
    ear1="Odnowa Earring +1",
    ear2="Sanare Earring",
    ring1="Vocane Ring",
    ring2="Defending Ring",
    back="Moonlight Cape",
  }

	-- Fast cast sets for spells
	sets.precast.FC = {
    ammo="Sapience Orb",
    head=gear.Herc_FC_head,
    body="Taeon Tabard",					--9
    hands="Leyline Gloves",
    --legs={ name="Taeon Tights", augments={'"Fast Cast"+5','Phalanx +3',}},
	  legs="Rawhide Trousers",
    --feet={ name="Taeon Boots", augments={'"Fast Cast"+5','Phalanx +3',}},
    neck="Voltsurge Torque",
    ear1="Enchntr. Earring +1",
    ear2="Loquacious Earring",
    ring1="Rahab Ring",
    ring2="Lebeche Ring",
    ring2="Kishar Ring",
  }

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
    ammo="Knobkierrie",
    head="Rao Kabuto +1",
    --body="Anchorite's Cyclas +1",
    body="Adhemar Jacket +1",
    hands="Ryuo Tekko +1",
    legs="Hiza. Hizayoroi +2",
    feet=gear.Herc_TA_feet,
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    ear1="Moonshade Earring",
    ear2="Sherida Earring",
    ring1="Niqmaddu Ring",
    --ring2="Regal Ring",
    ring2="Begrudging Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}},
  }
	sets.precast.WSSomeAcc = {
    --ammo="Falcon Eye",head="Dampening Tam",legs="Hiza. Hizayoroi +2",
  }
	sets.precast.WSAcc = {
    --ammo="Falcon Eye",head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ring2="Ramuh Ring +1",waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet=gear.herculean_acc_feet,
  }
	sets.precast.WSFullAcc = {
    --ammo="Falcon Eye",head="Mummu Bonnet +2",neck="Moonbeam Nodowa",ear1="Zennaroi Earring",ear2="Telos Earring",body="Mummu Jacket +2",hands="Ryuo Tekko",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet=gear.herculean_acc_feet
  }
	sets.precast.WSFodder = {}
	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, sets.precast.WSSomeAcc)
	sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, sets.precast.WSFullAcc)
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, sets.precast.WSFodder)

	-- Specific weaponskill sets.

	sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {})
	sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {})
	sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {})
	sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {})
	sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {})
	sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {
    ammo="Falcon Eye",
    neck="Caro Necklace",
    legs="Jokushu Haidate",
    feet="Ryuo Sune-ate +1",
  })
	sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS, {
    head=gear.Herc_Acc_head,
    body=gear.Herc_WS_body,
    --hands="Anchor. Gloves +2",
    feet=gear.Herc_WS_feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ring1="Regal Ring",
    back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
  })
	sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS['Tornado Kick'], {})
	sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})

	sets.precast.WS["Raging Fists"].SomeAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSSomeAcc)
	sets.precast.WS["Howling Fist"].SomeAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSSomeAcc)
	sets.precast.WS["Asuran Fists"].SomeAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSSomeAcc)
	sets.precast.WS["Ascetic's Fury"].SomeAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSSomeAcc, {})
	sets.precast.WS["Victory Smite"].SomeAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSSomeAcc, {})
	sets.precast.WS["Shijin Spiral"].SomeAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSSomeAcc, {})
	sets.precast.WS["Dragon Kick"].SomeAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSSomeAcc)
	sets.precast.WS["Tornado Kick"].SomeAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSSomeAcc)

	sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
	sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
	sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc, {})
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc, {})
	sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
	sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
	sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

	sets.precast.WS["Raging Fists"].FullAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSFullAcc)
	sets.precast.WS["Howling Fist"].FullAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSFullAcc)
	sets.precast.WS["Asuran Fists"].FullAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSFullAcc)
	sets.precast.WS["Ascetic's Fury"].FullAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSFullAcc, {})
	sets.precast.WS["Victory Smite"].FullAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSFullAcc, {})
	sets.precast.WS["Shijin Spiral"].FullAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSFullAcc)
	sets.precast.WS["Dragon Kick"].FullAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSFullAcc)
	sets.precast.WS["Tornado Kick"].FullAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSFullAcc)

	sets.precast.WS["Raging Fists"].Fodder = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSFodder)
	sets.precast.WS["Howling Fist"].Fodder = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSFodder)
	sets.precast.WS["Asuran Fists"].Fodder = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSFodder)
	sets.precast.WS["Ascetic's Fury"].Fodder = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSFodder, {})
	sets.precast.WS["Victory Smite"].Fodder = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSFodder, {})
	sets.precast.WS["Shijin Spiral"].Fodder = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSFodder)
	sets.precast.WS["Dragon Kick"].Fodder = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSFodder)
	sets.precast.WS["Tornado Kick"].Fodder = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSFodder)

	sets.precast.WS['Cataclysm'] = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring",ear2="Sherida Earring",}
	sets.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}

	-- Midcast Sets
	sets.midcast.FastRecast = sets.precast.FC

	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}


	-- Idle sets
	sets.idle = {
    ammo="Staunch Tathlum +1",
		head=gear.Herc_DT_head,
		body="Emet Harness +1",
    hands=gear.Herc_DT_hands,
    legs=gear.Herc_DT_legs,
    feet="Herald's Gaiters",
    neck="Loricate Torque +1",
    ear1="Etiolation Earring",
    ear2="Sanare Earring",
    ring1="Defending Ring",
    ring2="Sheltered Ring",
		back="Moonlight Cape",
    waist="Moonbow Belt +1",
  }

	sets.idle.Weak = sets.defense.PDT
	sets.idle.PDT = sets.defense.PDT

	-- Defense sets
	sets.defense.PDT = {
    ammo="Staunch Tathlum +1",
		head=gear.Herc_DT_head,
		body="Emet Harness +1",
    hands=gear.Herc_DT_hands,
    legs=gear.Herc_DT_legs,
    feet="Ahosi Leggings",
    neck="Loricate Torque +1",
    ear1="Etiolation Earring",
    ear2="Sanare Earring",
    ring1="Defending Ring",
    ring2="Vocane Ring",
		back="Moonlight Cape",
    waist="Moonbow Belt +1",
  }

	-- Defense sets
	sets.defense.HP = {}
	sets.defense.MDT = {}
	sets.defense.MEVA = {}

	sets.Kiting = {feet="Herald's Gaiters"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee sets
	sets.engaged = {
    ammo="Ginsen",
		head="Adhemar Bonnet +1",
		--body="Ken. Samue +1",
    body="Adhemar Jacket +1",
    hands="Adhemar Wrist. +1",
    legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    neck="Moonlight Nodowa",
    ear1="Brutal Earring",
    ear2="Sherida Earring",
    ring1="Niqmaddu Ring",
    ring2="Epona's Ring",
    waist="Moonbow Belt +1",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
  }
	sets.engaged.SomeAcc = set_combine(sets.engaged,{})
	sets.engaged.Acc = set_combine(sets.engaged.SomeAcc,{})
	sets.engaged.FullAcc = set_combine(sets.engaged.Acc,{})
	sets.engaged.Fodder = set_combine(sets.engaged.FullAcc,{})

	-- Defensive melee hybrid sets
	sets.engaged.PDT = set_combine(sets.engaged,{
    ammo="Staunch Tathlum +1",
    head="Adhemar Bonnet +1",
    body="Ashera Harness",
    hands="Adhemar Wrist. +1",
    legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    neck="Moonlight Nodowa",
    waist="Moonbow Belt +1",
    ear1="Telos Earring",
    ear2="Sherida Earring",
    ring1="Niqmaddu Ring",
    ring2="Defending Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},

  })
	sets.engaged.SomeAcc.PDT = set_combine(sets.engaged.SomeAcc,{})
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc,{})
	sets.engaged.FullAcc.PDT = set_combine(sets.engaged.FullAcc,{})
	sets.engaged.Fodder.PDT = set_combine(sets.engaged.Fodder,{})
	sets.engaged.PDTOnly = set_combine(sets.defense.PDT,{})
	sets.engaged.SomeAcc.PDTOnly = set_combine(sets.engaged.PDTOnly,{})
	sets.engaged.Acc.PDTOnly = set_combine(sets.engaged.SomeAcc.PDTOnly,{})
	sets.engaged.FullAcc.PDTOnly = set_combine(sets.engaged.FullAcc.PDTOnly,{})

	-- Hundred Fists/Impetus melee set mods
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.SomeAcc.HF = set_combine(sets.engaged.SomeAcc, {})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {})
	sets.engaged.FullAcc.HF = set_combine(sets.engaged.FullAcc, {})
	sets.engaged.Fodder.HF = set_combine(sets.engaged.Fodder, {})


	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Impetus = {} --body="Bhikku Cyclas +1"
	sets.buff.Footwork = {feet="Shukuyu Sune-Ate"}

	sets.FootworkWS = {feet="Shukuyu Sune-Ate"}
	sets.DayIdle = {}
	sets.NightIdle = {}
  sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {legs="Ryuo Hakama +1"}

	-- Weapons sets
	sets.weapons.Godhands = {main="Godhands"}
	sets.weapons.ProcStaff = {main="Terra's Staff"}
	sets.weapons.ProcClub = {main="Mafic Cudgel"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(5, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 20)
	elseif player.sub_job == 'THF' then
		set_macro_page(6, 20)
	elseif player.sub_job == 'RUN' then
		set_macro_page(7, 20)
	else
		set_macro_page(6, 20)
	end
end
