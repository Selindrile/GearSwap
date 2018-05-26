function user_setup()
	state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
	state.HybridMode:options('Normal', 'PDT')
	state.WeaponskillMode:options('Match','Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
	state.CastingMode:options('Normal')
	state.IdleMode:options('Normal', 'Refresh', 'Reraise')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PetPDT', 'PDT', 'Reraise', 'PKiller')
	state.MagicalDefenseMode:options('PetMDT','MDT', 'MKiller')
	state.ResistDefenseMode:options('PetMEVA', 'MEVA')
	state.Weapons:options('None','PetPDTAxe','DualWeapons')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Knockback','Suppa','DWEarrings'}

	send_command('bind !f11 gs c cycle ExtraMeleeMode')

	gear.PHYKumbha1 = {name="Kumbhakarna", augments={'Pet: Attack+20 Pet: Rng.Atk.+20','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: TP Bonus+180',}}
	gear.PHYKumbha2 = {name="Kumbhakarna", augments={'Pet: Accuracy+18 Pet: Rng. Acc.+18','Pet: TP Bonus+160',}}
	gear.PDTMABKumbha = {name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+20','Pet: Phys. dmg. taken -4%','Pet: TP Bonus+200',}}
	gear.MABKumbha = {name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+19','Pet: TP Bonus+160',}}

	-- Set up Jug Pet cycling and keybind Ctrl+F7
	-- INPUT PREFERRED JUG PETS HERE
	state.JugMode = M{['description']='Jug Mode', 'ScissorlegXerin','BlackbeardRandy','AttentiveIbuki','DroopyDortwin','WarlikePatrick','AcuexFamiliar'}
	send_command('bind ^f7 gs c cycle JugMode')

	-- Set up Monster Correlation Modes and keybind Alt+F7
	state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'Favorable'}
	send_command('bind !f7 gs c cycle CorrelationMode')

	-- Set up Pet Modes for Hybrid sets and keybind 'Windows Key'+F7
	state.PetMode = M{['description']='Pet Mode', 'PetOnly', 'PetTank', 'PetStance',  'Normal'}
	send_command('bind @f7 gs c cycle PetMode')

	-- Set up Reward Modes and keybind Ctrl+Backspace
	state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Zeta', 'Eta'}
	send_command('bind ^backspace gs c cycle RewardMode')

	send_command('bind @f8 gs c toggle AutoReadyMode')
	send_command('bind !` gs c ready default')

	--Example of how to change default ready moves.
	--ready_moves.default.WarlikePatrick = 'Tail Blow'

	--select_default_macro_book()
end

-- BST gearsets
function init_gear_sets()
	-- PRECAST SETS
	sets.precast.JA['Killer Instinct'] = {} --head="Ankusa Helm +1"
	sets.precast.JA['Bestial Loyalty'] = {
		hands="Ankusa Gloves +1",
		body="Mirke Wardecors",
	}
	sets.precast.JA['Call Beast'] = sets.precast.JA['Bestial Loyalty']
	sets.precast.JA.Familiar = {legs="Ankusa Trousers +1"}
	sets.precast.JA.Tame = {}--head="Totemic Helm +1"
	sets.precast.JA.Spur = {back="Artio's Mantle",feet="Nukumi Ocreae +1"}
	sets.SpurAxe = {main="Skullrender"}
	sets.SpurAxesDW = {main="Skullrender",sub="Skullrender"}

	sets.precast.JA['Feral Howl'] = {}

	sets.precast.JA.Reward = {
		head="Khimaira Bonnet",
		body="Tot. Jackcoat +1",
		--hands="Regimen Mittens",
		hands="Leyline Gloves",
		legs="Ankusa Trousers +1",
		--feet="Ankusa Gaiters +1",
		feet="Shukuyu Sune-Ate",
		--neck="Phalaina Locket",
		neck="Aife's Medal",
		ear1="Etiolation Earring",
		ear2="Pratik earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Pastoralist's Mantle",
		waist="Crudelis Belt",
	}

	sets.precast.JA.Reward.Theta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Theta"})
	sets.precast.JA.Reward.Zeta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Zeta"})
	sets.precast.JA.Reward.Eta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Eta"})

	sets.precast.JA.Charm = {}

	-- CURING WALTZ
	sets.precast.Waltz = {
		neck="Loricate Torque +1",
		ear1="Enmerkar Earring",
		ear2="Handler's Earring +1",
		body="Tot. Jackcoat +1",
		--hands="Regimen Mittens",
		--ring1="Valseur's Ring",
		ring2="Asklepian Ring",
		back="Moonlight Cape",
		waist="Chaac Belt",
		legs="Dashing Subligar",
		feet="Valorous Greaves"
	}

		-- HEALING WALTZ
	sets.precast.Waltz['Healing Waltz'] = {}

		-- STEPS
	sets.precast.Step = {}

		-- VIOLENT FLOURISH
	sets.precast.Flourish1 = {}
	sets.precast.Flourish1['Violent Flourish'] = {}

	sets.precast.FC = {
		ammo="Impatiens",
		neck="Voltsurge Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquacious Earring",
		body="Jumalik Mail",
		hands="Leyline Gloves",
		ring1="Kishar Ring",
		ring2="Prolix Ring",
		waist="Ninurta's Sash",
	}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	-- MIDCAST SETS
	sets.midcast.FastRecast = {
		waist="Ninurta's Sash",
	}

	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

	sets.midcast.Cure = {}

	sets.midcast.Curaga = sets.midcast.Cure

	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	sets.midcast.Stoneskin = sets.midcast.FastRecast

	sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {neck="Debilis Medallion",ring1="Haoma's Ring",ring2="Haoma's Ring"})

	sets.midcast.Protect = set_combine(sets.midcast.FastRecast, {ring2="Sheltered Ring"})
	sets.midcast.Protectra = sets.midcast.Protect

	sets.midcast.Shell = set_combine(sets.midcast.FastRecast, {ring2="Sheltered Ring"})
	sets.midcast.Shellra = sets.midcast.Shell

	sets.midcast['Enfeebling Magic'] = sets.midcast.FastRecast

	sets.midcast['Elemental Magic'] = sets.midcast.FastRecast

	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic']

		-- WEAPONSKILLS
		-- Default weaponskill sets.
	sets.precast.WS = {
		ammo="Hasty Pinion +1",
		head="Argosy Celata +1",
		body="Argosy Hauberk +1",
		hands="Argosy Mufflers +1",
		legs="Argosy Breeches +1",
		feet="Argosy Sollerets +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		ring1="Regal Ring",
		ring2="Ilabrat Ring",
		back="Artio's Mantle",
	}

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS,{})
	sets.precast.WS.Acc = set_combine(sets.precast.WS,{})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS,{})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS,{})

	-- Specific weaponskill sets.
	sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Ruinator'].Mekira = set_combine(sets.precast.WS['Ruinator'], {head="Gavialis Helm"})
	sets.precast.WS['Ruinator'].WSMedAcc = set_combine(sets.precast.WS.WSMedAcc, {})
	sets.precast.WS['Ruinator'].WSHighAcc = set_combine(sets.precast.WS.WSHighAcc, {})

	sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Onslaught'].WSMedAcc = set_combine(sets.precast.WSMedAcc, {})
	sets.precast.WS['Onslaught'].WSHighAcc = set_combine(sets.precast.WSHighAcc, {})

	sets.precast.WS['Primal Rend'] = {
		ammo="Pemphredo Tathlum",
		--head="Jumalik Helm",
		head=gear.Val_Head_WSD,
		body="Jumalik Mail",
		hands="Leyline Gloves",
		--legs="Tali'ah Sera. +1",
		legs=gear.Val_Legs_WSD,
		--feet="Tot. Gaiters +1",
		feet=gear.Val_Feet_WSD,
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
		back="Toro Cape",
	}

	sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {})

		-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring",ear2="Sherida Earring",}
	sets.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}

				-- PET SIC & READY MOVES
	sets.midcast.Pet.WS = {
		ammo="Demonry Core",
		head=gear.Val_Head_PetATT,
		body=gear.Val_Body_PetATT,
		hands="Nukumi Manoplas +1",
		legs=gear.Val_Legs_PetATT,
		feet=gear.Val_Feet_PetATT,
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		ring1="Varar Ring",
		ring2="Varar Ring",
		ear1="Enmerkar Earring",
		ear2="Domesticator's Earring",
		back="Pastoralist's Mantle",
	}

	sets.midcast.Pet.MagicReady = {
		ammo="Demonry Core",
		head=gear.Val_Head_PetATT,
		body=gear.Val_Body_PetATT,
		hands="Nukumi Manoplas +1",
		legs=gear.Val_Legs_PetATT,
		feet=gear.Val_Feet_PetATT,
		neck="Adad amulet",
		waist="Incarnation Sash",
		ear1="Enmerkar Earring",
		ear2="Domesticator's Earring",
		ring1="Varar Ring",
		ring2="Varar Ring",
		back="Argocham. Mantle",
	}

	sets.midcast.Pet.Acc = set_combine(sets.midcast.Pet.WS, {hands="Regimen Mittens"}) --legs="Wisent Kecks",head="Totemic Helm +1",
	sets.midcast.Pet.FullAcc = set_combine(sets.midcast.Pet.WS, {hands="Regimen Mittens"}) --head="Totemic Helm +1",legs="Wisent Kecks"

	sets.midcast.Pet.ReadyRecast = {legs="Desultor Tassets"}
	sets.midcast.Pet.Neutral = {}--head="Totemic Helm +1"
	sets.midcast.Pet.Favorable = {head="Nukumi Cabasset"}
	sets.midcast.Pet.TPBonus = {hands="Nukumi Manoplas +1"}

	-- PET-ONLY SETS THAT SWAP WEAPONS FOR READY AND IDLE
	sets.midcast.Pet.ReadyRecastNE = {sub="Charmer's Merlin",legs="Desultor Tassets"}
	sets.midcast.Pet.ReadyNE = set_combine(sets.midcast.Pet.WS, {
			main={ name="Digirbalag", augments={'Pet: Damage taken -1%','Pet: STR+3','Pet: Accuracy+18 Pet: Rng. Acc.+18','Pet: Attack+26 Pet: Rng.Atk.+26','DMG:+2',}},
			sub={ name="Digirbalag", augments={'Pet: Damage taken -3%','Pet: CHR+5','Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: Attack+30 Pet: Rng.Atk.+30','DMG:+10',}},
	})
	sets.midcast.Pet.ReadyNE.MedAcc = sets.midcast.Pet.ReadyNE
	sets.midcast.Pet.ReadyNE.FullAcc = sets.midcast.Pet.ReadyNE

	sets.midcast.Pet.MagicReadyNE = set_combine(sets.midcast.Pet.MagicReady, sets.midcast.Pet.ReadyNE)

	sets.IdleAxesNE = {main="Izizoeksi",sub=gear.PDTMABKumbha}
	sets.RewardAxe = {}
	sets.RewardAxesDW = {}

	-- RESTING
	sets.resting = {}

	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Genmei Kabuto",
		body="Tartarus Platemail",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		--feet="Meg. Jam. +2",
    feet="Skadi's Jambeaux +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		ear1="Rimeice Earring",
		ear2="Genmei Earring",
		ring1="Defending Ring",
		--ring2="Vocane Ring",
		ring2="Sheltered Ring",
		back="Moonlight Cape",
	}

	sets.idle.Refresh = set_combine(sets.idle, {})
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

	sets.idle.Pet = set_combine(sets.idle, {
		ead="Anwig Salade",
		--legs="Nukumi Quijotes +1",
		--feet="Skadi's Jambeaux +1",
		neck="Shulmanu Collar",
		--ammo="Demonry Core",
		--ring1="Thurandaut Ring",
		--ring2="Succor Ring",
		ear1="Handler's Earring",
		ear2="Handler's Earring +1",
		back="Pastoralist's Mantle",
		waist="Isa Belt"
	})

	sets.idle.Pet.Engaged = set_combine(sets.idle.Pet, {
		ammo="Demonry Core",
		head="Anwig Salade",
		neck="Shulmanu Collar",
		ear1="Enmerkar Earring",
		ear2="Handler's Earring +1",
		body="Tot. Jackcoat +1",
		hands="Regimen Mittens",
		ring1="Defending Ring",
		ring2="Dark Ring",
		back="Pastoralist's Mantle",
		waist="Klouskap Sash",
		legs="Tali'ah Sera. +2",
		feet="Tot. Gaiters +1",
	})

	-- DEFENSE SETS
	sets.defense.PDT = {}

	sets.defense.PetPDT = set_combine(sets.idle.Pet, {})

	sets.defense.PetMDT = set_combine(sets.idle.Pet, {})

	sets.defense.PetMEVA = sets.defense.PetMDT

	sets.defense.PKiller = set_combine(sets.defense.PDT, {body="Nukumi Gausape +1"})
	sets.defense.Reraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MDT = {}
	sets.defense.MEVA = {}

	sets.defense.MKiller = set_combine(sets.defense.MDT, {body="Nukumi Gausape +1"})

	sets.Kiting = {feet="Skd. Jambeaux +1"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- MELEE (SINGLE-WIELD) SETS
	sets.engaged = {
		main="Izizoeksi",
		ammo="Ginsen",
		head="Argosy Celata +1",
		body="Tali'ah Manteel +1",
		hands="Argosy Mufflers +1",
		legs="Meghanada Chausses +2",
		feet="Argosy Sollerets +1",
		neck="Asperity Necklace",
		ear1="Cessance Earring",
		ear2="Sherida Earring",
		ring1="Hetairoi Ring",
		ring2="Epona's Ring",
		back="Artio's Mantle",
		waist="Windbuffet Belt +1",
	}

	sets.engaged.SomeAcc = set_combine(sets.engaged,{})
	sets.engaged.Acc = set_combine(sets.engaged,{})
	sets.engaged.FullAcc = set_combine(sets.engaged,{})
	sets.engaged.Fodder = set_combine(sets.engaged,{})

	-- MELEE (SINGLE-WIELD) HYBRID SETS
	sets.engaged.PDT = set_combine(sets.engaged,{
		ammo="Staunch Tathlum +1",
		neck="Loricate Torque +1",
		ring1="Defending Ring",
		ring2="Vocane Ring",
		back="Moonlight Cape",
	})
	sets.engaged.SomeAcc.PDT = set_combine(sets.engaged.PDT,{})
	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT,{})
	sets.engaged.FullAcc.PDT = set_combine(sets.engaged.PDT,{})
	sets.engaged.Fodder.PDT = set_combine(sets.engaged.PDT,{})

	-- MELEE (DUAL-WIELD) SETS FOR DNC AND NIN SUBJOB
	sets.engaged.DW = set_combine(sets.engaged,{})
	sets.engaged.DW.SomeAcc = set_combine(sets.engaged,{})
	sets.engaged.DW.Acc = set_combine(sets.engaged,{})
	sets.engaged.DW.FullAcc = set_combine(sets.engaged,{})
	sets.engaged.DW.Fodder = set_combine(sets.engaged,{})

	-- MELEE (DUAL-WIELD) HYBRID SETS
	sets.engaged.DW.PDT = set_combine(sets.engaged.PDT, {})
	sets.engaged.DW.SomeAcc.PDT = set_combine(sets.engaged.SomeAcc.PDT, {})
	sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.Acc.PDT, {})
	sets.engaged.DW.FullAcc.PDT = set_combine(sets.engaged.FullAcc.PDT, {})

	-- GEARSETS FOR MASTER ENGAGED (SINGLE-WIELD) & PET ENGAGED
	sets.engaged.PetStance = set_combine(sets.engaged,{})
	sets.engaged.PetStance.SomeAcc = set_combine(sets.engaged.SomeAcc, {})
	sets.engaged.PetStance.Acc = set_combine(sets.engaged.Acc, {})
	sets.engaged.PetStance.FullAcc = set_combine(sets.engaged.FullAcc, {})
	sets.engaged.PetStance.Fodder = set_combine(sets.engaged.Fodder, {})

	-- GEARSETS FOR MASTER ENGAGED (SINGLE-WIELD) & PET TANKING
	sets.engaged.PetTank = set_combine(sets.engaged,{})
	sets.engaged.PetTank.SomeAcc = set_combine(sets.engaged.SomeAcc, {})
	sets.engaged.PetTank.Acc = set_combine(sets.engaged.Acc, {})
	sets.engaged.PetTank.FullAcc = set_combine(sets.engaged.FullAcc, {})
	sets.engaged.PetTank.Fodder = set_combine(sets.engaged.Fodder, {})

	-- GEARSETS FOR MASTER ENGAGED (DUAL-WIELD) & PET ENGAGED
	sets.engaged.DW.PetStance = set_combine(sets.engaged.DW,{})
	sets.engaged.DW.PetStance.SomeAcc = set_combine(sets.engaged.DW.SomeAcc, {})
	sets.engaged.DW.PetStance.Acc = set_combine(sets.engaged.DW.Acc, {})
	sets.engaged.DW.PetStance.FullAcc = set_combine(sets.engaged.DW.FullAcc, {})
	sets.engaged.DW.PetStance.Fodder = set_combine(sets.engaged.DW.Fodder, {})

	-- GEARSETS FOR MASTER ENGAGED (DUAL-WIELD) & PET TANKING
	sets.engaged.DW.PetTank = set_combine(sets.engaged.DW,{})
	sets.engaged.DW.PetTank.SomeAcc = set_combine(sets.engaged.DW.SomeAcc, {})
	sets.engaged.DW.PetTank.Acc = set_combine(sets.engaged.DW.Acc, {})
	sets.engaged.DW.PetTank.FullAcc = set_combine(sets.engaged.DW.FullAcc, {})
	sets.engaged.DW.PetTank.Fodder = set_combine(sets.engaged.DW.Fodder, {})

	sets.buff['Killer Instinct'] = {body="Nukumi Gausape +1"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Knockback = {}
	sets.SuppaBrutal = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}

	-- Weapons sets
	sets.weapons.PetPDTAxe = {main ="Kerehcatl"}
	sets.weapons.DualWeapons = {main ="Freydis",sub={ name="Digirbalag", augments={'Pet: Damage taken -1%','Pet: STR+3','Pet: Accuracy+18 Pet: Rng. Acc.+18','Pet: Attack+26 Pet: Rng.Atk.+26','DMG:+2',}},}


