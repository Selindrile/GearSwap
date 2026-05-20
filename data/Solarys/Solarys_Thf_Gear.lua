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
	state.Weapons:options('Savage','Aeneas','Aeolian','ProcWeapons','Evisceration','Throwing','SwordThrowing','Bow')

	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWMax','Parry'}
	state.AmbushMode = M(false, 'Ambush Mode')

	-- Additional local binds
	send_command('bind ^` input /ja "Flee" <me>')
	send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace input /item "Thief\'s Tools" <t>')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Special sets (required by rules)
	--------------------------------------

	sets.TreasureHunter = {hands="Plunderer's Armlets +1",feet="Skulk. Poulaines"}
	sets.Kiting = {ring2="Shneddick Ring"} --feet="Skd. Jambeaux +1"

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
	sets.weapons.Aeneas = {main="Aeneas",sub="Gleti's Knife"}
	sets.weapons.Aeolian = {main="Malevolence",sub="Malevolence"}
	sets.weapons.Savage = {main="Naegling",sub="Gleti's Knife"}
	sets.weapons.ProcWeapons = {main="Pukulatmuj +1",sub="Pukulatmuj"}
	sets.weapons.Evisceration = {main="Tauret",sub="Gleti's Knife"}
	sets.weapons.Throwing = {main="Aeneas",sub="Gleti's Knife",range="Raider's Bmrng.",ammo=empty}
	sets.weapons.SwordThrowing = {main="Naegling",sub="Gleti's Knife",range="Raider's Bmrng.",ammo=empty}
	sets.weapons.Bow = {main="Aeneas",sub="Kustawi +1",range="Kaja Bow",ammo="Chapuli Arrow"}
	
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
	sets.precast.JA['Collaborator'] = {}
	sets.precast.JA['Accomplice'] = {}
	sets.precast.JA['Flee'] = {} 
	sets.precast.JA['Hide'] = {}
	sets.precast.JA['Conspirator'] = {} 
	sets.precast.JA['Steal'] = {ammo="Barathrum"}
	sets.precast.JA['Mug'] = {ammo="Barathrum"}
	sets.precast.JA['Despoil'] = {}
	sets.precast.JA['Perfect Dodge'] = {}
	sets.precast.JA['Feint'] = {} 

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
	sets.precast.FC = {ammo="Impatiens",
		head=gear.herculean_fc_head,neck="Orunmila's Torque",ear1="Infused Earring",ear2="Loquac. Earring",
		body="Taeon Tabard",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		legs="Rawhide Trousers"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


	-- Ranged snapshot gear
	sets.precast.RA = {}


	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Oshasha's Treatise",
		head="Nyame Helm",neck="Rep. Plat. Medal",ear1="Moonshade Earring",ear2="Sherida Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gere Ring",ring2="Cornelia's Ring",
		back="Null Shawl",waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].TA = sets.precast.WS["Rudra's Storm"].SA
	sets.precast.WS["Rudra's Storm"].SATA = sets.precast.WS["Rudra's Storm"].SA
	
	sets.precast.WS["Evisceration"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Evisceration"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Evisceration"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Evisceration"].TA = sets.precast.WS["Rudra's Storm"].SA
	sets.precast.WS["Evisceration"].SATA = sets.precast.WS["Rudra's Storm"].SA

	sets.precast.WS.Proc = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Zennaroi Earring",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.precast.WS['Last Stand'] = sets.precast.WS
	sets.precast.WS['Empyreal Arrow'] = sets.precast.WS['Last Stand']
		
	sets.precast.WS['Aeolian Edge'] = sets.precast.WS
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

	sets.idle = {ammo="Staunch Tathlum +1",
		head="Null Masque",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.idle.Refresh = {ammo="Staunch Tathlum +1",
		head="Null Masque",neck="Sibyl Scarf",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Mekosu. Harness",hands="Malignance Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})

	sets.idle.Weak = set_combine(sets.idle, {})

	-- Defense sets

	sets.defense.PDT = {ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Shadow Mantle",waist="Plat. Mog Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MDT = {ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",neck="Null Loop",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}


	--------------------------------------
	-- Melee sets  
	--------------------------------------

	-- Normal melee group
	sets.engaged = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Suppanomimi",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Gere Ring",ring2="Epona's Ring",
		back="Null Shawl",waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.Acc = {ammo="Yamarang",
		head="Malignance Chapeau",neck="Null Loop",ear1="Suppanomimi",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Regal Ring",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DT = {ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",neck="Null Loop",ear1="Suppanomimi",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Acc.DT = {ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",neck="Null Loop",ear1="Suppanomimi",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 5)
	elseif player.sub_job == 'WHM' then
		set_macro_page(5, 5)
	end
end

function user_job_lockstyle()
	if player.equipment.main == nil or player.equipment.main == 'empty' then
		windower.chat.input('/lockstyleset 001')
	elseif res.items[get_item_id_by_name(player.equipment.main)].skill == 3 then --Sword in main hand.
		if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Sword/Nothing.
				windower.chat.input('/lockstyleset 007')
		elseif res.items[get_item_id_by_name(player.equipment.sub)].skill == 2 then --Sword/Dagger.
			windower.chat.input('/lockstyleset 007')
		else
			windower.chat.input('/lockstyleset 007') --Catchall just in case something's weird.
		end
	elseif res.items[get_item_id_by_name(player.equipment.main)].skill == 2 then --Dagger in main hand.
		if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Dagger/Nothing.
			windower.chat.input('/lockstyleset 008')
		elseif res.items[get_item_id_by_name(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
			windower.chat.input('/lockstyleset 008')
		else
			windower.chat.input('/lockstyleset 008') --Catchall just in case something's weird.
		end
	end
end

autows_list = {['Aeneas']="Rudra's Storm",['Aeolian']='Aeolian Edge',['Savage']='Savage Blade',['Throwing']="Rudra's Storm",['SwordThrowing']='Savage Blade',['Evisceration']='Evisceration',['ProcWeapons']='Wasp Sting',['Bow']='Empyreal Arrow'}