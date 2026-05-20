function character_user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.WeaponskillMode:options('Normal','Proc')
	state.HybridMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','Twilight'}
	state.Weapons:options('GreatAxe','DualWeapons','SwordShield','GreatSword','ProcDagger','ProcSword','ProcGreatSword','ProcScythe','ShiningOne','ProcPolearm','ProcKatana','ProcGreatKatana','ProcClub','ProcStaff')
	
	autows_list = {['GreatAxe']='Upheaval',['ShiningOne']='Impulse Drive',['DualWeapons']='Savage Blade',['SwordShield']='Savage Blade',
					['ProcDagger']='Cyclone',['ProcSword']='Red Lotus Blade',['ProcGreatSword']='Freezebite',['ProcScythe']='Shadow of Death',['ProcPolearm']='Raiden Thrust',['ProcGreatKatana']='Tachi: Koki',['ProcKatana']='Blade: Ei',['ProcClub']='Seraph Strike',['ProcStaff']='Earth Crusher',}

	-- Additional local binds

	send_command('bind @` gs c cycle SkillchainMode')

	--Ikenga_axe_bonus = 300  -- It is 300 at R25. Uncomment if you need to manually adjust because you are using below R25 or above

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.GreatAxe = {main="Lycurgos", sub="Duplus Grip"}
	sets.weapons.ShiningOne = {main="Shining One",sub="Duplus Grip"}
	sets.weapons.DualWeapons = {main="Naegling",sub="Demers. Degen +1"}
	sets.weapons.SwordShield = {main="Naegling", sub="Blurred Shield +1"}
	sets.weapons.GreatSword = {main="Montante +1", sub="Duplus Grip"}
	sets.weapons.ProcDagger = {main="Qutrub Knife",sub="Beatific Shield +1"}
	sets.weapons.ProcSword = {main="Kyukoto",sub="Beatific Shield +1"}
	sets.weapons.ProcGreatSword = {main="Goujian",sub="Duplus Grip"}
	sets.weapons.ProcScythe = {main="Ark Scythe",sub="Duplus Grip"}
	sets.weapons.ProcPolearm = {main="Pitchfork",sub="Duplus Grip"}
	sets.weapons.ProcKatana = {main="Debahocho",sub="Beatific Shield +1"}
	sets.weapons.ProcGreatKatana = {main="Lotus Katana",sub="Duplus Grip"}
	sets.weapons.ProcClub = {main="Hagoita",sub="Beatific Shield +1"}
	sets.weapons.ProcStaff = {main="Caver's Shovel",sub="Duplus Grip"}

	-- Precast Sets
	
	sets.Enmity = {}
	sets.Knockback = {}
	sets.passive.Twilight = {}
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Berserk'] = {feet="Agoge Calligae +1",body="Pumm. Lorica +3",back="Cichol's Mantle"}
	sets.precast.JA['Warcry'] = {head="Agoge Mask +2"}
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = {body="Agoge Lorica",head="Pummeler's Mask +1"}
	sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
	sets.precast.JA["Warrior's Charge"] = {legs="Agoge Cuisses +1"}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk"}
	sets.precast.JA['Retaliation'] = {feet="Boii Calligae +2",hands="Pummeler's Mufflers +1"}
	sets.precast.JA['Restraint'] = {hands="Boii Mufflers +2"}
	sets.precast.JA['Blood Rage'] = {body="Boii Lorica"}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})
				   
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
				   
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
		   
	sets.precast.Step = {}
	
	sets.precast.Flourish1 = {}
		   
	-- Fast cast sets for spells

	sets.precast.FC = {}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Midcast Sets
	sets.midcast.FastRecast = {}
	
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
				   
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
			ammo="Knobkierrie",
			head="Agoge Mask +2",
			body="Pumm. Lorica +3",
			hands={ name="Odyssean Gauntlets", augments={'Accuracy+13','Weapon skill damage +4%','STR+3 DEX+3',}},
			legs={ name="Valorous Hose", augments={'Attack+12','Weapon skill damage +5%','DEX+10','Accuracy+13',}},
			feet="Sulev. Leggings +2",
			neck="War. Beads +1",
			waist="Sailfi Belt +1",
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Epaminondas's Ring",
			right_ring="Karieyh Ring",
			back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
		
	sets.precast.WS.Proc = {}
	
	sets.precast.WS.MAcc = set_combine(sets.precast.WS, {
			head="Flam. Zucchetto +2",
			body="Flamma Korazin +2",
			hands="Flam. Manopolas +2",
			legs="Flamma Dirs +2",
			feet="Flam. Gambieras +2",
			waist="Eschan Stone",
		})
	

    sets.precast.WS['Full Break'] = set_combine(sets.precast.WS.MAcc, {	
		})
		
	sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS.MAcc, {	
		})
	