-------------------------------------------------------------------------------------------------------------------
-- Complete Lvl 76-99 Jug Pet Precast List +Funguar +Courier +Amigo
-------------------------------------------------------------------------------------------------------------------
--[[
	sets.precast.JA['Bestial Loyalty'].FunguarFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Seedbed Soil"})
	sets.precast.JA['Bestial Loyalty'].CourierCarrie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Fish Oil Broth"})
	sets.precast.JA['Bestial Loyalty'].AmigoSabotender = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sun Water"})
	sets.precast.JA['Bestial Loyalty'].NurseryNazuna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="D. Herbal Broth"})
	sets.precast.JA['Bestial Loyalty'].CraftyClyvonne = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Cng. Brain Broth"})
	sets.precast.JA['Bestial Loyalty'].PrestoJulio = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="C. Grass. Broth"})
	sets.precast.JA['Bestial Loyalty'].SwiftSieghard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Mlw. Bird Broth"})
	sets.precast.JA['Bestial Loyalty'].MailbusterCetas = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Gob. Bug Broth"})
	sets.precast.JA['Bestial Loyalty'].AudaciousAnna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="B. Carrion Broth"})
	sets.precast.JA['Bestial Loyalty'].TurbidToloi = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Auroral Broth"})
	sets.precast.JA['Bestial Loyalty'].LuckyLulush = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="L. Carrot Broth"})
	sets.precast.JA['Bestial Loyalty'].DipperYuly = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wool Grease"})
	sets.precast.JA['Bestial Loyalty'].FlowerpotMerle = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Vermihumus"})
	sets.precast.JA['Bestial Loyalty'].DapperMac = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Briny Broth"})
	sets.precast.JA['Bestial Loyalty'].DiscreetLouise = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Deepbed Soil"})
	sets.precast.JA['Bestial Loyalty'].FatsoFargann = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="C. Plasma Broth"})
	sets.precast.JA['Bestial Loyalty'].FaithfulFalcorr = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Lucky Broth"})
	sets.precast.JA['Bestial Loyalty'].BugeyedBroncha = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Svg. Mole Broth"})
	sets.precast.JA['Bestial Loyalty'].BloodclawShasra = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rzr. Brain Broth"})
	sets.precast.JA['Bestial Loyalty'].GorefangHobs = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="B. Carrion Broth"})
	sets.precast.JA['Bestial Loyalty'].GooeyGerard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Cl. Wheat Broth"})
	sets.precast.JA['Bestial Loyalty'].CrudeRaphie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Shadowy Broth"})
]]--
	-------------------------------------------------------------------------------------------------------------------
	-- Complete iLvl Jug Pet Precast List
	-------------------------------------------------------------------------------------------------------------------
