-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function character_user_job_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal','Resistant','Proc','OccultAcumen','9k')
    state.IdleMode:options('Normal','PDT')
	state.HybridMode:options('Normal','PDT')
	state.Weapons:options('None','Mpaca','Bunzi','Maxentius')
	
	default_weapons = 'Maxentius'
	
	autows_list = {['Maxentius']='Black Halo'}

	gear.nuke_jse_back = {name="Lugh's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	
		-- Additional local binds
	send_command('bind @` gs c cycle ElementalMode')
	send_command('bind ^` gs c scholar dark')
	send_command('bind !` gs c scholar light')
	send_command('bind !backspace gs c scholar speed')
	send_command('bind ^backspace gs c scholar power')
	send_command('bind @backspace gs c scholar cost')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise III" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	-- Weapons sets
	sets.weapons.Mpaca = {main="Mpaca's Staff",sub="Clerisy Strap +1"}
	sets.weapons.Bunzi = {main="Bunzi's Rod",sub="Ammurapi Shield"}
	sets.weapons.Maxentius = {main="Maxentius",sub="Ammurapi Shield"}

    -- Precast Sets

    -- Precast Sets

    sets.precast.JA['Tabula Rasa'] = {} --legs="Peda. Pants +1"
	sets.precast.JA['Enlightenment'] = {body="Peda. Gown +1"} 

    -- Fast cast sets for spells
    sets.precast.FC = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
        head=gear.merlinic_fc_head,neck="Orunmila's Torque",ear1="Malignance Earring",ear2="Loquac. Earring",
        body="Pinga Tunic",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Perimede Cape",waist="Witful Belt",legs="Pinga Pants",feet=gear.merlinic_fc_feet}
		
    sets.precast.FC.DT = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
        head=gear.merlinic_fc_head,neck="Orunmila's Torque",ear1="Malignance Earring",ear2="Loquac. Earring",
        body="Pinga Tunic",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Perimede Cape",waist="Witful Belt",legs="Pinga Pants",feet=gear.merlinic_fc_feet}
		
	sets.precast.FC.Arts = {feet="Acad. Loafers +3"}
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Crepuscular Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Crepuscular Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	
	sets.precast.WS = {ammo="Oshasha's Treatise",
		head="Nyame Helm",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Cornelia's Ring",
		back="Null Shawl",waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	
    sets.precast.WS['Myrkr'] = {ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Moonshade Earring",
		body="Arbatel Gown +3",hands="Nyame Gauntlets",ring1="Mephitas's Ring +1",ring2="Metamor. Ring +1",
		back="Pahtli Cape",waist="Luminary Sash",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}

    -- Midcast Sets

    sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Pemphredo Tathlum",
        head=gear.merlinic_fc_head,neck="Orunmila's Torque",ear1="Malignance Earring",ear2="Loquac. Earring",
        body="Pinga Tunic",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Solemnity Cape",waist="Cornelia's Belt",legs="Pinga Pants",feet=gear.merlinic_fc_feet}
		
	sets.midcast.Cure = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo="Pemphredo Tathlum",
        head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
        body="Pinga Tunic",hands=gear.chironic_nuke_hands,ring1="Sirona's Ring",ring2="Menelaus's Ring",
        back="Solemnity Cape",waist="Luminary Sash",legs="Pinga Pants",feet="Vanya Clogs"}
		
    sets.midcast.LightWeatherCure = {main="Chatoyant Staff",sub="Curatio Grip",range=empty,ammo="Pemphredo Tathlum",
        head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
        body="Pinga Tunic",hands=gear.chironic_nuke_hands,ring1="Sirona's Ring",ring2="Menelaus's Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Pinga Pants",feet="Vanya Clogs"}
		
    sets.midcast.LightDayCure = {main="Chatoyant Staff",sub="Curatio Grip",range=empty,ammo="Pemphredo Tathlum",
        head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
        body="Pinga Tunic",hands=gear.chironic_nuke_hands,ring1="Sirona's Ring",ring2="Menelaus's Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs=gear.chironic_macc_legs,feet="Vanya Clogs"}

    sets.midcast.Curaga = sets.midcast.Cure

	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
	
	sets.midcast.Cursna = {main=gear.grioavolr_fc_staff,sub="Curatio Grip",range=empty,ammo="Hasty Pinion +1",
        head="Vanya Hood",neck="Debilis Medallion",ear1="Malignance Earring",ear2="Meili Earring",
        body="Pinga Tunic",hands="Hieros Mittens",ring1="Haoma's Ring",ring2="Menelaus's Ring",
        back="Oretan. Cape +1",waist="Bishop's Sash",legs="Pinga Pants",feet="Vanya Clogs"}
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi Shield",ammo="Savant's Treatise",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Perimede Cape",waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga",head="Arbatel Bonnet +3",back="Bookworm's Cape"})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",waist="Siegel Sash"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif +1",waist="Emphatikos Rope"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes

	sets.midcast['Enfeebling Magic'] = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Null Loop",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Kishar Ring",ring2="Stikini Ring +1",
        back="Null Shawl",waist="Obstinate Sash",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
	
	sets.midcast['Enfeebling Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Null Loop",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = sets.midcast['Enfeebling Magic']
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring2="Stikini Ring +1",feet=gear.chironic_nuke_feet})

    sets.midcast['Dark Magic'] = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Null Loop",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}

    sets.midcast.Kaustra = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Saevus Pendant +1",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
		
    sets.midcast.Kaustra.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Null Loop",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}

    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands=gear.chironic_aspir_gloves,ring1="Evanescence Ring",ring2="Stikini Ring +1",
        back="Null Shawl",waist="Fucho-no-obi",legs=gear.chironic_aspir_legs,feet="Arbatel Loafers +3"}
		
    sets.midcast.Drain.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Null Loop",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

    sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
        head="Amalric Coif +1",neck="Orunmila's Torque",ear1="Malignance Earring",ear2="Loquac. Earring",
        body="Volte Doublet",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Perimede Cape",waist="Cornelia's Belt",legs="Artsieq Hose",feet="Regal Pumps +1"}

    sets.midcast.Stun.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Null Loop",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}

    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {main="Bunzi's Rod",sub="Culminus",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Saevus Pendant +1",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Sacro Cord",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
		
    sets.midcast['Elemental Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Null Loop",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
		
    sets.midcast['Elemental Magic']['9k'] = {main="Maxentius",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Null Masque",neck="Null Loop",ear1="Crep. Earring",ear2="Gwati Earring",
        body="Volte Doublet",hands="Volte Bracers",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet="Arbatel Loafers +3"}
		
    sets.midcast['Elemental Magic'].Proc = {main="Mafic Cudgel",sub="Genmei Shield",ammo="Impatiens",
        head="Null Masque",neck="Null Loop",ear1="Etiolation Earring",ear2="Loquac. Earring",
        body="Volte Doublet",hands="Volte Bracers",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet="Medium's Sabots"}
		
    sets.midcast['Elemental Magic'].OccultAcumen = {}
	
		
    -- Custom refinements for certain nuke tiers
	sets.midcast['Elemental Magic'].HighTierNuke = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Sibyl Scarf",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
		
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Null Loop",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}

	sets.midcast.Helix = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Sibyl Scarf",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
        back="Bookworm's Cape",waist="Acuity Belt +1",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
	
	sets.midcast.Helix.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +3",neck="Null Loop",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
		
	sets.midcast.Helix.Proc = {main=empty, sub=empty,ammo="Impatiens",
        head="Vanya Hood",neck="Orunmila's Torque",ear1="Etiolation Earring",ear2="Loquac. Earring",
        body="Volte Doublet",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

	sets.midcast.Impact = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head=empty,neck="Null Loop",ear1="Malignance Earring",ear2="Arbatel Earring +2",
        body="Crepuscular Cloak",hands="Arbatel Bracers +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
		
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Crepuscular Cloak"})

	-- Gear for Magic Burst mode.
    sets.MagicBurst = {main="Bunzi's Rod",sub="Ammurapi Shield",neck="Mizukage-no-Kubikazari",ring2="Mujin Band"}
    sets.HelixBurst = {main="Bunzi's Rod",sub="Ammurapi Shield",neck="Mizukage-no-Kubikazari",ring2="Mujin Band"}
    sets.ResistantHelixBurst = {main="Bunzi's Rod",sub="Ammurapi Shield",neck="Mizukage-no-Kubikazari",ring2="Mujin Band"}
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {} --body="Seidr Cotehardie"
	
	-- Gear for specific elemental nukes.
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
		
    -- Sets to return to when not performing an action.

     -- Resting sets
    sets.resting = {main="Mpaca's Staff",sub="Oneiros Grip",ammo="Homiliary",
		head="Null Masque",neck="Sibyl Scarf",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Arbatel Gown +3",hands=gear.chironic_refresh_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.merlinic_refresh_legs,feet=gear.merlinic_refresh_feet}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {main="Mpaca's Staff",sub="Oneiros Grip",ammo="Homiliary",
		head="Null Masque",neck="Sibyl Scarf",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Arbatel Gown +3",hands=gear.chironic_refresh_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.merlinic_refresh_legs,feet=gear.merlinic_refresh_feet}

    sets.idle.PDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Shadow Mantle",waist="Plat. Mog. Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.idle.MDT = {main="Daybreak",sub="Genmei Shield",range=empty,ammo="Staunch Tathlum +1",
		head="Arbatel Bonnet +3",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
		
	sets.idle.MEVA = {main="Daybreak",sub="Genmei Shield",range=empty,ammo="Staunch Tathlum +1",
		head="Arbatel Bonnet +3",neck="Null Loop",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
		
    -- Defense sets

    sets.defense.PDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Shadow Mantle",waist="Plat. Mog. Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.defense.MDT = {main="Daybreak",sub="Genmei Shield",range=empty,ammo="Staunch Tathlum +1",
		head="Arbatel Bonnet +3",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
		
    sets.defense.MEVA = {main="Daybreak",sub="Genmei Shield",range=empty,ammo="Staunch Tathlum +1",
		head="Arbatel Bonnet +3",neck="Null Loop",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Arbatel Gown +3",hands="Arbatel Bracers +3",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Arbatel Pants +3",feet="Arbatel Loafers +3"}
		
    sets.Kiting = {ring2="Shneddick Ring"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}

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
		
    sets.engaged.Acc = {main="Maxentius",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Null Loop",ear1="Crep. Earring",ear2="Telos Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +3"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +3"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +3"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +3"}
    sets.buff['Penury'] = {legs="Arbatel Pants +3"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +3"}
	sets.buff['Focalization'] = {}
    sets.buff['Celerity'] = {}
    sets.buff['Alacrity'] = {}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +3"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff['Light Arts'] = {} --legs="Academic's Pants +3"
	sets.buff['Dark Arts'] = {} --body="Academic's Gown +3"
    sets.buff.Sublimation = {waist="Embla Sash",ear1="Savant's Earring"}
	sets.buff.DTSublimation = {waist="Embla Sash",ear1="Savant's Earring"}	
	
	sets.HPDown = {main="Mpaca's Staff",sub="Oneiros Grip",ammo="Homiliary",
		head="Wivre Hairpin",neck="Loricate Torque +1",ear1="Hirudinea Earring",ear2="Ethereal Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Mephitas's Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Luminary Sash",legs="Jhakri Slops +1",feet="Jhakri Pigaches +2"}
		
    sets.HPCure = {main="Daybreak",sub="Ammurapi Shield",ammo="Regal Gem",
		head="Nyame Helm",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Bunzi's Robe",hands="Bokwus Gloves",ring1="Sirona's Ring",ring2="Kunaji Ring",
		back="Oretan. Cape +1",waist="Gishdubar Sash",legs="Nyame Flanchard",feet="Medium's Sabots"}
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'RDM' then
		set_macro_page(1, 3)
	elseif player.sub_job == 'BLM' then
		set_macro_page(1, 3)
	elseif player.sub_job == 'WHM' then
		set_macro_page(1, 3)
	else
		set_macro_page(1, 3)
	end
end