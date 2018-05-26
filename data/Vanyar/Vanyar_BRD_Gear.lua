function user_setup()
  -- Options: Override default values
  state.OffenseMode:options('Normal','Acc')
  state.CastingMode:options('Normal','Resistant')
  state.IdleMode:options('Normal','PDT')
  state.Weapons:options('None','Duration','Aeneas','Carnwenhan','DualWeapons','Swords')--,'NukeWeapons'

  -- Adjust this if using the Terpander (new +song instrument)
  info.ExtraSongInstrument = 'Daurdabla'
  -- How many extra songs we can keep from Daurdabla/Terpander
  info.ExtraSongs = 2

  -- Set this to false if you don't want to use custom timers.
  state.UseCustomTimers = M(false, 'Use Custom Timers')

  -- Additional local binds
  send_command('bind ^` gs c cycle ExtraSongsMode')
  send_command('bind !` input /ma "Chocobo Mazurka" <me>')
  send_command('bind @` gs c cycle MagicBurst')
  send_command('bind @f10 gs c cycle RecoverMode')
  send_command('bind @f8 gs c toggle AutoNukeMode')
  send_command('bind !q gs c weapons NukeWeapons;gs c update')
  send_command('bind ^q gs c weapons Swords;gs c update')

  --select_default_macro_book()
end

