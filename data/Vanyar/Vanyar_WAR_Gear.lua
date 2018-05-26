function user_setup()
	-- Options: Override default values
  state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
  state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
  state.HybridMode:options('Normal')
  state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
  state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
  state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','Twilight'}
	--state.Weapons:options('Chango','Bravura','Sword','Greatsword','ProcDagger','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana','ProcClub','ProcStaff')
  state.Weapons:options('Chango','Sword','Greatsword')

  ---	Cichol's Mantle
	gear.CicholDA = 		{ name = "Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',} }
	gear.CicholWSDSTR =  gear.CicholDA
	--{ name = "Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',} }
	gear.CicholWSDVIT =  gear.CicholDA
	--{ name = "Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',} }
	gear.CicholMeva = 	gear.CicholDA
	--{ name = "Cichol's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10',} }

  --- Job Ability + Buff Bindings
	send_command('bind %1 input /ja "Berserk" <me>')
	send_command('bind %2 input /ja "Aggressor" <me>')
	send_command('bind %3 input /ja "Restraint" <me>')
	send_command('bind %4 input /ja "Retaliation" <me>')
	send_command('bind %5 input /ja "Warcry" <me>; input /party Warcry | TP-Bonus 700')
	send_command('bind %6 input /ja "Blood Rage" <me>; input /party Blood Rage')
	send_command('bind %x input /ja "Weapon Bash" <t>')

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
  send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons Greatsword;gs c update')

	--select_default_macro_book()

  --- Lockstyle Binding
	send_command('wait 7; input /lockstyleset 4;wait 5;input /displayhead on')

	--- Augmented Gear
	include('Vanyar-Items.lua')
end

--- User Unload
function user_unload()

	--- Unload Binds
	send_command('unbind %1')
	send_command('unbind %2')
	send_command('unbind %3')
	send_command('unbind %4')
	send_command('unbind %5')
	send_command('unbind %6')
	send_command('unbind %z')
	send_command('unbind ^z')
	send_command('unbind %=')
	send_command('unbind ^=')
	send_command('unbind ^d')
	send_command('unbind ^s')
	send_command('unbind %x')
	send_command('unbind ^x')
	send_command('unbind %e')
	send_command('unbind !e')
	send_command('unbind %q')
	send_command('unbind ^q')
	send_command('unbind !q')
	send_command('unbind home')
	send_command('unbind delete')
	send_command('unbind end')
	send_command('unbind !end')
	send_command('unbind pagedown')
	send_command('unbind !pagedown')
	send_command('unbind @`')

	--- Unload React
	send_command('lua unload react')

end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets

  sets.Enmity = {}
	sets.Knockback = {}
	sets.passive.Reraise = {head="Twilight Helm",body="Twilight Mail"}

	-- Precast sets to enhance JAs
  sets.precast.JA['Blood Rage'] = {
		body  =  "Boii Lorica +1" -- Duration +34s
	}
	sets.precast.JA['Berserk'] = {
		feet  =  "Agoge Calligae +1", -- Duration +20s
		body  =  "Pummeler's Lorica +1", -- Duration +18s
		back  =  gear.CicholDA -- Duration +15s
	}
	sets.precast.JA['Aggressor'] = {
		head  =  "Pummeler's Mask +3", -- Duration +18s
		body  =  "Agoge Lorica +1" -- Duration +20s
	}
	sets.precast.JA['Warcry'] = {
		head  =  "Agoge Mask +1" -- Duration +30s
	}
	sets.precast.JA['Tomahawk'] = {
		ammo  =  "Thr. Tomahawk",
		feet  =  "Agoge Calligae +1" -- 1% Reduction
	}
	sets.precast.JA['Mighty Strikes'] = {
		hands =  "Agoge Mufflers" -- Duration +15s
	}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}

	sets.precast.Flourish1 = {}

	-- Fast cast sets for spells

	sets.precast.FC = {
    ammo  =  "Impatiens",
		neck  =  "Voltsurge Torque",      -- FC'4
		ear1  =  "Enchanter Earring +1",  -- FC'1
		ear2  =  "Loquacious Earring",    -- FC'2
		body  =  gear.Odyssean_Body_FC,   -- FC'9
		hands =  "Leyline Gloves",        -- FC'8
		ring1 =  "Prolix Ring",           -- FC'2
		ring2 =  "Kishar Ring",           -- FC'4
		waist =  "Tempus Fugit",
		legs  =  "Rawhide Trousers",      -- FC'5
		feet  =  gear.Odyssean_Feet_FC    -- FC'9
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
	sets.midcast.Cure = {}

	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo  =  "Knobkierrie",
		head  =  gear.Val_Head_WSD,
		--head  =  gear.Odyssean_Head_WSD,
		neck  =  "Fotia Gorget",
		ear1  =  "Cessance Earring",
		ear2  =  "Ishvara Earring",
		body  =  "Pummeler's Lorica +1",
		hands =  gear.Val_Hands_WSD,
		--hands =  gear.Odyssean_Hands_WSD,
		ring1 =  "Regal Ring",
		back  =  gear.CicholWSDSTR,
		waist =  "Fotia Belt",
		legs  =  gear.Val_Legs_WSD,
		feet  =  "Sulev. Leggings +2"
  }

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {back="Letalis Mantle",})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

  ----------------------------------------------------------------------
	--- Weaponskills Great Sword
	----------------------------------------------------------------------
  --- Scourge (40% STR 40% VIT | fTP: 3.0)
  sets.precast.WS['Scourge'] = {}
  sets.precast.WS['Scourge'].SomeAcc = set_combine(sets.precast.WS['Scourge'], {})
  sets.precast.WS['Scourge'].Acc = set_combine(sets.precast.WS['Scourge'].SomeAcc, {})
  sets.precast.WS['Scourge'].FullAcc = set_combine(sets.precast.WS['Scourge'].Acc, {})
  sets.precast.WS['Scourge'].Fodder = set_combine(sets.precast.WS['Scourge'], {})

  sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
    ammo  =  "Seething Bomblet +1",
		head  =  "Flamma Zucchetto +2",   -- STP'6
		body  =  "Argosy Hauberk +1",
		hands =  "Argosy Mufflers +1",    -- STP'6
		legs  =  "Argosy Breeches +1",
    feet  =  "Lustratio Leggings +1", --replace with flamma feet?
		--feet  =  "Pummeler's calligae +1" -- STP'4
		neck  =  "Fotia Gorget",
		ear1  =  "Cessance Earring",
		ear2  =  "Brutal Earring",
		ring1 =  "Niqmaddu Ring",
		ring2 =  "Regal Ring",
		back  =  gear.CicholDA,
		waist =  "Fotia Belt",
  })
  sets.precast.WS['Resolution'].SomeAcc = set_combine(sets.precast.WS['Resolution'], {
    legs  =  "Pummeler's Cuisses +1",
    feet  =  "Pummeler's calligae +1" -- STP'4
  })
  sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].SomeAcc, {})
  sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS['Resolution'].Acc, {})
  sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  --- Shockwave (Sleeps enemies)
  sets.precast.WS['Shockwave'] = {
		ammo  =  "Pemphredo Tathlum",
		head  =  "Flamma Zucchetto +2",
		body  =  "Flamma Korazin +2",
		hands =  "Flamma Manopolas +2",
		legs  =  "Flamma Dirs +2",
		feet  =  "Flamma Gambieras +2",
		neck  =  "Sanctity Necklace",
		ear1  =  "Moonshade Earring",
		ear2  =  "Dignitary's Earring",
		ring1 =  "Stikini Ring +1",
    ring2 =  "Stikini Ring +1",
		back  =  gear.CicholWSDSTR,
		waist =  "Eschan Stone",
	}

  ----------------------------------------------------------------------
	--- Weaponskills Great Axe
	----------------------------------------------------------------------
  --- Metatron Torment (80% STR | fTP: 2.75)
  sets.precast.WS['Metatron Torment'] = {}

  --- Upheaval 4-Hit (80% VIT | fTP: 1.0, 3.5, 6.5)
	sets.precast.WS['Upheaval'] = {
		ammo  =  "Knobkierrie",
		head  =  gear.Val_Head_WSD,
		--head  =  gear.Odyssean_Head_WSD,
		--body  =  "Pummeler's Lorica +1",
		hands =  "Sulevia's Gauntlets +2",
		legs  =  gear.Val_Legs_WSD, -- STP'5
		feet  =  "Sulev. Leggings +2",
		--legs  =  "Pummeler's Cuisses +1",
		--feet  =  "Pummeler's calligae +1" -- STP'4
		neck  =  "Fotia Gorget",
		ear1  =  "Cessance Earring",
		ear2  =  "Brutal Earring",
		ring1 =  "Niqmaddu Ring",
		ring2 =  "Regal Ring",
		back  =  gear.CicholDA,
		waist =  "Fotia Belt",
	}
  sets.precast.WS['Upheaval'].SomeAcc = set_combine(sets.precast.WS['Upheaval'], {})
  sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS['Upheaval'].SomeAcc, {})
  sets.precast.WS['Upheaval'].FullAcc = set_combine(sets.precast.WS['Upheaval'].Acc, {})
  sets.precast.WS['Upheaval'].Fodder = set_combine(sets.precast.WS['Upheaval'], {})
  sets.precast.WS['Upheaval'].WSD = set_combine(sets.precast.WS['Upheaval'], {
    hands =  gear.Val_Hands_WSD,
		back  =  gear.CicholWSDVIT,
		legs  =  gear.Val_Legs_WSD, -- STP'5
		feet  =  "Sulev. Leggings +2"
  })

  sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
    ammo  =  "Yetshila +1",
		head  =  "Argosy Celata +1",    -- STP'6
		body  =  "Argosy Hauberk +1",
		hands =  "Argosy Mufflers +1",  -- STP'6
		legs  =  "Argosy Breeches +1",
		feet  =  "Thereoid Greaves",
    --feet  =  "Pummeler's calligae +1" -- STP'4
		neck  =  "Fotia Gorget",
		ear1  =  "Cessance Earring",
		ear2  =  "Brutal Earring",
		ring1 =  "Niqmaddu Ring",
		ring2 =  "Regal Ring",
		back  =  gear.CicholDA,
		waist =  "Fotia Belt",
  })
  sets.precast.WS["Ukko's Fury"].SomeAcc = set_combine(sets.precast.WS["Ukko's Fury"], {})
  sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS["Ukko's Fury"].SomeAcc, {})
  sets.precast.WS["Ukko's Fury"].FullAcc = set_combine(sets.precast.WS["Ukko's Fury"].Acc, {})
  sets.precast.WS["Ukko's Fury"].Fodder = set_combine(sets.precast.WS["Ukko's Fury"], {})

  sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {
    ammo  =  "Seething Bomblet +1",
		head  =  "Flamma Zucchetto +2", -- STP'6
    body  =  "Argosy Hauberk +1",
		hands =  "Argosy Mufflers +1",  -- STP'6
		legs  =  "Argosy Breeches +1",
		feet  =  "Flamma Gambieras +2", -- STP'6
		neck  =  "Fotia Gorget",
		ear1  =  "Cessance Earring",
		ear2  =  "Brutal Earring",
		ring1 =  "Niqmaddu Ring",
		ring2 =  "Regal Ring",
		back  =  gear.CicholDA,
		waist =  "Fotia Belt",
  })
  sets.precast.WS["King's Justice"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
  sets.precast.WS["King's Justice"].Acc = set_combine(sets.precast.WS.Acc, {})
  sets.precast.WS["King's Justice"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
  sets.precast.WS["King's Justice"].Fodder = set_combine(sets.precast.WS.Fodder, {})
  sets.precast.WS["King's Justice"].WSD = set_combine(sets.precast.WS["King's Justice"], {
    ammo  =  "Knobkierrie",
		--head  =  gear.Odyssean_Head_WSD,
		head  =  gear.Val_Head_WSD,
		body  =  "Pummeler's Lorica +1",
		hands =  gear.Val_Hands_WSD,
		back  =  gear.CicholWSDSTR,
		legs  =  gear.Val_Legs_WSD,
		feet  =  "Sulev. Leggings +2"
  })

  --- Weapon Break (60% STR / 60% VIT | fTP: 1.0) Attack -25%
	sets.precast.WS['Weapon Break'] = set_combine(sets.precast.WS['Shockwave'], {})

	--- Armor Break (60% STR / 60% VIT | fTP: 1.0) -25% defense.
	sets.precast.WS['Armor Break'] = set_combine(sets.precast.WS['Shockwave'], {})

	--- Full Break (60% STR / 60% VIT | fTP: 1.0) Attack/Defense 12.5% | Evasion/Aaccuracy 20
	sets.precast.WS['Full Break'] = set_combine(sets.precast.WS['Shockwave'], {})

  ----------------------------------------------------------------------
	--- Weaponskills Sword
	----------------------------------------------------------------------

	--- Savage Blade (50% MND 50% STR | fTP: 4.0  10.25  13.75)
  sets.precast.WS['Savage Blade'] = {
		ammo  =  "Knobkierrie",
		--head  =  gear.Odyssean_Head_WSD,
    head  =  gear.Val_Head_WSD,
		neck  =  "Fotia Gorget",
    ear1  =  "Cessance Earring",
    ear2  =  "Ishvara Earring",
		body  =  "Pummeler's Lorica +1",
		--hands =  gear.Odyssean_Hands_WSD,
    hands =  gear.Val_Hands_WSD,
		ring1 =  "Regal Ring",
		back  =  gear.CicholWSDSTR,
		waist =  "Prosilio Belt +1",
		--legs  =  gear.Odyssean_Legs_WSD,
    legs  =  gear.Val_Legs_WSD,
		feet  =  "Sulev. Leggings +2"
	}
  sets.precast.WS['Savage Blade'].SomeAcc = set_combine(sets.precast.WS['Savage Blade'], {})
  sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'].SomeAcc, {})
  sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'].Acc, {})
  sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})


	--- Vorpal Blade (60% STR | fTP: 1.375)
	sets.precast.WS['Vorpal Blade'] = {
		ammo  =  "Seething Bomblet +1",
		head  =  "Flamma Zucchetto +2",
		body  =  "Argosy Hauberk +1",
		hands =  "Argosy Mufflers +1",
		legs  =  "Argosy Breeches +1",
		feet  =  "Pummeler's calligae +1",
		neck  =  "Fotia Gorget",
		ear1  =  "Cessance Earring",
		ear2  =  "Brutal Earring",
		ring1 =  "Niqmaddu Ring",
		ring2 =  "Regal Ring",
		back  =  gear.CicholDA,
		waist =  "Fotia Belt",
	}

  --- Requiescat (73~85% MND)
  sets.precast.WS['Requiescat'] = {
  	ammo  =  "Seething Bomblet +1",
  	head  =  "Flamma Zucchetto +2",
  	body  =  "Argosy Hauberk +1",
  	hands =  "Argosy Mufflers +1",
  	legs  =  "Argosy Breeches +1",
  	feet  =  "Pummeler's calligae +1",
  	neck  =  "Fotia Gorget",
  	ear1  =  "Cessance Earring",
  	ear2  =  "Brutal Earring",
  	ring1 =  "Niqmaddu Ring",
  	ring2 =  "Regal Ring",
  	back  =  gear.CicholDA,
  	waist =  "Fotia Belt",
  }
  ------------------------------------------------------------------------------------------
  --- Special WS Sets
  ------------------------------------------------------------------------------------------

  --- Mighty Strikes WS Set
  sets.MS_WS = { -- DA + Crit ??
    ammo  =  "Yetshila +1",
    --head  =  ValHead_MS,
    --body  =  ValBody_MS,
    body  =  gear.Val_body_DA,
    --hands =  ValHands_MS,
    --legs  =  ValLegs_MS,
    --feet  =  ValFeet_MS,
  }

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring +1",ear2="Lugra Earring",}
	sets.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Ishvara Earring",ear2="Brutal Earring",}
	sets.AccDayWSEars = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Brutal Earring",ear2="Moonshade Earring"}

  -- Sets to return to when not performing an action.

  -- Resting sets
  sets.resting = {}

	-- Idle sets
	sets.idle = {
    ammo  =  "Staunch Tathlum +1",
    head  =  "Sulevia's Mask +2",
    neck  =  "Sanctity Necklace",
    ear1  =  "Etiolation Earring",
    --ear2  =  "Hearty Earring",
    ear2	=	 "Infused Earring",
    body  =  "Sulevia's Platemail +2",
    hands =  "Sulevia's Gauntlets +2",
    ring1 =  "Defending Ring",
    ring2 =  "Vocane Ring",
    back  =  "Moonlight Cape",
    waist =  "Flume Belt +1",
    legs  =  "Sulevia's Cuisses +2",
    feet  =  "Sulevia's leggings +2",
  }

	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

	-- Defense sets
	sets.defense.PDT = {
    ammo  =  "Staunch Tathlum +1", 			-- DT'3
		head  =  "Sulevia's Mask +2", 			-- DT'6
		neck  =  "Loricate Torque +1", 			-- DT'6
		body  =  "Sulevia's Platemail +2", 	-- DT'9
		hands =  "Sulevia's Gauntlets +2", 	-- DT'5
		legs  =  "Sulevia's Cuisses +2", 		-- DT'7
		ring1 =  "Defending Ring", 					-- DT'10
		ring2 =  "Vocane Ring", 						-- DT'4
		back  =  gear.CicholDA,
		waist =  "Tempus Fugit",
  }

	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MDT = {
    main  =  "Firangi",
    sub   =  "Adapa Shield",
    ear1  =  "Flashward Earring",
    ear2  =  "Odnowa Earring +1",
    back  =  "Moonlight Cape",
    waist =  "Flume Belt +1",
    feet  =  "Amm Greaves"
    }

	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MEVA = {
    ammo  =  "Staunch Tathlum +1",
    head  =  "Pummeler's Mask +3",
    neck  =  "Warder's Charm +1",
    ear1  =  "Flashward Earring",
    ear2  =  "Hearty Earring",
    body  =  "Pummeler's Lorica +1",
    hands =  "Leyline Gloves",
    ring1 =  "Vengeful Ring",
    ring2 =  "Purity Ring",
    back  =  gear.CicholMeva,
    waist =  "Asklepian Belt",
    legs  =  "Pummeler's Cuisses +1",
    feet  =  "Founder's Greaves"
    }

	sets.Kiting = {}
	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}

  -- Engaged sets
  sets.engaged = {
    ammo  =  "Ginsen", -- STP'3
    head  =  "Flamma Zucchetto +2", -- STP'6 | TA'5 | HA'4
    neck  =  "Lissome Necklace", -- STP'4 | DA'1
    ear1  =  "Telos Earring", -- STP'5 | DA'1
    ear2  =  "Brutal Earring", -- STP'1 | DA'5
    body  =  gear.Val_Body_STP, -- STP'9 | DA'2 | HA'3
    hands =  "Sulevia's Gauntlets +2", -- DA'6 | HA'3
    ring1 =  "Niqmaddu Ring", -- QA'3
    ring2 =  "Petrov Ring", -- STP'5 | DA'1
    back  =  gear.CicholDA, -- DA'10
    waist =  "Ioskeha Belt +1", -- DA'9 | HA'8
    legs  =  "Pummeler's Cuisses +1", -- DA'11 | HA'6
    feet  =  "Pummeler's calligae +1" -- STP'4 | DA'9 | HA'4
  }

  --------------------------------------------------------------------------
  --- Engage Chango
  --------------------------------------------------------------------------

	--- ACC'1185  HA'28  STP'39/39 (5/1250)  DA'61  TA'5  QA'3
	sets.engaged.Chango = {
		-- main  =  "Chango", -- STP'10
		ammo  =  "Ginsen", -- STP'3
		head  =  "Flamma Zucchetto +2", -- STP'6 | TA'5 | HA'4
		--neck  =  "Lissome Necklace", -- STP'4 | DA'1
		neck 	=	 "Asperity Necklace",
		--ear1  =  "Cessance Earring", -- STP'3 | DA'3
		ear1	=	 "Mache Earring",
		ear2  =  "Brutal Earring", -- STP'1 | DA'5
		body  =  gear.Val_body_DA, -- STP'3 | DA'6 | HA'3
		hands =  "Sulevia's Gauntlets +2", -- DA'6 | HA'3
		ring1 =  "Niqmaddu Ring", -- QA'3
		ring2 =  "Petrov Ring", -- STP'5 | DA'1
		back  =  gear.CicholDA, -- DA'10
		waist =  "Ioskeha Belt +1", -- DA'9 | HA'8
		legs  =  "Pummeler's Cuisses +1", -- DA'11 | HA'6
		--- feet  =  "Pummeler's calligae +1" -- STP'4 | DA'9 | HA'4
		feet  =  "Flamma Gambieras +2", -- STP'6 | DA'6 | HA'2

		--- neck  =  "Ainia Collar", -- STP'8
		--- ear1  =  "Telos Earring", -- STP'5 | DA'1
		--- hands =  "Flamma Manopolas +2", -- STP'5 | HA'4
		--- body  =  gear.Val_Body_STP, -- STP'9 | DA'2 | HA'3
		--- ring2 =  "Petrov Ring", -- STP'5 | DA'1
		--- ring2 =  "Flamma Ring", -- ACC'6 | STP'5
		--- ring2 =  "Hetairoi Ring", -- TA'2
		--- legs  =  gear.Odyssean_Legs_STP, -- STP'12 | DA'2 | HA'5
		--- feet  =  ValFeet_STP -- STP'12 | HA'3
	}

	--- ACC 1223
	sets.engaged.Chango.Acc = set_combine(sets.engaged.Chango, {
		ear2  =  "Telos Earring", -- STP'5 | DA'1
		ring2 =  "Flamma Ring" -- ACC'6 | STP'5
	})

