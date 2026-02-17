-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
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
	gear.QDbullet = "Eminent Bullet" --For Quick Draw, do not put single-use bullets here.
	options.ammo_warning_limit = 15
	--Ikenga_vest_bonus = 190  -- It is 190 at R20. Uncomment if you need to manually adjust because you are using below R20
	gear.JSE_neck = {name="Comm. Charm +1"}
	gear.jse_dw_back = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}}
	gear.jse_str_wsd_back = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}

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
	sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +1"} --legs="Lanun Trews +3" (+1 is fine)
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"} --feet="Lanun Bottes +3"
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"} --body="Lanun Frac +3"
	sets.precast.JA['Double Up'] = {main={ name="Rostam", augments={'Path: C',}}} --main="Rostam",sub="Rostam"
	sets.precast.FoldDoubleBust = {hands="Lanun Gants +2"} --hands="Lanun Gants +3"

	sets.precast.CorsairRoll = {main={ name="Rostam", augments={'Path: C',}},range="Compensator",head="Lanun Tricorne +3",neck="Regal Necklace",
		body="Chasseur's Frac +2",hands="Chasseur's Gants +3",legs="Chas. Culottes +2",feet="Malignance Boots",back=gear.jse_dw_back} --main="Rostam",legs="Desultor Tassets"

	sets.precast.LuzafRing = {ring2="Luzaf's Ring"}

	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +2"}) --legs="Chas. Culottes +3"
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +2"}) --feet="Chass. Bottes +3"
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +2"}) --head="Chass. Tricorne +3"
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +2"}) --body="Chasseur's Frac +3"
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chassur's Gants +2"}) --hands="Chasseur's Gants +3"
	sets.precast.CorsairRoll["Bolter's Roll"] = set_combine(sets.precast.CorsairRoll, {})
	sets.precast.CorsairRoll.Recast = {}
	sets.precast.CorsairRoll.Weak = {}

	--Standard TP Generating Shot
	sets.precast.CorsairShot = {}

	--Damage shot for use with CastingMode: Fodder
	sets.precast.CorsairShot.Damage = {}

	--TH & Low Damage Shot for Procs.
	sets.precast.CorsairShot.Proc = {}

	--Macc Shot for Sleep/Dispel
	sets.precast.CorsairShot['Light Shot'] = {}

	sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	sets.Self_Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.Step = {}
		
	sets.precast.JA['Violent Flourish'] = {}

	-- Fast cast sets for spells

	sets.precast.FC = {}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	sets.precast.RA = {}

	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {body="Laksa. Frac +2",ear1="Moonshade Earring",ear2="Brutal Earring",hands="Chasseur's Gants +2",back=gear.jse_str_wsd_back,feet="Lunun Bottes +3",waist="Sailfi Belt +1"}

	sets.precast.WS.Acc = {}

	sets.precast.WS.Proc = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	-- Midcast Sets
	sets.midcast.FastRecast = {}

	-- Specific spells

	sets.midcast.Cure = {}

	sets.Self_Healing = {} --hands="Buremte Gloves",
	sets.Cure_Received = {} --hands="Buremte Gloves",
	sets.Self_Refresh = {}

	sets.midcast.Utsusemi = sets.midcast.FastRecast

	-- Ranged gear
	sets.midcast.RA = {}

	sets.midcast.RA.Acc = {}

	sets.buff['Triple Shot'] = {}

	-- Sets to return to when not performing an action.

	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {head="Chass. Tricorne +2",ear1="Alabaster Earring",ear2="Brutal Earring",body="Chasseur's Frac +2",
	hands="Nyame Gauntlets",ring2="Murky Ring",legs="Chas. Culottes +2",feet="Malignance Boots",back=gear.jse_dw_back}

	sets.idle.PDT = {}

	sets.idle.Refresh = {}

	-- Defense sets
	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.defense.MEVA = {}

	sets.Kiting = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Default = {}
	sets.weapons.Ranged = {}
	sets.weapons.Evisceration = {}
	sets.weapons.DualWeapons = {main="Naegling",sub="Gleti's Knife"}
	sets.weapons.DualSavageWeapons = {}
	sets.weapons.DualEvisceration = {}
	sets.weapons.Savage = {}
	sets.weapons.DualLeadenRanged = {}
	sets.weapons.DualLeadenMelee = {}
	sets.weapons.DualAeolian = {}
	sets.weapons.DualLeadenMeleeAcc = {}
	sets.weapons.DualRanged = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {}

	sets.engaged.Acc = {}

	sets.engaged.DT = {}

	sets.engaged.Acc.DT = {}

	sets.engaged.DW = {head="Malignance Chapeau",ear1="Alabaster Earring",ear2="Brutal Earring",body="Malignance Tabard",ring1="Chirich Ring +1",ring2="Murky Ring",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},legs="Malignance Tights",feet="Malignance Boots",back=gear.jse_dw_back,waist="Sailfi Belt +1"}

	sets.engaged.DW.Acc = {}

	sets.engaged.DW.DT = {}

	sets.engaged.DW.Acc.DT = {}
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
