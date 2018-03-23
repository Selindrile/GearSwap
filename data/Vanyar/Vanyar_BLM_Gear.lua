function user_setup()
	-- Options: Override default values
	state.CastingMode:options('Normal','OccAcumen', 'Resistant','Fodder','Proc')
	state.OffenseMode:options('Normal')
	state.IdleMode:options('Normal',  'Death', 'PDT', 'TPEat','DTHippo')
	state.Weapons:options('None','Laevateinn', 'Khatvanga', 'Lathi', 'Death', 'Grio')

	gear.obi_cure_waist = "Witful Belt"
	gear.obi_low_nuke_waist = "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	--send_command('bind ^` input /ma Stun <t>')
	send_command('bind !` gs c cycle MagicBurst')
	send_command('bind ^` gs c cycle MPMode')

	--- Buff Binds
	send_command('bind %1 input /ma "Aquaveil" <me>')
	send_command('bind %2 input /ma "Blink" <me>')
	send_command('bind %3 input /ma "Stoneskin" <me>')
	if player.sub_job == 'RDM' then
		send_command('bind %4 input /ma "Phalanx" <me>')
		send_command('bind %5 input /ma "Haste" <me>')
		send_command('bind %6 input /ma "Refresh" <me>')
	elseif player.sub_job == 'SCH' then
		send_command('bind %6 input /ja "Sublimation" <me>')
	end
	send_command('bind %7 input /ma "Cure III" <me>')
	send_command('bind %8 input /ma "Cure IV" <me>')

		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !\\\\ input /ja "Manawell" <me>')
	send_command('bind !` input /ma "Aspir III" <t>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f9 gs c cycle DeathMode')
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace input /ja "Enmity Douse" <t>')
	send_command('bind @backspace input /ja "Alacrity" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind @= input /ja "Addendum: White" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')

	--select_default_macro_book()

	--- Augmented Gear
	include('Vanyar-Items.lua')
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
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
end