--[[
  sets.engaged.Charge = {}
	sets.engaged.SomeAcc.Charge = {}
	sets.engaged.Acc.Charge = {}
	sets.engaged.FullAcc.Charge = {}
	sets.engaged.Fodder.Charge = {}

  sets.engaged.Mighty = {}
	sets.engaged.SomeAcc.Mighty = {}
	sets.engaged.Acc.Mighty = {}
	sets.engaged.FullAcc.Mighty = {}
	sets.engaged.Fodder.Mighty = {}

  sets.engaged.Charge.Mighty = {}
	sets.engaged.SomeAcc.Charge.Mighty = {}
	sets.engaged.Acc.Charge.Mighty = {}
	sets.engaged.FullAcc.Charge.Mighty = {}
	sets.engaged.Fodder.Charge.Mighty = {}

  sets.engaged.Adoulin = {}
	sets.engaged.SomeAcc.Adoulin = {}
	sets.engaged.Acc.Adoulin = {}
	sets.engaged.FullAcc.Adoulin = {}
	sets.engaged.Fodder.Adoulin = {}

  sets.engaged.Adoulin.Charge = {}
	sets.engaged.SomeAcc.Adoulin.Charge = {}
	sets.engaged.Acc.Adoulin.Charge = {}
	sets.engaged.FullAcc.Adoulin.Charge = {}
	sets.engaged.Fodder.Adoulin.Charge = {}

  sets.engaged.Adoulin.Mighty = {}
	sets.engaged.SomeAcc.Adoulin.Mighty = {}
	sets.engaged.Acc.Adoulin.Mighty = {}
	sets.engaged.FullAcc.Adoulin.Mighty = {}
	sets.engaged.Fodder.Adoulin.Mighty = {}

  sets.engaged.Adoulin.Charge.Mighty = {}
	sets.engaged.SomeAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Acc.Adoulin.Charge.Mighty = {}
	sets.engaged.FullAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Fodder.Adoulin.Charge.Mighty = {}

  sets.engaged.PDT = {}
	sets.engaged.SomeAcc.PDT = {}
	sets.engaged.Acc.PDT = {}
	sets.engaged.FullAcc.PDT = {}
	sets.engaged.Fodder.PDT = {}

  sets.engaged.PDT.Charge = {}
	sets.engaged.SomeAcc.PDT.Charge = {}
	sets.engaged.Acc.PDT.Charge = {}
	sets.engaged.FullAcc.PDT.Charge = {}
	sets.engaged.Fodder.PDT.Charge = {}

  sets.engaged.PDT.Mighty = {}
	sets.engaged.SomeAcc.PDT.Mighty = {}
	sets.engaged.Acc.PDT.Mighty = {}
	sets.engaged.FullAcc.PDT.Mighty = {}
	sets.engaged.Fodder.PDT.Mighty = {}

  sets.engaged.PDT.Charge.Mighty = {}
	sets.engaged.SomeAcc.PDT.Charge.Mighty = {}
	sets.engaged.Acc.PDT.Charge.Mighty = {}
	sets.engaged.FullAcc.PDT.Charge.Mighty = {}
	sets.engaged.Fodder.PDT.Charge.Mighty = {}

  sets.engaged.PDT.Adoulin = {}
	sets.engaged.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Acc.PDT.Adoulin = {}
	sets.engaged.FullAcc.PDT.Adoulin = {}
	sets.engaged.Fodder.PDT.Adoulin = {}

  sets.engaged.PDT.Adoulin.Charge = {}
	sets.engaged.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Fodder.PDT.Adoulin.Charge = {}

  sets.engaged.PDT.Adoulin.Mighty = {}
	sets.engaged.SomeAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Acc.PDT.Adoulin.Mighty = {}
	sets.engaged.FullAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Fodder.PDT.Adoulin.Mighty = {}

  sets.engaged.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.SomeAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Acc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.FullAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Fodder.PDT.Adoulin.Charge.Mighty = {}

  sets.engaged.MDT = {}
	sets.engaged.SomeAcc.MDT = {}
	sets.engaged.Acc.MDT = {}
	sets.engaged.FullAcc.MDT = {}
	sets.engaged.Fodder.MDT = {}

  sets.engaged.MDT.Charge = {}
	sets.engaged.SomeAcc.MDT.Charge = {}
	sets.engaged.Acc.MDT.Charge = {}
	sets.engaged.FullAcc.MDT.Charge = {}
	sets.engaged.Fodder.MDT.Charge = {}

  sets.engaged.MDT.Mighty = {}
	sets.engaged.SomeAcc.MDT.Mighty = {}
	sets.engaged.Acc.MDT.Mighty = {}
	sets.engaged.FullAcc.MDT.Mighty = {}
	sets.engaged.Fodder.MDT.Mighty = {}

  sets.engaged.MDT.Charge.Mighty = {}
	sets.engaged.SomeAcc.MDT.Charge.Mighty = {}
	sets.engaged.Acc.MDT.Charge.Mighty = {}
	sets.engaged.FullAcc.MDT.Charge.Mighty = {}
	sets.engaged.Fodder.MDT.Charge.Mighty = {}

  sets.engaged.MDT.Adoulin = {}
	sets.engaged.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Acc.MDT.Adoulin = {}
	sets.engaged.FullAcc.MDT.Adoulin = {}
	sets.engaged.Fodder.MDT.Adoulin = {}

  sets.engaged.MDT.Adoulin.Charge = {}
	sets.engaged.SomeAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Acc.MDT.Adoulin.Charge = {}
	sets.engaged.FullAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Fodder.MDT.Adoulin.Charge = {}

  sets.engaged.MDT.Adoulin.Mighty = {}
	sets.engaged.SomeAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Acc.MDT.Adoulin.Mighty = {}
	sets.engaged.FullAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Fodder.MDT.Adoulin.Mighty = {}

  sets.engaged.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.SomeAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Acc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.FullAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Fodder.MDT.Adoulin.Charge.Mighty = {}

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- Conqueror melee sets
  sets.engaged.Conqueror = {}
	sets.engaged.Conqueror.SomeAcc = {}
	sets.engaged.Conqueror.Acc = {}
	sets.engaged.Conqueror.FullAcc = {}
	sets.engaged.Conqueror.Fodder = {}

  sets.engaged.Conqueror.Adoulin = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin = {}
	sets.engaged.Conqueror.Acc.Adoulin = {}
	sets.engaged.Conqueror.FullAcc.Adoulin = {}
	sets.engaged.Conqueror.Fodder.Adoulin = {}

  sets.engaged.Conqueror.AM = {}
	sets.engaged.Conqueror.SomeAcc.AM = {}
	sets.engaged.Conqueror.Acc.AM = {}
	sets.engaged.Conqueror.FullAcc.AM = {}
	sets.engaged.Conqueror.Fodder.AM = {}

  sets.engaged.Conqueror.Adoulin.AM = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.AM = {}
	sets.engaged.Conqueror.Acc.Adoulin.AM = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.AM = {}
	sets.engaged.Conqueror.Fodder.Adoulin.AM = {}

  sets.engaged.Conqueror.Charge = {}
	sets.engaged.Conqueror.SomeAcc.Charge = {}
	sets.engaged.Conqueror.Acc.Charge = {}
	sets.engaged.Conqueror.FullAcc.Charge = {}
	sets.engaged.Conqueror.Fodder.Charge = {}

  sets.engaged.Conqueror.Adoulin.Charge = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.Charge = {}
	sets.engaged.Conqueror.Acc.Adoulin.Charge = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.Charge = {}
	sets.engaged.Conqueror.Fodder.Adoulin.Charge = {}

  sets.engaged.Conqueror.Charge.AM = {}
	sets.engaged.Conqueror.SomeAcc.Charge.AM = {}
	sets.engaged.Conqueror.Acc.Charge.AM = {}
	sets.engaged.Conqueror.FullAcc.Charge.AM = {}
	sets.engaged.Conqueror.Fodder.Charge.AM = {}

  sets.engaged.Conqueror.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.Acc.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.Fodder.Adoulin.Charge.AM = {}

	sets.engaged.Conqueror.PDT = {}
	sets.engaged.Conqueror.SomeAcc.PDT = {}
	sets.engaged.Conqueror.Acc.PDT = {}
	sets.engaged.Conqueror.FullAcc.PDT = {}
	sets.engaged.Conqueror.Fodder.PDT = {}

	sets.engaged.Conqueror.PDT.Adoulin = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin = {}

	sets.engaged.Conqueror.PDT.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.AM = {}
	sets.engaged.Conqueror.Acc.PDT.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.AM = {}

	sets.engaged.Conqueror.PDT.Adoulin.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.AM = {}

	sets.engaged.Conqueror.PDT.Charge = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Charge = {}
	sets.engaged.Conqueror.Acc.PDT.Charge = {}
	sets.engaged.Conqueror.FullAcc.PDT.Charge = {}
	sets.engaged.Conqueror.Fodder.PDT.Charge = {}

	sets.engaged.Conqueror.PDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.Charge = {}

	sets.engaged.Conqueror.PDT.Charge.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Charge.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Charge.AM = {}

	sets.engaged.Conqueror.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Conqueror.MDT = {}
	sets.engaged.Conqueror.SomeAcc.MDT = {}
	sets.engaged.Conqueror.Acc.MDT = {}
	sets.engaged.Conqueror.FullAcc.MDT = {}
	sets.engaged.Conqueror.Fodder.MDT = {}

	sets.engaged.Conqueror.MDT.Adoulin = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin = {}

	sets.engaged.Conqueror.MDT.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.AM = {}
	sets.engaged.Conqueror.Acc.MDT.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.AM = {}

	sets.engaged.Conqueror.MDT.Adoulin.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.AM = {}

	sets.engaged.Conqueror.MDT.Charge = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Charge = {}
	sets.engaged.Conqueror.Acc.MDT.Charge = {}
	sets.engaged.Conqueror.FullAcc.MDT.Charge = {}
	sets.engaged.Conqueror.Fodder.MDT.Charge = {}

	sets.engaged.Conqueror.MDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.Charge = {}

	sets.engaged.Conqueror.MDT.Charge.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Charge.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Charge.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Charge.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Charge.AM = {}

	sets.engaged.Conqueror.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.Charge.AM = {}

  sets.engaged.Conqueror.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.Mighty = {}
	sets.engaged.Conqueror.Acc.Mighty = {}
	sets.engaged.Conqueror.FullAcc.Mighty = {}
	sets.engaged.Conqueror.Fodder.Mighty = {}

  sets.engaged.Conqueror.Adoulin.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.Mighty = {}
	sets.engaged.Conqueror.Acc.Adoulin.Mighty = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.Mighty = {}
	sets.engaged.Conqueror.Fodder.Adoulin.Mighty = {}

  sets.engaged.Conqueror.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.Mighty.AM = {}

  sets.engaged.Conqueror.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.Adoulin.Mighty.AM = {}

  sets.engaged.Conqueror.Charge.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.Charge.Mighty = {}
	sets.engaged.Conqueror.Acc.Charge.Mighty = {}
	sets.engaged.Conqueror.FullAcc.Charge.Mighty = {}
	sets.engaged.Conqueror.Fodder.Charge.Mighty = {}

  sets.engaged.Conqueror.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.Acc.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.Fodder.Adoulin.Charge.Mighty = {}

  sets.engaged.Conqueror.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.Charge.Mighty.AM = {}

  sets.engaged.Conqueror.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Conqueror.PDT.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Mighty = {}
	sets.engaged.Conqueror.Acc.PDT.Mighty = {}
	sets.engaged.Conqueror.FullAcc.PDT.Mighty = {}
	sets.engaged.Conqueror.Fodder.PDT.Mighty = {}

	sets.engaged.Conqueror.PDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.Mighty = {}

	sets.engaged.Conqueror.PDT.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Mighty.AM = {}

	sets.engaged.Conqueror.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.Mighty.AM = {}

	sets.engaged.Conqueror.PDT.Charge.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Charge.Mighty = {}
	sets.engaged.Conqueror.Acc.PDT.Charge.Mighty = {}
	sets.engaged.Conqueror.FullAcc.PDT.Charge.Mighty = {}
	sets.engaged.Conqueror.Fodder.PDT.Charge.Mighty = {}

	sets.engaged.Conqueror.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.Charge.Mighty = {}

	sets.engaged.Conqueror.PDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Charge.Mighty.AM = {}

	sets.engaged.Conqueror.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Conqueror.MDT.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Mighty = {}
	sets.engaged.Conqueror.Acc.MDT.Mighty = {}
	sets.engaged.Conqueror.FullAcc.MDT.Mighty = {}
	sets.engaged.Conqueror.Fodder.MDT.Mighty = {}

	sets.engaged.Conqueror.MDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.Mighty = {}

	sets.engaged.Conqueror.MDT.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Mighty.AM = {}

	sets.engaged.Conqueror.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.Mighty.AM = {}

	sets.engaged.Conqueror.MDT.Charge.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Charge.Mighty = {}
	sets.engaged.Conqueror.Acc.MDT.Charge.Mighty = {}
	sets.engaged.Conqueror.FullAcc.MDT.Charge.Mighty = {}
	sets.engaged.Conqueror.Fodder.MDT.Charge.Mighty = {}

	sets.engaged.Conqueror.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.Charge.Mighty = {}

	sets.engaged.Conqueror.MDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Charge.Mighty.AM = {}

	sets.engaged.Conqueror.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.Charge.Mighty.AM = {}

-- Bravura melee sets
  sets.engaged.Bravura = {}
	sets.engaged.Bravura.SomeAcc = {}
	sets.engaged.Bravura.Acc = {}
	sets.engaged.Bravura.FullAcc = {}
	sets.engaged.Bravura.Fodder = {}

  sets.engaged.Bravura.Adoulin = {}
	sets.engaged.Bravura.SomeAcc.Adoulin = {}
	sets.engaged.Bravura.Acc.Adoulin = {}
	sets.engaged.Bravura.FullAcc.Adoulin = {}
	sets.engaged.Bravura.Fodder.Adoulin = {}

  sets.engaged.Bravura.AM = {}
	sets.engaged.Bravura.SomeAcc.AM = {}
	sets.engaged.Bravura.Acc.AM = {}
	sets.engaged.Bravura.FullAcc.AM = {}
	sets.engaged.Bravura.Fodder.AM = {}

  sets.engaged.Bravura.Adoulin.AM = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.AM = {}
	sets.engaged.Bravura.Acc.Adoulin.AM = {}
	sets.engaged.Bravura.FullAcc.Adoulin.AM = {}
	sets.engaged.Bravura.Fodder.Adoulin.AM = {}

  sets.engaged.Bravura.Charge = {}
	sets.engaged.Bravura.SomeAcc.Charge = {}
	sets.engaged.Bravura.Acc.Charge = {}
	sets.engaged.Bravura.FullAcc.Charge = {}
	sets.engaged.Bravura.Fodder.Charge = {}

  sets.engaged.Bravura.Adoulin.Charge = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Charge = {}
	sets.engaged.Bravura.Acc.Adoulin.Charge = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Charge = {}
	sets.engaged.Bravura.Fodder.Adoulin.Charge = {}

  sets.engaged.Bravura.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.Charge.AM = {}
	sets.engaged.Bravura.Acc.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.Charge.AM = {}
	sets.engaged.Bravura.Fodder.Charge.AM = {}

  sets.engaged.Bravura.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Acc.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Fodder.Adoulin.Charge.AM = {}

	sets.engaged.Bravura.PDT = {}
	sets.engaged.Bravura.SomeAcc.PDT = {}
	sets.engaged.Bravura.Acc.PDT = {}
	sets.engaged.Bravura.FullAcc.PDT = {}
	sets.engaged.Bravura.Fodder.PDT = {}

	sets.engaged.Bravura.PDT.Adoulin = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin = {}

	sets.engaged.Bravura.PDT.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.AM = {}
	sets.engaged.Bravura.Acc.PDT.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.AM = {}
	sets.engaged.Bravura.Fodder.PDT.AM = {}

	sets.engaged.Bravura.PDT.Adoulin.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.AM = {}

	sets.engaged.Bravura.PDT.Charge = {}
	sets.engaged.Bravura.SomeAcc.PDT.Charge = {}
	sets.engaged.Bravura.Acc.PDT.Charge = {}
	sets.engaged.Bravura.FullAcc.PDT.Charge = {}
	sets.engaged.Bravura.Fodder.PDT.Charge = {}

	sets.engaged.Bravura.PDT.Adoulin.Charge = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Charge = {}

	sets.engaged.Bravura.PDT.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Bravura.Acc.PDT.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Charge.AM = {}

	sets.engaged.Bravura.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Bravura.MDT = {}
	sets.engaged.Bravura.SomeAcc.MDT = {}
	sets.engaged.Bravura.Acc.MDT = {}
	sets.engaged.Bravura.FullAcc.MDT = {}
	sets.engaged.Bravura.Fodder.MDT = {}

	sets.engaged.Bravura.MDT.Adoulin = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin = {}

	sets.engaged.Bravura.MDT.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.AM = {}
	sets.engaged.Bravura.Acc.MDT.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.AM = {}
	sets.engaged.Bravura.Fodder.MDT.AM = {}

	sets.engaged.Bravura.MDT.Adoulin.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.AM = {}

	sets.engaged.Bravura.MDT.Charge = {}
	sets.engaged.Bravura.SomeAcc.MDT.Charge = {}
	sets.engaged.Bravura.Acc.MDT.Charge = {}
	sets.engaged.Bravura.FullAcc.MDT.Charge = {}
	sets.engaged.Bravura.Fodder.MDT.Charge = {}

	sets.engaged.Bravura.MDT.Adoulin.Charge = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Charge = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Charge = {}

	sets.engaged.Bravura.MDT.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Charge.AM = {}
	sets.engaged.Bravura.Acc.MDT.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Charge.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Charge.AM = {}

	sets.engaged.Bravura.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Charge.AM = {}

  sets.engaged.Bravura.Mighty = {}
	sets.engaged.Bravura.SomeAcc.Mighty = {}
	sets.engaged.Bravura.Acc.Mighty = {}
	sets.engaged.Bravura.FullAcc.Mighty = {}
	sets.engaged.Bravura.Fodder.Mighty = {}

  sets.engaged.Bravura.Adoulin.Mighty = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Mighty = {}
	sets.engaged.Bravura.Acc.Adoulin.Mighty = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Mighty = {}
	sets.engaged.Bravura.Fodder.Adoulin.Mighty = {}

  sets.engaged.Bravura.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.Mighty.AM = {}
	sets.engaged.Bravura.Acc.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.Mighty.AM = {}

  sets.engaged.Bravura.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Acc.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.Adoulin.Mighty.AM = {}

  sets.engaged.Bravura.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.Charge.Mighty = {}

  sets.engaged.Bravura.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.Adoulin.Charge.Mighty = {}

  sets.engaged.Bravura.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.Charge.Mighty.AM = {}

  sets.engaged.Bravura.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Bravura.PDT.Mighty = {}
	sets.engaged.Bravura.SomeAcc.PDT.Mighty = {}
	sets.engaged.Bravura.Acc.PDT.Mighty = {}
	sets.engaged.Bravura.FullAcc.PDT.Mighty = {}
	sets.engaged.Bravura.Fodder.PDT.Mighty = {}

	sets.engaged.Bravura.PDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Mighty = {}

	sets.engaged.Bravura.PDT.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Mighty.AM = {}
	sets.engaged.Bravura.Acc.PDT.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Mighty.AM = {}

	sets.engaged.Bravura.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Mighty.AM = {}

	sets.engaged.Bravura.PDT.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.PDT.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.PDT.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.PDT.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.PDT.Charge.Mighty = {}

	sets.engaged.Bravura.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Charge.Mighty = {}

	sets.engaged.Bravura.PDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Charge.Mighty.AM = {}

	sets.engaged.Bravura.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Bravura.MDT.Mighty = {}
	sets.engaged.Bravura.SomeAcc.MDT.Mighty = {}
	sets.engaged.Bravura.Acc.MDT.Mighty = {}
	sets.engaged.Bravura.FullAcc.MDT.Mighty = {}
	sets.engaged.Bravura.Fodder.MDT.Mighty = {}

	sets.engaged.Bravura.MDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Mighty = {}

	sets.engaged.Bravura.MDT.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Mighty.AM = {}
	sets.engaged.Bravura.Acc.MDT.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Mighty.AM = {}

	sets.engaged.Bravura.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Mighty.AM = {}

	sets.engaged.Bravura.MDT.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.MDT.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.MDT.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.MDT.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.MDT.Charge.Mighty = {}

	sets.engaged.Bravura.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Charge.Mighty = {}

	sets.engaged.Bravura.MDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Charge.Mighty.AM = {}

	sets.engaged.Bravura.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Charge.Mighty.AM = {}

-- Ragnarok melee sets
  sets.engaged.Ragnarok = {}
	sets.engaged.Ragnarok.SomeAcc = {}
	sets.engaged.Ragnarok.Acc = {}
	sets.engaged.Ragnarok.FullAcc = {}
	sets.engaged.Ragnarok.Fodder = {}

  sets.engaged.Ragnarok.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin = {}
	sets.engaged.Ragnarok.Acc.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.Adoulin = {}

  sets.engaged.Ragnarok.AM = {}
	sets.engaged.Ragnarok.SomeAcc.AM = {}
	sets.engaged.Ragnarok.Acc.AM = {}
	sets.engaged.Ragnarok.FullAcc.AM = {}
	sets.engaged.Ragnarok.Fodder.AM = {}

  sets.engaged.Ragnarok.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.AM = {}

  sets.engaged.Ragnarok.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.Charge = {}
	sets.engaged.Ragnarok.Acc.Charge = {}
	sets.engaged.Ragnarok.FullAcc.Charge = {}
	sets.engaged.Ragnarok.Fodder.Charge = {}

  sets.engaged.Ragnarok.Adoulin.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Charge = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Charge = {}

  sets.engaged.Ragnarok.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.Charge.AM = {}

  sets.engaged.Ragnarok.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Charge.AM = {}

	sets.engaged.Ragnarok.PDT = {}
	sets.engaged.Ragnarok.SomeAcc.PDT = {}
	sets.engaged.Ragnarok.Acc.PDT = {}
	sets.engaged.Ragnarok.FullAcc.PDT = {}
	sets.engaged.Ragnarok.Fodder.PDT = {}

	sets.engaged.Ragnarok.PDT.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin = {}

	sets.engaged.Ragnarok.PDT.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.AM = {}

	sets.engaged.Ragnarok.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.AM = {}

	sets.engaged.Ragnarok.PDT.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge = {}

	sets.engaged.Ragnarok.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge = {}

	sets.engaged.Ragnarok.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge.AM = {}

	sets.engaged.Ragnarok.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Ragnarok.MDT = {}
	sets.engaged.Ragnarok.SomeAcc.MDT = {}
	sets.engaged.Ragnarok.Acc.MDT = {}
	sets.engaged.Ragnarok.FullAcc.MDT = {}
	sets.engaged.Ragnarok.Fodder.MDT = {}

	sets.engaged.Ragnarok.MDT.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin = {}

	sets.engaged.Ragnarok.MDT.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.AM = {}

	sets.engaged.Ragnarok.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.AM = {}

	sets.engaged.Ragnarok.MDT.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Charge = {}
	sets.engaged.Ragnarok.Acc.MDT.Charge = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Charge = {}
	sets.engaged.Ragnarok.Fodder.MDT.Charge = {}

	sets.engaged.Ragnarok.MDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Charge = {}

	sets.engaged.Ragnarok.MDT.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Charge.AM = {}

	sets.engaged.Ragnarok.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Charge.AM = {}

  sets.engaged.Ragnarok.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.Mighty = {}
	sets.engaged.Ragnarok.Acc.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.Mighty = {}
	sets.engaged.Ragnarok.Fodder.Mighty = {}

  sets.engaged.Ragnarok.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Mighty = {}

  sets.engaged.Ragnarok.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.Mighty.AM = {}

  sets.engaged.Ragnarok.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Mighty.AM = {}

  sets.engaged.Ragnarok.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.Charge.Mighty = {}

  sets.engaged.Ragnarok.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Charge.Mighty = {}

  sets.engaged.Ragnarok.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.Charge.Mighty.AM = {}

  sets.engaged.Ragnarok.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Ragnarok.PDT.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Mighty = {}
	sets.engaged.Ragnarok.Acc.PDT.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Mighty = {}
	sets.engaged.Ragnarok.Fodder.PDT.Mighty = {}

	sets.engaged.Ragnarok.PDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Mighty = {}

	sets.engaged.Ragnarok.PDT.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Mighty.AM = {}

	sets.engaged.Ragnarok.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Mighty.AM = {}

	sets.engaged.Ragnarok.PDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge.Mighty = {}

	sets.engaged.Ragnarok.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge.Mighty = {}

	sets.engaged.Ragnarok.PDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge.Mighty.AM = {}

	sets.engaged.Ragnarok.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Ragnarok.MDT.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Mighty = {}
	sets.engaged.Ragnarok.Acc.MDT.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Mighty = {}
	sets.engaged.Ragnarok.Fodder.MDT.Mighty = {}

	sets.engaged.Ragnarok.MDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Mighty = {}

	sets.engaged.Ragnarok.MDT.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Mighty.AM = {}

	sets.engaged.Ragnarok.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Mighty.AM = {}

	sets.engaged.Ragnarok.MDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.MDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.MDT.Charge.Mighty = {}

	sets.engaged.Ragnarok.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Charge.Mighty = {}

	sets.engaged.Ragnarok.MDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Charge.Mighty.AM = {}

	sets.engaged.Ragnarok.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Charge.Mighty.AM = {}

]]--

	--Extra Special Sets

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Chango = {main="Chango",sub="Utu Grip"}
  sets.weapons.Greatsword = {main="Raetic Algol +1",sub="Utu Grip"}
  --sets.weapons.Bravura = {main="Bravura",sub="Utu Grip"}
  if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
    sets.weapons.Sword = {main="Firangi",sub="Reikiko"}
  else
    sets.weapons.Sword = {main="Firangi",sub="Blurred Shield +1"}
  end
	--sets.weapons.Greatsword = {main="Montante +1",sub="Utu Grip"}
	sets.weapons.ProcDagger = {main="Kustawi",sub=empty}
	sets.weapons.ProcSword = {main="Ark Sword",sub=empty}
	sets.weapons.ProcGreatSword = {main="Irradiance Blade",sub=empty}
	sets.weapons.ProcScythe = {main="Ark Scythe",sub=empty}
	sets.weapons.ProcPolearm = {main="Pitchfork +1",sub=empty}
	sets.weapons.ProcGreatKatana = {main="Hardwood Katana",sub=empty}
	sets.weapons.ProcClub = {main="Dream Bell +1",sub=empty}
	sets.weapons.ProcStaff = {main="Terra's Staff",sub=empty}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(3, 3)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 3)
    else
        set_macro_page(5, 3)
    end
