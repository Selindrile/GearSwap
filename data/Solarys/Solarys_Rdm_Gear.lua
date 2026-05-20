function character_user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Normal','DT')
	state.WeaponskillMode:options('Match','Proc')
	state.CastingMode:options('Normal','Resistant','Proc','SIRD')
    state.IdleMode:options('Normal','PDT','MDT','MEVA','Aminon')
    state.PhysicalDefenseMode:options('PDT','NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.BuffWeaponsMode = M{'Always','Never'}
	state.AutoBuffMode = M{['description'] = 'Auto Buff Mode','Off','Auto','AutoMelee','AutoMage'}
	state.Weapons:options('None','Naegling','Maxentius','Crocea','Tauret','EnspellOnly','DualWeapons','DualWeaponsAcc','DualMaxentius','DualCrocea','DualMaxentiusAcc','DualPrime','DualAeolian','DualEnspellOnly','DualProcSword')
	state.WeaponSets:options('Default','Dual','Proc','Dynamis')

	weapon_sets = {
		['Default'] = {'None','Naegling','Maxentius','Crocea','Tauret','EnspellOnly'},
		['Dual'] = {'DualWeapons','DualWeaponsAcc','DualMaxentius','DualCrocea','DualMaxentiusAcc','DualPrime','DualAeolian','DualEnspellOnly'},
		['Dynamis'] = {'DualCroceaSavageBlade','DualCrocea','DualTauretCrocea','DualAeolian'},
		['Proc'] = {'ProcSword','ProcDagger','DualProcSword','DualProcDagger'},
	}

	default_weapons = 'Naegling'
	default_dual_weapons = 'DualWeapons'

	autows_list =  {['Naegling']='Savage Blade',['Maxentius']='Black Halo',['Crocea']='Sanguine Blade',['Tauret']='Aeolian Edge',['DualWeapons']='Savage Blade',['DualWeaponsAcc']='Savage Blade',
					['DualMaxentius']='Black Halo',['DualMaxentiusAcc']='Black Halo',['DualEvisceration']='Evisceration',['DualCrocea']='Sanguine Blade',['DualClubs']='Black Halo',
					['DualAeolian']='Aeolian Edge',['DualPrime']='Exenterator',['DualCroceaSavageBlade']="Savage Blade",['CroceaDaybreak']="Seraph Blade",["DualTauretCrocea"]="Aeolian Edge"}
	trust_list = {"Joachim","Ulmia","Qultada","Yoran-Oran (UC)","Selh'teus"}
	
	gear.mnd_enfeebling_jse_back = {name="Sucellos's Cape",augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Haste+10','Damage taken-5%',}}
	gear.int_enfeebling_jse_back = {name="Sucellos's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}}
	gear.str_wsd_jse_back = {name="Sucellos's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	gear.physical_mnd_wsd_jse_back = {name="Sucellos's Cape",augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}}
	gear.magical_mnd_wsd_jse_back = {name="Sucellos's Cape",augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Damage taken-3%',}}
	gear.int_wsd_jse_back = {name="Sucellos's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Damage taken-5%',}}
	gear.nuke_jse_back = {name="Sucellos's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}
	gear.dw_jse_back = {name="Sucellos's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}
	
		-- Additional local binds
	send_command('bind @` gs c cycle ElementalMode')
	send_command('bind ^` gs c scholar dark')
	send_command('bind !` gs c scholar light')
	send_command('bind !backspace input /ja "Composure" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind @backspace input /ja "Spontaneity" <t>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise III" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Naegling = {main="Naegling",sub="Ammurapi Shield",range=empty}
	sets.weapons.Crocea = {main="Crocea Mors",sub="Ammurapi Shield",range=empty}
	sets.weapons.Maxentius = {main="Maxentius",sub="Ammurapi Shield",range=empty}
	sets.weapons.Tauret = {main="Tauret",sub="Ammurapi Shield",range=empty}
	sets.weapons.DualWeapons = {main="Naegling",sub="Thibron",range=empty}
	sets.weapons.DualWeaponsAcc = {main="Naegling",sub="Gleti's Knife",range=empty}
	sets.weapons.DualPrime = {main="Mpu Gandring",sub="Gleti's Knife",range=empty}
	sets.weapons.DualEvisceration = {}
	sets.weapons.DualCrocea = {main="Crocea Mors",sub="Daybreak",range=empty}
	sets.weapons.DualAeolian = {main="Tauret",sub="Maxentius",range=empty}
	sets.weapons.DualProcSword = {main="Demers. Degen +1",sub="Blurred Knife +1",range=empty}
	sets.weapons.ProcSword = {main="Demers. Degen +1",sub="Ammurapi Shield",range=empty}
	sets.weapons.ProcDagger = {main="Blurred Knife +1",sub="Ammurapi Shield",range=empty}
	sets.weapons.DualProcDagger = {main="Blurred Knife +1",sub="Demers. Degen +1",range=empty}
	sets.weapons.EnspellOnly = {main="Qutrub Knife",sub="Sacro Bulwark"}
	sets.weapons.DualEnspellOnly = {main="Qutrub Knife",sub="Ethereal Dagger"}
	sets.weapons.DualBow = {}
	sets.weapons.BowMacc = {}
	sets.weapons.DualMaxentius = {main="Maxentius",sub="Thibron",range=empty}
	sets.weapons.DualMaxentiusAcc = {main="Maxentius",sub="Gleti's Knife",range=empty}
	
	--Temporary Weapon Sets for Dynamis RP
	sets.weapons.DualCroceaSavageBlade = {main="Crocea Mors",sub="Thibron"}
	sets.weapons.DualTauretCrocea = {main="Tauret",sub="Crocea Mors"}
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}
	
	-- Steps (Pure Acc)
    sets.precast.Step = {ammo="Hasty Pinion +1",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Crepuscular Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	-- Violent Flourish (Macc & Acc)
    sets.precast.JA['Violent Flourish'] = {ammo="Regal Gem",--Or range="Ullr" but swapping to this makes you lose TP.
		head="Leth. Chappel +3",neck="Null Loop",ear1="Malignance Earring",ear2="Crepuscular Earring",
		body="Malignance Tabard",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamorph Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {main="Sakpata's Sword",sub="Sacro Bulwark",ammo="Impatiens",
		head="Atrophy Chapeau +3",neck="Loricate Torque +1",ear1="Malignance Earring",ear2="Leth. Earring +1",
		body="Viti. Tabard +3",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.precast.FC.DT = {main="Sakpata's Sword",sub="Sacro Bulwark",ammo="Impatiens",
		head="Atrophy Chapeau +3",neck="Loricate Torque +1",ear1="Malignance Earring",ear2="Leth. Earring +1",
		body="Viti. Tabard +3",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.precast.FullFC = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
		head="Atrophy Chapeau +3",neck="Orunmila's Torque",ear1="Malignance Earring",ear2="Leth. Earring +1",
		body="Viti. Tabard +3",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Aya. Cosciales +2",feet=gear.merlinic_fc_feet}
		
	sets.precast.FC.Impact = set_combine(sets.precast.FullFC, {head=empty,body="Crepuscular Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Sacro Bulwark"})
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {range=empty,ammo="Oshasha's Treatise",
		head="Viti. Chapeau +3",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Jhakri Cuffs +2",ring1="Sroda Ring",ring2="Cornelia's Ring",
		back=gear.str_wsd_jse_back,waist="Fotia Belt",legs="Nyame Flanchard",feet="Leth. Houseaux +3"}
		
	sets.precast.WS.Proc = 	{ammo="Hasty Pinion +1",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Crepuscular Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = {range=empty,ammo="Regal Gem",
		head="Viti. Chapeau +3",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back=gear.physical_mnd_wsd_jse_back,waist="Fotia Belt",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}

	sets.precast.WS['Chant Du Cygne'] = {range=empty,ammo="Coiste Bodhar",
		head="Nyame Helm",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Brutal Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Epaminondas's Ring",ring2="Cornelia's Ring",
		back=gear.str_wsd_jse_back,waist="Fotia Belt",legs="Nyame Flanchard",feet="Leth. Houseaux +3"}
		
	sets.precast.WS['Evisceration'] = sets.precast.WS['Chant Du Cygne']

	sets.precast.WS['Savage Blade'] = {range=empty,ammo="Oshasha's Treatise",
		head="Viti. Chapeau +3",neck="Rep. Plat. Medal",ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Jhakri Cuffs +2",ring1="Sroda Ring",ring2="Cornelia's Ring",
		back=gear.str_wsd_jse_back,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Leth. Houseaux +3"}
		
	sets.precast.WS['Black Halo'] = {range=empty,ammo="Oshasha's Treatise",
		head="Viti. Chapeau +3",neck="Rep. Plat. Medal",ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Jhakri Cuffs +2",ring1="Sroda Ring",ring2="Cornelia's Ring",
		back=gear.physical_mnd_wsd_jse_back,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Leth. Houseaux +3"}
		
	sets.precast.WS['Sanguine Blade'] = {range=empty,ammo="Sroda Tathlum",
		head="Leth. Chappel +3",neck="Baetyl Pendant",ear1="Malignance Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Leth. Ganth. +3",ring1="Epaminondas's Ring",ring2="Cornelia's Ring",
		back=gear.magical_mnd_wsd_jse_back,waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Leth. Houseaux +3"}
		
	sets.precast.WS['Seraph Blade'] = {range=empty,ammo="Sroda Tathlum",
		head="Leth. Chappel +3",neck="Baetyl Pendant",ear1="Malignance Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Leth. Ganth. +3",ring1="Epaminondas's Ring",ring2="Cornelia's Ring",
		back=gear.magical_mnd_wsd_jse_back,waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Leth. Houseaux +3"}
		
	sets.precast.WS['Shining Strike'] = sets.precast.WS['Seraph Blade'] 
	sets.precast.WS['Flash Nova'] = sets.precast.WS['Seraph Blade'] 
		
	sets.precast.WS['Aeolian Edge'] = {range=empty,ammo="Sroda Tathlum",
		head="Leth. Chappel +3",neck="Fotia Gorget",ear1="Malignance Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Jhakri Cuffs +2",ring1="Freke Ring",ring2="Cornelia's Ring",
		back=gear.int_wsd_jse_back,waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Leth. Houseaux +3"}
		
	sets.precast.WS['Red Lotus Blade'] = sets.precast.WS['Aeolian Edge']

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear2="Brutal Earring"}
	sets.AccMaxTP = {ear2="Telos Earring"}
	sets.MagicalMaxTP = {ear2="Friomisi Earring"}
	
	-- Midcast Sets

	-- Gear that converts elemental damage done to recover MP.	
	sets.midcast.FastRecast = {main="Sakpata's Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
		head="Atrophy Chapeau +3",neck="Loricate Torque +1",ear1="Malignance Earring",ear2="Leth. Earring +1",
		body="Viti. Tabard +3",hands="Bunzi's Gloves",ring1="Defending Ring",ring2="Freke Ring",
		back=gear.mnd_enfeebling_jse_back,waist="Emphatikos Rope",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	sets.midcast.Cure = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo="Regal Gem",
        head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
        body="Bunzi's Robe",hands="Gende. Gages +1",ring1="Sirona's Ring",ring2="Menelaus's Ring",
        back=gear.mnd_enfeebling_jse_back,waist="Luminary Sash",legs="Atrophy Tights +3",feet="Vanya Clogs"}
		
    sets.midcast.LightWeatherCure = {main="Chatoyant Staff",sub="Curatio Grip",range=empty,ammo="Regal Gem",
        head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
        body="Bunzi's Robe",hands="Gende. Gages +1",ring1="Sirona's Ring",ring2="Menelaus's Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Atrophy Tights +3",feet="Vanya Clogs"}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo="Regal Gem",
        head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
        body="Bunzi's Robe",hands="Gende. Gages +1",ring1="Sirona's Ring",ring2="Menelaus's Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Atrophy Tights +3",feet="Vanya Clogs"}
		
    sets.midcast.Cure.DT = {main="Daybreak",sub="Culminus",range=empty,ammo="Staunch Tathlum +1",
        head="Leth. Chappel +3",neck="Loricate Torque +1",ear1="Halasz Earring",ear2="Mendi. Earring",
        body="Bunzi's Robe",hands=gear.chironic_nuke_hands,ring1="Defending Ring",ring2="Freke Ring",
        back=gear.mnd_enfeebling_jse_back,waist="Emphatikos Rope",legs="Bunzi's Pants",feet="Bunzi's Sabots"}
		
	sets.midcast.Cursna = {main=gear.grioavolr_fc_staff,sub="Curatio Grip",range=empty,ammo="Hasty Pinion +1",
        head="Vanya Hood",neck="Debilis Medallion",ear1="Meili Earring",ear2="Leth. Earring +1",
        body="Viti. Tabard +3",hands="Hieros Mittens",ring1="Haoma's Ring",ring2="Menelaus's Ring",
        back="Oretan. Cape +1",waist="Bishop's Sash",legs="Atrophy Tights +3",feet="Vanya Clogs"}

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})
	
	sets.midcast['Enhancing Magic'] = {main="Colada",sub="Ammurapi Shield",ammo="Staunch Tathlum +1",
		head="Telchine Cap",neck="Dls. Torque +2",ear1="Andoaa Earring",ear2="Leth. Earring +1",
		body="Viti. Tabard +3",hands="Atrophy Gloves +3",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Ghostfyre Cape",waist="Embla Sash",legs="Telchine Braconi",feet="Leth. Houseaux +3"}

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.
	sets.buff.ComposureOther = {head="Leth. Chappel +3",
		body="Lethargy Sayon +3",
		legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}
		
	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.EnhancingSkill = {main="Pukulatmuj +1",sub="Forfend +1",ammo="Staunch Tathlum +1",
		head="Befouled Crown",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Mimir Earring",
		body="Viti. Tabard +3",hands="Viti. Gloves +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Fi Follet Cape +1",waist="Olympus Sash",legs="Atrophy Tights +3",feet="Leth. Houseaux +3"}
		
	sets.midcast.Refresh = {head="Amalric Coif +1",body="Atrophy Tabard +3",legs="Leth. Fuseau +3"}
	sets.midcast.Aquaveil = {head="Amalric Coif +1",waist="Emphatikos Rope",legs="Shedir Seraweels"} --hands="Regal Cuffs"
	sets.midcast.BarElement = {legs="Shedir Seraweels"}
	sets.midcast.BarStatus = {neck="Sroda Necklace"}
	sets.midcast.Temper = sets.EnhancingSkill
	sets.midcast.Enspell = sets.EnhancingSkill
	sets.midcast.BoostStat = {hands="Vitiation Gloves +3"}
	sets.midcast.Stoneskin = {neck="Nodens Gorget",waist="Siegel Sash"}--ring2="Earthcry Earring"
	sets.midcast.Protect = {ring2="Sheltered Ring"}
	sets.midcast.Shell = {ring2="Sheltered Ring"}
	sets.midcast.Regen = {main="Bolelabunga",sub="Ammurapi Shield"}
	
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {neck="Phalaina Locket",ear1="Etiolation Earring",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	sets.Self_Phalanx = {main="Sakpata's Sword",head="Taeon Chapeau",body="Taeon Tabard",hands="Taeon Gloves",back=gear.mnd_enfeebling_jse_back,legs="Taeon Tights",feet="Taeon Boots",ammo="Staunch Tathlum +1"}
	sets.Self_Phalanx.DW = {main="Sakpata's Sword",sub="Egeking"}
	
	sets.midcast['Enfeebling Magic'] = {main="Bunzi's Rod",sub="Ammurapi Shield",range=empty,ammo="Regal Gem",
		head="Leth. Chappel +3",neck="Dls. Torque +2",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back=gear.mnd_enfeebling_jse_back,waist="Obstinate Sash",legs=gear.chironic_macc_legs,feet="Vitiation Boots +3"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head="Leth. Chappel +3",neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Atrophy Tabard +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet="Leth. Houseaux +3"}
		
	sets.midcast['Enfeebling Magic'].DW = {main="Bunzi's Rod",sub="Maxentius"}
		
	sets.midcast.Sleep = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head="Leth. Chappel +3",neck="Dls. Torque +2",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Kishar Ring",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Obstinate Sash",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"} --Obstinate Sash
		
	sets.midcast.Bind = sets.midcast.Sleep
	sets.midcast.Break = sets.midcast.Sleep
	sets.midcast['Dia III'] = sets.midcast.Sleep
	sets.midcast['Bio III'] = sets.midcast.Sleep
	sets.midcast.Inundation = sets.midcast.Sleep
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {legs=gear.merlinic_treasure_legs,feet=gear.chironic_treasure_feet})
	sets.midcast.Dia = set_combine(sets.midcast.Sleep, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.Sleep, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.Sleep, sets.TreasureHunter)
		
	sets.midcast.Sleep.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head="Atrophy Chapeau +3",neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Atrophy Tabard +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet="Leth. Houseaux +3"}
		
	sets.midcast.Bind.Resistant = sets.midcast.Sleep.Resistant
	sets.midcast.Break.Resistant = sets.midcast.Sleep.Resistant
	
	sets.midcast.Sleep.DW = {main="Bunzi's Rod",sub="Maxentius"}
	sets.midcast.Bind.DW = sets.midcast.Sleep.DW
	sets.midcast.Break.DW = sets.midcast.Sleep.DW

	sets.midcast.Dispel = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head="Atrophy Chapeau +3",neck="Dls. Torque +2",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Atrophy Tabard +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet="Leth. Houseaux +3"}
		
	sets.midcast.Dispel.DW = {main="Bunzi's Rod",sub="Maxentius"}
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {main="Daybreak",sub="Ammurapi Shield"})
	sets.midcast.Dispelga.DW = {main="Daybreak",sub="Bunzi's Rod"}
	
	sets.midcast.Frazzle = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo="Regal Gem",
		head="Leth. Chappel +3",neck="Dls. Torque +2",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back=gear.mnd_enfeebling_jse_back,waist="Obstinate Sash",legs="Leth. Fuseau +3",feet="Vitiation Boots +3"}
		
	sets.midcast.Distract = sets.midcast.Frazzle
		
	sets.midcast.Frazzle.Resistant = {main="Daybreak",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head="Atrophy Chapeau +3",neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Atrophy Tabard +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet="Leth. Houseaux +3"}
		
	sets.midcast.Distract.Resistant = sets.midcast.Frazzle.Resistant
		
	sets.midcast['Frazzle II'] = sets.midcast.Frazzle.Resistant
	sets.midcast.Frazzle.DW = {main="Bunzi's Rod",sub="Daybreak"}
	sets.midcast.Distract.DW = sets.midcast.Frazzle.DW
	
	sets.midcast.Addle = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo="Regal Gem",
		head="Viti. Chapeau +3",neck="Dls. Torque +2",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back=gear.mnd_enfeebling_jse_back,waist="Obstinate Sash",legs=gear.chironic_macc_legs,feet="Vitiation Boots +3"}
		
	sets.midcast.Paralyze = sets.midcast.Addle
	sets.midcast.Slow = sets.midcast.Addle
	
	sets.midcast.Addle.Resistant = {main="Daybreak",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head="Viti. Chapeau +3",neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet="Leth. Houseaux +3"}
		
	sets.midcast.Paralyze.Resistant = sets.midcast.Addle.Resistant
	sets.midcast.Slow.Resistant = sets.midcast.Addle.Resistant
	
	sets.midcast.Addle.DW = {main="Bunzi's Rod",sub="Daybreak"}
	sets.midcast.Paralyze.DW = sets.midcast.Addle.DW
	sets.midcast.Slow.DW = sets.midcast.Addle.DW
	
	sets.midcast.Gravity = {main="Bunzi's Rod",sub="Ammurapi Shield",range=empty,ammo="Regal Gem",
		head="Leth. Chappel +3",neck="Dls. Torque +2",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Kishar Ring",ring2="Metamor. Ring +1",
		back=gear.int_enfeebling_jse_back,waist="Obstinate Sash",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}
		
	sets.midcast.Gravity.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range=empty,ammo="Regal Gem",
		head="Leth. Chappel +3",neck="Dls. Torque +2",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back=gear.int_enfeebling_jse_back,waist="Null Belt",legs=gear.chironic_macc_legs,feet="Leth. Houseaux +3"}
		
	sets.midcast.Gravity.DW = {main="Bunzi's Rod",sub="Maxentius"}
	
	sets.midcast.Poison = sets.midcast.Gravity
	sets.midcast.Poison.Resistant = sets.midcast.Gravity.Resistant
	sets.midcast.Poison.DW = sets.midcast.Gravity.DW
	
	sets.midcast.Blind = sets.midcast.Gravity
	sets.midcast.Blind.Resistant = sets.midcast.Gravity.Resistant
	sets.midcast.Blind.DW = sets.midcast.Gravity.DW
	
	sets.midcast.Silence = {main="Daybreak",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head="Leth. Chappel +3",neck="Dls. Torque +2",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Kishar Ring",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Obstinate Sash",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}
		
	sets.midcast.Silence.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head="Atrophy Chapeau +3",neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Atrophy Tabard +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet="Leth. Houseaux +3"}
		
	sets.midcast.Silence.DW = {main="Bunzi's Rod",sub="Daybreak"}
	
	--After Bunzi's is augmented it will probably win on low-tier nukes.
	sets.midcast['Elemental Magic'] = {main="Bunzi's Rod",sub="Culminus",ammo="Ghastly Tathlum +1",
		head="Leth. Chappel +3",neck="Baetyl Pendant",ear1="Malignance Earring",ear2="Friomisi Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}
		
	sets.midcast['Elemental Magic'].DT = {main="Bunzi's Rod",sub="Culminus",ammo="Staunch Tathlum +1",
		head="Leth. Chappel +3",neck="Loricate Torque +1",ear1="Malignance Earring",ear2="Friomisi Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Emphatikos Rope",legs="Bunzi's Pants",feet="Leth. Houseaux +3"}
		
    sets.midcast['Elemental Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head="Leth. Chappel +3",neck="Sibyl Scarf",ear1="Malignance Earring",ear2="Friomisi Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}
		
    sets.midcast['Elemental Magic'].Proc = {main="Gleti's Knife",sub="Forfend +1",range=empty,ammo="Regal Gem",
        head="Malignance Chapeau",neck="Null Loop",ear1="Snotra Earring",ear2="Leth. Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
        back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.midcast['Elemental Magic'].HighTierNuke = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="Leth. Chappel +3",neck="Sibyl Scarf",ear1="Malignance Earring",ear2="Friomisi Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}
		
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head="Leth. Chappel +3",neck="Sibyl Scarf",ear1="Malignance Earring",ear2="Friomisi Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
		gear.nuke_jse_back,waist="Acuity Belt +1",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}
		
	-- Gear that Recovers MP when nuking.
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {main="Bunzi's Rod",sub="Ammurapi Shield",neck="Mizu. Kubikazari",hands="Bunzi's Gloves",ring1="Mujin Band"}
	sets.midcast['Elemental Magic'].DW = {main="Bunzi's Rod",sub="Daybreak"}
		
	sets.midcast.Impact = {main="Bunzi's Rod",sub="Ammurapi Shield",range=empty,ammo="Regal Gem",
		head=empty,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Crepuscular Cloak",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}

	sets.midcast['Dark Magic'] = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo="Regal Gem",
		head="Leth. Chappel +3",neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}

    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",range=empty,ammo="Regal Gem",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Snotra Earring",
        body="Lethargy Sayon +3",hands=gear.chironic_aspir_gloves,ring1="Evanescence Ring",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Fucho-no-obi",legs=gear.chironic_aspir_legs,feet="Leth. Houseaux +3"}

	sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast['Absorb-TP'] = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
        head="Atrophy Chapeau +3",neck="Null Loop",ear1="Malignance Earring",ear2="Leth. Earring +1",
        body="Viti. Tabard +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.mnd_enfeebling_jse_back,waist="Null Belt",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}
		
	sets.midcast['Absorb-TP'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
        head="Atrophy Chapeau +3",neck="Null Loop",ear1="Malignance Earring",ear2="Leth. Earring +1",
        body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back="Null Shawl",waist="Null Belt",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}
		
	sets.midcast.Stun = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
        head="Atrophy Chapeau +3",neck="Null Loop",ear1="Malignance Earring",ear2="Leth. Earring +1",
        body="Viti. Tabard +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.mnd_enfeebling_jse_back,waist="Null Belt",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}

	sets.midcast.Stun.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
        head="Atrophy Chapeau +3",neck="Null Loop",ear1="Malignance Earring",ear2="Leth. Earring +1",
        body="Lethargy Sayon +3",hands="Leth. Ganth. +3",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back="Null Shawl",waist="Null Belt",legs="Leth. Fuseau +3",feet="Leth. Houseaux +3"}
		
	sets.midcast.Stun.DW = {main="Bunzi's Rod",sub="Maxentius"}

	-- Sets for special buff conditions on spells.
		
	sets.buff.Saboteur = {hands="Leth. Ganth. +3"}
	
	sets.HPDown = {main="Mpaca's Staff",sub="Oneiros Grip",ammo="Homiliary",
		head="Pixie Hairpin +1",neck="Loricate Torque +1",ear1="Hirudinea Earring",ear2="Ethereal Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Mephitas's Ring +1",ring2="Metamor. Ring +1",
		back="Null Shawl",waist="Luminary Sash",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
		
    sets.HPCure = {main="Daybreak",sub="Ammurapi Shield",ammo="Regal Gem",
		head="Nyame Helm",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Bunzi's Robe",hands="Bokwus Gloves",ring1="Sirona's Ring",ring2="Kunaji Ring",
		back="Engulfer Cape +1",waist="Gishdubar Sash",legs="Nyame Flanchard",feet="Medium's Sabots"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main="Chatoyant Staff",sub="Oneiros Grip",range=empty,ammo="Impatiens",
		head="Viti. Chapeau +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Lethargy Sayon +3",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Sheltered Ring",
		back="Null Shawl",waist="Null Belt",legs=gear.merlinic_refresh_legs,feet=gear.merlinic_refresh_feet}
	
	sets.Ballista = {main="Sakpata's Sword",sub="Sacro Bulwark",range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck="Dls. Torque +2",ear1="Etiolation Earring",ear2="Leth. Earring +1",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Shneddick Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Bunzi's Pants",feet="Leth. Houseaux +3"}

	-- Idle sets
	sets.idle = {main="Mpaca's Staff",sub="Oneiros Grip",ammo="Homiliary",
		head="Viti. Chapeau +3",neck="Sibyl Scarf",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Lethargy Sayon +3",hands=gear.chironic_refresh_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.merlinic_refresh_legs,feet=gear.merlinic_refresh_feet}
		
	sets.idle.PDT = {main="Daybreak",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Shadow Mantle",waist="Plat. Mog. Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.idle.MDT = {main="Daybreak",sub="Sacro Bulwark",range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Defending Ring",ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}
		
	sets.idle.MEVA = {main="Daybreak",sub="Sacro Bulwark",range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}
		
	sets.idle.Aminon = {main="Daybreak",sub="Sacro Bulwark",range=empty,ammo="Staunch Tathlum +1",
		head="Null Masque",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}
	
	-- Defense sets
	sets.defense.PDT = {main="Daybreak",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Shadow Mantle",waist="Plat. Mog. Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.NukeLock = sets.midcast['Elemental Magic']
		
	sets.defense.MDT = {main="Daybreak",sub="Sacro Bulwark",range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Defending Ring",ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}
		
    sets.defense.MEVA = {main="Daybreak",sub="Sacro Bulwark",range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}
		
	sets.Kiting = {ring2="Shneddick Ring"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.Dagger.Accuracy.Evasion
	
	-- Normal melee group

	sets.engaged = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Anu Torque",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.Acc = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.Acc.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.DW = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Anu Torque",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.dw_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.DW.Acc = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.dw_jse_back,waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.DW.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Chirich Ring +1",
		back=gear.dw_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.DW.Acc.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Chirich Ring +1",
		back=gear.dw_jse_back,waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.EnspellOnly = {ammo="Sroda Tathlum",
		head="Umuthi Hat",neck="Null Loop",ear1="Sherida Earring",ear2="Brutal Earring",
		body="Malignance Tabard",hands="Aya. Manopolas +2",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Ghostfyre Cape",waist="Orpheus's Sash",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.EnspellOnly.Acc = {ammo="Sroda Tathlum",
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Leth. Earring +1",
		body="Malignance Tabard",hands="Aya. Manopolas +2",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Orpheus's Sash",legs="Malignance Tights",feet="Malignance Boots"}		

	sets.engaged.DualEnspellOnly = {ammo="Sroda Tathlum",
		head="Umuthi Hat",neck="Null Loop",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Malignance Tabard",hands="Aya. Manopolas +2",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Ghostfyre Cape",waist="Orpheus's Sash",legs="Carmine Cuisses +1",feet="Malignance Boots"}
		
	sets.engaged.DualEnspellOnly.Acc = {ammo="Sroda Tathlum",
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Leth. Earring +1",
		body="Malignance Tabard",hands="Aya. Manopolas +2",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Orpheus's Sash",legs="Carmine Cuisses +1",feet="Malignance Boots"}
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'SCH' then
		set_macro_page(1, 2)
	elseif player.sub_job == 'DNC' then
		set_macro_page(4, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(5, 2)
	elseif player.sub_job == 'BLM' then
		set_macro_page(2, 2)
	elseif player.sub_job == 'DRK' then
		set_macro_page(6, 2)
	else
		set_macro_page(3, 2)
	end
end

function user_job_buff_change(buff, gain)
	if buff:startswith('Addendum: ') or buff:endswith(' Arts') then
		style_lock = true
	end
end

function user_job_lockstyle()
	if player.sub_job == 'SCH' then
		if state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
			windower.chat.input('/lockstyleset 001')
		elseif state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
			windower.chat.input('/lockstyleset 002')
		else
			windower.chat.input('/lockstyleset 004')
		end
	elseif player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		windower.chat.input('/lockstyleset 020')
	end
end

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Refresh III',	Buff='Refresh',		SpellID=894,	When='Always'},
		{Name='Haste II',		Buff='Haste',		SpellID=511,	When='Always'},
		{Name='Aurorastorm',	Buff='Aurorastorm',	SpellID=119,	When='Idle'},
		{Name='Reraise',		Buff='Reraise',		SpellID=135,	When='Always'},
	},
	
	AutoMelee = {
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	When='Combat'},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	When='Combat'},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	When='Combat'},
		--{Name='Refresh III',	Buff='Refresh',			SpellID=894,	When='Always'},
		{Name='Gain-STR',		Buff='STR Boost',		SpellID=486,	When='Combat'},
	},
	
	AutoMage = {
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	When='Always'},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	When='Always'},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	When='Always'},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	When='Always'},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	When='Always'},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		When='Always'},
		{Name='Blink',			Buff='Blink',			SpellID=53,		When='Always'},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		When='Always'},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		When='Always'},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		When='Always'},
	},
	
	Default = {
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Gain-MND',		Buff='MND Boost',		SpellID=491,	Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},

	MageBuff = {
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},
	
	FullMeleeBuff = {
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Gain-STR',		Buff='STR Boost',		SpellID=486,	Reapply=false},
		--{Name='Enthunder',		Buff='Enthunder',		SpellID=104,	Reapply=false},
		--{Name='Shock Spikes',	Buff='Shock Spikes',	SpellID=251,	Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
		--{Name='Barblizzard',	Buff='Barblizzard',		SpellID=61,		Reapply=false},
		--{Name='Barparalyze',	Buff='Barparalyze',		SpellID=74,		Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},		
		{Name='Regen II',		Buff='Regen',			SpellID=110,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
	},
	
	MeleeBuff = {
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Gain-STR',		Buff='STR Boost',		SpellID=486,	Reapply=false},
		{Name='Enthunder',		Buff='Enthunder',		SpellID=104,	Reapply=false},
		{Name='Shock Spikes',	Buff='Shock Spikes',	SpellID=251,	Reapply=false},
	},

	Odin = {
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Regen II',		Buff='Regen',			SpellID=110,	Reapply=false},
		{Name='Enaero',			Buff='Enaero',			SpellID=102,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},
	
	HybridCleave = {
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	Reapply=false},
		{Name='Enthunder II',	Buff='Enthunder II',	SpellID=316,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},
}