function init_gear_sets()
	--------------------------------------
	-- BLM Capes
	--------------------------------------
	gear.Taranus_FC = { name="Taranus's Cape", augments={'MP+60','"Fast Cast"+10',}}
	gear.Taranus_MATT_INT = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.Taranus_MATT_MP = { name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.Taranus_STP = { name="Taranus's Cape", augments={'"Store TP"+10',}}


  --------------------------------------
  -- Start defining the sets
  --------------------------------------

	-- Weapons sets
	sets.weapons.Laevateinn	= {
		main="Laevateinn",
		sub="Enki Strap"
	}
	sets.weapons.Khatvanga	= {
		main="Khatvanga",
		sub="Enki Strap"
	}
	sets.weapons.Lathi	= {
		main="Lathi",
		sub="Enki Strap"
	}
	sets.weapons.Death	= {
		main=gear.Grio_MATT_MP,
		sub="Enki Strap"
	}
	sets.weapons.Grio	= {
		main=gear.Grio_MATT_INT,
		sub="Enki Strap"
	}
  ---- Precast Sets ----

  -- Precast sets to enhance JAs
  sets.precast.JA['Mana Wall'] = {
		back=gear.Taranus_MATT_MP,
		feet="Wicce Sabots +1"
	}

  sets.precast.JA.Manafont = {body="Archmage's Coat"} --body="Sorcerer's Coat +2"

  -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
  sets.precast.JA.Convert = {}

  -- Fast cast sets for spells
  sets.precast.FC = {
		-- // 66% FC
		ammo="Sapience orb",--2%
		head=gear.Merlinic_FC_head, -- fc 8%%
		body="Zendik Robe",--13%
    hands=gear.Merlinic_FC_hands, --FC 6%
		legs="Psycloth Lappas", --fc 7%
		feet=gear.Merlinic_FC_feet,--FC 10
		neck="Voltsurge Torque", --4%
		ear2="Loquacious Earring",--2%
		ring1="Prolix Ring",--2%
		ring2="Kishar Ring",--4%
		back=gear.Taranus_FC, --10%
		waist="Witful Belt", --3%
	}

  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {ammo="Staunch Tathlum +1",back="Swith Cape +1",waist="Siegel Sash",})
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

  sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		ear1="Barkaro. Earring",
		waist="Channeler's stone",
	})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		back="Pahtli Cape",
		feet="Vanya clogs",
	})

  sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

	sets.precast.FC.Death = {
		ammo="Strobilus",
		head="Amalric Coif +1",
		body="Shango Robe",
		hands=gear.Merlinic_FC_hands,
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Barkaro. Earring",
		right_ear="Etiolation Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Mephitas's Ring",
		back=gear.Taranus_FC,
		}

  -- Weaponskill sets
  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
		ammo="Dosis Tathlum",
		head="Hagondes Hat +1",
		neck="Baetyl Pendant",
		ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Taranus's Cape",
		waist="Fotia Belt",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
	}

  -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
  sets.precast.WS['Vidohunir'] = {
		ammo="Dosis Tathlum",
		head="Hagondes Hat +1",
		neck="Baetyl Pendant",
		ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Zendik Robe",
		hands="Hagondes Cuffs +1",
		ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Taranus's Cape",
		waist="Fotia Belt",
		legs="Hagondes Pants +1",
		feet=gear.merlinic_nuke_feet,
	}

  sets.precast.WS['Myrkr'] = {
		ammo="Staunch Tathlum",
		head="Pixie Hairpin +1",
		neck="Sanctity Necklace",
		ear1="Gifted Earring",ear2="Etiolation Earring",
		body="Amalric Doublet",
		hands="Telchine Gloves",
		ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Taranus's Cape",
		waist="Yamabuki-no-Obi",
		legs="Psycloth Lappas",
		feet="Medium's Sabots"
	}


  ---- Midcast Sets ----

  sets.midcast.FastRecast = {
		head="Merlinic Hood",
		ear2="Loquacious Earring",
		ring1="Prolix Ring",
		ring2="Lebeche ring",
		back=gear.Taranus_FC,
		waist="Witful Belt",
	}

  sets.midcast.Cure = {
		head="Vanya Hood",
		body="Vanya Robe",
		hands="Telchine Gloves",
		legs="Vanya Slops",
		feet="Vanya Clogs",
		neck="Incanter's Torque",
		waist="Gishdubar Sash",
		left_ring="Ephedra Ring",
		right_ring="Lebeche Ring",
		back="Solemnity Cape",
	}

  sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure,{back="Twilight Cape",waist="Hachirin-no-Obi",})
	--Cureset for if it's not light weather but is light day.
  sets.midcast.LightDayCure = sets.midcast.LightWeatherCure
  sets.midcast.Curaga = sets.midcast.Cure
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",ring1="Haoma's Ring",ring2="Haoma's Ring"})
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Enhancing Magic'] = {
	}
	sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'],{
			head="Telchine Cap",
			body="Telchine Chas.",
			hands="Telchine Gloves",
			legs="Telchine Braconi",
			feet="Telchine Pigaches",
			neck="Incanter's Torque",
			back="Perimede Cape",
	})

  sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash"})
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1",hands="Regal Cuffs",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
  sets.midcast['Enfeebling Magic'] = {
		ammo="Pemphredo Tathlum",
		head=gear.Merlinic_MACC_head,
		body="Spaekona's Coat +3",
		hands="Spae. Gloves +3",
		legs=gear.Merlinic_MACC_legs,
		feet=gear.Merlinic_MACC_feet,neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Barkaro. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Kishar Ring",
		back=gear.Taranus_MATT_INT,
	}

  sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'],{})

  sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif +1",waist="Acuity Belt +1"})
  sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif +1",waist="Acuity Belt +1"})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif +1",ear1="Barkaro. Earring",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif +1",ear1="Barkaro. Earring",waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

  sets.midcast['Dark Magic'] = {
		ammo="Impatiens",
		head=gear.Merlinic_MACC_head,
		body=gear.Merlinic_MACC_body,
		hands="Spae. Gloves +3",
		legs=gear.Merlinic_MACC_legs,
		feet=gear.Merlinic_MACC_feet,
		neck="Erra Pendant",
		waist="Eschan Stone",
		ear1="Barkarole Earring",
		ear2="Regal Earring",
		ring1="Kishar Ring",
		ring2="Evanescence Ring",
		back=gear.Taranus_MATT_INT,
	}

  sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{
		head="Pixie Hairpin +1",
		waist="Fucho-no-Obi",
		feet="Merlinic Crackows",
	})

  sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Aspir.Death = {
		main=gear.grioavolr_nuke_staff,
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
		neck="Erra Pendant",
		ear1="Barkaro. Earring",ear2="Regal Earring",
    body=gear.merlinic_nuke_body,
		hands="Amalric Gages",
		ring1="Evanescence Ring",ring2="Archon Ring",
    back="Taranus's Cape",
		waist="Fucho-no-obi",
		legs="Merlinic Shalwar",
		feet=gear.merlinic_aspir_feet
		}

	sets.midcast.Death = {
		ammo="Strobilus",
		head="Pixie Hairpin +1",
		body="Amalric Doublet +1",  --6% II
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Mizu. Kubikazari",    --10%
		waist="Eschan Stone",
		ear1="Barkaro. Earring",
		ear2="Static Earring",      --5%
		ring1="Mephitas's Ring +1",
		ring2="Archon Ring",
		back=gear.Taranus_MATT_MP,  --5 %
	}

  sets.midcast.Stun = {
		ammo="Pemphredo Tathlum",
		head=gear.Merlinic_MACC_head,
		body="Spaekona's Coat +3",
		hands="Spae. Gloves +3",
		legs=gear.Merlinic_MACC_legs,
		feet="Jhakri Pigaches +2",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Barkaro. Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		waist="Luminary Sash",
		back=gear.Taranus_MATT_INT,
	}

  sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun,{})

  sets.midcast.BardSong = {}

	sets.midcast.Impact = {
		main="Oranyan",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head=empty,
		neck="Erra Pendant",
		ear1="Barkaro. Earring",ear2="Regal Earring",
		body="Twilight Cloak",
		--hands="Regal Cuffs",
		hands="Spae. Gloves +3",
		ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back=gear.Taranus_MATT_INT,
		waist="Acuity Belt +1",
		legs="Hagondes Pants +1",
		feet=gear.merlinic_aspir_feet,
	}

  -- Elemental Magic sets

  sets.midcast['Elemental Magic'] = {
		ammo="Pemphredo Tathlum",
		head="Amalric Coif +1",
		body="Amalric Doublet +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Saevus Pendant +1",
		waist="Refoccilation Stone",
		left_ear="Friomisi Earring",
		right_ear="Barkaro. Earring",
		left_ring="Shiva Ring +1",
		right_ring="Shiva Ring +1",
		back=gear.Taranus_MATT_INT,
	}

  sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
		--neck="Erra Pendant",
		--body="Spaekona's Coat +3",
		hands="Spae. Gloves +3",
		left_ear="Regal Earring",
	})

  sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'],{})

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].Resistant.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].Fodder.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant

	-- Minimal damage gear, maximum recast gear for procs.
  sets.midcast['Elemental Magic'].Proc = {}

	sets.midcast['Elemental Magic'].OccAcumen = set_combine(sets.midcast['Elemental Magic'],{
		ammo="Seraphic Ampulla",
		head="Welkin Crown",
		body="Spaekona's Coat +3",
		hands=gear.Merlinic_OA_hands,
		legs="Perdition Slops",
		feet=gear.Merlinic_OA_feet,
		neck="Lissome Necklace",
		waist="Oneiros Rope",
		left_ear="Digni. Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring",
		right_ring="Petrov Ring",
		back=gear.Taranus_STP,
	})
  -- Sets to return to when not performing an action.

  -- Resting sets
  sets.resting = {}

  -- Idle sets

  -- Normal refresh idle set
  sets.idle = {
		--main={name="Lathi",priority=0},
		--sub={name="Enki Strap",priority=15},
		ammo="Staunch Tathlum +1",
		head="Befouled crown",
		neck="Loricate Torque +1",
		ear1="Etiolation earring",
		ear2="Infused Earring",
		body="Shamash robe",
		hands="Spae. Gloves +3",
		ring1="Defending Ring",
		ring2="Vocane Ring",
		back="Moonlight Cape",
		waist="Ninurta's sash",
		legs="Assiduity Pants +1",
		feet="Jhakri Pigaches +2",
	}

  -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
  sets.idle.PDT = set_combine(sets.idle,{})
  sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque"})
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {})

	sets.idle.Death = {
		ammo="Strobilus",
		head="Befouled Crown",
		body="Shamash Robe",
		hands="Spae. Gloves +3",
		legs="Assid. Pants +1",
		feet="Telchine Pigaches",
		neck="Sanctity Necklace",
		waist="Fucho-no-Obi",
		left_ear="Barkaro. Earring",
		right_ear="Etiolation Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Mephitas's Ring",
		back={ name="Bane Cape", augments={'Elem. magic skill +6','Dark magic skill +3','"Mag.Atk.Bns."+1','"Fast Cast"+3',}},
	}
	-- not sure what I want to do with this '~yet'
  sets.idle.Weak = {}

  -- Defense sets

  sets.defense.PDT = {}
  sets.defense.MDT = {}
  sets.defense.MEVA = {}

	sets.Kiting = {feet="Herald's Gaiters"}
	--sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
  sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.ElementalObi = {
		waist="Hachirin-No-Obi"
	}
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.

	sets.HPDown = {
		head="Pixie Hairpin +1",
		ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",
		legs="Shedir Seraweels",
		feet="Jhakri Pigaches +2",
	}

	sets.HPCure = {
		ammo="Hasty Pinion +1",
		head="Blistering Sallet +1",
		neck="Nodens Gorget",
		ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Vrikodara Jupon",
		hands="Telchine Gloves",
		ring1="Kunaji Ring",ring2="Meridian Ring",
		back="Tempered Cape +1",
		waist="Witful Belt",
		legs="Psycloth Lappas",
		feet="Vanya Clogs",
	}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
  sets.buff['Mana Wall'] = {back="Taranus's Cape",feet="Wicce Sabots +1"}

	-- Gear that converts elemental damage done to recover MP.
	sets.RecoverMP = {
			body="Spaekona's Coat +3",
			left_ear="Regal Earring",
	}
	-- Gear for Magic Burst mode.
  sets.MagicBurst = {
		ammo="Pemphredo Tathlum",
		head="Ea Hat +1",             -- 7 / 7
		body="Ea Houppe. +1",         -- 9 / 9
		hands="Amalric Gages +1",     -- 6 II
		legs="Ea Slops +1",           -- 8 / 8
		feet="Ea Pigaches +1",        -- 5 / 5
		neck="Mizu. Kubikazari",      --10%
		ear1="Barkaro. Earring",
		ear2="Friomisi Earring",
		ring1="Mujin Band",           -- %5 II
		ring2="Shiva Ring +1",
		waist="Refoccilation Stone",
		back=gear.Taranus_MATT_INT,   --5%
	}
	sets.RecoverBurst = set_combine(sets.MagicBurst,{
		body="Spaekona's Coat +3",
		left_ear="Regal Earring",
	})

	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.element.Earth = {}

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- Normal melee group
  sets.engaged = {
		ammo="Amar Cluster",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Asperity Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Digni. Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring",
		right_ring="Petrov Ring",
		back="Kayapa Cape",
	}

	sets.engaged.ACC = set_combine(sets.engaged,{
		neck="Sanctity necklace",
  })

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 7)
end

function user_job_precast(spell, spellMap, eventArgs)
	if spell.english == "Impact" then
		local abil_recasts = windower.ffxi.get_ability_recasts()

		if abil_recasts[35] == 0 and not buffactive['amnesia'] then
			cancel_spell()
			send_command('@input /ja "Manawell" <me>;wait 1;input /ma Impact '..spell.target.raw..'')
			return
		end
	end
end
