-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_setup()
  state.OffenseMode:options('None','Normal','Acc')
  state.CastingMode:options('Normal','Resistant')
  state.IdleMode:options('Normal','MDT', 'PDT','TPEat')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','MeleeWeapons','DualWeapons')

	gear.obi_nuke_waist = "Sekhmet Corset"
	gear.obi_nuke_back = "Toro Cape"
  gear.Alaunus_Cure_MND = { name="Alaunus's Cape", augments={'MND+20','"Cure" potency +10%',}}
  gear.Alaunus_FC = { name="Alaunus's Cape", augments={'"Fast Cast"+10',}}
  gear.Alaunus_DualWield = { name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10',}}

  --- Buff Binds
  send_command('bind %1 input /ma "Aquaveil" <me>')
  send_command('bind %2 input /ma "Blink" <me>')
  send_command('bind %3 input /ma "Stoneskin" <me>')
  if player.sub_job == 'RDM' then
    send_command('bind %4 input /ma "Phalanx" <me>')
    send_command('bind %6 input /ma "Refresh" <me>')
  elseif player.sub_job == 'SCH' then
    send_command('bind %4 input /ma "Aurorastorm" <me>')
    send_command('bind %6 input /ja "Sublimation" <me>')
  end
  send_command('bind %5 input /ma "Haste" <me>')
  send_command('bind %7 input /ma "Reraise IV" <me>')

  --- Magic Binds
  --send_command('bind %r input /ma "Repose" <t>')
  send_command('bind ^a input /ma "Addle" <t>')
  send_command('bind ^s input /ma "Silence" <t>')
  send_command('bind ^d input /ma "Dia II" <t>;input /p Dia II')
  send_command('bind ^q input /ma "Paralyze" <t>')
  --send_command('bind !` gs c cycle HighHP')

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	--send_command('bind !` input /ja "Penury" <me>')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

  -- for dressup instead?
  send_command('lua l dressup;@wait 1;du blinking all all on')

  --- Augmented Gear
  include('Vanyar-Items.lua')

  --select_default_macro_book()
end


function user_unload()
  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind %1')
  send_command('unbind %2')
  send_command('unbind %3')
  send_command('unbind %4')
  send_command('unbind %5')
  send_command('unbind %6')
  send_command('unbind %7')
  send_command('unbind %8')
  send_command('unbind %9')
  send_command('unbind %q')
  send_command('unbind ^q')
  send_command('unbind !q')
  send_command('unbind !d')
  send_command('unbind ^a')
  send_command('unbind ^s')
  send_command('unbind ^d')
  send_command('unbind delete')
  send_command('unbind end')
  send_command('unbind ^end')
  send_command('unbind !end')
  send_command('unbind %x')
  send_command('unbind pageup')
  send_command('unbind pagedown')
  send_command('unbind !pagedown')
  send_command('lua u dressup')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  --------------------------------------
  -- Start defining the sets
  --------------------------------------
  gear.Alaunus_Cure_MND = { name="Alaunus's Cape", augments={'MND+20','"Cure" potency +10%',}}
  gear.Alaunus_FC = { name="Alaunus's Cape", augments={'"Fast Cast"+10',}}
  gear.Alaunus_DualWield = { name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10',}}

	-- Weapons sets
	sets.weapons.MeleeWeapons = {main="Yagrush",sub="Thorfinn Shield +1"}
	sets.weapons.DualWeapons = {main="Yagrush",sub="Mjollnir"}

  -- Precast Sets

  -- Fast cast sets for spells
  sets.precast.FC = {
    main="Yagrush",             -- FC 20 %
    sub="Sors Shield",          -- CCT -5
    ammo="Impatiens",				    -- QC 2%
    head="Haruspex hat +1",			-- FC 9%
    body="Inyanga jubbah +2",		-- FC 14%
    hands="Fanatic Gloves",			-- FC 7
    legs="Kaykaus Tights +1",   -- FC 7%
    feet="Regal Pumps +1"  ,    -- FC 5-7%
    neck="Voltsurge Torque",		-- FC 4%
    ear1="Etiolation earring",	-- FC 1%
    ear2="Loquacious Earring",	-- FC 2%
    ring1="Lebeche Ring",			  -- QC+2%
    ring2="Prolix Ring",			  -- FC+2%
    back=gear.Alaunus_FC,				-- FC 10%
    waist="Witful Belt",			  -- FC 3% ,QC 3%
  }

  sets.precast.FC.DT = sets.precast.FC
  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
  sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
  sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +1",})
  sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
  sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
    -- CCT -36 / Healing -13 / FC 12 / QC 11
    -- Total Combined: CCT 52 / FC 30 / QC 11
    ammo="Impatiens",               -- QC 2
    head="Piety Cap +1",            -- CCT -13
    legs="Ebers Pant. +1",          -- healing time -13
    feet="Kaykaus Boots +1",        -- CCT -7
    waist="Witful Belt",            -- FC+3 / QC+3
    ear1="Nourish. Earring",        -- CCT -3
    ear2="Nourishing earring +1",	  -- CCT -4
    ring1="Lebeche Ring",           -- QC 2
    ring2="Prolix Ring",            -- FC 2
    back="Perimede Cape"            -- QC 4
  })

	sets.precast.FC.Cure.DT = sets.precast.FC.DT
  sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.CureSolace = sets.precast.FC.Cure
	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
  -- Precast sets to enhance JAs
  sets.precast.JA.Benediction = {body="Piety Briault +1"}

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
		head="Nahtirah Hat",
    ear1="Roundel Earring",
		body="Piety Briault +1",
    hands="Telchine Gloves",
		waist="Chaac Belt",
    back="Aurist's Cape +1",
  }

  -- Weaponskill sets

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = set_combine(sets.engaged.ACC,{
		neck="Fotia Gorget",
		ring1="Ilabrat Ring",
		ring2="Rufescent Ring",
		waist="Fotia Belt",
		})

  --sets.precast.WS['Flash Nova'] = {}
  sets.precast.WS['Mystic Boon'] = set_combine(sets.precast.WS,{
    ammo="Quartz Tathlum +1",
    head="Theophany Cap +3",
    body="Theophany Briault +3",
    hands="Theophany Mitts +3",
    legs="Theophany Pantaloons +3",
    feet="Theophany Duckbills +3",
    neck="Nuna Gorget +1",
    ear1="Nourish. Earring +1",
    ear2="Ishvara Earring",
    ring1="Levia. Ring +1",
    ring2="Rufescent Ring",
    back="Alaunus's Cape",
    waist="Luminary Sash",
  })

  -- Midcast Sets

  sets.Kiting = {feet="Herald's Gaiters"}
  sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {back="Umbra Cape"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}

	-- Conserve Mp set for spells that don't need anything else, for set_combine.

	sets.ConserveMP = {
    --[[
    ammo="Hasty Pinion +1",
		head="Vanya Hood",
    neck="Incanter's Torque",
    ear1="Gifted Earring",ear2="Gwati Earring",
		body="Vedic Coat",
    hands="Fanatic Gloves",
    ring1="Kishar Ring",
    ring2="Prolix Ring",
		back="Solemnity Cape",
    waist="Austerity Belt +1",
    legs="Vanya Slops",
    feet="Medium's Sabots"
    ]]--
   }

	sets.midcast.Teleport = sets.ConserveMP
  sets.midcast.FastRecast = set_combine(sets.precast.FC,{waist="Ninurta's sash"})

  -- Default Cure sets
	sets.midcast['Full Cure'] = sets.midcast.FastRecast
  sets.midcast.Cure = {
    main="Queller Rod",             -- I 10% / II 2%
    sub="Sors Shield",              -- I 3%
    ammo="Hydrocera",
    head="Kaykaus Mitra +1",        -- I 11%
    body="Ebers Bliaud +1",
    hands="Theophany Mitts +3",     -- II 4%
    legs="Ebers Pant. +1",
    feet="Kaykaus Boots +1",        -- I 11%
    neck="Incanter's Torque",
    ear1="Glorious Earring",        -- II 2%
    ear2="Nourishing earring +1",	  -- I 6-7%
    ring1="Lebeche Ring",
    ring2="Stikini Ring +1",
    back=gear.Alaunus_Cure_MND,     -- I 10%
  }

  sets.midcast.CureHighHP = set_combine(sets.midcast.Cure,{
    neck="Bathy Choker",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    ring1="Gelatinous Ring",
    ring2="Supershear Ring",
    back="Moonlight Cape",
  })

  -- Cure Sets
	sets.midcast.CureSolace = {
    main="Queller Rod",             -- I 10% / II 2%
    sub="Sors Shield",              -- I 3%
    ammo="Hydrocera",
    head="Kaykaus Mitra +1",        -- I 11%
    body="Ebers Bliaud +1",
    hands="Theophany Mitts +3",     -- II 4%
    legs="Ebers Pant. +1",
    feet="Kaykaus Boots +1",        -- I 11%
    neck="Incanter's Torque",
    ear1="Glorious Earring",        -- II 2%
    ear2="Nourishing earring +1",	  -- I 6-7%
    ring1="Lebeche Ring",
    ring2="Stikini Ring +1",
    back=gear.Alaunus_Cure_MND,     -- I 10%
  }

  sets.midcast.CureSolaceHighMP = set_combine(sets.midcast.CureSolace,{
    --not sure if this will be feasible due to the HighMP usage
    main="Raetic Rod +1",           -- 23 I / 10 II
    sub="Ammurapi Shield",
  })

	sets.midcast.LightWeatherCure = {
    -- can add WHM Ring in both setups
    -- 52 I / 10 II
    main="Chatoyant Staff",         -- 10 I
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    --ammo="Esper Stone +1",        --Enmity-
    head="Kaykaus Mitra +1",        -- 11 I / +II
    body="Ebers Bliaud +1",
    hands="Theophany Mitts +3",     --4 II
    legs="Ebers Pant. +1",
    feet="Kaykaus Boots +1",        -- 11 I / 4 II (with 2 Pieces) // path D ( + 6% I ) for Staff. Path B for Rod+1
    neck="Nodens Gorget",           -- 5% I
    waist="Hachirin-no-Obi",        -- Weather
    ear1="Glorious Earring",        -- 2 II
    ear2="Nourish. Earring +1",     -- 6-7 I
    ring1="Lebeche Ring",           -- 3 I
    back="Twilight Cape",           -- Weather
  }

  sets.midcast.LightWeatherCureHighMP = {
    -- 54 I / 20 II
    main="Raetic Rod +1",           -- 23 I / 10 II
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    --ammo="Esper Stone +1",        --Enmity-
    head="Kaykaus Mitra +1",        -- 11 I / +II
    body="Ebers Bliaud +1",
    hands="Theophany Mitts +3",     --4 II
    legs="Ebers Pant. +1",
    feet="Kaykaus Boots +1",        -- 11 I / 4 II (with 2 Pieces) // path D (6% I) for Staff. Path B for Rod+1
    neck="Incanter's Torque",
    waist="Hachirin-no-Obi",        -- Weather
    ear1="Glorious Earring",        -- 2 II
    ear2="Nourish. Earring +1",     -- 6-7 I
    ring1="Lebeche Ring",           -- 3 I
    back="Twilight Cape",           -- Weather
  }
	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.LightWeatherCure,{body="Ebers Bliaud +1"})
  sets.midcast.LightWeatherCureSolaceHighMP = set_combine(sets.midcast.LightWeatherCureHighMP,{body="Ebers Bliaud +1"})

  -- Curaga Sets
	sets.midcast.Curaga = {
    main="Queller Rod",
    sub="Ammurapi Shield",
    ammo="Hydrocera",
    head="Kaykaus Mitra +1",
    body="Theophany Briault +3",
    hands="Theophany Mitts +3",
    legs="Kaykaus Tights +1",
    feet="Kaykaus Boots +1",
    waist="Luminary Sash",
    left_ear="Glorious Earring",
    right_ear="Nourish. Earring +1",
    ring1="Rufescent Ring",
    ring2="Stikini Ring +1",
    back=gear.Alaunus_Cure_MND,       -- 10 I
  }
	sets.midcast.LightWeatherCuraga = {
    main="Chatoyant Staff",         -- 10 I
    sub="Enki Strap",
    ammo="Hydrocera",
    head="Kaykaus Mitra +1",
    body="Theophany Briault +3",
    hands="Theophany Mitts +3",
    legs="Kaykaus Tights +1",
    feet="Kaykaus Boots +1",
    waist="Hachirin-no-Obi",        -- Weather
    left_ear="Glorious Earring",
    right_ear="Nourish. Earring +1",
    ring1="Stikini Ring +1",
    ring2="Stikini Ring +1",
    back="Twilight Cape",           -- Weather
  }
  -- not using ReaticRod as we won't have any MP Return.
  sets.midcast.LightWeatherCuragaHighMP = sets.midcast.LightWeatherCuraga

	--Melee Curesets are used whenever your OffenseMode is set to anything but None.
	sets.midcast.MeleeCure = {
    ammo="Pemphredo Tathlum",
		head="Kaykaus Mitra +1",
    neck="Incanter's Torque",
    ear1="Glorious Earring",ear2="Nourish. Earring +1",
		body="Kaykaus Bliaut +1",
    hands="Kaykaus Cuffs +1",
    ring1="Janniston Ring",
    ring2="Lebeche Ring",
		back="Alaunus's Cape",
    waist="Luminary Sash",
    legs="Ebers Pant. +1",
    feet="Kaykaus Boots +1"
  }

	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
  sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})

  -- Potential CureDT Sets
  sets.midcast.Cure.DT = sets.midcast.Cure
  sets.midcast.CureHighHP.DT = sets.midcast.CureHighHP
	sets.midcast.CureSolace.DT = sets.midcast.CureSolace
  sets.midcast.CureSolaceHighMP.DT = sets.midcast.CureSolaceHighMP
	sets.midcast.LightWeatherCure.DT = sets.midcast.LightWeatherCure
  sets.midcast.LightWeatherCureHighMP.DT = sets.midcast.LightWeatherCureHighMP
  sets.midcast.LightWeatherCureSolace.DT = sets.midcast.LightWeatherCureSolace
  sets.midcast.LightWeatherCureSolaceHighMP.DT = sets.midcast.LightWeatherCureSolaceHighMP
  sets.midcast.Curaga.DT = sets.midcast.Curaga
	sets.midcast.LightWeatherCuraga.DT = sets.midcast.LightWeatherCuraga
  sets.midcast.LightWeatherCuragaHighMP.DT = sets.midcast.LightWeatherCuragaHighMP
  sets.midcast.MeleeCure.DT = sets.midcast.MeleeCure

	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

	sets.midcast.Cursna = {
    main="Yagrush",
		sub="Culminus",
		head="Kaykaus Mitra +1",		    --skill +16
		neck="Debilis Medallion",		    --Cursna +15%
		body="Ebers Bliaud +1",			    --skill +24
		hands="Fanatic gloves",			    --Cursna+15, skill+10
		ring1="Haoma's Ring",			      --Cursna +15%
		ring2="Haoma's Ring",			      --Cursna +15%
		back="Alaunus's Cape",			    --Cursna +25
		legs="Theophany Pantaloons +3",	--Cursna +21
		feet="Vanya clogs"				      --Cursna +5, Skill +40
  }

	sets.midcast.StatusRemoval = {
    main="Yagrush",					--AOE
    neck="Incanter's torque",
    head="Ebers Cap +1",			--22%
  }

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {
    main=gear.Gada_Duration,      --skill 18
		sub="Ammurapi shield",
		head="Befouled Crown", 			  --Skill 16
		body="Telchine chasuble",		  --Skill 12
		hands="Dynasty Mitts", 			  --Skill 18 / duration 5
		legs="Piety Pantaloons +1", 	--Skill 22 / bar 30
		feet="Ebers Duckbills +1", 		--Skill 25
		ring1="Stikini Ring +1",			--Skill 5
		ring2="Stikini Ring +1",			--Skill 5
		neck="Incanter's Torque", 		--Skill 10 / mp deplete
		back="Mending Cape", 			    --Skill 1
  }

  sets.midcast.EnhDuration = set_combine(sets.midcast['Enhancing Magic'],{--50 + 10% total duration / skill 460
    main=gear.Gada_Duration,	--6
    sub="Ammurapi shield",			--10%
    head="Telchine Cap", 			--10
    body="Telchine Chas.",			--10
    hands="Telchine Gloves",		--10
    legs="Telchine Braconi",		--10
    feet="Telchine Pigaches",		--10
  })

	sets.midcast.Stoneskin = set_combine(sets.midcast.EnhDuration, {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",hands="Dynasty Mitts"})
	sets.midcast.Auspice = set_combine(sets.midcast.EnhDuration, {feet="Ebers Duckbills +1"})
	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhDuration, {main="Vadose Rod",sub="Ammurapi Shield",hands="Regal Cuffs",waist="Emphatikos Rope",legs="Shedir Seraweels"})
  sets.midcast.Haste = set_combine(sets.midcast.EnhDuration,{})
	sets.midcast.Regen =  set_combine(sets.midcast.EnhDuration,{--Regen effect + conserver MP. I prefer duration over effect though.
    main="Bolelabunga",					      --Regen Potency +10%
    head="Inyanga Tiara +2",			    --Potency +12%
    body="Piety Briault +1",			    --Potency +36%
    hands="Ebers Mitts +1",				    --Duration +22 (beats anything)
    legs="Theophany Pantaloons +3",	  --18 seconds extra.
  })
	sets.midcast.Protect = set_combine(sets.midcast.EnhDuration, {ring2="Sheltered Ring",feet="Piety Duckbills +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Protectra = set_combine(sets.midcast.EnhDuration, {ring2="Sheltered Ring",feet="Piety Duckbills +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Shell = set_combine(sets.midcast.EnhDuration, {ring2="Sheltered Ring",legs="Piety Pantaln. +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Shellra = set_combine(sets.midcast.EnhDuration, {ring2="Sheltered Ring",legs="Piety Pantaln. +1",ear1="Gifted Earring",waist="Sekhmet Corset"})

	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],{
    main="Beneficus",
    sub="Ammurapi shield",
    head="Ebers cap +1",
    body="Ebers Bliaud +1",
    hands="Ebers Mitts +1",
    legs="Piety Pantaloons +1",
    feet="Ebers Duckbills +1",
  })

	sets.midcast.Impact = {
    main="Oranyan",
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
		head=empty,
    neck="Erra Pendant",
    ear1="Regal Earring",ear2="Digni. Earring",
		body="Twilight Cloak",
    hands=gear.chironic_enfeeble_hands,
    ring1="Stikini Ring +1",
    ring2="Stikini Ring +1",
		back="Toro Cape",
    waist="Acuity Belt +1",
    legs="Chironic Hose",
    feet=gear.chironic_nuke_feet
  }

	sets.midcast['Elemental Magic'] = {}

	sets.midcast['Elemental Magic'].Resistant = {}

	sets.midcast['Divine Magic'] = {
    main="Oranyan",
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
		head="Befouled Crown",
    neck="Incanter's Torque",
    ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",
    hands="Fanatic Gloves",
    ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",
    waist="Luminary Sash",
    legs="Chironic Hose",
    feet=gear.chironic_nuke_feet
  }

	sets.midcast['Dark Magic'] = {}
  sets.midcast.Drain = {}
  sets.midcast.Drain.Resistant = {}
  sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {}

	sets.midcast.Stun.Resistant = {}

	sets.midcast['Enfeebling Magic'] = {
    main="Yagrush",
    sub="Ammurapi Shield",
    ammo="Hydrocera",
    head="Theophany Cap +3",
    body="Theophany Briault +3",
    hands="Kaykaus Cuffs +1",
    legs="Theophany Pantaloons +3",
    feet="Theophany Duckbills +3",
    neck="Erra Pendant",
    waist="Luminary Sash",
    left_ear="Regal Earring",
    right_ear="Digni. Earring",
    ring1="Stikini Ring +1",
    ring2="Stikini Ring +1",
    back=gear.Alaunus_Cure_MND,
  }
	sets.midcast['Enfeebling Magic'].Resistant = {}

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

  sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
  sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {back="Alaunus's Cape"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {back="Alaunus's Cape",ring1="Stikini Ring +1"})

  -- Sets to return to when not performing an action.

  -- Resting sets
	sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
    main="Queller Rod",                 --Refresh 1
    sub="Genmei shield",		            --PDT -10
		ammo="Homiliary",								    --Refresh 1
		head="Befouled Crown",							--Refresh 1
		neck="Loricate Torque +1",					--DT -6
		ear1="Infused Earring",							--Regen
		ear2="Genmei Earring",							--PDT -2
		body="Shamash robe",							  --Refresh 3, PDT-10%
		hands=gear.Chironic_Refresh_hands,  --Refresh 2
    ring1="Defending Ring",
    ring2="Vocane Ring",
		back="Solemnity Cape",							--DT -4
		waist="Ninurta's sash",							--interruption rate down. PDT/MDT would be better
		legs="Assiduity Pants +1",					--refresh 1-2
		feet=gear.Chironic_Refresh_feet,    --refresh 1
  }

	sets.idle.PDT = {
    main="Mafic Cudgel",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head="Inyanga Tiara +2",
		hands="Inyan. Dastanas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Loricate Torque +1",
		waist="Ninurta's Sash",
		ear1="Etiolation Earring",
		ear2="Genmei Earring",
		ring1="Defending Ring",
		ring2="Vocane Ring",
		back="Solemnity Cape",
  }

  sets.idle.MDT = set_combine(sets.idle,{
		--32% DT, 20% PDT, 21% MDT, 600MEVA,
		--105 ResistSilence,36 MDB
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head="Inyanga Tiara +2",
		body="Shamash Robe",
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyan. Crackows +2",
		neck="Loricate Torque +1",
		waist="Fucho-no-Obi",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		ring1="Defending Ring",
		ring2="Vocane Ring",
		back="Moonlight Cape",
		})

  sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque"})

	sets.idle.Weak = sets.idle.MDT

  -- Defense sets
	sets.defense.PDT = sets.idle.PDT
	sets.defense.MDT = sets.idle.MDT
  sets.defense.MEVA = sets.idle.MDT

	-- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- Basic set for if no TP weapon is defined.
  sets.engaged = {
    ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Asperity Necklace",
		waist="Shetal Stone",
		ear1="Telos Earring",
		ear2="Suppanomimi",
		--ear2="Dignitary's earring",
		ring1="Hetairoi Ring",
		ring2="Petrov Ring",
		back=gear.Alaunus_DualWield,
  }
  sets.engaged.Acc = set_combine(sets.engaged,{
    neck="Sanctity Necklace",
		ring1="Begrudging Ring",
		ring2="Chirich Ring",
  })
  sets.engaged.DW = {
    ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Asperity Necklace",
		waist="Shetal Stone",
		ear1="Telos Earring",
		ear2="Suppanomimi",
		--ear2="Dignitary's earring",
		ring1="Hetairoi Ring",
		ring2="Petrov Ring",
		back=gear.Alaunus_DualWield,
  }
  sets.engaged.DW.Acc = set_combine(sets.engaged.DW,{
    neck="Sanctity Necklace",
		ring1="Begrudging Ring",
		ring2="Chirich Ring",
  })

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
  sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}
  sets.HPCure =  set_combine(sets.midcast.Cure,{
    neck="Bathy Choker",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    ring1="Gelatinous Ring",
    ring2="Supershear Ring",
    back="Moonlight Cape",
  })
  sets.HighHP = sets.HPCure
	--sets.HPDown = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 6)
end
