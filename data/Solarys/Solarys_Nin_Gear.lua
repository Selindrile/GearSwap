-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function character_user_job_setup()
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal','DT')
	state.RangedMode:options('Normal','Acc')
	state.WeaponskillMode:options('Match','Proc')
	state.CastingMode:options('Normal','Proc','Resistant')
	state.IdleMode:options('Normal','Sphere')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Savage','Evisceration','ProcDagger','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana','ProcKatana','ProcClub','ProcStaff')

	state.WeaponSets:options('Default','Proc')

	weapon_sets = {
		['Default'] = {'Savage','Evisceration',},
		['Proc'] = {'ProcDagger','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana','ProcKatana','ProcClub','ProcStaff'},
	}

	autows_list = {['Savage']='Savage Blade',['Evisceration']='Evisceration',['ProcDagger']='Cyclone',['ProcSword']='Red Lotus Blade',['ProcGreatSword']='Freezebite',['ProcScythe']='Shadow of Death',['ProcPolearm']='Raiden Thrust',['ProcGreatKatana']='Tachi: Koki',['ProcKatana']='Blade: Ei',['ProcClub']='Seraph Strike',['ProcStaff']='Earth Crusher',}

	send_command('bind ^` input /ja "Innin" <me>')
	send_command('bind !` input /ja "Yonin" <me>')
	send_command('bind @` gs c cycle Stance')

	utsusemi_cancel_delay = .3
	utsusemi_ni_cancel_delay = .06

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Savage = {main="Naegling",sub="Gleti's Knife"}
	sets.weapons.Evisceration = {main="Tauret",sub="Gleti's Knife"}
	sets.weapons.ProcDagger = {main="Qutrub Knife",sub="Ethereal Dagger"}
	sets.weapons.ProcSword = {main="Kyukoto",sub="Ethereal Dagger"}
	sets.weapons.ProcGreatSword = {main="Goujian",sub="Niobid Strap"}
	sets.weapons.ProcScythe = {main="Ark Scythe",sub="Niobid Strap"}
	sets.weapons.ProcPolearm = {main="Pitchfork",sub="Niobid Strap"}
	sets.weapons.ProcKatana = {main="Debahocho",sub="Ethereal Dagger"}
	sets.weapons.ProcGreatKatana = {main="Lotus Katana",sub="Niobid Strap"}
	sets.weapons.ProcClub = {main="Hagoita",sub="Ethereal Dagger"}
	sets.weapons.ProcStaff = {main="Caver's Shovel",sub="Niobid Strap"}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	sets.Enmity = {ammo="Paeapua",
		head="Dampening Tam",neck="Unmoving Collar +1",ear1="Friomisi Earring",ear2="Trux Earring",
		body="Emet Harness +1",hands="Kurys Gloves",ring1="Petrov Ring",ring2="Vengeful Ring",
		back="Moonlight Cape",waist="Goading Belt",legs="Nyame Flanchard",feet="Amm Greaves"}

	-- Precast sets to enhance JAs
	sets.precast.JA['Mijin Gakure'] = {} --legs="Mochizuki Hakama",--main="Nagi"
	sets.precast.JA['Futae'] = {hands="Hattori Tekko +1"}
	sets.precast.JA['Sange'] = {} --body="Mochizuki Chainmail"
	sets.precast.JA['Provoke'] = sets.Enmity
	sets.precast.JA['Warcry'] = sets.Enmity

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Yamarang",
		head="Mummu Bonnet +2",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
		body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
		back="Moonlight Cape",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Hattori Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.precast.JA['Violent Flourish'] = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Crep. Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Impatiens",
		head="Malignance Chapeau",neck="Orunmila's Torque",ear1="Etiolation Earring ",ear2="Loquac. Earring",
		body="Malignance Tabard",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Kishar Ring",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})

	-- Snapshot for ranged
	sets.precast.RA = {}
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Oshasha's Treatise",
		head="Nyame Helm",neck="Rep. Plat. Medal",ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Sroda Ring",ring2="Cornelia's Ring",
		back="Null Shawl",waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.precast.WS.Proc = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Hattori Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Crep. Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.midcast.ElementalNinjutsu = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Crep. Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.midcast.ElementalNinjutsu.Proc = sets.midcast.FastRecast

	sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {})

	sets.MagicBurst = {ring1="Mujin Band",ring2="Locus Ring"}

	sets.midcast.NinjutsuDebuff = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Crep. Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, {})

	sets.midcast.RA = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Zennaroi Earring",ear2="Crep. Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.midcast.RA.Acc = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Crep. Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {ammo="Staunch Tathlum +1",
		head="Null Masque",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})

	sets.defense.PDT = {ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MDT = {ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MEVA = {ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}


	sets.Kiting = {ring2="Shneddick Ring"}
	sets.DuskKiting = {}
	sets.DuskIdle = {}
	sets.DayIdle = {}
	sets.NightIdle = {}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Sherida Earring",ear2="Hattori Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DT = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Sherida Earring",ear2="Hattori Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Migawari = {} --body="Hattori Ningi +1"
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Futae = {}
	sets.buff.Yonin = {} --legs="Hattori Hakama +1"
	sets.buff.Innin = {} --head="Hattori Zukin +1"

	-- Extra Melee sets.  Apply these on top of melee sets.
	sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {legs="Ryuo Hakama"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 17)
	elseif player.sub_job == 'RNG' then
		set_macro_page(1, 12)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 12)
	else
		set_macro_page(1, 12)
	end
end
