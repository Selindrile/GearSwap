function character_user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DT')
	state.CastingMode:options('Normal','Resistant','AoE')
	state.IdleMode:options('Normal','NoRefresh','DT')
	state.Weapons:options('None','Naegling','Tauret','DualNaegling')

	gear.melee_jse_back = {name="Intarabus's Cape",augments={'Accuracy+20 Attack+20'}}
	gear.magic_jse_back = {name="Intarabus's Cape",augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}

	info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
	info.ExtraSongs = 2
	
	-- Set this to false if you don't want to use custom timers.
	state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
	send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !f7 gs c cycle CarnMode')
	
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.None = {}
	sets.weapons.Naegling = {main="Naegling",sub="Genbu's Shield"}
	sets.weapons.Tauret = {main="Tauret",sub="Kali"}
	sets.weapons.DualNaegling = {main="Naegling",sub="Centovente"}
	
	sets.weapons.DualTauret = {main="Tauret",sub="Centovente"}
	--sets.weapons.DualAeolian = {main="Tauret",sub="Malevolence"}

	sets.buff.Sublimation = {waist="Embla Sash"}
	sets.buff.DTSublimation = {waist="Embla Sash"}
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
        main="Kali", --7
		head="C. Palug Crown",--8
        body="Inyanga Jubbah +2", --14
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Song spellcasting time -5%',}},--12
		legs="Aya. Cosciales +2",
		feet="Fili Cothurnes +2",
		ring1="Kishar ring",
        ear1="Loquac. Earring", --2
		waist="Embla Sash",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+5','"Fast Cast"+10',}}, --10
        }
		
	sets.precast.FC.DT = {}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Vanya Clogs"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genbu Shield",})
	
	sets.precast.FC.BardSong = {
		main="Kali", --7
		head="Fili Calot +2", --14
		body="Brioso Justau. +3", --15
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Song spellcasting time -5%',}},--12
		feet="Fili Cothurnes +2",
		legs="Aya. Cosciales +2",
		ring1="Kishar ring",
        ear1="Loquac. Earring", --2
		ear2="Aoidos' earring",
		waist="Embla Sash",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+5','"Fast Cast"+10',}}, --10
        ring2="Defending Ring",
        }

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Blurred Harp +1"})
	sets.precast.FC.Lullaby = {range="Marsyas"}
	sets.precast.FC.Lullaby.Resistant = {range="Blurred Harp +1"}
	sets.precast.FC['Horde Lullaby'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby'].Resistant = {range="Blurred Harp +1"}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Blurred Harp +1"}
	sets.precast.FC['Horde Lullaby II'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby II'].Resistant = {range="Blurred Harp +1"}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Blurred Harp +1"}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers"}
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps +3"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
			body="Bihu Jstcorps. +3",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        }
		
	sets.precast.WS.Acc = {}
		
	sets.precast.WS['Savage Blade'] = {}
		
	sets.precast.WS['Aeolian Edge'] = {}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {
		ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",
		ring1="Kishar Ring",
		egs="Aya. Cosciales +2",
		feet="Bihu Slippers",
		}

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {range="Gjallarhorn", --[[legs="Fili Rhingrave +2"]]}
	sets.midcast.Lullaby = {range="Blurred Harp +1",}
	sets.midcast.Lullaby.Resistant = {range="Blurred Harp +1",}
	sets.midcast['Horde Lullaby'] = {range="Marsyas",}
	sets.midcast['Horde Lullaby'].Resistant = {range="Blurred Harp +1",}
	sets.midcast['Horde Lullaby'].AoE = {range="Blurred Harp +1",}
	sets.midcast['Horde Lullaby II'] = {
		range="Daurdabla", 
		body="Brioso Justau. +3",
		hands="Inyan. Dastanas +2",
		}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Blurred Harp +1",}
	sets.midcast['Horde Lullaby II'].AoE = {range="Blurred Harp +1",}
	sets.midcast.Madrigal = {head="Fili Calot +2",}
	sets.midcast.Paeon = {range="Daurdabla",}
	sets.midcast.March = {range="Gjallarhorn", hands="Fili Manchettes +2",}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Marsyas"})
	sets.midcast.Minuet = {range="Gjallarhorn", body="Fili Hongreline +3",}
	sets.midcast.Minne = {range="Gjallarhorn", legs="Mou. Seraweels +1",}
	sets.midcast.Threnody = {range="Gjallarhorn", body="Mou. Manteel +1",}
	sets.midcast.Carol = {range="Gjallarhorn", hands="Mousai Gages +1",}
	sets.midcast["Sentinel's Scherzo"] = {range="Gjallarhorn", feet="Fili Cothurnes +2",}
	sets.midcast['Magic Finale'] = {range="Gjallarhorn", legs="Fili Rhingrave +2",}
	sets.midcast.Mazurka = {range="Daurdabla",}
	sets.midcast.Etude = {range="Gjallarhorn", head="Mousai Turban +1",}
	
	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
		main="Kali",
		sub="Genbu's Shield",
		head="Fili Calot +2",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +2",
        legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		ear2="Musical earring",
        }
		
	sets.midcast.SongEffect.DW = {main="Kali",sub="Gleti's Knife"} --Only weapons in this set. This set is overlayed onto  SongEffect

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {
		main="Kali",
		sub="Genbu's Shield",
		head="brioso roundlet +4",
		body="Brioso Justau. +3",
		hands="Inyan. Dastanas +2",
		legs="Brioso Cannions +2",
		feet="Brioso Slippers +3",
		waist="Eschan Stone",
		neck="Mnbw. Whistle +1",
		ring1="Kishar Ring",
		ring2="Crepuscular Ring",
		}
		
	sets.midcast.SongDebuff.DW = {main="Kali",sub="Kali"} --Only weapons in this set. This set is overlayed onto  SongDebuff

	-- For song debuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = {}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {}

	-- Cast spell with normal gear, except using Daurdabla instead
	sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
	sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
		
	sets.midcast['Enhancing Magic'] = {
		head="brioso roundlet +4",
		body="Brioso Justau. +3",
		hands="Inyan. Dastanas +2",
		legs="Brioso Cannions +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Eschan Stone",
		ring1="Kishar Ring",
		ring2="Crepuscular Ring",

        }
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
		
	sets.midcast['Elemental Magic'] = {}
		
	sets.midcast['Elemental Magic'].Resistant = {}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	-- Resting sets
	sets.resting = {}
	
	sets.idle = {
		head="Inyanga Tiara +2",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +2",
		legs="Inyanga Shalwar +2",
		feet="Fili Cothurnes +2",
		neck="Loricate Torque",
		}
		
	sets.idle.NoRefresh = {}

	sets.idle.DT = {
		main="Daybreak",
		sub="Genbu's Shield",
		neck="Loricate Torque", --5/5
        ring2="Defending Ring",  --10/10}
		}
	-- Defense sets

	sets.defense.PDT = {		
		neck="Loricate Torque", --5/5
        ring2="Defending Ring",  --10/10}
		}
	sets.defense.MDT = {       
	head="Inyanga Tiara +2", --0/5
        body="Inyanga Jubbah +2", --0/8
        legs="Inyanga Shalwar +2", --0/6
        feet="Inyan. Crackows +2", --0/3}
		}
	sets.Kiting = {feet="Fili Cothurnes +2"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {
			range={ name="Linos", augments={'Accuracy+13 Attack+13','"Dbl.Atk."+2','Quadruple Attack +3',}},
			head="Aya. Zucchetto +2",
			body="Ayanmo Corazza +2",
			hands="Aya. Manopolas +2",
			legs="Aya. Cosciales +2",
			feet="Aya. Gambieras +2",
			neck={ name="Bard's Charm", augments={'Path: A',}},
			waist="Sailfi Belt +1",
			left_ear="Cessance Earring",
			right_ear="Suppanomimi",
			left_ring="Inyanga Ring",
			right_ring="Ayanmo Ring",
			back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+5','"Fast Cast"+10',}}

        }
	sets.engaged.DT = {}
	sets.engaged.Acc = {}
	sets.engaged.DW = {			
			range={ name="Linos", augments={'Accuracy+13 Attack+13','"Dbl.Atk."+2','Quadruple Attack +3',}},
			head="Aya. Zucchetto +2",
			body="Ayanmo Corazza +2",
			hands="Aya. Manopolas +2",
			legs="Aya. Cosciales +2",
			feet="Aya. Gambieras +2",
			neck={ name="Bard's Charm", augments={'Path: A',}},
			waist="Sailfi Belt +1",
			left_ear="Cessance Earring",
			right_ear="Suppanomimi",
			left_ring="Inyanga Ring",
			right_ring="Ayanmo Ring",
			back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+5','"Fast Cast"+10',}}

      }
	sets.engaged.DW.DT = {}
	sets.engaged.DW.Acc = {}
	sets.engaged.DW.Acc.DT = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 10)
end

autows_list = {['Tauret']='Evisceration',['Naegling']='Savage Blade',['Aeneas']="Rudra's Storm",['DualWeapons']="Rudra's Storm",['DualNaegling']='Savage Blade',['DualTauret']='Evisceration',
	 ['DualAeolian']='Aeolian Edge'}
