-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function character_user_job_setup()
	state.OffenseMode:options('Normal','Acc')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match','Acc','Proc')
	state.CastingMode:options('Normal','Fodder','Proc')
	state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.HybridMode:options('Normal','DT')
	state.Weapons:options('Default','Ranged','Savage','Evisceration','DualWeapons','DualEvisceration','DualLeadenRanged','DualLeadenMelee','DualAeolian','DualRanged','DualProcWeapons')
	autows_list = {['Default']='Savage Blade',['Evisceration']='Evisceration',['Savage']='Savage Blade',['Ranged']='Last Stand',['DualWeapons']='Savage Blade',['DualSavageWeapons']='Savage Blade',['DualEvisceration']='Evisceration',['DualLeadenRanged']='Leaden Salute',['DualLeadenMelee']='Leaden Salute',['DualAeolian']='Aeolian Edge',['DualRanged']='Last Stand'}
	state.CompensatorMode:options('Always','300','1000','Never')

	gear.RAbullet = "Eminent Bullet"
	gear.WSbullet = "Eminent Bullet"
	gear.MAbullet = "Eminent Bullet" --For MAB WS, do not put single-use bullets here.
	gear.QDbullet = "Animikii Bullet"
	options.ammo_warning_limit = 15
	--Ikenga_vest_bonus = 190  -- It is 190 at R20. Uncomment if you need to manually adjust because you are using below R20

	--gear.tp_ranger_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
	--gear.snapshot_jse_back = {name="Camulus's Mantle",augments={'"Snapshot"+10',}}
	gear.ranger_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}
	--gear.magic_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.str_wsd_jse_back = {name="Camulus's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')

	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')

	send_command('bind ^\\\\ input /ja "Random Deal" <me>')
	send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @!^f9 gs c toggle RngHelper')

	send_command('bind @pause roller roll')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Precast sets to enhance JAs

	sets.precast.JA['Triple Shot'] = {} --body="Chasseur's Frac +3"
	sets.precast.JA['Snake Eye'] = {} --legs="Lanun Trews +3" (+1 is fine)
	sets.precast.JA['Wild Card'] = {} --feet="Lanun Bottes +3"
	sets.precast.JA['Random Deal'] = {} --body="Lanun Frac +3"
	sets.precast.JA['Double Up'] = {} --main="Rostam",sub="Rostam"
	sets.precast.FoldDoubleBust = {} --hands="Lanun Gants +3"

	sets.precast.CorsairRoll = {range="Compensator",neck="Regal Necklace",back=gear.ranger_wsd_jse_back} --main="Rostam",legs="Desultor Tassets"

	sets.precast.LuzafRing = {ring2="Luzaf's Ring"}

	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {}) --legs="Chas. Culottes +3"
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {}) --feet="Chass. Bottes +3"
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {}) --head="Chass. Tricorne +3"
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {}) --body="Chasseur's Frac +3"
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {}) --hands="Chasseur's Gants +3"
	sets.precast.CorsairRoll["Bolter's Roll"] = set_combine(sets.precast.CorsairRoll, {})
	sets.precast.CorsairRoll.Recast = {}
	sets.precast.CorsairRoll.Weak = {}

	--Standard TP Generating Shot
	sets.precast.CorsairShot = {ammo=gear.QDbullet,
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Crep. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.ranger_wsd_jse_back,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}

	--Damage shot for use with CastingMode: Fodder
	sets.precast.CorsairShot.Damage = {ammo=gear.QDbullet,
		head="Nyame Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Crepuscular Ring",ring2="Regal Ring",
		back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs="Malignance Tights",feet="Chass. Bottes +1"}

	--TH & Low Damage Shot for Procs.
	sets.precast.CorsairShot.Proc = {ammo=gear.RAbullet,
		head="Volte Cap",neck="Iskur Gorget",ear1="Crep. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Volte Bracers",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.ranger_wsd_jse_back,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}

	--Macc Shot for Sleep/Dispel
	sets.precast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Chas. Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	sets.Self_Waltz = {head="Mummu Bonnet +2",body="Passion Jacket"}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.Step = {ammo=gear.QDbullet,
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Chas. Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.precast.JA['Violent Flourish'] = {ammo=gear.QDbullet,
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Chas. Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Metamor. Ring +1",ring2="Cacoethic Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	-- Fast cast sets for spells

	sets.precast.FC = {}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear2="Mendi. Earring"})

	sets.precast.RA = {ammo=gear.RAbullet,ring1="Crepuscular Ring",waist="Yemaya Belt",feet="Meg. Jam. +2"}

	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Nyame Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Regal Ring",ring2="Cornelia's Ring",
		back=gear.str_wsd_jse_back,waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.precast.WS.Acc = {
		head="Nyame Helm",neck="Null Loop",ear1="Moonshade Earring",ear2="Telos Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Regal Ring",ring2="Cornelia's Ring",
		back=gear.str_wsd_jse_back,waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.precast.WS.Proc = {
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Chas. Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	-- Midcast Sets
	sets.midcast.FastRecast = {}

	-- Specific spells

	sets.midcast.Cure = {}

	sets.Self_Healing = {neck="Phalaina Locket",ring2="Kunaji Ring",waist="Gishdubar Sash"} --hands="Buremte Gloves",
	sets.Cure_Received = {neck="Phalaina Locket",ring2="Kunaji Ring",waist="Gishdubar Sash"} --hands="Buremte Gloves",
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	sets.midcast.Utsusemi = sets.midcast.FastRecast

	-- Ranged gear
	sets.midcast.RA = {ammo=gear.RAbullet,
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Crep. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Crepuscular Ring",ring2="Chirich Ring +1",
		back=gear.ranger_wsd_jse_back,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.midcast.RA.Acc = {ammo=gear.RAbullet,
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Crep. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Crepuscular Ring",ring2="Chirich Ring +1",
		back=gear.ranger_wsd_jse_back,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.buff['Triple Shot'] = {}

	-- Sets to return to when not performing an action.

	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {ammo=gear.RAbullet,
		head="Null Masque",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shneddick Ring",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.idle.PDT = {ammo=gear.RAbullet,
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shneddick Ring",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.idle.Refresh = {ammo=gear.RAbullet,
		head="Null Masque",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Mekosu. Harness",hands="Nyame Gauntlets",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	-- Defense sets
	sets.defense.PDT = {ammo=gear.RAbullet,
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shneddick Ring",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MDT = {ammo=gear.RAbullet,
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shneddick Ring",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MEVA = {ammo=gear.RAbullet,
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shneddick Ring",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.Kiting = {ring2="Shneddick Ring"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Default = {main="Naegling",sub="Nusku Shield",range="Compensator"}
	sets.weapons.Ranged = {main="Rostam",sub="Nusku Shield",range="Compensator"}
	sets.weapons.Evisceration = {main="Tauret",sub="Nusku Shield",range="Ataktos"}
	sets.weapons.DualWeapons = {main="Naegling",sub="Blurred Knife +1",range="Compensator"}
	sets.weapons.DualSavageWeapons = {main="Naegling",sub="Blurred Knife +1",range="Ataktos"}
	sets.weapons.DualEvisceration = {main="Tauret",sub="Blurred Knife +1",range="Ataktos"}
	sets.weapons.Savage = {main="Naegling",sub="Nusku Shield",range="Ataktos"}
	sets.weapons.DualLeadenRanged = {main="Rostam",sub="Tauret",range="Compensator"}
	sets.weapons.DualLeadenMelee = {main="Naegling",sub="Atoyac",range="Compensator"}
	sets.weapons.DualAeolian = {main="Rostam",sub="Tauret",range="Ataktos"}
	sets.weapons.DualLeadenMeleeAcc = {main="Naegling",sub="Blurred Knife +1",range="Compensator"}
	sets.weapons.DualRanged = {main="Rostam",sub="Kustawi +1",range="Compensator"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Acc = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DT = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Acc.DT = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DW = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DW.Acc = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DW.DT = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DW.Acc.DT = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	if player.sub_job == 'NIN' then
		set_macro_page(2, 11)
	elseif player.sub_job == 'DNC' then
		set_macro_page(1, 11)
	elseif player.sub_job == 'RNG' then
		set_macro_page(9, 11)
	elseif player.sub_job == 'DRG' then
		set_macro_page(5, 11)
	else
		set_macro_page(2, 11)
	end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 001')
end