--[[
	sets.precast.JA['Bestial Loyalty'].DroopyDortwin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Swirling Broth"})
	sets.precast.JA['Bestial Loyalty'].PonderingPeter = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Vis. Broth"})
	sets.precast.JA['Bestial Loyalty'].SunburstMalfik = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Shimmering Broth"})
	sets.precast.JA['Bestial Loyalty'].AgedAngus = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Ferm. Broth"})
	sets.precast.JA['Bestial Loyalty'].WarlikePatrick = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Livid Broth"})
	sets.precast.JA['Bestial Loyalty'].ScissorlegXerin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Spicy Broth"})
	sets.precast.JA['Bestial Loyalty'].BouncingBertha = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Bubbly Broth"})
	sets.precast.JA['Bestial Loyalty'].RhymingShizuna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Lyrical Broth"})
	sets.precast.JA['Bestial Loyalty'].AttentiveIbuki = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Salubrious Broth"})
	sets.precast.JA['Bestial Loyalty'].SwoopingZhivago = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Windy Greens"})
	sets.precast.JA['Bestial Loyalty'].AmiableRoche = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Airy Broth"})
	sets.precast.JA['Bestial Loyalty'].HeraldHenry = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Trans. Broth"})
	sets.precast.JA['Bestial Loyalty'].BrainyWaluis = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Crumbly Soil"})
	sets.precast.JA['Bestial Loyalty'].HeadbreakerKen = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Blackwater Broth"})
	sets.precast.JA['Bestial Loyalty'].SuspiciousAlice = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Furious Broth"})
	sets.precast.JA['Bestial Loyalty'].AnklebiterJedd = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Crackling Broth"})
	sets.precast.JA['Bestial Loyalty'].FleetReinhard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rapid Broth"})
	sets.precast.JA['Bestial Loyalty'].CursedAnnabelle = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Creepy Broth"})
	sets.precast.JA['Bestial Loyalty'].SurgingStorm = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Insipid Broth"})
	sets.precast.JA['Bestial Loyalty'].SubmergedIyo = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Deepwater Broth"})
	sets.precast.JA['Bestial Loyalty'].RedolentCandi = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Electrified Broth"})
	sets.precast.JA['Bestial Loyalty'].AlluringHoney = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Bug-Ridden Broth"})
	sets.precast.JA['Bestial Loyalty'].CaringKiyomaro = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Fizzy Broth"})
	sets.precast.JA['Bestial Loyalty'].VivaciousVickie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Tant. Broth"})
	sets.precast.JA['Bestial Loyalty'].HurlerPercival = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Pale Sap"})
	sets.precast.JA['Bestial Loyalty'].BlackbeardRandy = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Meaty Broth"})
	sets.precast.JA['Bestial Loyalty'].GenerousArthur = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Dire Broth"})
	sets.precast.JA['Bestial Loyalty'].ThreestarLynn = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Muddy Broth"})
	sets.precast.JA['Bestial Loyalty'].MosquitoFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wetlands Broth"})
	sets.precast.JA['Bestial Loyalty']['Left-HandedYoko'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Heavenly Broth"})
	sets.precast.JA['Bestial Loyalty'].BraveHeroGlenn = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wispy Broth"})
	sets.precast.JA['Bestial Loyalty'].SharpwitHermes = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Saline Broth"})
	sets.precast.JA['Bestial Loyalty'].ColibriFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sugary Broth"})
	sets.precast.JA['Bestial Loyalty'].ChoralLeera = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Glazed Broth"})
	sets.precast.JA['Bestial Loyalty'].SpiderFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sticky Webbing"})
	sets.precast.JA['Bestial Loyalty'].GussyHachirobe = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Slimy Webbing"})
	sets.precast.JA['Bestial Loyalty'].AcuexFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Poisonous Broth"})
	sets.precast.JA['Bestial Loyalty'].FluffyBredo = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Venomous Broth"})
]]--
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(6, 16)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 16)
	elseif player.sub_job == 'THF' then
		set_macro_page(6, 20)
	elseif player.sub_job == 'RUN' then
		set_macro_page(7, 20)
	else
		set_macro_page(6, 20)
	end
end

function user_job_tick()
	if state.AutoReadyMode.value and player.sub_job == 'NIN' and not moving and not (buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)']) then
		local spell_recasts = windower.ffxi.get_spell_recasts()

		if spell_recasts[339] == 0 then
			send_command('input /ma "Utsusemi: Ni" <me>')
			tickdelay = 250
			return true
		end

	end
	return false
end