--[[WS set examples.
	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {back="Letalis Mantle",})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Savage Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Upheaval'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Upheaval'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Upheaval'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	 
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Resolution'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Ruinator'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS['Ruinator'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Ruinator'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Ruinator'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Rampage'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS['Rampage'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Rampage'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Rampage'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS['Raging Rush'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Raging Rush'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS['Raging Rush'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Raging Rush'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Raging Rush'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Ukko's Fury"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Ukko's Fury"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS["Ukko's Fury"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["King's Justice"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS["King's Justice"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["King's Justice"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS["King's Justice"].Fodder = set_combine(sets.precast.WS.Fodder, {})
]]

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}
	
	--Specialty WS set overwrites.
	sets.AccWSMightyCharge = {}
	sets.AccWSCharge = {}
	sets.AccWSMightyCharge = {}
	sets.WSMightyCharge = {}
	sets.WSCharge = {}
	sets.WSMighty = {}

	 -- Sets to return to when not performing an action.
		   
	 -- Resting sets
	 sets.resting = {}
		   
	-- Idle sets
	sets.idle = {
			ammo="Knobkierrie",
			head="Agoge Mask +2",
			body={ name="Valorous Mail", augments={'Accuracy+28','"Dbl.Atk."+4','Attack+14',}},
			hands="Sulev. Gauntlets +2",
			legs="Pumm. Cuisses +3",
			feet="Pumm. Calligae +3",
			neck="War. Beads +1",
			waist="Sailfi belt +1",
			left_ear="Cessance Earring",
			right_ear="Brutal Earring",
			--left_ring="Rajas Ring",
			left_ring="Niqmaddu ring",
			right_ring="Moonbeam ring", --4/4
			back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
		
	-- Defense sets
	sets.defense.PDT = {head="Sakpata's Helm",
			body="Sakpata's Plate",
			hands="Sakpata's Gauntlets",
			legs="Sakpata's Cuisses",
			feet="Sakpata's Leggings",
			neck={ name="War. Beads +1", augments={'Path: A',}},
			waist="Ioskeha Belt",
			left_ear="Cessance Earring",
			right_ear="Brutal Earring",
			left_ring="Niqmaddu Ring",
			right_ring="Rajas Ring",
			back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
		
	sets.defense.MDT = set_combine(sets.defense.PDT, {})
		
	sets.defense.MEVA = set_combine(sets.defense.PDT, {})

	sets.Kiting = {}
	sets.Reraise = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	 
	-- Engaged sets
	sets.engaged = {--DA 33% Base  w/ Merits + Master
			ammo="Seeth. Bomblet +1",
			head="Flam. Zucchetto +2",--TA5 STP6
			body={ name="Valorous Mail", augments={'Accuracy+28','"Dbl.Atk."+4','Attack+14',}},--DA6 STP3
			hands="Sakpata's Gauntlets",--DA6
			legs="Pumm. Cuisses +3",--DA11
			feet="Pumm. Calligae +3",--DA9 STP4
			neck="War. Beads +1",--DA6
			waist="Sailfi belt +1",--DA5 TA2
			left_ear="Cessance Earring",--DA3 STP3
			right_ear="Boii Earring",--DA7 
			--left_ring="Rajas Ring",--STP5
			right_ring="Flamma Ring",--STP5
			left_ring="Niqmaddu ring",--QA3
			back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},--DA10
	}
		
	sets.engaged.Acc = set_combine(sets.engaged, {        
		ammo="Seeth. Bomblet +1",
        hands="Gazu Bracelet +1",}
		)
		
	sets.engaged.SwordShield = set_combine(sets.engaged, {
		ammo="Ginsen",
		belt="Sailfi belt +1",
		left_ear="Dedition Earring",
		
				
		})
--[[Engaged set examples
	sets.engaged.Charge = {}
	sets.engaged.SomeAcc.Charge = {}
	sets.engaged.Acc.Charge = {}
	sets.engaged.FullAcc.Charge = {}
	sets.engaged.Fodder.Charge = {}
	
	sets.engaged.Mighty = {}
	sets.engaged.SomeAcc.Mighty = {}
	sets.engaged.Acc.Mighty = {}
	sets.engaged.FullAcc.Mighty = {}
	sets.engaged.Fodder.Mighty = {}

	sets.engaged.Charge.Mighty = {}
	sets.engaged.SomeAcc.Charge.Mighty = {}
	sets.engaged.Acc.Charge.Mighty = {}
	sets.engaged.FullAcc.Charge.Mighty = {}
	sets.engaged.Fodder.Charge.Mighty = {}
	
	sets.engaged.Adoulin = {}
	sets.engaged.SomeAcc.Adoulin = {}
	sets.engaged.Acc.Adoulin = {}
	sets.engaged.FullAcc.Adoulin = {}
	sets.engaged.Fodder.Adoulin = {}
	
	sets.engaged.Adoulin.Charge = {}
	sets.engaged.SomeAcc.Adoulin.Charge = {}
	sets.engaged.Acc.Adoulin.Charge = {}
	sets.engaged.FullAcc.Adoulin.Charge = {}
	sets.engaged.Fodder.Adoulin.Charge = {}
	
	sets.engaged.Adoulin.Mighty = {}
	sets.engaged.SomeAcc.Adoulin.Mighty = {}
	sets.engaged.Acc.Adoulin.Mighty = {}
	sets.engaged.FullAcc.Adoulin.Mighty = {}
	sets.engaged.Fodder.Adoulin.Mighty = {}
	
	sets.engaged.Adoulin.Charge.Mighty = {}
	sets.engaged.SomeAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Acc.Adoulin.Charge.Mighty = {}
	sets.engaged.FullAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Fodder.Adoulin.Charge.Mighty = {}

	sets.engaged.PDT = {}
	sets.engaged.SomeAcc.PDT = {}
	sets.engaged.Acc.PDT = {}
	sets.engaged.FullAcc.PDT = {}
	sets.engaged.Fodder.PDT = {}
	
	sets.engaged.PDT.Charge = {}
	sets.engaged.SomeAcc.PDT.Charge = {}
	sets.engaged.Acc.PDT.Charge = {}
	sets.engaged.FullAcc.PDT.Charge = {}
	sets.engaged.Fodder.PDT.Charge = {}
	
	sets.engaged.PDT.Mighty = {}
	sets.engaged.SomeAcc.PDT.Mighty = {}
	sets.engaged.Acc.PDT.Mighty = {}
	sets.engaged.FullAcc.PDT.Mighty = {}
	sets.engaged.Fodder.PDT.Mighty = {}

	sets.engaged.PDT.Charge.Mighty = {}
	sets.engaged.SomeAcc.PDT.Charge.Mighty = {}
	sets.engaged.Acc.PDT.Charge.Mighty = {}
	sets.engaged.FullAcc.PDT.Charge.Mighty = {}
	sets.engaged.Fodder.PDT.Charge.Mighty = {}
	
	sets.engaged.PDT.Adoulin = {}
	sets.engaged.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Acc.PDT.Adoulin = {}
	sets.engaged.FullAcc.PDT.Adoulin = {}
	sets.engaged.Fodder.PDT.Adoulin = {}
	
	sets.engaged.PDT.Adoulin.Charge = {}
	sets.engaged.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Fodder.PDT.Adoulin.Charge = {}
	
	sets.engaged.PDT.Adoulin.Mighty = {}
	sets.engaged.SomeAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Acc.PDT.Adoulin.Mighty = {}
	sets.engaged.FullAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Fodder.PDT.Adoulin.Mighty = {}
	
	sets.engaged.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.SomeAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Acc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.FullAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Fodder.PDT.Adoulin.Charge.Mighty = {}

	sets.engaged.MDT = {}
	sets.engaged.SomeAcc.MDT = {}
	sets.engaged.Acc.MDT = {}
	sets.engaged.FullAcc.MDT = {}
	sets.engaged.Fodder.MDT = {}
	
	sets.engaged.MDT.Charge = {}
	sets.engaged.SomeAcc.MDT.Charge = {}
	sets.engaged.Acc.MDT.Charge = {}
	sets.engaged.FullAcc.MDT.Charge = {}
	sets.engaged.Fodder.MDT.Charge = {}
	
	sets.engaged.MDT.Mighty = {}
	sets.engaged.SomeAcc.MDT.Mighty = {}
	sets.engaged.Acc.MDT.Mighty = {}
	sets.engaged.FullAcc.MDT.Mighty = {}
	sets.engaged.Fodder.MDT.Mighty = {}

	sets.engaged.MDT.Charge.Mighty = {}
	sets.engaged.SomeAcc.MDT.Charge.Mighty = {}
	sets.engaged.Acc.MDT.Charge.Mighty = {}
	sets.engaged.FullAcc.MDT.Charge.Mighty = {}
	sets.engaged.Fodder.MDT.Charge.Mighty = {}
	
	sets.engaged.MDT.Adoulin = {}
	sets.engaged.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Acc.MDT.Adoulin = {}
	sets.engaged.FullAcc.MDT.Adoulin = {}
	sets.engaged.Fodder.MDT.Adoulin = {}
	
	sets.engaged.MDT.Adoulin.Charge = {}
	sets.engaged.SomeAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Acc.MDT.Adoulin.Charge = {}
	sets.engaged.FullAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Fodder.MDT.Adoulin.Charge = {}
	
	sets.engaged.MDT.Adoulin.Mighty = {}
	sets.engaged.SomeAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Acc.MDT.Adoulin.Mighty = {}
	sets.engaged.FullAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Fodder.MDT.Adoulin.Mighty = {}
	
	sets.engaged.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.SomeAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Acc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.FullAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Fodder.MDT.Adoulin.Charge.Mighty = {}
	
			-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
			-- sets if more refined versions aren't defined.
			-- If you create a set with both offense and defense modes, the offense mode should be first.
			-- EG: sets.engaged.Dagger.Accuracy.Evasion

-- Conqueror melee sets
	sets.engaged.Conqueror = {}
	sets.engaged.Conqueror.SomeAcc = {}
	sets.engaged.Conqueror.Acc = {}
	sets.engaged.Conqueror.FullAcc = {}
	sets.engaged.Conqueror.Fodder = {}
	
	sets.engaged.Conqueror.Adoulin = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin = {}
	sets.engaged.Conqueror.Acc.Adoulin = {}
	sets.engaged.Conqueror.FullAcc.Adoulin = {}
	sets.engaged.Conqueror.Fodder.Adoulin = {}
	
	sets.engaged.Conqueror.AM = {}
	sets.engaged.Conqueror.SomeAcc.AM = {}
	sets.engaged.Conqueror.Acc.AM = {}
	sets.engaged.Conqueror.FullAcc.AM = {}
	sets.engaged.Conqueror.Fodder.AM = {}
	
	sets.engaged.Conqueror.Adoulin.AM = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.AM = {}
	sets.engaged.Conqueror.Acc.Adoulin.AM = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.AM = {}
	sets.engaged.Conqueror.Fodder.Adoulin.AM = {}

	sets.engaged.Conqueror.Charge = {}
	sets.engaged.Conqueror.SomeAcc.Charge = {}
	sets.engaged.Conqueror.Acc.Charge = {}
	sets.engaged.Conqueror.FullAcc.Charge = {}
	sets.engaged.Conqueror.Fodder.Charge = {}
	
	sets.engaged.Conqueror.Adoulin.Charge = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.Charge = {}
	sets.engaged.Conqueror.Acc.Adoulin.Charge = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.Charge = {}
	sets.engaged.Conqueror.Fodder.Adoulin.Charge = {}
	
	sets.engaged.Conqueror.Charge.AM = {}
	sets.engaged.Conqueror.SomeAcc.Charge.AM = {}
	sets.engaged.Conqueror.Acc.Charge.AM = {}
	sets.engaged.Conqueror.FullAcc.Charge.AM = {}
	sets.engaged.Conqueror.Fodder.Charge.AM = {}
	
	sets.engaged.Conqueror.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.Acc.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.Fodder.Adoulin.Charge.AM = {}

	sets.engaged.Conqueror.PDT = {}
	sets.engaged.Conqueror.SomeAcc.PDT = {}
	sets.engaged.Conqueror.Acc.PDT = {}
	sets.engaged.Conqueror.FullAcc.PDT = {}
	sets.engaged.Conqueror.Fodder.PDT = {}
	
	sets.engaged.Conqueror.PDT.Adoulin = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin = {}
	
	sets.engaged.Conqueror.PDT.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.AM = {}
	sets.engaged.Conqueror.Acc.PDT.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.AM = {}
	
	sets.engaged.Conqueror.PDT.Adoulin.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.AM = {}
	
	sets.engaged.Conqueror.PDT.Charge = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Charge = {}
	sets.engaged.Conqueror.Acc.PDT.Charge = {}
	sets.engaged.Conqueror.FullAcc.PDT.Charge = {}
	sets.engaged.Conqueror.Fodder.PDT.Charge = {}
	
	sets.engaged.Conqueror.PDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.Charge = {}
	
	sets.engaged.Conqueror.PDT.Charge.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Charge.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Charge.AM = {}
	
	sets.engaged.Conqueror.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Conqueror.MDT = {}
	sets.engaged.Conqueror.SomeAcc.MDT = {}
	sets.engaged.Conqueror.Acc.MDT = {}
	sets.engaged.Conqueror.FullAcc.MDT = {}
	sets.engaged.Conqueror.Fodder.MDT = {}
	
	sets.engaged.Conqueror.MDT.Adoulin = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin = {}
	
	sets.engaged.Conqueror.MDT.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.AM = {}
	sets.engaged.Conqueror.Acc.MDT.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.AM = {}
	
	sets.engaged.Conqueror.MDT.Adoulin.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.AM = {}
	
	sets.engaged.Conqueror.MDT.Charge = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Charge = {}
	sets.engaged.Conqueror.Acc.MDT.Charge = {}
	sets.engaged.Conqueror.FullAcc.MDT.Charge = {}
	sets.engaged.Conqueror.Fodder.MDT.Charge = {}
	
	sets.engaged.Conqueror.MDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.Charge = {}
	
	sets.engaged.Conqueror.MDT.Charge.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Charge.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Charge.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Charge.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Charge.AM = {}
	
	sets.engaged.Conqueror.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.Charge.AM = {}
	
	sets.engaged.Conqueror.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.Mighty = {}
	sets.engaged.Conqueror.Acc.Mighty = {}
	sets.engaged.Conqueror.FullAcc.Mighty = {}
	sets.engaged.Conqueror.Fodder.Mighty = {}
	
	sets.engaged.Conqueror.Adoulin.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.Mighty = {}
	sets.engaged.Conqueror.Acc.Adoulin.Mighty = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.Mighty = {}
	sets.engaged.Conqueror.Fodder.Adoulin.Mighty = {}
	
	sets.engaged.Conqueror.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.Mighty.AM = {}
	
	sets.engaged.Conqueror.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.Adoulin.Mighty.AM = {}

	sets.engaged.Conqueror.Charge.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.Charge.Mighty = {}
	sets.engaged.Conqueror.Acc.Charge.Mighty = {}
	sets.engaged.Conqueror.FullAcc.Charge.Mighty = {}
	sets.engaged.Conqueror.Fodder.Charge.Mighty = {}
	
	sets.engaged.Conqueror.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.Acc.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.Fodder.Adoulin.Charge.Mighty = {}
	
	sets.engaged.Conqueror.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.Charge.Mighty.AM = {}
	
	sets.engaged.Conqueror.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Conqueror.PDT.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Mighty = {}
	sets.engaged.Conqueror.Acc.PDT.Mighty = {}
	sets.engaged.Conqueror.FullAcc.PDT.Mighty = {}
	sets.engaged.Conqueror.Fodder.PDT.Mighty = {}
	
	sets.engaged.Conqueror.PDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.Mighty = {}
	
	sets.engaged.Conqueror.PDT.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Mighty.AM = {}
	
	sets.engaged.Conqueror.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.Mighty.AM = {}
	
	sets.engaged.Conqueror.PDT.Charge.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Charge.Mighty = {}
	sets.engaged.Conqueror.Acc.PDT.Charge.Mighty = {}
	sets.engaged.Conqueror.FullAcc.PDT.Charge.Mighty = {}
	sets.engaged.Conqueror.Fodder.PDT.Charge.Mighty = {}
	
	sets.engaged.Conqueror.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.Charge.Mighty = {}
	
	sets.engaged.Conqueror.PDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Charge.Mighty.AM = {}
	
	sets.engaged.Conqueror.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.PDT.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Conqueror.MDT.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Mighty = {}
	sets.engaged.Conqueror.Acc.MDT.Mighty = {}
	sets.engaged.Conqueror.FullAcc.MDT.Mighty = {}
	sets.engaged.Conqueror.Fodder.MDT.Mighty = {}
	
	sets.engaged.Conqueror.MDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.Mighty = {}
	
	sets.engaged.Conqueror.MDT.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Mighty.AM = {}
	
	sets.engaged.Conqueror.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.Mighty.AM = {}
	
	sets.engaged.Conqueror.MDT.Charge.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Charge.Mighty = {}
	sets.engaged.Conqueror.Acc.MDT.Charge.Mighty = {}
	sets.engaged.Conqueror.FullAcc.MDT.Charge.Mighty = {}
	sets.engaged.Conqueror.Fodder.MDT.Charge.Mighty = {}
	
	sets.engaged.Conqueror.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.Charge.Mighty = {}
	
	sets.engaged.Conqueror.MDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Charge.Mighty.AM = {}
	
	sets.engaged.Conqueror.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.SomeAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Acc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.FullAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Conqueror.Fodder.MDT.Adoulin.Charge.Mighty.AM = {}
	
-- Bravura melee sets
	sets.engaged.Bravura = {}
	sets.engaged.Bravura.SomeAcc = {}
	sets.engaged.Bravura.Acc = {}
	sets.engaged.Bravura.FullAcc = {}
	sets.engaged.Bravura.Fodder = {}
	
	sets.engaged.Bravura.Adoulin = {}
	sets.engaged.Bravura.SomeAcc.Adoulin = {}
	sets.engaged.Bravura.Acc.Adoulin = {}
	sets.engaged.Bravura.FullAcc.Adoulin = {}
	sets.engaged.Bravura.Fodder.Adoulin = {}
	
	sets.engaged.Bravura.AM = {}
	sets.engaged.Bravura.SomeAcc.AM = {}
	sets.engaged.Bravura.Acc.AM = {}
	sets.engaged.Bravura.FullAcc.AM = {}
	sets.engaged.Bravura.Fodder.AM = {}
	
	sets.engaged.Bravura.Adoulin.AM = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.AM = {}
	sets.engaged.Bravura.Acc.Adoulin.AM = {}
	sets.engaged.Bravura.FullAcc.Adoulin.AM = {}
	sets.engaged.Bravura.Fodder.Adoulin.AM = {}

	sets.engaged.Bravura.Charge = {}
	sets.engaged.Bravura.SomeAcc.Charge = {}
	sets.engaged.Bravura.Acc.Charge = {}
	sets.engaged.Bravura.FullAcc.Charge = {}
	sets.engaged.Bravura.Fodder.Charge = {}
	
	sets.engaged.Bravura.Adoulin.Charge = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Charge = {}
	sets.engaged.Bravura.Acc.Adoulin.Charge = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Charge = {}
	sets.engaged.Bravura.Fodder.Adoulin.Charge = {}
	
	sets.engaged.Bravura.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.Charge.AM = {}
	sets.engaged.Bravura.Acc.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.Charge.AM = {}
	sets.engaged.Bravura.Fodder.Charge.AM = {}
	
	sets.engaged.Bravura.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Acc.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Fodder.Adoulin.Charge.AM = {}

	sets.engaged.Bravura.PDT = {}
	sets.engaged.Bravura.SomeAcc.PDT = {}
	sets.engaged.Bravura.Acc.PDT = {}
	sets.engaged.Bravura.FullAcc.PDT = {}
	sets.engaged.Bravura.Fodder.PDT = {}
	
	sets.engaged.Bravura.PDT.Adoulin = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin = {}
	
	sets.engaged.Bravura.PDT.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.AM = {}
	sets.engaged.Bravura.Acc.PDT.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.AM = {}
	sets.engaged.Bravura.Fodder.PDT.AM = {}
	
	sets.engaged.Bravura.PDT.Adoulin.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.AM = {}
	
	sets.engaged.Bravura.PDT.Charge = {}
	sets.engaged.Bravura.SomeAcc.PDT.Charge = {}
	sets.engaged.Bravura.Acc.PDT.Charge = {}
	sets.engaged.Bravura.FullAcc.PDT.Charge = {}
	sets.engaged.Bravura.Fodder.PDT.Charge = {}
	
	sets.engaged.Bravura.PDT.Adoulin.Charge = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Charge = {}
	
	sets.engaged.Bravura.PDT.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Bravura.Acc.PDT.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Charge.AM = {}
	
	sets.engaged.Bravura.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Bravura.MDT = {}
	sets.engaged.Bravura.SomeAcc.MDT = {}
	sets.engaged.Bravura.Acc.MDT = {}
	sets.engaged.Bravura.FullAcc.MDT = {}
	sets.engaged.Bravura.Fodder.MDT = {}
	
	sets.engaged.Bravura.MDT.Adoulin = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin = {}
	
	sets.engaged.Bravura.MDT.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.AM = {}
	sets.engaged.Bravura.Acc.MDT.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.AM = {}
	sets.engaged.Bravura.Fodder.MDT.AM = {}
	
	sets.engaged.Bravura.MDT.Adoulin.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.AM = {}
	
	sets.engaged.Bravura.MDT.Charge = {}
	sets.engaged.Bravura.SomeAcc.MDT.Charge = {}
	sets.engaged.Bravura.Acc.MDT.Charge = {}
	sets.engaged.Bravura.FullAcc.MDT.Charge = {}
	sets.engaged.Bravura.Fodder.MDT.Charge = {}
	
	sets.engaged.Bravura.MDT.Adoulin.Charge = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Charge = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Charge = {}
	
	sets.engaged.Bravura.MDT.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Charge.AM = {}
	sets.engaged.Bravura.Acc.MDT.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Charge.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Charge.AM = {}
	
	sets.engaged.Bravura.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Charge.AM = {}
	
	sets.engaged.Bravura.Mighty = {}
	sets.engaged.Bravura.SomeAcc.Mighty = {}
	sets.engaged.Bravura.Acc.Mighty = {}
	sets.engaged.Bravura.FullAcc.Mighty = {}
	sets.engaged.Bravura.Fodder.Mighty = {}
	
	sets.engaged.Bravura.Adoulin.Mighty = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Mighty = {}
	sets.engaged.Bravura.Acc.Adoulin.Mighty = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Mighty = {}
	sets.engaged.Bravura.Fodder.Adoulin.Mighty = {}
	
	sets.engaged.Bravura.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.Mighty.AM = {}
	sets.engaged.Bravura.Acc.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.Mighty.AM = {}
	
	sets.engaged.Bravura.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Acc.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.Adoulin.Mighty.AM = {}

	sets.engaged.Bravura.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.Charge.Mighty = {}
	
	sets.engaged.Bravura.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.Adoulin.Charge.Mighty = {}
	
	sets.engaged.Bravura.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.Charge.Mighty.AM = {}
	
	sets.engaged.Bravura.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Bravura.PDT.Mighty = {}
	sets.engaged.Bravura.SomeAcc.PDT.Mighty = {}
	sets.engaged.Bravura.Acc.PDT.Mighty = {}
	sets.engaged.Bravura.FullAcc.PDT.Mighty = {}
	sets.engaged.Bravura.Fodder.PDT.Mighty = {}
	
	sets.engaged.Bravura.PDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Mighty = {}
	
	sets.engaged.Bravura.PDT.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Mighty.AM = {}
	sets.engaged.Bravura.Acc.PDT.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Mighty.AM = {}
	
	sets.engaged.Bravura.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Mighty.AM = {}
	
	sets.engaged.Bravura.PDT.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.PDT.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.PDT.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.PDT.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.PDT.Charge.Mighty = {}
	
	sets.engaged.Bravura.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Charge.Mighty = {}
	
	sets.engaged.Bravura.PDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Charge.Mighty.AM = {}
	
	sets.engaged.Bravura.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Bravura.MDT.Mighty = {}
	sets.engaged.Bravura.SomeAcc.MDT.Mighty = {}
	sets.engaged.Bravura.Acc.MDT.Mighty = {}
	sets.engaged.Bravura.FullAcc.MDT.Mighty = {}
	sets.engaged.Bravura.Fodder.MDT.Mighty = {}
	
	sets.engaged.Bravura.MDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Mighty = {}
	
	sets.engaged.Bravura.MDT.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Mighty.AM = {}
	sets.engaged.Bravura.Acc.MDT.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Mighty.AM = {}
	
	sets.engaged.Bravura.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Mighty.AM = {}
	
	sets.engaged.Bravura.MDT.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.MDT.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.MDT.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.MDT.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.MDT.Charge.Mighty = {}
	
	sets.engaged.Bravura.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Charge.Mighty = {}
	
	sets.engaged.Bravura.MDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Charge.Mighty.AM = {}
	
	sets.engaged.Bravura.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Charge.Mighty.AM = {}
	
-- Ragnarok melee sets
	sets.engaged.Ragnarok = {}
	sets.engaged.Ragnarok.SomeAcc = {}
	sets.engaged.Ragnarok.Acc = {}
	sets.engaged.Ragnarok.FullAcc = {}
	sets.engaged.Ragnarok.Fodder = {}
	
	sets.engaged.Ragnarok.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin = {}
	sets.engaged.Ragnarok.Acc.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.Adoulin = {}
	
	sets.engaged.Ragnarok.AM = {}
	sets.engaged.Ragnarok.SomeAcc.AM = {}
	sets.engaged.Ragnarok.Acc.AM = {}
	sets.engaged.Ragnarok.FullAcc.AM = {}
	sets.engaged.Ragnarok.Fodder.AM = {}
	
	sets.engaged.Ragnarok.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.AM = {}

	sets.engaged.Ragnarok.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.Charge = {}
	sets.engaged.Ragnarok.Acc.Charge = {}
	sets.engaged.Ragnarok.FullAcc.Charge = {}
	sets.engaged.Ragnarok.Fodder.Charge = {}
	
	sets.engaged.Ragnarok.Adoulin.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Charge = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Charge = {}
	
	sets.engaged.Ragnarok.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.Charge.AM = {}
	
	sets.engaged.Ragnarok.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Charge.AM = {}

	sets.engaged.Ragnarok.PDT = {}
	sets.engaged.Ragnarok.SomeAcc.PDT = {}
	sets.engaged.Ragnarok.Acc.PDT = {}
	sets.engaged.Ragnarok.FullAcc.PDT = {}
	sets.engaged.Ragnarok.Fodder.PDT = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin = {}
	
	sets.engaged.Ragnarok.PDT.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.AM = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.AM = {}
	
	sets.engaged.Ragnarok.PDT.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge = {}
	
	sets.engaged.Ragnarok.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge.AM = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Ragnarok.MDT = {}
	sets.engaged.Ragnarok.SomeAcc.MDT = {}
	sets.engaged.Ragnarok.Acc.MDT = {}
	sets.engaged.Ragnarok.FullAcc.MDT = {}
	sets.engaged.Ragnarok.Fodder.MDT = {}
	
	sets.engaged.Ragnarok.MDT.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin = {}
	
	sets.engaged.Ragnarok.MDT.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.AM = {}
	
	sets.engaged.Ragnarok.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.AM = {}
	
	sets.engaged.Ragnarok.MDT.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Charge = {}
	sets.engaged.Ragnarok.Acc.MDT.Charge = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Charge = {}
	sets.engaged.Ragnarok.Fodder.MDT.Charge = {}
	
	sets.engaged.Ragnarok.MDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Charge = {}
	
	sets.engaged.Ragnarok.MDT.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Charge.AM = {}
	
	sets.engaged.Ragnarok.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Charge.AM = {}
	
	sets.engaged.Ragnarok.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.Mighty = {}
	sets.engaged.Ragnarok.Acc.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.Mighty = {}
	sets.engaged.Ragnarok.Fodder.Mighty = {}
	
	sets.engaged.Ragnarok.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Mighty = {}
	
	sets.engaged.Ragnarok.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.Mighty.AM = {}
	
	sets.engaged.Ragnarok.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Mighty.AM = {}

	sets.engaged.Ragnarok.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.Charge.Mighty = {}
	
	sets.engaged.Ragnarok.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Charge.Mighty = {}
	
	sets.engaged.Ragnarok.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.Charge.Mighty.AM = {}
	
	sets.engaged.Ragnarok.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Ragnarok.PDT.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Mighty = {}
	sets.engaged.Ragnarok.Acc.PDT.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Mighty = {}
	sets.engaged.Ragnarok.Fodder.PDT.Mighty = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Mighty = {}
	
	sets.engaged.Ragnarok.PDT.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Mighty.AM = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Mighty.AM = {}
	
	sets.engaged.Ragnarok.PDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge.Mighty = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge.Mighty = {}
	
	sets.engaged.Ragnarok.PDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge.Mighty.AM = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Ragnarok.MDT.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Mighty = {}
	sets.engaged.Ragnarok.Acc.MDT.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Mighty = {}
	sets.engaged.Ragnarok.Fodder.MDT.Mighty = {}
	
	sets.engaged.Ragnarok.MDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Mighty = {}
	
	sets.engaged.Ragnarok.MDT.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Mighty.AM = {}
	
	sets.engaged.Ragnarok.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Mighty.AM = {}
	
	sets.engaged.Ragnarok.MDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.MDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.MDT.Charge.Mighty = {}
	
	sets.engaged.Ragnarok.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Charge.Mighty = {}
	
	sets.engaged.Ragnarok.MDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Charge.Mighty.AM = {}
	
	sets.engaged.Ragnarok.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Charge.Mighty.AM = {}
	
]]--
	
	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {ammo="Per. Lucky Egg"})
