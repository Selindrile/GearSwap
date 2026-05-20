function character_user_job_setup()
	state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DT','PetTank','BothDD')
	state.WeaponskillMode:options('Match','Normal','Acc')
	state.CastingMode:options('Normal')
	state.IdleMode:options('Normal','Refresh')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PetPDT','PDT')
	state.MagicalDefenseMode:options('PetMDT','MDT')
	state.ResistDefenseMode:options('PetMEVA','MEVA')
	state.Weapons:options('None','Default','DualWeapons')
	autows_list = {['Default']='Ruinator',['DualWeapons']='Ruinator'}

	-- Set up Jug Pet cycling and keybind Ctrl+F7
	-- INPUT PREFERRED JUG PETS HERE
	state.JugMode = M{['description']='Jug Mode','GenerousArthur','ScissorlegXerin','BlackbeardRandy','AttentiveIbuki','DroopyDortwin','WarlikePatrick','AcuexFamiliar'}
	send_command('bind !f7 gs c cycle JugMode')

	-- Set up Monster Correlation Modes and keybind Alt+F7
	state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'Favorable'}
	send_command('bind @!f7 gs c cycle CorrelationMode')

	-- Set up Pet Modes for Hybrid sets and keybind 'Windows Key'+F7
	state.PetMode = M{['description']='Pet Mode','Tank','DD'}
	send_command('bind @f9 gs c cycle PetMode')

	-- Set up Reward Modes and keybind Ctrl+Backspace
	state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Zeta', 'Eta'}
	send_command('bind ^backspace gs c cycle RewardMode')

	send_command('bind @f8 gs c toggle AutoReadyMode')
	send_command('bind !` gs c ready default')

	--Example of how to change default ready moves.
	--ready_moves.default.WarlikePatrick = 'Tail Blow'


	--Ikenga_axe_bonus = 300  -- It is 300 at R25. Uncomment if you need to manually adjust because you are using below R25 or above

	select_default_macro_book()
end

