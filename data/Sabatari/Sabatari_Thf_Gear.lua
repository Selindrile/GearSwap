-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function character_user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DT')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match','Normal','Proc')
	state.IdleMode:options('Normal','Refresh')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Twashtar''Tauret','Naegling'--[['Sandung', 'StaffSunburstEarthcrusher', 'PolearmRaidenThrust', 'ScytheShadowofDeath', 
						'GreatswordFreezebite', 'ClubSeraphStrike', 'DaggerCycloneEnergyDrain', 'SwordRedLotusBladeSeraphBlade']])

	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWMax','Parry'}
	state.AmbushMode = M(false, 'Ambush Mode')

	-- Additional local binds
    send_command('bind !` input /ja "Flee" <me>')
    send_command('bind !numpad7 input /ws "Exenterator" <t>')
    send_command('bind !numpad8 input /ws "Mandalic Stab" <t>')
    send_command('bind !numpad4 input /ws "Evisceration" <t>')
    send_command('bind !numpad5 input /ws "Rudra\'s Storm" <t>')
    send_command('bind !numpad1 input /ws "Aeolian Edge" <t>')
    --send_command('bind !numpad2 input /ws "Wasp Sting" <t>')
    send_command('bind !numpad3 input /ws "Gust Slash" <t>')

    send_command('bind !numpad0 input /ja "Sneak Attack" <me>')
    send_command('bind !numpad. input /ja "Trick Attack" <me>')

	default_weapons = 'Twashtar'
	
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Special sets (required by rules)
	--------------------------------------

	sets.TreasureHunter = {hands="Plunderer's Armlets +1",feet="Skulk. Poulaines +3"}
	sets.Kiting = {feet = "Jute Boots +1"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	
	sets.buff['Sneak Attack'] = {}
	sets.buff['Trick Attack'] = {}

	-- Extra Melee sets.  Apply these on top of melee sets.
	sets.Knockback = {}
	sets.Suppa = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.DWEarrings = {}
	sets.DWMax = {}
	sets.Ambush = {}
	
	-- Weapons sets
	sets.weapons.Tauret = {main="Tauret", sub={"Centovente",}	
	sets.weapons.Twashtar = {main="Twashtar",sub={"Centovente", }
	sets.weapons.Naegling = {main="Naegling", sub={"Centovente",}
--[[	sets.weapons.Sandung = {main="Tauret", sub="Sandung",}
	sets.weapons.StaffSunburstEarthcrusher = {main="Profane Staff", sub="Duplus grip",}
	sets.weapons.PolearmRaidenThrust = {main="Iapetus",sub="Duplus grip",}
	sets.weapons.ScytheShadowofDeath = {main="Lost Sickle",sub="Duplus grip",}
	sets.weapons.GreatswordFreezebite = {main="Lament",sub="Duplus grip",}
	sets.weapons.ClubSeraphStrike = {main="Chocobo Wand",sub="Wind Knife",}
	sets.weapons.DaggerCycloneEnergyDrain = {main="Qutrub Knife", sub="Wind Knife",}
	sets.weapons.SwordRedLotusBladeSeraphBlade = {main="Ibushi Shinai",sub="Wind Knife",}
]]
	
	sets.precast.Step = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.precast.JA['Violent Flourish'] = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = set_combine(sets.TreasureHunter, {head="Skulker's Bonnet +2"})
	sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +2"}
	sets.precast.JA['Flee'] = {feet="Pill. Poulaines +1"} 
	sets.precast.JA['Hide'] = {body="Pillager's Vest +3"}
	sets.precast.JA['Conspirator'] = set_combine(sets.TreasureHunter, {body="Skulker's Vest +2"})
	sets.precast.JA['Steal'] = {
		head="Plun. Bonnet +3",
        hands="Pillager's Armlets +1",
        feet="Pill. Poulaines +3",}
	sets.precast.JA['Mug'] = {}
	sets.precast.JA['Despoil'] = {legs="Skulk. Culottes +2", feet="Skulk. Poulaines +3"}
	sets.precast.JA['Perfect Dodge'] = {hands="Plun. Armlets +1"}
	sets.precast.JA['Feint'] = {legs="Plun. Culottes +3"} 

	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Yamarang",
		head="Nyame Helm",neck="Elite Royal Collar",ear1="Genmei Earring",ear2="Odnowa Earring +1",
		body="Passion Jacket",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Shadow Mantle",waist="Plat. Mog. Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.Self_Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}


	-- Fast cast sets for spells
	sets.precast.FC = {		
		head="Malignance Chapeau",
		body={ name="Taeon Tabard", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
		legs="Limbo Trousers",
		feet="Skulk. Poulaines +3",
		neck={ name="Assassin's Gorget", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Lebeche Ring",
		right_ring="Defending Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


	-- Ranged snapshot gear
	sets.precast.RA = {}


	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="pill. bonnet +4",
		body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
		hands="Meg. Gloves +2",
		legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck="Assassin's Gorget",
		waist="Eschan Stone",
		left_ear="Odr Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Karieyh Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
		}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {body="Skulker's Vest +2",})
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].TA = sets.precast.WS["Rudra's Storm"].SA
	sets.precast.WS["Rudra's Storm"].SATA = sets.precast.WS["Rudra's Storm"].SA
	
	sets.precast.WS["Evisceration"] = set_combine(sets.precast.WS, {		
		hands="Adhemar Wrist. +1",
		legs="Pill. Culottes +2", 
		feet="Mummu Gamash. +1",
		neck="Soil Gorget",
		left_ring="Ilabrat Ring",
		right_ring="Rajas Ring",})
	sets.precast.WS["Evisceration"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Evisceration"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Evisceration"].TA = sets.precast.WS["Rudra's Storm"].SA
	sets.precast.WS["Evisceration"].SATA = sets.precast.WS["Rudra's Storm"].SA
	
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		legs="Meg. Chausses +2",
		left_ear="Brutal Earring",
		right_ear="Sherida Earring",
		neck="Soil Gorget",
		waist="Thunder Belt",

        })

	sets.precast.WS.Proc = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.precast.WS['Last Stand'] = sets.precast.WS
	sets.precast.WS['Empyreal Arrow'] = sets.precast.WS['Last Stand']
		
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
			head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+23','MND+14','Mag. Acc.+9',}},
			body={ name="Herculean Vest", augments={'"Mag.Atk.Bns."+25','STR+8','Mag. Acc.+2',}},
			hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
			legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','CHR+2','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
			feet={ name="Herculean Boots", augments={'Mag. Acc.+18','Accuracy+6 Attack+6','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
			neck={ name="Assassin's Gorget", augments={'Path: A',}},
			waist="Eschan Stone",
			left_ear="Friomisi Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Karieyh Ring",
			right_ring="Epaminondas's Ring",
			back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
			})
	sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = {}

	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

	-- Ranged gear

	sets.midcast.RA = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Neritic Earring",ear2="Enervating Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Apate Ring",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.midcast.RA.Acc = {
		head="Malignance Chapeau",neck="Null Loop",ear1="Neritic Earring",ear2="Enervating Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Apate Ring",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	--------------------------------------
	-- Idle/resting/defense sets
	--------------------------------------

	-- Resting sets
	sets.resting = {}

	sets.HPDown = {ammo="Staunch Tathlum +1",
		head="Pixie Hairpin +1",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
		body=empty,hands=empty,ring1="Metamorph Ring +1",ring2="Mephitas's Ring +1",
		back="Null Shawl",waist="Cornelia's Belt",legs=empty,feet=empty}
	
	sets.HPMax = {ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Null Loop",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Kunaji Ring",ring2="K'ayres Ring",
		back="Engulfer Cape +1",waist="Plat. Mog Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = { head="Skulker's Bonnet +2",
			body="Pillager's Vest +3",
			hands="Adhemar Wrist. +1",
			legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
			feet="Skulk. Poulaines +3",
			neck={ name="Assassin's Gorget", augments={'Path: A',}},
			waist="Windbuffet Belt +1",
			left_ear="Dedition earring",
			right_ear="Skulk. Earring +1",
			left_ring="Gere Ring",
			right_ring="Epaminondas's Ring",
			back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
		}

	sets.idle.Refresh = {ammo="Staunch Tathlum +1",
		head="Null Masque",neck="Sibyl Scarf",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Mekosu. Harness",hands="Malignance Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})

	sets.idle.Weak = set_combine(sets.idle, {})

	-- Defense sets

	sets.defense.PDT = {
			head="Malignance Chapeau", --6
			hands="Malignance gloves", --5
			legs="Skulk. Culottes +2", --12
			feet="Skulk. Poulaines +3", --11
			left_ear="Eabani Earring",
			right_ear="Etiolation Earring",
			right_ring="Moonbeam ring", --4
			left_ring="Defending Ring", --10
			back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},}

	sets.defense.MDT = set_combine(sets.defense.PDT, {})
		
	sets.defense.MEVA = {
		body="Malignance Tabard",legs="Malignance Tights",feet="Malignance Boots"}


	--------------------------------------
	-- Melee sets  
	--------------------------------------

	-- Normal melee group
	sets.engaged = {
		head="Skulker's Bonnet +2",
		body="Pillager's Vest +3",
		hands="Adhemar Wrist. +1",
		legs="Meg. Chausses +2", 
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck={ name="Assassin's Gorget", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Dedition earring",
		right_ear="Skulk. Earring +1",
		left_ring="Ilabrat Ring",
		--left_ring="Mummu Ring",
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
		}
		
	sets.engaged.Acc = set_combine(sets.engaged, {sub={ name="Shijo", augments={'DEX+15','"Dual Wield"+5','"Triple Atk."+2',}},})

	sets.engaged.DT = set_combine(sets.engaged, {})

	sets.engaged.Acc.DT = set_combine(sets.engaged, {})
end

function job_state_change(field, new_value, old_value)
    if state.Weapons.value == 'Twashtar' or 'Tauret' then
		send_command('bind !` input /ja "Flee" <me>')
		send_command('bind !numpad7 input /ws "Exenterator" <t>')
		send_command('bind !numpad8 input /ws "Mandalic Stab" <t>')
		send_command('bind !numpad4 input /ws "Evisceration" <t>')
		send_command('bind !numpad5 input /ws "Rudra\'s Storm" <t>')
		send_command('bind !numpad1 input /ws "Aeolian Edge" <t>')
		--send_command('bind !numpad2 input /ws "Wasp Sting" <t>')
		send_command('bind !numpad3 input /ws "Gust Slash" <t>')

	elseif state.Weapons.value == "Naegling" then
		send_command('bind !numpad7 input /ws "Requiescat" <t>') --Merit ws
		send_command('unbind !numpad8')
		send_command('bind !numpad4 input /ws "Savage Blade" <t>') --Quest WS
		send_command('bind !numpad5 input /ws "Savage Blade" <lastst>')
		send_command('unbind !numpad1')
		send_command('unbind !numpad3')

    end


end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 5)
	elseif player.sub_job == 'WAR' then
		set_macro_page(1, 6)
	end
end

function user_job_lockstyle()
	if player.equipment.main == nil or player.equipment.main == 'empty' then
		windower.chat.input('/lockstyleset 097')
	elseif res.items[get_item_id_by_name(player.equipment.main)].skill == 3 then --Sword in main hand.
		if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Sword/Nothing.
				windower.chat.input('/lockstyleset 097')
		elseif res.items[get_item_id_by_name(player.equipment.sub)].skill == 2 then --Sword/Dagger.
			windower.chat.input('/lockstyleset 097')
		else
			windower.chat.input('/lockstyleset 097') --Catchall just in case something's weird.
		end
	elseif res.items[get_item_id_by_name(player.equipment.main)].skill == 2 then --Dagger in main hand.
		if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Dagger/Nothing.
			windower.chat.input('/lockstyleset 097')
		elseif res.items[get_item_id_by_name(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
			windower.chat.input('/lockstyleset 097')
		else
			windower.chat.input('/lockstyleset 097') --Catchall just in case something's weird.
		end
	end
end

autows_list = {['Tauret']='Evisceration',['Twashtar']='Rudra\'s Storm',['Aeolian']='Aeolian Edge',['Naegling']='Savage Blade',['Bow']='Empyreal Arrow'}