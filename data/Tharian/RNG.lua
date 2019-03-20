function get_sets()
	AccIndex = 1
	AccArray = {"LowACC","MidACC","HighACC","ThreeHit"} -- 3 Levels Of Accuracy Sets For Shooting/TP/WS. First Set Is LowACC. Add More ACC Sets If Needed Then Create Your New ACC Below. Most of These Sets Are Empty So You Need To Edit Them On Your Own. Remember To Check What The Combined Set Is For Each Sets. --
	WeaponIndex = 1
	WeaponArray = {"Fomalhaut","Fail-Not","Yoichinoyumi"} -- Default Ranged Weapon Is Annihilator. Can Delete Any Weapons/Sets That You Don't Need Or Replace/Add The New Weapons That You Want To Use. --
	IdleIndex = 1
	IdleArray = {"Kustawi","Oneiros","Perun","Malevolence","MaxTp","Regen"} -- Default Idle Set Is Movement --
	Armor = 'None'
	warning = false
	AutoGunWS = "LastStand" -- Set Auto Gun WS Here --
	AutoBowWS = "Namas Arrow" -- Set Auto Bow WS Here --
	AutoMode = 'OFF' -- Set Default Auto RA/WS ON or OFF Here --
    ThreeHit = 'OFF' -- Set Default Threehit Set ON or OFF Here --
	Obi = 'ON' -- Turn Default Obi ON or OFF Here --
	ammo_warning_limit = 10 -- Set Ammo Limit Check Here --
	Samurai_Roll = 'ON' -- Set Default SAM Roll ON or OFF Here --
	target_distance = 25 -- Set Default Distance Here --
	send_command('input ;wait 1;input /lockstyleset 21') 
	select_default_macro_book() -- Change Default Macro Book At The End --
    include('organizer-lib.lua')
	Ele_WS = S{"Trueflight","Wildfire"}
	sc_map = {SC1="LastStand", SC2="Coronach", SC3="Ranged"} -- 3 Additional Binds. Can Change Whatever JA/WS/Spells You Like Here. Remember Not To Use Spaces. --
	
	gear = {}
	gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Chrono Bullet"
	gear.RAarrow = "Chrono Arrow"
    gear.WSarrow = "Chrono Arrow"
    gear.MAarrow = "Chrono Arrow"
    gear.MAarrow = "Chrono Arrow"
	
	sets.Idle = {}
	-- Idle/Town Sets --
	sets.Idle.Regen = {
			head="Orion Beret +2",	--{ name="Herculean Helm", augments={'Accuracy+8','Damage taken-4%','STR+4','Attack+10',}},
			neck="Loricate Torque +1",
			ear1="Colossus's Earring",
			ear2="Infused Earring",
			body="Meghanada Cuirie +1",
			hands="Herculean Gloves",--{ name="Herculean Gloves", augments={'Accuracy+19','Damage taken-3%','STR+7',}},
			ring1="Defending Ring",
			ring2="Sheltered Ring",
			back="Solemnity Cape",
			waist="Flume Belt",
			legs="Carmine Cuisses +1",
			feet="Herculean Boots",}--{ name="Herculean Boots", augments={'Accuracy+11','Damage taken-2%','DEX+4',}}}
	
	-- Ranged Weapon sets
	sets.Idle.Fomalhaut = {
			range="Fomalhaut",
		    ammo="Chrono bullet"}
	sets.Idle['Fail-Not'] = {
            range="Fail-Not",
			ammo="Chrono Arrow"
			}
	sets.Idle.Yoichinoyumi = {
			--range="Yoichinoyumi",
		    --ammo="Yoichi's Arrow"
			}
	
	-- Weapon Sets
	sets.Idle.Kustawi = set_combine(sets.Idle.Regen,{
			--main="Kustawi +1",
			sub="Nusku Shield",})
	sets.Idle.Perun	 = set_combine(sets.Idle.Regen,{
			main="Perun +1",
			sub="Nusku Shield"})
	sets.Idle.Oneiros  = set_combine(sets.Idle.Regen,{
			--main="Oneiros",
			sub="Nusku Shield"})
	sets.Idle.Malevolence  = set_combine(sets.Idle.Regen,{
			main={ name="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
		    sub="Nusku Shield"})
	sets.Idle.MaxTp = set_combine(sets.Idle.Regen,{
			--main="Mekki Shakki",
		    --sub="Bloodrain Strap"
			})
			
	-- /NIN sets
	sets.Idle.Kustawi.NIN = {
			main="Kustawi +1",
			sub="Perun +1"}
	sets.Idle.Perun.NIN = {
			main="Perun +1",
			sub="Perun"}
	sets.Idle.Oneiros.NIN = {
			main="Kustawi +1",
			sub="Oneiros Knife",}
	sets.Idle.Malevolence.NIN = {
			main={ name="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
			--sub={ name="Malevolence", augments={'INT+7','Mag. Acc.+3','"Mag.Atk.Bns."+5','"Fast Cast"+2',}}
			}
	
	-- Set Combinations	
	sets.Idle.Kustawi.Fomalhaut = set_combine(sets.Idle.Kustawi, sets.Idle.Fomalhaut)
	sets.Idle.Kustawi['Fail-Not'] = set_combine(sets.Idle.Kustawi, sets.Idle['Fail-Not'])
	sets.Idle.Kustawi.Yoichinoyumi = set_combine(sets.Idle.Kustawi, sets.Idle.Yoichinoyumi)

	sets.Idle.Perun.Fomalhaut = set_combine(sets.Idle.Perun, sets.Idle.Fomalhaut)
	sets.Idle.Perun['Fail-Not'] = set_combine(sets.Idle.Perun, sets.Idle['Fail-Not'])
    sets.Idle.Perun.Yoichinoyumi = set_combine(sets.Idle.Perun, sets.Idle.Yoichinoyumi)
	
	sets.Idle.Oneiros.Fomalhaut = set_combine(sets.Idle.Oneiros, sets.Idle.Fomalhaut)
	sets.Idle.Oneiros['Fail-Not'] = set_combine(sets.Idle.Oneiros, sets.Idle['Fail-Not'])
    sets.Idle.Oneiros.Yoichinoyumi = set_combine(sets.Idle.Oneiros, sets.Idle.Yoichinoyumi)
	
	sets.Idle.Malevolence.Fomalhaut = set_combine(sets.Idle.Malevolence, sets.Idle.Fomalhaut)
	sets.Idle.Malevolence['Fail-Not'] = set_combine(sets.Idle.Malevolence, sets.Idle['Fail-Not'])
    sets.Idle.Malevolence.Yoichinoyumi = set_combine(sets.Idle.Malevolence, sets.Idle.Yoichinoyumi)
	
	sets.Idle.MaxTp.Fomalhaut = set_combine(sets.Idle.MaxTp, sets.Idle.Fomalhaut)
	sets.Idle.MaxTp['Fail-Not'] = set_combine(sets.Idle.MaxTp, sets.Idle['Fail-Not'])
    sets.Idle.MaxTp.Yoichinoyumi = set_combine(sets.Idle.MaxTp, sets.Idle.Yoichinoyumi)
	
	sets.Idle.Kustawi.Fomalhaut.NIN = set_combine(sets.Idle.Kustawi.NIN, sets.Idle.Fomalhaut)
	sets.Idle.Kustawi['Fail-Not'].NIN = set_combine(sets.Idle.Kustawi.NIN, sets.Idle['Fail-Not'])
    sets.Idle.Kustawi.Yoichinoyumi.NIN = set_combine(sets.Idle.Kustawi.NIN, sets.Idle.Yoichinoyumi)
	
	sets.Idle.Perun.Fomalhaut.NIN = set_combine(sets.Idle.Perun.NIN, sets.Idle.Fomalhaut)
	sets.Idle.Perun['Fail-Not'].NIN = set_combine(sets.Idle.Perun.NIN, sets.Idle['Fail-Not'])
    sets.Idle.Perun.Yoichinoyumi.NIN = set_combine(sets.Idle.Perun.NIN, sets.Idle.Yoichinoyumi)
	
	sets.Idle.Oneiros.NIN = set_combine(sets.Idle.Oneiros.NIN, sets.Idle.Fomalhaut)
	sets.Idle.Oneiros['Fail-Not'].NIN = set_combine(sets.Idle.Oneiros.NIN, sets.Idle['Fail-Not'])
    sets.Idle.Oneiros.Yoichinoyumi.NIN = set_combine(sets.Idle.Oneiros.NIN, sets.Idle.Yoichinoyumi)
	
	sets.Idle.Malevolence.NIN = set_combine(sets.Idle.Malevolence.NIN, sets.Idle.Fomalhaut)
	sets.Idle.Malevolence['Fail-Not'].NIN = set_combine(sets.Idle.Malevolence.NIN, sets.Idle['Fail-Not'])
    sets.Idle.Malevolence.Yoichinoyumi.NIN = set_combine(sets.Idle.Malevolence.NIN, sets.Idle.Yoichinoyumi)

	
	-- Normal TP Sets 
	-- /nin Haste 1 42dw required  haste 2 31dw required
	sets.TP = {
			head="Dampening Tam",
			neck="Anu Torque",
			ear1="Suppanomimi",  --5dw--
			ear2="Eabani Earring",  --4dw--
			body="Adhemar Jacket +1",  --5dw--
			hands={ name="Herculean Gloves", augments={'Attack+29','"Triple Atk."+3','DEX+8',}},
			ring1="Epona's Ring",
			ring2="Ilabrat Ring",
			back="Bleating Mantle",
			waist="Windbuffet Belt +1",  
			legs="Samnuha Tights",
			feet="Herculean boots"}
	sets.TP.MidACC = set_combine(sets.TP,{
			neck="Sanctity Necklace",
			ear1="Dignitary's Earring",
			ear2="Cessance Earring",
			hands="Meghanada Gloves +1",
			legs="Carmine Cuisses +1",})
	sets.TP.HighACC = set_combine(sets.TP.MidACC,{
			head="Meghanada Visor +1",
			--neck="Combatant's Torque",
			ear1="Telos Earring",
			ear2="Digni. Earring",
			body="Meghanada Cuirie +1",
			hands="Meghanada Gloves +1",
			ring1="Mars's ring",
			ring2="Enlivened Ring",
			back="Ground. Mantle +1",
			waist="Olseni Belt",
			legs="Meg. Chausses +2",
			feet="Meg. Jam. +2"})
			
	-- March x2 + Haste --
	-- Embrava + (March or Haste) --
	-- Geo Haste + (March or Haste or Embrava) --
	--/nin 11dw required --
	sets.TP.HighHaste =  set_combine(sets.TP,{
			--head={ name="Herculean Helm", augments={'Accuracy+29','"Triple Atk."+3','AGI+4','Attack+12',}},
			ear2="Brutal Earring",
			legs="Samnuha Tights",
			waist="Windbuffet Belt +1",
			feet={ name="Herculean Boots", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','DEX+5','Accuracy+5',}},
			})
	sets.TP.MidACC.HighHaste = set_combine(sets.TP.HighHaste,{
			--head={ name="Herculean Helm", augments={'Accuracy+29','"Triple Atk."+3','AGI+4','Attack+12',}},
			neck="Sanctity Necklace",
			ear1="Dignitary's Earring",
			ear2="Cessance Earring",
			hands="Meghanada Gloves +1",
			legs="Meg. Chausses +2",})
	sets.TP.HighACC.HighHaste = set_combine(sets.TP.MidACC.HighHaste,{
	        head="Meghanada Visor +1",
			body="Meghanada Cuirie +1",
			ear1="Telos Earring",
			ear2="Digni. Earring",
			ring1="Mars's ring",
			ring2="Enlivened Ring",
			back="Ground. Mantle +1",
			waist="Olseni Belt",
			legs="Meg. Chausses +2",
			})
			
			
	-- Preshot --
	sets.Preshot = {
			head="Taeon Chapeau",											--09
			body="Taeon Tabard",											--06
			hands="Carmine Fin. Ga.",										--07
			back={ name="Belenus's Cape", augments={'"Snapshot"+10',}},		--10	
			waist="Impulse Belt",											--03
			legs="Adhemar Kecks",											--09
			feet="Meg. Jam. +2"}											--10
			

	-- Barrage Base Set. This Set Takes Priority Over Other Pieces. --
	Barrage = {
			hands="Orion Bracers +1",
			--legs="Desultor Tassets"
			}

	-- Shooting Base Set --
	sets.Midshot = {
			head="Oshosi Mask +1", --"Arcadian Beret +1",
			neck="Iskur Gorget",
			ear1="Telos earring",
		    ear2="Sherida earring",
			body="Nisroch Jerkin",
			hands={ name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10','"Store TP"+5',}},
			ring1="Ilabrat Ring",
			ring2="Petrov Ring",
			back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}},
			waist="Yemaya Belt",
			legs="Osh. Trousers +1",
			--{ name="Herculean Trousers", augments={'Rng.Acc.+21 Rng.Atk.+21','Sklchn.dmg.+5%','AGI+14','Rng.Acc.+5','Rng.Atk.+15',}},
			--legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			feet="Osh. Leggings +1"}
	
	sets.Midshot.MidACC = set_combine(sets.Midshot, {
			--body="Meg. Cuirie +2", -- Herc Body racc --
			hands="Adhemar Wristbands",
			--legs="Meg. Chausses +2",
			--feet={ name="Herculean Boots", augments={'Rng.Acc.+21 Rng.Atk.+21','"Subtle Blow"+7','AGI+9','Rng.Acc.+15','Rng.Atk.+3',}}
			})  -- herc feet agi racc -- 
	
	sets.Midshot.HighACC = set_combine(sets.Midshot.MidACC, {
			--head="Meghanada Visor +1",
			neck="Iskur Gorget",
			body="Meg. Cuirie +2",
			hands="Meg. Gloves +1",
		    ring1="Hajduk Ring",
			ring2="Cacoethic Ring +1",
		    waist="Kwahu Kachina Belt"})

	
	sets.Midshot['Fail-Not'] = set_combine(sets.Midshot, {ammo=gear.RAarrow})
	sets.Midshot['Fail-Not'].MidACC = set_combine(sets.Midshot.MidACC, {ammo=gear.RAarrow})
	sets.Midshot['Fail-Not'].HighACC = set_combine(sets.Midshot.HighACC, {ammo=gear.RAarrow})

	-- Fail-Not Barrage Sets --
	sets.Midshot['Fail-Not'].Barrage = set_combine(sets.Midshot['Fail-Not'].HighACC,{},Barrage)
	sets.Midshot['Fail-Not'].MidACC.Barrage = set_combine(sets.Midshot['Fail-Not'].HighACC,{},Barrage)
	sets.Midshot['Fail-Not'].HighACC.Barrage = set_combine(sets.Midshot['Fail-Not'].HighACC,{},Barrage)

	-- Fomalhaut Sets --

	sets.Midshot.Fomalhaut = set_combine(sets.Midshot, {ammo=gear.RAbullet})
	sets.Midshot.Fomalhaut.MidACC = set_combine(sets.Midshot.MidACC, {ammo=gear.RAbullet})
	sets.Midshot.Fomalhaut.HighACC = set_combine(sets.Midshot.HighACC, {ammo=gear.RAbullet})

	sets.Midshot.Fomalhaut.ThreeHit = {
			ammo=gear.RAbullet,
			head="Arcadian Beret +1",
			neck="Ainia Collar",
			ear1="Telos Earring",
		    --ear2="Dedition Earring",
			body={ name="Herculean Vest", augments={'Rng.Acc.+22 Rng.Atk.+22','Weapon skill damage +4%','AGI+6',}},
			hands="Adhemar Wristbands",
		    ring1="Apate Ring",
	        ring2="Petrov Ring",
		    waist="Yemaya Belt",
			back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}},
			legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
            feet={ name="Herculean Boots", augments={'Rng.Acc.+21 Rng.Atk.+21','"Subtle Blow"+7','AGI+9','Rng.Acc.+15','Rng.Atk.+3',}}}	
			
	-- Fomalhaut Barrage Sets --
	sets.Midshot.Fomalhaut.Barrage = set_combine(sets.Midshot.Fomalhaut.HighACC,{},Barrage)
	sets.Midshot.Fomalhaut.MidACC.Barrage = set_combine(sets.Midshot.Fomalhaut.HighACC,{},Barrage)
	sets.Midshot.Fomalhaut.HighACC.Barrage = set_combine(sets.Midshot.Fomalhaut.HighACC,{},Barrage)
	
	-- Yoichinoyumi Sets --
	sets.Midshot.Yoichinoyumi = set_combine(sets.Midshot, {ammo="Yoichi's Arrow"})
	sets.Midshot.Yoichinoyumi.MidACC = set_combine(sets.Midshot.MidACC, {ammo="Yoichi's Arrow"})
	sets.Midshot.Yoichinoyumi.HighACC = set_combine(sets.Midshot.HighACC, {ammo="Yoichi's Arrow"})
			
	-- Yoichinoyumi Barrage Sets --
	sets.Midshot.Yoichinoyumi.Barrage = set_combine(sets.Midshot.Yoichinoyumi.HighACC,{},Barrage)
	sets.Midshot.Yoichinoyumi.MidACC.Barrage = set_combine(sets.Midshot.Yoichinoyumi.HighACC,{},Barrage)
	sets.Midshot.Yoichinoyumi.HighACC.Barrage = set_combine(sets.Midshot.Yoichinoyumi.HighACC,{},Barrage)

	-- Fail-Not /SAM Sets --
	sets.Midshot['Fail-Not'].SAM = sets.Midshot['Fail-Not']
	sets.Midshot['Fail-Not'].SAM.MidACC = sets.Midshot['Fail-Not'].MidACC
	sets.Midshot['Fail-Not'].SAM.HighACC = sets.Midshot['Fail-Not'].HighACC

	-- Fail-Not /SAM Barrage Sets --
	sets.Midshot['Fail-Not'].SAM.Barrage = set_combine(sets.Midshot['Fail-Not'].SAM.HighACC,{},Barrage)
	sets.Midshot['Fail-Not'].SAM.MidACC.Barrage = set_combine(sets.Midshot['Fail-Not'].SAM.HighACC,{},Barrage)
	sets.Midshot['Fail-Not'].SAM.HighACC.Barrage = set_combine(sets.Midshot['Fail-Not'].SAM.HighACC,{},Barrage)

	-- .Fomalhaut/SAM Sets --
	sets.Midshot.Fomalhaut.SAM = sets.Midshot.Fomalhaut
	sets.Midshot.Fomalhaut.SAM.MidACC = sets.Midshot.Fomalhaut.MidACC
	sets.Midshot.Fomalhaut.SAM.HighACC = sets.Midshot.Fomalhaut.HighACC
    sets.Midshot.Fomalhaut.SAM.ThreeHit = sets.Midshot.Fomalhaut.ThreeHit
	-- Fomalhaut /SAM Barrage Sets --
	sets.Midshot.Fomalhaut.SAM.Barrage = set_combine(sets.Midshot.Fomalhaut.SAM.HighACC,{},Barrage)
	sets.Midshot.Fomalhaut.SAM.MidACC.Barrage = set_combine(sets.Midshot.Fomalhaut.SAM.HighACC,{},Barrage)
	sets.Midshot.Fomalhaut.SAM.HighACC.Barrage = set_combine(sets.Midshot.Fomalhaut.SAM.HighACC,{},Barrage)
	
	-- Yoichinoyumi /SAM Sets --
	sets.Midshot.Yoichinoyumi.SAM = sets.Midshot.Yoichinoyumi
	sets.Midshot.Yoichinoyumi.SAM.MidACC = sets.Midshot.Yoichinoyumi.MidACC
	sets.Midshot.Yoichinoyumi.SAM.HighACC = sets.Midshot.Yoichinoyumi.HighACC

	-- Yoichinoyumi /SAM Barrage Sets --
	sets.Midshot.Yoichinoyumi.SAM.Barrage = set_combine(sets.Midshot.Yoichinoyumi.SAM.HighACC,{},Barrage)
	sets.Midshot.Yoichinoyumi.SAM.MidACC.Barrage = set_combine(sets.Midshot.Yoichinoyumi.SAM.HighACC,{},Barrage)
	sets.Midshot.Yoichinoyumi.SAM.HighACC.Barrage = set_combine(sets.Midshot.Yoichinoyumi.SAM.HighACC,{},Barrage)

	-- Fail-Not /NIN Sets --
	
	sets.Midshot['Fail-Not'].NIN = sets.Midshot['Fail-Not']
	sets.Midshot['Fail-Not'].NIN.MidACC = sets.Midshot['Fail-Not'].MidACC
	sets.Midshot['Fail-Not'].NIN.HighACC = sets.Midshot['Fail-Not'].HighACC
	
	-- Fail-Not /NIN Barrage Sets --
	sets.Midshot['Fail-Not'].NIN.Barrage = set_combine(sets.Midshot['Fail-Not'].NIN.HighACC,{},Barrage)
	sets.Midshot['Fail-Not'].NIN.MidACC.Barrage = set_combine(sets.Midshot['Fail-Not'].NIN.HighACC,{},Barrage)
	sets.Midshot['Fail-Not'].NIN.HighACC.Barrage = set_combine(sets.Midshot['Fail-Not'].NIN.HighACC,{},Barrage)

	-- Fail-Not /NIN Sets --
	sets.Midshot.Fomalhaut.NIN = sets.Midshot.Fomalhaut
	sets.Midshot.Fomalhaut.NIN.MidACC = sets.Midshot.Fomalhaut.MidACC
	sets.Midshot.Fomalhaut.NIN.HighACC = sets.Midshot.Fomalhaut.HighACC
    sets.Midshot.Fomalhaut.NIN.ThreeHit = sets.Midshot.Fomalhaut.ThreeHit
	
	-- Fail-Not /NIN Barrage Sets --
	sets.Midshot.Fomalhaut.NIN.Barrage = set_combine(sets.Midshot.Fomalhaut.NIN.HighACC,{},Barrage)
	sets.Midshot.Fomalhaut.NIN.MidACC.Barrage = set_combine(sets.Midshot.Fomalhaut.NIN.HighACC,{},Barrage)
	sets.Midshot.Fomalhaut.NIN.HighACC.Barrage = set_combine(sets.Midshot.Fomalhaut.NIN.HighACC,{},Barrage)
	
	-- Yoichinoyumi /NIN Sets --
	sets.Midshot.Yoichinoyumi.NIN = sets.Midshot.Yoichinoyumi
	sets.Midshot.Yoichinoyumi.NIN.MidACC = sets.Midshot.Yoichinoyumi.MidACC
	sets.Midshot.Yoichinoyumi.NIN.HighACC = sets.Midshot.Yoichinoyumi.HighACC
	
	-- Yoichinoyumi /NIN Barrage Sets --
	sets.Midshot.Yoichinoyumi.NIN.Barrage = set_combine(sets.Midshot.Yoichinoyumi.NIN.HighACC,{},Barrage)
	sets.Midshot.Yoichinoyumi.NIN.MidACC.Barrage = set_combine(sets.Midshot.Yoichinoyumi.NIN.HighACC,{},Barrage)
	sets.Midshot.Yoichinoyumi.NIN.HighACC.Barrage = set_combine(sets.Midshot.Yoichinoyumi.NIN.HighACC,{},Barrage)

	-- PDT/MDT Sets --
	sets.DT = {
			neck="Loricate Torque +1",
			ring1="Vocane Ring",
			ring2="Defending Ring",
			back="Solemnity Cape",}
	
	sets.PDT = set_combine(sets.DT,{
			--head={ name="Herculean Helm", augments={'Accuracy+8','Damage taken-4%','STR+4','Attack+10',}},
			body="Meg. Cuirie +2",
			--hands={ name="Herculean Gloves", augments={'Accuracy+19','Damage taken-3%','STR+7',}},
			waist="Flume Belt",
			--feet={ name="Herculean Boots", augments={'Accuracy+11','Damage taken-2%','DEX+4',}}
			})

	sets.MDT = set_combine(sets.PDT,{
			--ear2="Sanare Earring",
			--ring1="Shadow Ring",
			back="Engulfer Cape +1"
			})

	-- WS Base Set --
	sets.WS = {}
	
	sets.WS.Base = {
			ear1="Moonshade Earring",
			ear2="Ishvara Earring",
			neck="Fotia Gorget",
			waist="Fotia Belt",}
	
	sets.WS.AGI = set_combine(sets.WS.Base, {
			head={ name="Herculean Helm", augments={'Rng.Acc.+23 Rng.Atk.+23','AGI+9','Rng.Acc.+8','Rng.Atk.+7',}},
			body={ name="Herculean Vest", augments={'Rng.Acc.+22 Rng.Atk.+22','Weapon skill damage +4%','AGI+6',}},
			hands="Meg. Gloves +1",
			ring1="Apate Ring",
			ring2="Arvina Ringlet +1",
			back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}, -- belenus WSDMG -- 
			--legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			legs={ name="Herculean Trousers", augments={'Rng.Acc.+21 Rng.Atk.+21','Sklchn.dmg.+5%','AGI+14','Rng.Acc.+5','Rng.Atk.+15',}},
			feet={ name="Herculean Boots", augments={'Rng.Acc.+17 Rng.Atk.+17','Crit. hit damage +5%','AGI+9','Rng.Acc.+4','Rng.Atk.+9',}}})
	sets.WS.AGI.MidACC = set_combine(sets.WS.AGI, {
			body="Meg. Cuirie +2"})
	sets.WS.AGI.HighACC = set_combine(sets.WS.AGI.MidACC,{
			head="Meghanada Visor +1",
			ring2="Cacoethic Ring +1",
			ring2="Hajduk Ring",
			feet={ name="Herculean Boots", augments={'Rng.Acc.+21 Rng.Atk.+21','"Subtle Blow"+7','AGI+9','Rng.Acc.+15','Rng.Atk.+3',}}})
	sets.WS.AGI.ThreeHit = {
			head="Arcadian Beret +1",
			neck="Ainia Collar",
			ear1="Telos Earring",
			--ear2="Dedition Earring",
			--body="Pursuer's Doublet",
			hands="Meg. Gloves +1", -- hands="Amini Glovelettes +1",
			ring1="Apate Ring",
			ring2="Petrov Ring",
			waist="Yemaya Belt",
			legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			feet={ name="Herculean Boots", augments={'Rng.Acc.+21 Rng.Atk.+21','"Subtle Blow"+7','AGI+9','Rng.Acc.+15','Rng.Atk.+3',}}} 
	
	sets.WS.DEX = set_combine(sets.WS.Base, {
			head={ name="Adhemar Bonnet", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			ear2="Telos earring",
			body="Abnoba Kaftan",
			hands={ name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10','"Store TP"+5',}},
			ring1="Apate Ring",
			--ring2="Begrudging Ring",
			back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}},  --Belenus's Cape crit --
			legs={ name="Herculean Trousers", augments={'Rng.Acc.+21 Rng.Atk.+21','Sklchn.dmg.+5%','AGI+14','Rng.Acc.+5','Rng.Atk.+15',}},
			feet="Thereoid greaves"})
	sets.WS.DEX.MidACC = set_combine(sets.WS.DEX, {
			neck="Iskur Gorget",
			body="Meg. Cuirie +2",
			waist="Kwahu Kachina Belt"})
	sets.WS.DEX.HighACC = set_combine(sets.WS.DEX.MidACC,{})
	
	-- Namas Arrow Sets --
	sets.WS["Namas Arrow"] = set_combine(sets.WS.Base, {
			ammo="Yoichi's Arrow",
			head="Arcadian Beret +1",
			body="Amini Caban +1",
			hands="Meg. Gloves +1",
			--ring1="Ifrit Ring +1",
			ring2="Arvina Ringlet +1",
			--back="",
			legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			feet={ name="Herculean Boots", augments={'Rng.Acc.+17 Rng.Atk.+17','Crit. hit damage +5%','AGI+9','Rng.Acc.+4','Rng.Atk.+9',}}})
    sets.WS["Namas Arrow"].MidACC = set_combine(sets.WS["Namas Arrow"],{
	        body="Meg. Cuirie +2"})
	sets.WS["Namas Arrow"].HighACC = set_combine(sets.WS["Namas Arrow"].MidACC,{
			head="Meghanada Visor +1",
			hands="Meg. Gloves +1",
			ring2="Cacoethic Ring +1",
			ring2="Hajduk Ring",
			feet={ name="Herculean Boots", augments={'Rng.Acc.+21 Rng.Atk.+21','"Subtle Blow"+7','AGI+9','Rng.Acc.+15','Rng.Atk.+3',}}})	
	
	sets.WS.MAB = set_combine(sets.WS.Base, {
			ammo=gear.MAbullet,
			head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','DEX+9','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
			neck="Sanctity Necklace",
			ear2="Friomisi Earring",
			body="Samnuha Coat",
			hands={ name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10','"Store TP"+5',}},
			ring1="Arvina Ringlet +1",
			ring2="Acumen Ring", 
			back="Argocham. Mantle",
			waist="Eschan Stone",
			legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+10','Mag. Acc.+13','"Mag.Atk.Bns."+14',}},
			feet={ name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Crit. hit damage +1%','INT+8','"Mag.Atk.Bns."+13',}}})
			
	sets.WS.MAB.MidACC = set_combine(sets.WS.MAB, {
			ear2="Digni. Earring",
			waist="Eschan stone"})
	sets.WS.MAB.HighACC = set_combine(sets.WS.MAB.MidACC, {
			waist="Kwahu Kachina Belt"})
	
	-- Coronach Sets --
	sets.WS.Coronach = {}
	sets.WS.Coronach.MidACC = set_combine(sets.WS.Coronach,{})
	sets.WS.Coronach.HighACC = set_combine(sets.WS.Coronach.MidACC,{})

	-- Coronach(SAM Roll) Sets --
	sets.WS.Coronach.STP = set_combine(sets.WS.Coronach,{})
	sets.WS.Coronach.MidACC.STP = set_combine(sets.WS.Coronach.MidACC,{})
	sets.WS.Coronach.HighACC.STP = set_combine(sets.WS.Coronach.HighACC,{})

	-- Last Stand Sets --
	sets.WS["Last Stand"] = set_combine(sets.WS.Base, {ammo=gear.WSbullet})		
	sets.WS["Last Stand"].MidACC = set_combine(sets.WS.AGI.MidACC, sets.WS["Last Stand"])
	sets.WS["Last Stand"].HighACC = set_combine(sets.WS.AGI.HighACC, sets.WS["Last Stand"])
	sets.WS["Last Stand"].ThreeHit = set_combine(sets.WS.AGI.ThreeHit, sets.WS["Last Stand"]) 
	
	-- Last Stand(AM) Sets --
	sets.WS["Last Stand"].AM = set_combine(sets.WS["Last Stand"],{})
	sets.WS["Last Stand"].MidACC.AM = set_combine(sets.WS["Last Stand"].MidACC,{})
	sets.WS["Last Stand"].HighACC.AM = set_combine(sets.WS["Last Stand"].HighACC,{})

	-- Last Stand(SAM Roll) Sets --
	sets.WS["Last Stand"].STP = set_combine(sets.WS["Last Stand"],{})
	sets.WS["Last Stand"].MidACC.STP = set_combine(sets.WS["Last Stand"].MidACC,{})
	sets.WS["Last Stand"].HighACC.STP = set_combine(sets.WS["Last Stand"].HighACC,{})

	-- Namas Arrow(AM) Sets --
	sets.WS["Namas Arrow"].AM = set_combine(sets.WS["Namas Arrow"],{})
	sets.WS["Namas Arrow"].MidACC.AM = set_combine(sets.WS["Namas Arrow"].MidACC,{})
	sets.WS["Namas Arrow"].HighACC.AM = set_combine(sets.WS["Namas Arrow"].HighACC,{})

	-- Namas Arrow(SAM Roll) Sets --
	sets.WS["Namas Arrow"].STP = set_combine(sets.WS["Namas Arrow"],{})
	sets.WS["Namas Arrow"].MidACC.STP = set_combine(sets.WS["Namas Arrow"].MidACC,{})
	sets.WS["Namas Arrow"].HighACC.STP = set_combine(sets.WS["Namas Arrow"].HighACC,{})

	-- Jishnu's Radiance Sets --
	sets.WS["Jishnu's Radiance"] = set_combine(sets.WS.DEX, {ammo="Yoichi's Arrow"})
	sets.WS["Jishnu's Radiance"].MidACC = set_combine(sets.WS.DEX.MidACC, sets.WS["Jishnu's Radiance"])
	sets.WS["Jishnu's Radiance"].HighACC = set_combine(sets.WS.DEX.HighACC, sets.WS["Jishnu's Radiance"])

	-- Jishnu's Radiance(AM) Sets --
	sets.WS["Jishnu's Radiance"].AM = set_combine(sets.WS["Jishnu's Radiance"],{})
	sets.WS["Jishnu's Radiance"].MidACC.AM = set_combine(sets.WS["Jishnu's Radiance"].MidACC,{})
	sets.WS["Jishnu's Radiance"].HighACC.AM = set_combine(sets.WS["Jishnu's Radiance"].HighACC,{})

	-- Jishnu's Radiance(SAM Roll) Sets --
	sets.WS["Jishnu's Radiance"].STP = set_combine(sets.WS["Jishnu's Radiance"],{})
	sets.WS["Jishnu's Radiance"].MidACC.STP = set_combine(sets.WS["Jishnu's Radiance"].MidACC,{})
	sets.WS["Jishnu's Radiance"].HighACC.STP = set_combine(sets.WS["Jishnu's Radiance"].HighACC,{})

	-- Apex Arrow Sets --
	sets.WS["Apex Arrow"] = set_combine(sets.WS.DEX, {ammo="Yoichi's Arrow"})
	sets.WS["Apex Arrow"].MidACC = set_combine(sets.WS.DEX.MidACC, sets.WS["Apex Arrow"])
	sets.WS["Apex Arrow"].HighACC = set_combine(sets.WS.DEX.HighACC, sets.WS["Apex Arrow"])
	
	sets.WS.Trueflight = sets.WS.MAB
	sets.WS.Trueflight.MidACC = sets.WS.MAB.MidACC
	sets.WS.Trueflight.HighACC = sets.WS.MAB.HighACC

	sets.WS.Wildfire = sets.WS.MAB
	sets.WS.Wildfire.MidACC = sets.WS.MAB.MidACC
	sets.WS.Wildfire.HighACC = sets.WS.MAB.HighACC
	
	-- JA Sets --
	sets.JA = {}
	sets.JA.Shadowbind = {
			head="Meghanada Visor +1",
			neck="Iskur Gorget",
			ear1="Telos Earring",
			ear2="Enervating earring",
			body="Meg. Cuirie +2",
			hands="Meg. Gloves +1",
			ring1="Hajduk Ring",
			ring2="Cacoethic Ring +1",
			back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}, -- ambuscade cape
			waist="Yemaya Belt",
			legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			feet={ name="Herculean Boots", augments={'Rng.Acc.+21 Rng.Atk.+21','"Subtle Blow"+7','AGI+9','Rng.Acc.+15','Rng.Atk.+3',}}}

	sets.JA.Scavenge = {feet="Orion Socks +1"}
	sets.JA.Camouflage = {body="Orion Jerkin +1"}
	sets.JA.Sharpshot = {legs="Orion Braccae +1"}
	sets.JA["Bounty Shot"] = {hands="Amini Glovelettes"}
	sets.JA["Eagle Eye Shot"] = {
			head={ name="Adhemar Bonnet", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			neck="Iskur Gorget",
			ear1="Telos earring",
			ear2="Enervating earring",
			body="Meg. Cuirie +2",
			hands="Orion Bracers +1",
			ring1="Apate Ring",
			ring2="Petrov Ring",
			back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}, -- ambuscade cape
			waist="Yemaya Belt",
			legs="Arcadian Braccae",
			feet={ name="Herculean Boots", augments={'Rng.Acc.+21 Rng.Atk.+21','"Subtle Blow"+7','AGI+9','Rng.Acc.+15','Rng.Atk.+3',}}}

	-- Elemental Obi --
        sets.Obi = {}
        sets.Obi.Lightning = {waist='Hachirin-no-Obi'}
        sets.Obi.Water = {waist='Hachirin-no-Obi'}
        sets.Obi.Fire = {waist='Hachirin-no-Obi'}
        sets.Obi.Ice = {waist='Hachirin-no-Obi'}
        sets.Obi.Wind = {waist='Hachirin-no-Obi'}
        sets.Obi.Earth = {waist='Hachirin-no-Obi'}
        sets.Obi.Light = {waist='Hachirin-no-Obi'}
        sets.Obi.Dark = {waist='Hachirin-no-Obi'}		
			
	-- Waltz Set --
	sets.Waltz = {}

	sets.Precast = {}
	-- Fastcast Set --
	sets.Precast.FastCast = {
			head="Carmine Mask",			--12
			neck="Voltsurge Torque",		--04
			ear1="Loquac. Earring",			--02
			--ear2="Enchntr. Earring +1",
			body="Taeon Tabard",			--04
			hands="Leyline Gloves",			--08
			ring1="Prolix Ring",			--02
			legs="",
			--feet="Carmine Greaves"
			}
	-- Utsusemi Precast Set --
	sets.Precast.Utsusemi = set_combine(sets.Precast.FastCast,{}) --{neck="Magoraga Beads"})

	sets.Midcast = {}
	-- Magic Haste Set --
	sets.Midcast.Haste = set_combine(sets.PDT,{})
end

function pretarget(spell,action)
	if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
	elseif spell.english == "Berserk" and buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
		cancel_spell()
		send_command('Aggressor')
	elseif spell.english == "Seigan" and buffactive.Seigan then -- Change Seigan To Third Eye If Seigan Is On --
		cancel_spell()
		send_command('ThirdEye')
	elseif spell.english == "Meditate" and player.tp > 290 then -- Cancel Meditate If TP Is Above 290 --
		cancel_spell()
		add_to_chat(123, spell.name .. ' Canceled: ['..player.tp..' TP]')
	elseif spell.action_type == 'Ranged Attack' and spell.target.distance > 24.9 then
		cancel_spell()
		add_to_chat(123, spell.name..' Canceled: [Out of Range]')
		return
	elseif spell.type == 'WeaponSkill' and player.status == 'Engaged' then
		if spell.skill == 'Archery' or spell.skill == 'Marksmanship' then
			if spell.target.distance > 16+target_distance then
				cancel_spell()
				add_to_chat(123, spell.name..' Canceled: [Out of Range]')
				return
			end
		else
			if spell.target.distance > target_distance then
				cancel_spell()
				add_to_chat(123, spell.name..' Canceled: [Out of Range]')
				return
			end
		end
	end
end

function precast(spell, action)
	local check_ammo
	local check_ammo_count = 1
	if spell.action_type == 'Ranged Attack' then
		if spell.action_type == 'Ranged Attack' then
			bullet_name = gear.RAbullet
		elseif player.equipment.ammo == 'empty' or player.inventory[check_ammo].count <= check_ammo_count then
			add_to_chat(123, spell.name..' Canceled: [Out of Ammo]')
			cancel_spell()
			return
		else
			equip(sets.Preshot)
			if player.inventory[check_ammo].count <= ammo_warning_limit and player.inventory[check_ammo].count > 1 and not warning then
				add_to_chat(8, '***** [Low Ammo Warning!] *****')
				warning = true
			elseif player.inventory[check_ammo].count > ammo_warning_limit and warning then
				warning = false
			end
		end
		local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
		
		-- If no ammo is available, give appropriate warning and end.
		--if player.equipment.ammo == gear.MAbullet then
			--add_to_chat(104, 'Wrong ammo equipped.')
			--cancel_spell()
			--return
		--else
		--if not available_bullets then
		--	add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
		--	cancel_spell()
		--	return
		--end

	elseif spell.type == "WeaponSkill" then
		if player.status ~= 'Engaged' then 
			cancel_spell()
			add_to_chat(123,'Unable To Use WeaponSkill: [Disengaged]')
			return
		else
			equipSet = sets.WS
			if equipSet[spell.english] then
				equipSet = equipSet[spell.english]
			end
			if equipSet[AccArray[AccIndex]] then
				equipSet = equipSet[AccArray[AccIndex]]
			end
			if buffactive.Aftermath and equipSet["AM"] then
				equipSet = equipSet["AM"]
			end
			if buffactive["Samurai Roll"] and equipSet["STP"] and Samurai_Roll == 'ON' then
				equipSet = equipSet["STP"]
			end
			if player.tp > 299 or buffactive.Sekkanoki then
				if spell.english == "Last Stand" then -- Equip Altdorf's Earring and Wilhelm's Earring When You Have 300 TP or Sekkanoki For Last Stand --
					equipSet = set_combine(equipSet,{ear1="Altdorf's Earring",ear2="Wilhelm's Earring"})
				elseif spell.english == "Jishnu's Radiance" then -- Equip Jupiter's Pearl When You Have 300 TP or Sekkanoki For Jishnu's Radiance --
					equipSet = set_combine(equipSet,{ear1="Jupiter's Pearl"})
				end
			end
			if Ele_WS:contains(spell.english) and (world.day_element == spell.element or world.weather_element == spell.element) and sets.Obi[spell.element] and Obi == 'ON' then -- Use Obi Toggle To Unlock Elemental Obi --
				equipSet = set_combine(equipSet,sets.Obi[spell.element])
			end	
			equip(equipSet)
		end
	elseif spell.type == "JobAbility" then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
	elseif spell.action_type == 'Magic' then
		if string.find(spell.english,'Utsusemi') then
			if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
				cancel_spell()
				add_to_chat(123, spell.name .. ' Canceled: [3+ Images]')
				return
			else
				equip(sets.Precast.Utsusemi)
			end
		else
			equip(sets.Precast.FastCast)
		end
	elseif spell.type == "Waltz" then
		equip(sets.Waltz)
	elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
		cast_delay(0.2)
		send_command('cancel Sneak')
	end
end

function midcast(spell,action)
	if spell.action_type == 'Ranged Attack' then
		equipSet = sets.Midshot
		if equipSet[WeaponArray[WeaponIndex]] then
			equipSet = equipSet[WeaponArray[WeaponIndex]]
		end
		if equipSet[player.sub_job] then
			equipSet = equipSet[player.sub_job]
		end
		if equipSet[AccArray[AccIndex]] then
			equipSet = equipSet[AccArray[AccIndex]]
		end
		if buffactive.Barrage and equipSet["Barrage"] then
			equipSet = equipSet["Barrage"]
		end
		if buffactive.Overkill then
            equipSet = set_combine(equipSet,{body="Arcadian Jerkin +1"})
		end	
		if buffactive.Aftermath and equipSet["AM"] then
			equipSet = equipSet["AM"]
		end
		if buffactive["Samurai Roll"] and equipSet["STP"] and Samurai_Roll == 'ON' then
			equipSet = equipSet["STP"]
		end
		equip(equipSet)
	elseif spell.action_type == 'Magic' then
		if string.find(spell.english,'Utsusemi') then
			if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
				send_command('@wait 1.7;cancel Copy Image*')
			end
			equip(sets.Midcast.Haste)
		elseif spell.english == 'Monomi: Ichi' then
			if buffactive['Sneak'] then
				send_command('@wait 1.7;cancel sneak')
			end
			equip(sets.Midcast.Haste)
		else
			equip(sets.Midcast.Haste)
		end
	end
end

function aftercast(spell,action)
	if spell.action_type == 'Ranged Attack' and AutoMode == 'ON' then
		autoRA()
	else
		status_change(player.status)
	end
	if spell.type == "WeaponSkill" and not spell.interrupted then
		send_command('wait 0.2;gs c TP')
	end
end

function status_change(new,old)
	if Armor == 'PDT' then
		equip(sets.PDT)
	elseif Armor == 'MDT' then
		equip(sets.MDT)
	elseif new == 'Engaged' then
		equipSet = sets.TP
		if equipSet[AccArray[AccIndex]] then
			equipSet = equipSet[AccArray[AccIndex]]
		end
	    if buffactive.March == 2 or buffactive.March == 1 or buffactive[580] or buffactive['Mighty Guard']  and (buffactive.Embrava or buffactive.Haste) and equipSet["HighHaste"] then
            equipSet = equipSet["HighHaste"]
        end
		equip(equipSet)
	
	else
		equipSet = sets.Idle
		if equipSet[IdleArray[IdleIndex]] then
			equipSet = equipSet[IdleArray[IdleIndex]]
		end
		if equipSet[WeaponArray[WeaponIndex]] then
			equipSet = equipSet[WeaponArray[WeaponIndex]]
		end
		if equipSet[player.sub_job] then
			equipSet = equipSet[player.sub_job]
		end
		equip(equipSet)
	end
end

function buff_change(buff,gain)
	buff = string.lower(buff)
	if buff == "overkill" then -- Overkill Timer --
		if gain then
			send_command('timers create "Overkill" 60 down')
		else
			send_command('timers delete "Overkill"')
			add_to_chat(123,'Overkill: [OFF]')
		end
	elseif buff == "decoy shot" then -- Decoy Shot Timer --
		if gain then
			send_command('timers create "Decoy Shot" 180 down')
		else
			send_command('timers delete "Decoy Shot"')
			add_to_chat(123,'Decoy Shot: [OFF]')
		end
	elseif buff == 'weakness' then -- Weakness Timer --
		if gain then
			send_command('timers create "Weakness" 300 up')
		else
			send_command('timers delete "Weakness"')
		end
	end
	if not midaction() then
		status_change(player.status)
	end
end

-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
	if command == 'C1' then -- Accuracy Level Toggle --
		AccIndex = (AccIndex % #AccArray) + 1
		add_to_chat(158,'Accuracy Level: ' .. AccArray[AccIndex])
		status_change(player.status)
	elseif command == 'C17' then -- Ranged Weapon Toggle --
		WeaponIndex = (WeaponIndex % #WeaponArray) + 1
		add_to_chat(158,'Ranged Weapon: '..WeaponArray[WeaponIndex])
		status_change(player.status)
	elseif command == 'C5' then -- Auto Update Gear Toggle --
		status_change(player.status)
		add_to_chat(158,'Auto Update Gear')
	elseif command == 'C7' then -- PDT Toggle --
		if Armor == 'PDT' then
			Armor = 'None'
			add_to_chat(123,'PDT Set: [Unlocked]')
		else
			Armor = 'PDT'
			add_to_chat(158,'PDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C15' then -- MDT Toggle --
		if Armor == 'MDT' then
			Armor = 'None'
			add_to_chat(123,'MDT Set: [Unlocked]')
		else
			Armor = 'MDT'
			add_to_chat(158,'MDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C11' then -- SAM Roll Toggle --
		if Samurai_Roll == 'ON' then
			Samurai_Roll = 'OFF'
			add_to_chat(123,'SAM Roll: [OFF]')
		else
			Samurai_Roll = 'ON'
			add_to_chat(158,'SAM Roll: [ON]')
		end
		status_change(player.status)
	elseif command == 'C67' then -- ThreeHit Toggle --
		if ThreeHit == 'ON' then
			ThreeHit = 'OFF'
			add_to_chat(123,'ThreeHit: [OFF]')
		else
			ThreeHit = 'ON'
			add_to_chat(158,'ThreeHit: [ON]')
		end
		status_change(player.status)	
	elseif command == 'C8' then -- Distance Toggle --
		if player.target.distance then
			target_distance = math.floor(player.target.distance*10)/10
			add_to_chat(158,'Distance: '..target_distance)
		else
			add_to_chat(123,'No Target Selected')
		end
	elseif command == 'C6' then -- Idle Toggle --
		IdleIndex = (IdleIndex % #IdleArray) + 1
		add_to_chat(158,'Idle Set: ' .. IdleArray[IdleIndex])
		status_change(player.status)
	elseif command == 'C2' then -- Auto RA/WS Toggle --
		if AutoMode == 'ON' then
			AutoMode = 'OFF'
			add_to_chat(123,'Auto Mode: [OFF]')
		else
			AutoMode = 'ON'
			add_to_chat(158,'Auto Mode: [ON]')
		end
	elseif command == 'TP' then
		add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
	elseif command:match('^SC%d$') then
		send_command('//' .. sc_map[command])
	end
end

function autoRA()
	send_command('@wait 2.7; input /shoot <t>')
end

function autoWS() -- Change Ranged Weapon Here --
	if player.equipment.range == 'Annihilator' then
		send_command('input /ws "'..AutoGunWS..'" <t>')
	elseif player.equipment.range == 'Yoichinoyumi' then
		send_command('input /ws "'..AutoBowWS..'" <t>')
	end
end

--Macros--
send_command('bind ^f9 gs c C7') --PDT--
send_command('bind !f9 gs c C15') --MDT--
send_command('bind !f12 gs c C2') --autora--
send_command('bind f9 gs c C1') --ACC Level--
send_command('bind f11 gs c C5') --autoupdategear--
send_command('bind f10 gs c C17') --WeaponToggle--
send_command('bind f12 gs c C6') --Idle toggle--

function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end

	send_command('unbind ^f9')
	send_command('unbind !f9')
	send_command('unbind !f12')
	send_command('unbind f11')
    send_command('unbind f10')
    send_command('unbind f9')
	send_command('unbind f12')

end


function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book()
end

function set_macro_page(set,book)
	if not tonumber(set) then
		add_to_chat(123,'Error setting macro page: Set is not a valid number ('..tostring(set)..').')
		return
	end
	if set < 1 or set > 10 then
		add_to_chat(123,'Error setting macro page: Macro set ('..tostring(set)..') must be between 1 and 10.')
		return
	end
	if book then
		if not tonumber(book) then
			add_to_chat(123,'Error setting macro page: book is not a valid number ('..tostring(book)..').')
			return
		end
		if book < 1 or book > 20 then
			add_to_chat(123,'Error setting macro page: Macro book ('..tostring(book)..') must be between 1 and 20.')
			return
		end
		send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(set))
	else
		send_command('@input /macro set '..tostring(set))
	end
end

function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 15)
	elseif player.sub_job == 'DNC' then
		set_macro_page(1, 15)
	elseif player.sub_job == 'SAM' then
		set_macro_page(1, 15)
	elseif player.sub_job == 'DRG' then
		set_macro_page(1, 15)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 15)
	else
		set_macro_page(1, 15)
	end
end