-- BST gearsets
function init_gear_sets()
	-- PRECAST SETS
	sets.precast.JA['Killer Instinct'] = {} --head="Ankusa Helm +1"
	sets.precast.JA['Bestial Loyalty'] = {hands="Ankusa Gloves +1"} --body="Mirke Wardecors"
	sets.precast.JA['Call Beast'] = sets.precast.JA['Bestial Loyalty']
	sets.precast.JA.Familiar = {} --legs="Ankusa Trousers +1"
	sets.precast.JA.Tame = {} --head="Totemic Helm +1"
	sets.precast.JA.Spur = {back="Artio's Mantle",feet="Nukumi Ocreae +3"}
	sets.SpurAxe = {main="Skullrender"}
	sets.SpurAxesDW = {main="Skullrender",sub="Skullrender"}

	sets.precast.JA['Feral Howl'] = {}

	sets.precast.JA.Reward = {main="Mdomo Axe",sub="Sacro Bulwark", --+1 and Augment the Axe
		head="Null Masque",neck="Phalaina Locket",ear1="Ferine Earring",ear2="Nukumi Earring +1", --head="Stout Bonnet"
		body="Nyame Mail",hands="Malignance Gloves",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back="Artio's Mantle",waist="Isa Belt",legs="Nukumi Quijotes +3",feet="Monster Gaiters +2"}

	sets.precast.JA.Reward.DW = {}

	sets.precast.JA.Reward.Theta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Theta"})
	sets.precast.JA.Reward.Zeta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Zeta"})
	sets.precast.JA.Reward.Eta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Eta"})
	

	sets.precast.JA.Charm = {}

	-- CURING WALTZ
	sets.precast.Waltz = {}

		-- HEALING WALTZ
	sets.precast.Waltz['Healing Waltz'] = {}

		-- STEPS
	sets.precast.Step = {}

		-- VIOLENT FLOURISH
	sets.precast.Flourish1 = {}
	sets.precast.Flourish1['Violent Flourish'] = {}

	sets.precast.FC = {}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

		-- MIDCAST SETS
	sets.midcast.FastRecast = {}

	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {}) --back="Mujin Mantle"

	sets.midcast.Cure = {}

	sets.midcast.Curaga = sets.midcast.Cure

	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	sets.midcast.Stoneskin = sets.midcast.FastRecast

	sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {neck="Debilis Medallion",ring1="Haoma's Ring",ring2="Menelaus's Ring"})

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
	sets.precast.WS = {}

	sets.precast.WS.Acc = {}

		-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Sherida Earring",ear2="Brutal Earring",}
	sets.AccMaxTP = {ear1="Telos Earring",ear2="Nukumi Earring +1"}

				-- PET SIC & READY MOVES
	sets.midcast.Pet.WS = {main="Agwu's Axe",sub="Sacro Bulwark",ammo="Voluspa Tathlum",
		head="Nuk. Cabasset +3",neck="Adad Amulet",ear1="Kyrene's Earring",ear2="Nukumi Earring +1",
		body="Nukumi Gausape +3",hands="Nukumi Manoplas +3",ring1="Tali'ah Ring",ring2="Stikini Ring +1", --ring2="C. Palug Ring"
		back="Artio's Mantle",waist="Incarnation Sash",legs="Nukumi Quijotes +3",feet="Gleti's Boots"}

	sets.midcast.Pet.Acc = {main="Agwu's Axe",sub="Sacro Bulwark",ammo="Voluspa Tathlum",
		head="Nuk. Cabasset +3",neck="Adad Amulet",ear1="Kyrene's Earring",ear2="Nukumi Earring +1",
		body="Nukumi Gausape +3",hands="Nukumi Manoplas +3",ring1="Tali'ah Ring",ring2="Stikini Ring +1", --ring2="C. Palug Ring"
		back="Artio's Mantle",waist="Incarnation Sash",legs="Nukumi Quijotes +3",feet="Gleti's Boots"}
				
	sets.midcast.Pet.MagicReady = {main="Agwu's Axe",sub="Sacro Bulwark",ammo="Voluspa Tathlum",
		head="Nuk. Cabasset +3",neck="Adad Amulet",ear1="Kyrene's Earring",ear2="Nukumi Earring +1",
		body="Nukumi Gausape +3",hands="Nukumi Manoplas +3",ring1="Tali'ah Ring",ring2="Stikini Ring +1", --ring2="C. Palug Ring"
		back="Artio's Mantle",waist="Incarnation Sash",legs="Nukumi Quijotes +3",feet="Gleti's Boots"}
		
	sets.midcast.Pet.DebuffReady = {main="Agwu's Axe",sub="Sacro Bulwark",ammo="Voluspa Tathlum",
		head="Nuk. Cabasset +3",neck="Adad Amulet",ear1="Kyrene's Earring",ear2="Nukumi Earring +1",
		body="Nukumi Gausape +3",hands="Nukumi Manoplas +3",ring1="Tali'ah Ring",ring2="Stikini Ring +1", --ring2="C. Palug Ring"
		back="Artio's Mantle",waist="Incarnation Sash",legs="Nukumi Quijotes +3",feet="Gleti's Boots"}
		
	sets.midcast.Pet.PhysicalDebuffReady = {main="Agwu's Axe",sub="Sacro Bulwark",ammo="Voluspa Tathlum",
		head="Nuk. Cabasset +3",neck="Adad Amulet",ear1="Kyrene's Earring",ear2="Nukumi Earring +1",
		body="Nukumi Gausape +3",hands="Nukumi Manoplas +3",ring1="Tali'ah Ring",ring2="Stikini Ring +1", --ring2="C. Palug Ring"
		back="Artio's Mantle",waist="Incarnation Sash",legs="Nukumi Quijotes +3",feet="Gleti's Boots"}

	sets.midcast.Pet.ReadyRecast = {main="Charmer's Merlin",legs="Gleti's Breeches"}
	sets.midcast.Pet.ReadyRecastDW = {sub="Charmer's Merlin",legs="Gleti's Breeches"}
	sets.midcast.Pet.Neutral = {}
	sets.midcast.Pet.Favorable = {head="Nuk. Cabasset +3"}
	sets.midcast.Pet.TPBonus = {hands="Nukumi Manoplas +3"}

	-- RESTING
	sets.resting = {}

	sets.idle = {main="Agwu's Axe",sub="Sacro Bulwark",ammo="Voluspa Tathlum",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Infused Earring",ear2="Sanare Earring", --ear1="Domesticator's Earring+1"
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shneddick Ring",
		back="Null Shawl",waist="Null Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.idle.Refresh = {}
		
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

	sets.idle.Pet = {main="Agwu's Axe",sub="Sacro Bulwark",ammo="Voluspa Tathlum",
		head="Nuk. Cabasset +3",neck="Empath Necklace",ear1="Odnowa Earring +1",ear2="Nukumi Earring +1", --ear1="Domesticator's Earring+1"
		body="Nyame Mail",hands="Gleti's Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Artio's Mantle",waist="Isa Belt",legs="Nukumi Quijotes +3",feet="Gleti's Boots"}
		
	sets.idle.Pet.DW = {main="Agwu's Axe",sub="Astolfo"}

	sets.idle.Pet.Engaged = {main="Agwu's Axe",sub="Sacro Bulwark",ammo="Voluspa Tathlum",
		head="Nuk. Cabasset +3",neck="Empath Necklace",ear1="Odnowa Earring +1",ear2="Nukumi Earring +1", --ear1="Domesticator's Earring+1"
		body="Nyame Mail",hands="Gleti's Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Artio's Mantle",waist="Isa Belt",legs="Nukumi Quijotes +3",feet="Gleti's Boots"}

	sets.idle.Pet.Engaged.DW = {main="Agwu's Axe",sub="Astolfo"}

	-- DEFENSE SETS
	sets.defense.PDT = {}

	sets.defense.PetPDT = {}

	sets.defense.PetMDT = {}

	sets.defense.PetMEVA = sets.defense.PetMDT

	sets.defense.PKiller = set_combine(sets.defense.PDT, {body="Nukumi Gausape +3"})
	sets.defense.Reraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MDT = {}

	sets.defense.MKiller = set_combine(sets.defense.MDT, {body="Nukumi Gausape +3"})

	sets.defense.MEVA = {}

	sets.Kiting = {ring2="Shneddick Ring"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- MELEE (SINGLE-WIELD) SETS
	sets.engaged = {}

	sets.engaged.Acc = {}

	-- MELEE (SINGLE-WIELD) HYBRID SETS
	sets.engaged.DT = {}

	sets.engaged.Acc.DT = {}

	-- MELEE (DUAL-WIELD) SETS FOR DNC AND NIN SUBJOB
	sets.engaged.DW = {}

	sets.engaged.DW.DT = {}

	sets.engaged.DW.Acc = {}

	sets.engaged.DW.Acc.DT = {}

	-- GEARSETS FOR MASTER ENGAGED (SINGLE-WIELD) & PET ENGAGED
	sets.engaged.BothDD = set_combine(sets.engaged,{})
	sets.engaged.BothDD.SomeAcc = set_combine(sets.engaged.SomeAcc, {})
	sets.engaged.BothDD.Acc = set_combine(sets.engaged.Acc, {})
	sets.engaged.BothDD.FullAcc = set_combine(sets.engaged.FullAcc, {})
	sets.engaged.BothDD.Fodder = set_combine(sets.engaged.Fodder, {})

	-- GEARSETS FOR MASTER ENGAGED (SINGLE-WIELD) & PET TANKING
	sets.engaged.PetTank = set_combine(sets.engaged,{})
	sets.engaged.PetTank.SomeAcc = set_combine(sets.engaged.SomeAcc, {})
	sets.engaged.PetTank.Acc = set_combine(sets.engaged.Acc, {})
	sets.engaged.PetTank.FullAcc = set_combine(sets.engaged.FullAcc, {})
	sets.engaged.PetTank.Fodder = set_combine(sets.engaged.Fodder, {})

	-- GEARSETS FOR MASTER ENGAGED (DUAL-WIELD) & PET ENGAGED
	sets.engaged.DW.BothDD = set_combine(sets.engaged.DW,{})
	sets.engaged.DW.BothDD.SomeAcc = set_combine(sets.engaged.DW.SomeAcc, {})
	sets.engaged.DW.BothDD.Acc = set_combine(sets.engaged.DW.Acc, {})
	sets.engaged.DW.BothDD.FullAcc = set_combine(sets.engaged.DW.FullAcc, {})
	sets.engaged.DW.BothDD.Fodder = set_combine(sets.engaged.DW.Fodder, {})

	-- GEARSETS FOR MASTER ENGAGED (DUAL-WIELD) & PET TANKING
	sets.engaged.DW.PetTank = set_combine(sets.engaged.DW,{})
	sets.engaged.DW.PetTank.SomeAcc = set_combine(sets.engaged.DW.SomeAcc, {})
	sets.engaged.DW.PetTank.Acc = set_combine(sets.engaged.DW.Acc, {})
	sets.engaged.DW.PetTank.FullAcc = set_combine(sets.engaged.DW.FullAcc, {})
	sets.engaged.DW.PetTank.Fodder = set_combine(sets.engaged.DW.Fodder, {})

	sets.buff['Killer Instinct'] = {body="Nukumi Gausape +3"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {} --head="Frenzy Sallet"
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Default = {main="Agwu's Axe",sub="Sacro Bulwark",}
	sets.weapons.DualWeapons = {}

-------------------------------------------------------------------------------------------------------------------
-- Complete Lvl 76-99 Jug Pet Precast List +Funguar +Courier +Amigo
-------------------------------------------------------------------------------------------------------------------

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

	-------------------------------------------------------------------------------------------------------------------
	-- Complete iLvl Jug Pet Precast List
	-------------------------------------------------------------------------------------------------------------------

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
	sets.precast.JA['Bestial Loyalty'].WeevilFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Pristine Sap"})
	sets.precast.JA['Bestial Loyalty'].StalwartAngelina = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="T. Pristine Sap"})
	sets.precast.JA['Bestial Loyalty'].SweetCaroline = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Aged Humus"})
	sets.precast.JA['Bestial Loyalty']['P.CrabFamiliar'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rancid Broth"})
	sets.precast.JA['Bestial Loyalty'].JovialEdwin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Pungent Broth"})
	sets.precast.JA['Bestial Loyalty']['Y.BeetleFamiliar'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Zestful Sap"})
	sets.precast.JA['Bestial Loyalty'].EnergizedSefina = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Gassy Sap"})
	sets.precast.JA['Bestial Loyalty'].LynxFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Frizzante Broth"})
	sets.precast.JA['Bestial Loyalty'].VivaciousGaston = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Spumante Broth"})
	sets.precast.JA['Bestial Loyalty']['Hip.Familiar'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Turpid Broth"})
	sets.precast.JA['Bestial Loyalty'].DaringRoland = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Feculent Broth"})
	sets.precast.JA['Bestial Loyalty'].SlimeFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Decaying Broth"})
	sets.precast.JA['Bestial Loyalty'].SultryPatrice = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Putrescent Broth"})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(6, 16)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 16)
	elseif player.sub_job == 'THF' then
		set_macro_page(6, 16)
	elseif player.sub_job == 'RUN' then
		set_macro_page(6, 16)
	else
		set_macro_page(6, 16)
	end
end