end

function job_state_change(field, new_value, old_value)
    if state.Weapons.value == 'GreatSword' then
        send_command('bind !numpad7 input /ws "Resolution" <t>') --Merit ws
		send_command('unbind !numpad8')
		send_command('bind !numpad4 input /ws "Ground Strike" <t>') --Quest WS
		send_command('unbind !numpad5')
		send_command('bind !numpad1 input /ws "Shockwave" <t>') -- AOE WS
		send_command('unbind !numpad3')
    elseif state.Weapons.value == "GreatAxe" then
		send_command('bind !numpad7 input /ws "Upheaval" <t>')
		send_command('bind !numpad8 input /ws "King\'s Justice" <t>')
		send_command('bind !numpad4 input /ws "Steel Cyclone" <t>')
		send_command('bind !numpad5 input /ws "Ukko\'s Fury" <t>')
		send_command('bind !numpad1 input /ws "Fell Cleave" <t>')
		send_command('bind !numpad3 input /ws "Full Break" <t>')
	elseif state.Weapons.value == "SwordShield" then
		send_command('bind !numpad7 input /ws "Requiescat" <t>') --Merit ws
		send_command('unbind !numpad8')
		send_command('bind !numpad4 input /ws "Savage Blade" <t>') --Quest WS
		send_command('bind !numpad5 input /ws "Savage Blade" <lastst>')
		send_command('unbind !numpad1')
		send_command('unbind !numpad3')
	elseif state.Weapons.value == "ShiningOne" then
		send_command('bind !numpad7 input /ws "Stardiver" <t>') --Merit ws
		send_command('unbind !numpad8')
		send_command('bind !numpad4 input /ws "Impulse Drive" <t>') --Quest WS
		send_command('unbind !numpad5')
		send_command('bind !numpad1 input /ws "Sonic Thrust" <t>')
		send_command('unbind !numpad3')
    end


end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 1)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 019')
end