function init_gear_sets()

  IntarabusMacc = {name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
	IntarabusDD = {
		--name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}
		}
	IntarabusWS = {}

	sets.horn 	= 	{range="Gjallarhorn"}
	sets.harp 	= 	{range="Daurdabla"}
	sets.marsy 	= 	{range="Marsyas"}

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
  sets.weapons.Duration = {main="Carnwenhan",sub="Kali"}
	sets.weapons.Aeneas = {main="Aeneas",sub="Genmei Shield"}
  sets.weapons.Carnwenhan = {main="Carnwenhan",sub="Genmei Shield"}
	sets.weapons.DualWeapons = {main="Aeneas",sub="Carnwenhan"}
	sets.weapons.Swords = {main="Vampirism",sub="Vampirism"}
	--sets.weapons.NukeWeapons = {main="Malevolence",sub="Malevolence"}

	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
		ammo="Impatiens",
		head="Haruspex hat +1",
		body="Inyanga jubbah +2",
		hands="Leyline Gloves",
		legs="Kaykaus tights +1",
    feet="Kaykaus boots +1",
		neck="Voltsurge Torque",
		ear1="Loquacious Earring",
		ear2="Enchanter Earring +1",
		ring1="Prolix Ring",
		ring2="Kishar Ring",
		back=IntarabusMacc,
		waist="Witful Belt",
		--feet=TelchineFeetFC,
  }

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Vanya Clogs"})
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.BardSong = {
    range="Gjallarhorn",
    ammo=empty,
		head="Fili Calot +1",
		body="Inyanga Jubbah +2",
		--hands="Gendewitha Gages +1",
		hands="Leyline Gloves",
		legs="Querkening Brais", 		--10%
		feet="Bihu slippers +1", 		--8%
		--feet=TelchineFeetFC,
		neck="Moonbow Whistle +1",
		ear1="Loquacious Earring",
		--ear2="Enchanter Earring +1",
		ear2="Etiolation earring",
		ring1="Prolix Ring",
		ring2="Kishar Ring",
		back=IntarabusMacc,
		waist="Witful belt",
  }

	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla

	-- Precast sets to enhance JAs
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps +1"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		range="Linos",
		--head="Lustratio Cap +1",
    head="Aya. Zucchetto +2",
		neck="Caro Necklace",
    ear1="Moonshade Earring",
    ear2="Ishvara Earring",
		body="Ayanmo Corazza +2",
		hands="Ayanmo Manopolas +2",
		ring1="Ilabrat Ring",
		ring2="Rajas Ring",
		back=IntarabusMR,
		waist="Grunfeld Rope",
		legs="Jokushu Haidate",
		feet="Ayanmo Gambieras +2",
  }
	sets.precast.WS['Mordant Rime'] = {
		range="Linos",
		head="Lustratio Cap +1",
		neck="Moonbow Whistle +1",
		ear1="Brutal Earring",
		ear2="Telos Earring",
		body="Bihu Justaucorps +1",
		hands="Ayanmo Manopolas +2",
		ring1="Ilabrat Ring",
		ring2="Rajas Ring",
		back=IntarabusMR,
		waist="Grunfeld Rope",
		legs="Jokushu Haidate",
		feet="Ayanmo Gambieras +2",
	}
	sets.precast.WS['Evisceration'] = {
		range="Linos",
		head="Lustratio Cap +1",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Ayanmo Corazza +2",
		hands="Ayanmo Manopolas +2",
		ring1="Hetairoi Ring",
		ring2="Begrudging Ring",
		back=IntarabusDD,
		waist="Fotia Belt",
		legs="Jokushu Haidate",
		feet="Ayanmo Gambieras +2",
	}
	sets.precast.WS["Rudra's Storm"] = {
		range="Linos",
		head="Lustratio Cap +1",
		neck="Caro Necklace",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Lustratio Harness +1",
		hands="Ayanmo Manopolas +2",
		ring1="Ilabrat Ring",
		ring2="Apate Ring",
		back=IntarabusWS,
		waist="Grunfeld Rope",
		legs="Lustratio Subligar +1",
		feet="Lustratio Leggings +1",
	}
	sets.precast.WS['Exenterator'] = {
		range="Linos",
		head="Lustratio Cap +1",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Telos Earring",
		body="Ayanmo Corazza +2",
    hands="Ayanmo Manopolas +2",
		ring1="Ilabrat Ring",
		ring2="Apate Ring",
		back=IntarabusDD,
		waist="Fotia Belt",
		legs="Ayanmo Cosciales +2",
		feet="Ayanmo Gambieras +2",
	}
	sets.precast.WS['Aeolian Edge'] = {
		head="Lustratio Cap +1",
		neck="Fotia Gorget",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body="Brioso Justaucorps +1",
		hands="Leyline Gloves",
		ring1="Ilabrat Ring",
		ring2="Shiva Ring +1",
		back=IntarabusMacc,
		waist="Fotia Belt",
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}--ear1="Jupiter's Pearl",ear2="Kuwunga Earring"
	sets.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {
		--head="Nahtirah Hat",
		neck="Voltsurge Torque",
		ear1="Loquacious Earring",
		ear2="Enchanter Earring +1",
		body="Inyanga Jubbah +2",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Kishar Ring",
		back=IntarabusMacc,
		waist="Witful Belt",
		legs="Kaykaus Tights +1",
		feet="Regal Pumps +1",
  }

	-- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
	sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
	sets.midcast.Lullaby = {hands="Brioso Cuffs +1"}
	sets.midcast.Madrigal = {head="Fili Calot +1",back=IntarabusMacc}
	sets.midcast.Paeon = {head="Brioso Roundlet +1"}
	sets.midcast.March = {hands="Fili Manchettes +1"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Marsyas"})
	sets.midcast.Minuet = {body="Fili Hongreline +1"}
	sets.midcast.Minne = {body="Fili Hongreline +1"}
	sets.midcast.Carol = {}--hands="Mousai Gages"
	sets.midcast["Sentinel's Scherzo"] = {} --feet="Fili Cothurnes +1" Brioso Slippers still provides more Duration
	sets.midcast['Magic Finale'] = {}
	sets.midcast.Mazurka = {range="Marsyas"}


	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
    --main="Carnwenhan",
    range="Gjallarhorn",
    ammo=empty,
		head="Fili Calot +1",
		neck="Moonbow Whistle +1",
		body="Fili Hongreline +1",
		hands="Fili manchettes +1",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
    ring1="Stikini Ring +1",
    ring2="Stikini Ring +1",
		back="Intarabus's Cape",
  }

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {
		--main="Carnwenhan",
    range="Gjallarhorn",
    ammo=empty,
		head="Inyanga Tiara +2",
		body={ name="Chironic Doublet", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Cure" potency +1%','CHR+4','Mag. Acc.+15','"Mag.Atk.Bns."+1',}},
		hands="Kaykaus Cuffs +1",
		legs="Fili Rhingrave +1",
		feet="Brioso Slippers +3",
		neck="Moonbow Whistle +1",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=IntarabusMacc,
		--[[
		main="Carnwenhan",
		sub="Ammurapi Shield",
		head="Brioso Roundlet +1",
		neck="Moonbow Whistle +1",
		ear1="Regal Earring",
		ear2="Enchanter Earring +1",
		body="Brioso Justaucorps +1",
		hands="Brioso Cuffs +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back=IntarabusMacc,
		waist="Luminary Sash",
		legs="Brioso Cannions +1",
		feet="Brioso Slippers +3",
		]]--
  }

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.ResistantSongDebuff = set_combine(sets.midcast.SongDebuff,{})

	-- Song-specific recast reduction
	sets.midcast.SongRecast = sets.midcast.FastRecast

  -- Cast spell with normal gear, except using Daurdabla instead
  sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

  -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
  sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {
		head="Kaykaus Mitra +1",
		body="Kaykaus Bliaut +1",
		hands="Kaykaus Cuffs +1",
		legs="Kaykaus Tights +1",
		feet="Kaykaus Boots +1",
		neck="Incanter's Torque",
		waist="Hachirin-no-Obi",
		ear1="Digni. Earring",
		ear2="Regal Earring",
		ring1="Haoma's Ring",
		ring2="Lebeche Ring",
		back="Solemnity Cape",
  }

	sets.Self_Healing = {neck="Phalaina Locket",waist="Gishdubar Sash"}--hands="Buremte Gloves",ring2="Kunaji Ring",
	sets.Cure_Received = {neck="Phalaina Locket",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	sets.midcast['Enhancing Magic'] = {
  	sub="Ammurapi Shield",
		head="Telchine Cap",
		body="Telchine Chasuble",
		hands="Telchine Gloves",
		legs="Telchine Braconi",
		feet="Telchine Pigaches",
  }

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",waist="Siegel Sash"})--ear2="Earthcry Earring",legs="Shedir Seraweels"
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {
		head="Kaykaus Mitra +1",		    --skill +16
		body="Vanya Robe",
		feet="Vanya clogs",				      --Cursna +5, Skill +40
		neck="Debilis Medallion",		    --Cursna +15%
		ring1="Haoma's Ring",			  		--Cursna +15%
		ring2="Haoma's Ring",						--Cursna +15%
		--back="Oretania's Cape +1",
  })

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})--main=gear.grioavolr_fc_staff,sub="Clemency Grip"

	-- Resting sets
	sets.resting = {}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		sub="Genmei Shield",
		range="Oneiros Harp",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands=gear.Chironic_Refresh_hands,
		legs="Assid. Pants +1",
		--feet=gear.Chironic_Refresh_feet,
    feet="Fili Cothurnes +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		ear1="Etiolation Earring",
		ear2="Infused Earring",
		ring1="Defending Ring",
		ring2="Vocane Ring",
		back="Moonlight Cape",
  }

	sets.idle.PDT = {
		sub="Genmei Shield",
		range="Oneiros Harp",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands=gear.Chironic_Refresh_hands,
		legs="Assid. Pants +1",
		--feet=gear.Chironic_Refresh_feet,
    feet="Fili Cothurnes +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		ear1="Etiolation Earring",
		ear2="Infused Earring",
		ring1="Defending Ring",
		ring2="Vocane Ring",
		back="Moonlight Cape",
  }

	-- Defense sets
	sets.defense.PDT = {
		sub="Genmei Shield",
		range="Oneiros Harp",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands=gear.Chironic_Refresh_hands,
		legs="Assid. Pants +1",
		--feet=gear.Chironic_Refresh_feet,
    feet="Fili Cothurnes +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		ear1="Etiolation Earring",
		ear2="Infused Earring",
		ring1="Defending Ring",
		ring2="Vocane Ring",
		back="Moonlight Cape",
  }

	sets.defense.MDT = {
		sub="Genmei Shield",
		range="Oneiros Harp",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands=gear.Chironic_Refresh_hands,
		legs="Assid. Pants +1",
		--feet=gear.Chironic_Refresh_feet,
    feet="Fili Cothurnes +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Infused Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back="Moonlight Cape",
  }

	sets.Kiting = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	sets.engaged = {
		range="Linos",
		--head=ChiroHeadTH2,
		head="Ayanmo Zucchetto +2",
		neck="Asperity Necklace",
    ear1="Cessance Earring",
		ear2="Telos Earring",
		body="Ayanmo Corazza +2",
		--hands=ChiroHandsDD,
		hands="Aya. Manopolas +2",
		ring1="Hetairoi Ring",
		ring2="Petrov Ring",
		back=IntarabusDD,
		waist="Windbuffet Belt +1",
		legs="Jokushu Haidate",
		feet="Ayanmo Gambieras +2",
  }
	sets.engaged.Acc = set_combine(sets.engaged,{
    ear1="Cessance Earring",
		ear2="Telos Earring",
		waist="Grunfeld Rope",
  })
	sets.engaged.DW = {
		sub=dagger,
		range="Linos",
		--head=ChiroHeadTH2,
		head="Ayanmo Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Eabani Earring",
		ear2="Suppanomimi",
		body="Ayanmo Corazza +2",
		--hands=ChiroHandsDD,
		hands="Aya. Manopolas +2",
		ring1="Hetairoi Ring",
		ring2="Petrov Ring",
		back=IntarabusDD,
		waist="Reiki Yotai",
		legs="Jokushu Haidate",
		feet="Ayanmo Gambieras +2",
  }
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW,{
		head="Ayanmo Zucchetto +2",
		neck="Subtlety Spectacles",
		hands="Ayanmo Manopolas +2",
		ring1="Ilabrat Ring",
		ring2="Cacoethic Ring",
		legs="Ayanmo Cosciales +2",
  })
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(10, 10)
end