end

function user_bind_ws(var)
  if state.Weapons.value == 'Ragnarok' then
    --- Bind Ragnarok WeaponSkills
		send_command('bind %q input /ws "Resolution" <t>')
		send_command('bind ^q input /ws "Scourge" <t>')
		send_command('bind !q input /ws "Scourge" <t>')

	elseif state.Weapons.value == 'Greatsword' then
	  --- Bind Algol WeaponSkills
		send_command('bind %q input /ws "Resolution" <t>')

	elseif state.Weapons.value == 'Chango' then
		--- Bind Chango WeaponSkills
		send_command('bind !q input /ws "King/s Justice" <t>')
		send_command('bind %q input /ws "Upheaval" <t>')
		send_command('bind ^q input /ws "Ukko/s Fury" <t>')

  elseif state.Weapons.value == 'Bravura' then
	  --- Bind Bravura WeaponSkills
		send_command('bind !q input /ws "Metatron Torment" <t>')
		send_command('bind %q input /ws "Upheaval" <t>')
		send_command('bind ^q input /ws "Ukko/s Fury" <t>')

	elseif state.Weapons.value == 'Sword' then
	  --- Bind Sword WeaponSkills
		send_command('bind %q input /ws "Savage Blade" <t>')
		send_command('bind !q input /ws "Red Lotus Blade" <t>')
		send_command('bind ^q input /ws "Flat Blade" <t>')
  end
	-- Trigger on unbind.
	if var == 'unload' then
		send_command('unbind %q')
		send_command('unbind ^q')
		send_command('unbind !q')
	end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

        if spell_recasts[979] == 0 and not have_trust("Cornelia") then
					windower.send_command('input /ma "Cornelia" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[980] == 0 and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[952] == 0 and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[967] == 0 and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[914] == 0 and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = 250
					return true
				else
					return false
				end
			end
		end
	end
	return false
end
