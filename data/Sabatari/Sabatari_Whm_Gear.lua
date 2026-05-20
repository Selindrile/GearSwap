-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function character_user_job_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Normal','PDT','MDT','MEVA')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','DualWeapons','Maxentius')
	state.WeaponskillMode:options('Normal','Fodder')
	
	default_weapons = 'Maxentius'
	default_dual_weapons = 'DualWeapons'
	
	autows_list = {['DualWeapons']='Black Halo',['Maxentius']='Black Halo'}

		-- Additional local binds
	send_command('bind @` gs c cycle ElementalMode')
	send_command('bind ^` gs c scholar dark')
	send_command('bind !` gs c scholar light')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind !backspace input /ja "Afflatus Solace" <me>')
	send_command('bind @backspace input /ja "Afflatus Misery" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	
	send_command('bind !numpad0 input /ma Cursna <t>')
	send_command('bind !numpad. input /ja Sacrosanctity <me>')
	send_command('bind !numpad9 input /ja "Divine seal" <me>')
	send_command('bind !numpad3 input /ja Devotion <t>')
	send_command('bind !numpad5 input /ja "Divine Caress" <me>')
	
	send_command('bind ^q input //lua load nostrum')
	send_command('bind !q input //lua unload nostrum')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

	-- Weapons sets
	sets.weapons.Maxentius = {main="Maxentius",sub="Genmei Shield"}
	sets.weapons.DualWeapons = {main="Maxentius",sub="Daybreak"}

    -- Precast Sets
	
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Bliaut +3"}

	-- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Fast cast sets for spells
    sets.precast.FC = {-- current 79 gear + 3 sch
    --  /SCH --3
            main="C. Palug Hammer", --fc 7
			sub="Sors Shield",
			ammo="Incantor Stone", --fc 2
			head="Ebers Cap +2", --fc 10
			body="Inyanga Jubbah +2", --fc 14
			hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','"Cure" spellcasting time -2%',}}, --fc 7
			legs="Aya. Cosciales +2", --fc 6
			feet="Regal Pumps +1", --fc 5-7
			waist="Witful Belt", --fc 3 qc 3
			left_ear="Loquac. Earring", --fc 5
			right_ear="Malignance Earring", --fc 4
			left_ring="Kishar Ring", --fc 4
			right_ring="Lebeche Ring", --qc 2
			back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+1','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --fc 10
        }
		
    sets.precast.FC.DT = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
		head="Bunzi's Hat",neck="Clr. Torque +1",ear1="Loquac. Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Aya. Cosciales +2",feet="Regal Pumps +1"}

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pant. +2"})
    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.CureSolace = sets.precast.FC.Cure
	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty,body="Crepuscular Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}

    sets.precast.WS['Flash Nova'] = {}
    sets.precast.WS['Mystic Boon'] = {}
		
	sets.MaxTP = {}
	sets.MaxTP.Myrkr = {}
	sets.MaxTP.Dagan = {}

	-- Midcast Sets
    sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Pemphredo Tathlum",
		head="Ebers Cap +3",neck="Clr. Torque +1",ear1="Loquac. Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Defending Ring",ring2="Freke Ring",
		back="Alaunus's Cape",waist="Cornelia's Belt",legs="Aya. Cosciales +2",feet="Regal Pumps +1"}
		
	sets.midcast.Raise = sets.midcast.FastRecast

    -- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	sets.midcast.Cure = {
			main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
			sub="Sors Shield",
			head="Ebers Cap +2",
			body="Ebers Bliaut +2",
			hands="Theophany Mitts +2",
			legs="Ebers Pant. +2",
			right_ring="Lebeche Ring",
			left_ear="Nourish. Earring",
			right_ear="Orison Earring",
      }
		
	sets.midcast.CureSolace = {
			main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
			sub="Sors Shield",
			head="Ebers Cap +2",
			body="Ebers Bliaut +2",
			hands="Theophany Mitts +2",
			legs="Ebers Pant. +2",
			right_ring="Lebeche Ring",
			left_ear="Nourish. Earring",
			right_ear="Orison Earring",
      }

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {
			main="Chatoyant Staff",

        })

	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.Cure, {
			main="Chatoyant Staff",

        })
		
	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.Cure, {
			main="Chatoyant Staff",

        })
	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {
			main="Chatoyant Staff",

        })

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
			body="Theo. Bliaut +3",

        })
		
	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.Cure, {
			main="Chatoyant Staff",
			body="Theo. Bliaut +3",

        })
		
	sets.midcast.LightDayCuraga = set_combine(sets.midcast.Cure, {
			main="Chatoyant Staff",
			body="Theo. Bliaut +3",

        })

	sets.midcast.Cure.DT = {main="Daybreak",sub="Culminus",range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck="Loricate Torque +1",ear1="Mendi. Earring",ear2="Glorious Earring",
		body="Bunzi's Robe",hands=gear.chironic_aspir_gloves,ring1="Defending Ring",ring2="Freke Ring",
		back="Alaunus's Cape",waist="Emphatikos Rope",legs="Ebers Pant. +2",feet="Theo. Duckbills +3"}
		
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = {}
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaut +3",back="Alaunus's Cape",})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {back="Twilight Cape",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaut +3",back="Alaunus's Cape",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaut +3",back="Twilight Cape",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {back="Twilight Cape",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {back="Twilight Cape",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {back="Twilight Cape",waist="Hachirin-no-Obi"})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +3"})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +3",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +3",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +3"})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +3",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +3",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	
	--Situational Healing Sets
	sets.Self_Healing = {neck="Phalaina Locket",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",waist="Gishdubar Sash"}

	sets.midcast.Cursna = {
			body="Ebers Bliaut +2",
			legs="Theo. Pant. +1",}

	sets.midcast.StatusRemoval = {}
		
	sets.midcast.StatusRemoval.DT = {main="Daybreak",sub="Genmei Shield",range=empty,ammo="Staunch Tathlum +1",
		head="Ebers Cap +3",neck="Loricate Torque +1",ear1="Sanare Earring",ear2="Halasz Earring",
		body="Bunzi's Robe",hands=gear.chironic_aspir_gloves,ring1="Defending Ring",ring2="Freke Ring",
		back="Alaunus's Cape",waist="Emphatikos Rope",legs="Bunzi's Pants",feet="Theo. Duckbills +3"}

	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Clr. Torque +1"})
	sets.midcast.Erase.DT = set_combine(sets.midcast.StatusRemoval.DT, {neck="Clr. Torque +1"})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {
			sub='Ammurapi shield',
			head="Befouled Crown", --16
			hands="Inyan. Dastanas +2", --20
			waist="Olympus Sash", --5
			legs="Piety Pantaln. +3", --26
			feet="Ebers Duckbills +2", --30
			back={ name="Mending Cape", augments={'Healing magic skill +6','Enha.mag. skill +7','Mag. Acc.+9','"Cure" potency +3%',}}, 

        } --Total 78


	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {			
			neck='Nodens Gorget',
			legs='Doyen pants',
			waist='Siegel Sash',
			left_ear="Earthcry Earring",
			})
		
	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +2",})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Ammurapi Shield",head=gear.chironic_nuke_head,waist="Emphatikos Rope"})
	
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
			main="Bolelabunga",
			sub="Ammurapi Shield",
			body="Piety Bliaut +3",
			hands="Ebers Mitts +2",			
			head="Inyanga Tiara +2",
			legs="Theo. Pant. +1",
			})
			
	sets.midcast.Regen.Duration = set_combine(sets.midcast['Enhancing Magic'], {			
			sub='Ammurapi shield',
			hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +8',}},
			legs={ name="Telchine Braconi", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +10',}},
			feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}
			},})
			
	sets.midcast.Regen.Potency = {head="Inyanga Tiara +2"}
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {
			sub='Ammurapi shield',
			hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +8',}},
			legs={ name="Telchine Braconi", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +10',}},
			feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {
			ring2="Sheltered Ring",
			sub='Ammurapi shield',
			hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +8',}},
			legs={ name="Telchine Braconi", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +10',}},
			feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {
			ring2="Sheltered Ring",
			sub='Ammurapi shield',
			hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +8',}},
			legs={ name="Telchine Braconi", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +10',}},
			feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {
			ring2="Sheltered Ring",
			sub='Ammurapi shield',
			hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +8',}},
			legs={ name="Telchine Braconi", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +10',}},
			feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
})
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
		head="Ebers Cap +2",
		body="Ebers Bliaut +2",
		hands="Ebers Mitts +2",
		legs="Piety Pantaln. +3",
		})
	
	sets.midcast.BarStatus = set_combine(sets.midcast['Enhancing Magic'], {neck="Sroda Necklace"})

	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
	sets.Refresh_Received = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}

	sets.midcast.Impact = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=empty,neck="Null Loop",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Crepuscular Cloak",hands="Ebers Mitts +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Ebers Pant. +3",feet="Ebers Duckbills +3"}
		
	sets.midcast['Elemental Magic'] = {main="Bunzi's Rod",sub="Culminus",ammo="Ghastly Tathlum +1",
		head="Bunzi's Hat",neck="Saevus Pendant +1",ear1="Friomisi Earring",ear2="Malignance Earring",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Sacro Cord",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	sets.midcast['Elemental Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="Bunzi's Hat",neck="Null Loop",ear1="Friomisi Earring",ear2="Malignance Earring",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}
		
	sets.midcast['Divine Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Ebers Cap +3",neck="Null Loop",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Ebers Bliaut +3",hands="Ebers Mitts +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Ebers Pant. +3",feet="Ebers Duckbills +3"}
		
	sets.midcast.Repose = {
			main="Daybreak",
			sub="Ammurapi Shield",
			ammo="Hydrocera",
			head="Inyanga Tiara +2",
			body="Theo. Bliaut +3",
			hands="Inyan. Dastanas +2",
			legs="Aya. Cosciales +2",
			feet="Inyan. Crackows +2",
			neck="Clr. Torque +1",
			waist="Rumination Sash",
			left_ear="Crep. Earring",
			right_ear="Malignance Earring",
			left_ring="Crepuscular Ring",
			right_ring="Kishar Ring",
			back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+1','"Fast Cast"+10','Phys. dmg. taken-10%',}},
				}
		
	sets.midcast.Holy = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="C. Palug Crown",neck="Saevus Pendant +1",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Shamash Robe",hands="Bunzi's Gloves",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Sacro Cord",legs="Bunzi's Pants",feet="Bunzi's Sabots"}
		
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {neck="Mizu. Kubikazari",body="Bunzi's Robe",hands="Bunzi's Gloves",ring2="Mujin Band",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	sets.midcast['Dark Magic'] = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Ebers Cap +3",neck="Null Loop",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Ebers Bliaut +3",hands="Ebers Mitts +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Ebers Pant. +3",feet="Ebers Duckbills +3"}

    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Ebers Bliaut +3",hands=gear.chironic_aspir_gloves,ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_aspir_legs,feet="Ebers Duckbills +3"}

    sets.midcast.Drain.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Ebers Cap +3",neck="Null Loop",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Ebers Bliaut +3",hands="Ebers Mitts +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Ebers Pant. +3",feet="Ebers Duckbills +3"}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Bunzi's Hat",neck="Clr. Torque +1",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Alaunus's Cape",waist="Embla Sash",legs="Aya. Cosciales +2",feet="Regal Pumps +1"}

	sets.midcast.Stun.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Ebers Cap +3",neck="Null Loop",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Ebers Bliaut +3",hands="Ebers Mitts +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Ebers Pant. +3",feet="Ebers Duckbills +3"}
		
	sets.midcast.Dispel = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Ebers Cap +3",neck="Null Loop",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Ebers Bliaut +3",hands="Ebers Mitts +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Ebers Pant. +3",feet="Ebers Duckbills +3"}
		
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {main="Daybreak",sub="Ammurapi Shield"})

	sets.midcast['Enfeebling Magic'] = {
			main="Daybreak",
			sub="Ammurapi Shield",
			ammo="Hydrocera",
			head="Inyanga Tiara +2",
			body="Theo. Bliaut +3",
			hands="Inyan. Dastanas +2",
			legs="Aya. Cosciales +2",
			feet="Inyan. Crackows +2",
			neck="Clr. Torque +1",
			waist="Rumination Sash",
			left_ear="Crep. Earring",
			right_ear="Malignance Earring",
			left_ring="Crepuscular Ring",
			right_ring="Kishar Ring",
			back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+1','"Fast Cast"+10','Phys. dmg. taken-10%',}},
				}

	sets.midcast['Enfeebling Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Ebers Cap +3",neck="Null Loop",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Ebers Bliaut +3",hands="Ebers Mitts +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet="Ebers Duckbills +3"}
		
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {ammo="Per. Lucky Egg",feet=gear.chironic_treasure_feet})
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    -- Sets to return to when not performing an action.

    -- Resting sets
	sets.resting = {main="Mpaca's Staff",sub="Oneiros Grip",ammo="Homiliary",
		head="Null Masque",neck="Sibyl Scarf",ear1="Sanare Earring",ear2="Ethereal Earring",
		body="Ebers Bliaut +3",hands=gear.chironic_refresh_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
			main="Daybreak",
			sub="Ammurapi Shield",
			ammo="Homiliary",
			head="Inyanga Tiara +2",
			body="Ebers Bliaut +2",
			hands="Inyan. Dastanas +2",
			legs={ name="Chironic Hose", augments={'AGI+5','MND+2','"Refresh"+2','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
			feet="Inyan. Crackows +2",
			neck="Loricate Torque +1",
			waist="Rumination Sash",
			left_ear="Eabani Earring",
			right_ear="Etiolation Earring",
			left_ring="Inyanga Ring",
			right_ring="Defending Ring",
			back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+1','"Fast Cast"+10','Phys. dmg. taken-10%',}},
}

	sets.idle.PDT = {
		hands="Ebers mitts +2", --10/10
		legs="Ebers Pant. +2", --12/12
		feet="Ebers Duckbills +2", --10/10
		right_ring="Defending Ring", --10/10
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+1','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10/0

   }
		
	sets.idle.MDT = {
		hands="Ebers mitts +2", --10/10
		legs="Ebers Pant. +2", --12/12
		feet="Ebers Duckbills +2", --10/10
		right_ring="Defending Ring", --10/10
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+1','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10/0

   }
		
	sets.idle.MEVA = {
		hands="Ebers mitts +2", --10/10
		legs="Ebers Pant. +2", --12/12
		feet="Ebers Duckbills +2", --10/10
		right_ring="Defending Ring", --10/10
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+1','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10/0

   }
		
	-- Situational Idle sets
    sets.Kiting = {ring2="Shneddick Ring"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Defense sets

	sets.defense.PDT = {hands="Ebers mitts +2", --10/10
		legs="Ebers Pant. +2", --12/12
		feet="Ebers Duckbills +2", --10/10
		right_ring="Defending Ring", --10/10
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+1','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10/0

   }

	sets.defense.MDT = {hands="Ebers mitts +2", --10/10
		legs="Ebers Pant. +2", --12/12
		feet="Ebers Duckbills +2", --10/10
		right_ring="Defending Ring", --10/10
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+1','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10/0

   }

    sets.defense.MEVA = {hands="Ebers mitts +2", --10/10
		legs="Ebers Pant. +2", --12/12
		feet="Ebers Duckbills +2", --10/10
		right_ring="Defending Ring", --10/10
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+1','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10/0

   }
		
		-- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
			main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
			sub="Sors Shield",
			ammo="Homiliary",
			head="Befouled Crown",
			body="Ebers Bliaut +2",
			hands="Inyan. Dastanas +2",
			legs="Assid. Pants +1",
			feet="Inyan. Crackows +2",
			neck="Clr. Torque +1",
			waist="Rumination Sash",
			left_ear="Eabani Earring",
			right_ear="Etiolation Earring",
			left_ring="Inyanga Ring",
			right_ring="Defending Ring",
			back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+1','"Fast Cast"+10','Phys. dmg. taken-10%',}},
}
		
    sets.engaged.Acc = {}

	sets.engaged.DW = {}

    sets.engaged.DW.Acc = {}

		-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +2", back="Mending Cape"}
	sets.buff['Divine Caress'] = {hands="Ebers Mitts +2", back="Mending Cape"}
    sets.buff['Devotion'] = {head="Piety Cap +3"}
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}

	sets.HPDown = {main="Queller Rod",sub="Genmei Shield",ammo="Homiliary",
		head="Pixie Hairpin +1",neck="Loricate Torque +1",ear1="Hirudinea Earring",ear2="Ethereal Earring",
		body="Councilor's Garb",hands="Hieros Mittens",ring1="Defending Ring",ring2="Persis Ring",
		back="Null Shawl",waist="Null Belt",legs="",feet=""}

	sets.HPCure = {main="Queller Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Ebers Cap +3",neck="Nodens Gorget",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Ebers Bliaut +3",hands="Bokwus Gloves",ring1="Sirona's Ring",ring2="Lebeche Ring",
		back="Twilight Cape",waist="Eschan Stone",legs="Piety Pantaln. +3",feet="Ebers Duckbills +3"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 3)
end

function user_job_buff_change(buff, gain)
	if buff:startswith('Addendum: ') or buff:endswith(' Arts') then
		style_lock = true
	end
end

function user_job_lockstyle()
	if player.sub_job == 'SCH' then
		if state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
			windower.chat.input('/lockstyleset 098')
		elseif state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
			windower.chat.input('/lockstyleset 098')
		else
			windower.chat.input('/lockstyleset 098')
		end
	else
		windower.chat.input('/lockstyleset 003')
	end
end