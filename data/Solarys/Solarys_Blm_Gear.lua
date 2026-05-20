function character_user_job_setup()
	-- Options: Override default values
	state.CastingMode:options('Normal','Resistant','Proc','OccultAcumen')
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal')
	state.IdleMode:options('Normal','PDT','MDT','MEVA')
	state.Weapons:options('None','Bunzi','Lathi','Maxentius')
	
	default_weapons = 'Maxentius'
	
	autows_list = {['Maxentius']='Black Halo'}

	gear.nuke_jse_back = {name="Taranus's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}

		-- Additional local binds
	send_command('bind @` gs c cycle ElementalMode')
	send_command('bind ^` gs c scholar dark')
	send_command('bind !` gs c scholar light')
	send_command('bind ^backspace input /ma "Aspir III" <t>')
	send_command('bind !backspace input /ja "Manawell" <me>')
	send_command('bind @backspace gs c scholar cost')
	send_command('bind ^\\\\ gs c scholar speed')
	send_command('bind @\\\\ input /ja "Mana Wall" <me>')
	send_command('bind !\\\\ input /ma "Reraise III" <me>')	
	send_command('bind @f9 gs c cycle DeathMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Weapons sets
	sets.weapons.Maxentius = {main="Maxentius",sub="Ammurapi Shield"}
	sets.weapons.Bunzi = {main="Bunzi's Rod",sub="Ammurapi Shield"}
	sets.weapons.Lathi = {main="Lathi",sub="Niobid Strap"}
	
	sets.buff.Sublimation = {waist="Embla Sash"}
	sets.buff.DTSublimation = {waist="Embla Sash"}	
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Mana Wall'] = {back=gear.nuke_jse_back,feet="Wicce Sabots +3"}
	sets.precast.JA.Manafont = {} --body="Sorcerer's Coat +2"

	-- Fast cast sets for spells
	sets.precast.FC = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
		head=gear.merlinic_fc_head,neck="Orunmila's Torque",ear1="Malignance Earring",ear2="Loquac. Earring",
		body="Volte Doublet",hands="Telchine Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Artsieq Hose",feet=gear.merlinic_fc_feet}
		
	sets.precast.FC.DT = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
		head=gear.merlinic_fc_head,neck="Orunmila's Torque",ear1="Malignance Earring",ear2="Loquac. Earring",
		body="Volte Doublet",hands="Telchine Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Artsieq Hose",feet=gear.merlinic_fc_feet}
		
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris"})
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	sets.precast.FC.Death = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Oshasha's Treatise",
		head="Nyame Helm",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Cornelia's Ring",
		back="Null Shawl",waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.precast.WS['Myrkr'] = {ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Moonshade Earring",
		body="Wicce Coat +3",hands="Nyame Gauntlets",ring1="Mephitas's Ring",ring2="Metamor. Ring +1",
		back="Pahtli Cape",waist="Luminary Sash",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
		
	sets.MaxTPMyrkr = {ear2="Gifted Earring"}
	
	
	---- Midcast Sets ----
	sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
		head="Amalric Coif +1",neck="Orunmila's Torque",ear1="Malignance Earring",ear2="Loquac. Earring",
		body="Volte Doublet",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Cornelia's Belt",legs="Artsieq Hose",feet="Regal Pumps +1"}

	sets.midcast.Cure = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo="Pemphredo Tathlum",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Nyame Mail",hands="Wicce Gloves +3",ring1="Sirona's Ring",ring2="Menelaus's Ring",
		back="Solemnity Cape",waist="Luminary Sash",legs="Nyame Flanchard",feet="Wicce Sabots +3"}

	sets.midcast.MeleeCure = {range=empty,ammo="Pemphredo Tathlum",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Heka's Kalasiris",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Menelaus's Ring",
		back="Solemnity Cape",waist="Luminary Sash",legs="Nyame Flanchard",feet="Vanya Clogs"}		
		
	sets.midcast.LightWeatherCure = {main="Chatoyant Staff",sub="Curatio Grip",ammo="Pemphredo Tathlum",
		head="Vanya Hood",neck="Phalaina Locket",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Heka's Kalasiris",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Menelaus's Ring",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs="Psycloth Lappas",feet="Vanya Clogs"}
		
		--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo="Pemphredo Tathlum",
		head="Vanya Hood",neck="Phalaina Locket",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Heka's Kalasiris",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Menelaus's Ring",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs="Psycloth Lappas",feet="Vanya Clogs"}

	sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.Cursna =  {main=gear.grioavolr_fc_staff,sub="Curatio Grip",range=empty,ammo="Hasty Pinion +1",
		head="Vanya Hood",neck="Debilis Medallion",ear1="Malignance Earring",ear2="Meili Earring",
		body="Volte Doublet",hands="Hieros Mittens",ring1="Haoma's Ring",ring2="Menelaus's Ring",
		back="Oretan. Cape +1",waist="Bishop's Sash",legs="Artsieq Hose",feet="Vanya Clogs"}
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Perimede Cape",waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",waist="Siegel Sash"}) --ear2="Earthcry Earring",legs="Shedir Seraweels"
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif +1",waist="Emphatikos Rope"})--hands="Regal Cuffs",legs="Shedir Seraweels"
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})--legs="Shedir Seraweels"

	sets.midcast['Enfeebling Magic'] = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Null Loop",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Null Loop",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
		
	sets.midcast.ElementalEnfeeble = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Null Loop",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast['Dark Magic'] = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Null Loop",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}

	sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Evanescence Ring",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
		
	sets.midcast.Drain.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Null Loop",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
	
	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant
	
	sets.midcast.Comet = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Null Loop",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
	
	sets.midcast.Stun = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Null Loop",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
		
	sets.midcast.Stun.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Null Loop",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}

	sets.midcast.BardSong = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Null Loop",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}

	sets.midcast.Impact = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=empty,neck="Null Loop",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Crepuscular Cloak",hands="Wicce Gloves +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
		
	-- Elemental Magic sets
	
	sets.midcast['Elemental Magic'] = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Saevus Pendant +1",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
		
	sets.midcast['Elemental Magic'].DT = {main="Bunzi's Rod",sub="Culminus",ammo="Staunch Tathlum +1",
		head="Wicce Petasos +3",neck="Loricate Torque +1",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Defending Ring",ring2="Freke Ring",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
		
	sets.midcast['Elemental Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Null Loop",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
		
	sets.midcast['Elemental Magic'].HighTierNuke = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Sibyl Scarf",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
	
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Wicce Petasos +3",neck="Null Loop",ear1="Malignance Earring",ear2="Wicce Earring +1",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
	
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant
		
		-- Minimal damage gear, maximum recast gear for procs.
	sets.midcast['Elemental Magic'].Proc = {main="Mafic Cudgel",sub="Genmei Shield",ammo="Impatiens",
		head="Null Masque",neck="Null Loop",ear1="Etiolation Earring",ear2="Loquac. Earring",
		body="Volte Doublet",hands="Volte Bracers",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet="Medium's Sabots"}
		
	sets.midcast['Elemental Magic'].OccultAcumen = {}
		
	sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Crepuscular Cloak"})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Spaekona's Coat +2"}

	-- Gear for Magic Burst mode.
	sets.MagicBurst = {main="Bunzi's Rod",sub="Ammurapi Shield",neck="Mizukage-no-Kubikazari",ring2="Mujin Band"}
	sets.ResistantMagicBurst = {main="Bunzi's Rod",sub="Ammurapi Shield",neck="Mizukage-no-Kubikazari",ring2="Mujin Band"}
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main="Mpaca's Staff",sub="Oneiros Grip",ammo="Staunch Tathlum +1",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Etiolation Earring",
		body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Umbra Cape",waist="Carrier's Sash",legs="Assid. Pants +1",feet=gear.merlinic_refresh_feet}

	-- Idle sets
	
	-- Normal refresh idle set
	sets.idle = {main="Mpaca's Staff",sub="Oneiros Grip",ammo="Staunch Tathlum +1",
		head="Null Masque",neck="Sibyl Scarf",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Wicce Coat +3",hands=gear.merlinic_refresh_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Assid. Pants +1",feet=gear.merlinic_refresh_feet}

	-- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
	sets.idle.PDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Shadow Mantle",waist="Plat. Mog. Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.idle.MDT = {main="Daybreak",sub="Ammurapi Shield",ammo="Staunch Tathlum +1",
		head="Wicce Petasos +3",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Lugalbanda Earring",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
		
	sets.idle.MEVA = {main="Daybreak",sub="Ammurapi Shield",ammo="Staunch Tathlum +1",
		head="Wicce Petasos +3",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Lugalbanda Earring",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}

	sets.idle.Death = {}

	-- Defense sets

	sets.defense.PDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Shadow Mantle",waist="Plat. Mog. Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MDT = {main="Daybreak",sub="Ammurapi Shield",ammo="Staunch Tathlum +1",
		head="Wicce Petasos +3",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Lugalbanda Earring",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}
		
	sets.defense.MEVA = {main="Daybreak",sub="Ammurapi Shield",ammo="Staunch Tathlum +1",
		head="Wicce Petasos +3",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Lugalbanda Earring",
		body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Wicce Chausses +3",feet="Wicce Sabots +3"}

	sets.Kiting = {ring2="Shneddick Ring"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {feet=gear.merlinic_refresh_feet}
	sets.NightIdle = {}
	
	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	
	sets.HPDown = {main="Mpaca's Staff",sub="Oneiros Grip",ammo="Staunch Tathlum +1",
		head="Pixie Hairpin +1",neck="Loricate Torque +1",ear1="Hirudinea Earring",ear2="Ethereal Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Mephitas's Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Luminary Sash",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
		
	sets.HPCure = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo="Pemphredo Tathlum",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Nyame Mail",hands="Wicce Gloves +3",ring1="Sirona's Ring",ring2="Menelaus's Ring",
		back="Solemnity Cape",waist="Luminary Sash",legs="Nyame Flanchard",feet="Wicce Sabots +3"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff['Mana Wall'] = {back=gear.nuke_jse_back,feet="Wicce Sabots +3"}
	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {main="Maxentius",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Null Loop",ear1="Brutal Earring",ear2="Dedition Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.engaged.DT = {main="Maxentius",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Null Loop",ear1="Brutal Earring",ear2="Dedition Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}

	-- Treasure Hunter
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {legs=gear.merlinic_treasure_legs})	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	if player.sub_job == 'SCH' then
		set_macro_page(1, 4)
	elseif player.sub_job == 'RDM' then
		set_macro_page(2, 4)
	else
		set_macro_page(3, 4)
	end
end