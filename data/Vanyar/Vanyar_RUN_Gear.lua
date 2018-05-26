function user_setup()

	state.OffenseMode:options('Normal','SomeAcc','Acc','HighAcc','FullAcc')
	state.HybridMode:options('Normal','DTLite','Tank')
	state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','HighAcc','FullAcc')
	state.CastingMode:options('Normal', 'Resistant')
	state.PhysicalDefenseMode:options('PDT', 'PDT_HP')
	state.MagicalDefenseMode:options('MDT','MDT_HP','BDT','BDT_HP')
	state.ResistDefenseMode:options('MEVA','MEVA_HP','Death','Charm')
	state.IdleMode:options('Normal','Tank','KiteTank','Refresh', 'Regain')
	state.Weapons:options('Aettir','Epeolatry','Lionheart','DualWeapons')

	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP'}

	gear.enmity_jse_back = {name="Ogma's cape",augments={'INT+20','Eva.+20 /Mag. Eva.+20','Enmity+10',}}
	gear.stp_jse_back = {name="Ogma's cape",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.da_jse_back = {name="Ogma's cape",augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}

	if player.sub_job == 'BLU' then
		send_command('bind !w input /ma "Cocoon" <me>')
	elseif player.sub_job == 'WAR' then
		send_command('bind !w input /ja "Defender" <me>')
	elseif player.sub_job == 'DRK' then
		send_command('bind !w input /ja "Last Resort" <me>')
	elseif player.sub_job == 'SAM' then
		send_command('bind !w input /ja "Hasso" <me>')
	end

	send_command('bind %1 input /ma "Aquaveil" <me>')
	send_command('bind %2 input /ma "Blink" <me>')
	send_command('bind %3 input /ma "Stoneskin" <me>')
	send_command('bind %4 input /ma "Phalanx" <me>')
	send_command('bind %5 input /ma "Crusade" <me>')
	send_command('bind %6 input /ma "Refresh" <me>')
	send_command('bind %7 input /ma "Regen IV" <me>')
	send_command('bind %8 input /ma "Ice Spikes" <me>')
	send_command('bind %9 input /ma "Temper" <me>')


	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind @` input /ja "Vivacious Pulse" <me>')
	--send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^- gs c cycleback RuneElement')
	send_command('bind ^= gs c cycle RuneElement')
	send_command('bind ^` gs c RuneElement')
	send_command('bind %t input /ma "Temper" <me>')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
  send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind ^\\\\ input /ma "Protect IV" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Crusade" <me>')
	send_command('bind ^backspace input /ja "Lunge" <t>')
	send_command('bind @backspace input /ja "Gambit" <t>')
	send_command('bind !backspace input /ja "Rayke" <t>')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons DDWeapons;gs c update')

	--select_default_macro_book()
	set_lockstyle()

	--- Augmented Gear
	include('Vanyar-Items.lua')
end

--- User Unload
function user_unload()

	--- Unload Binds
	send_command('unbind %1')
	send_command('unbind %2')
	send_command('unbind %3')
	send_command('unbind %4')
	send_command('unbind %5')
	send_command('unbind %6')
	send_command('unbind %7')
	send_command('unbind %8')
	send_command('unbind %q')
	send_command('unbind ^q')
	send_command('unbind !q')
	send_command('unbind !d')
	send_command('unbind ^a')
	send_command('unbind ^s')
	send_command('unbind ^d')
	send_command('unbind %z')
	send_command('unbind ^z')
	send_command('unbind %=')
	send_command('unbind ^=')
	send_command('unbind ^d')
	send_command('unbind ^s')
	send_command('unbind %x')
	send_command('unbind ^x')
	send_command('unbind %e')
	send_command('unbind !e')
	send_command('unbind %q')
	send_command('unbind %t')
	send_command('unbind ^q')
	send_command('unbind !q')
	send_command('unbind home')
	send_command('unbind delete')
	send_command('unbind end')
	send_command('unbind ^end')
	send_command('unbind !end')
	send_command('unbind pagedown')
	send_command('unbind !pagedown')
	send_command('unbind @`')

	--- Unload React
	send_command('lua unload react')
end

function init_gear_sets()
	--------------------------------------
	-- Capes
	--------------------------------------
	-- RUN Capes
	gear.RUN_WSD_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	gear.RUN_DA_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
	gear.RUN_HP_Cape = {name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10',}}
	gear.RUN_TP_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+4','"Store TP"+10',}}

	--------------------------------------
	-- Organizer
	--------------------------------------
	sets.Org = {
		ammo="Miso Ramen +1",
		head="Miso Ramen",
		body="Holy Water",
		hands="Remedy",
	}

  sets.Enmity = {
		--74+28
		ammo="Sapience orb", 			--2
		--head="Halitus Helm", 		--8
		head="Rabid Visor", 			--6
		body="Emet Harness +1", 	--10
		hands="Kurys Gloves", 		--9
		legs="Eri. Leg Guards +1",--7
		feet="Erilaz Greaves +1",	--6
		neck="Unmoving Collar +1",--10
		ear1="Cryptic Earring", 	--4
		ear2="Friomisi Earring", 	--2
		ring1="Supershear Ring", 	--5
		ring2="Petrov Ring", 			--4
		back="Reiki Cloak", 			--6
		waist="Sulla Belt",				--3
	}

  sets.Enmity.DT = set_combine(sets.Enmity,{
			-- 24 DT
			ammo="Staunch Tathlum +1",		--3
			ring1="Moonlight Ring",				--5/5
			ring2="Defending Ring", 			--10/10
			back="Moonlight Cape", 				--6/6
		})

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Item sets.

	-- Precast sets to enhance JAs
  sets.precast.JA['Vallation'] = set_combine(sets.Enmity,{
		body="Runeist's Coat +3",
		legs="Futhark Trousers +1",
		back=gear.RUN_HP_Cape,
	})
  sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
  sets.precast.JA['Pflug'] = set_combine(sets.Enmity,{feet="Runeist's Boots +3"})
  sets.precast.JA['Battuta'] = set_combine(sets.Enmity,{head="Futhark Bandeau +1"})
  sets.precast.JA['Liement'] = set_combine(sets.Enmity,{body="Futhark Coat +1"})
  sets.precast.JA['Gambit'] = set_combine(sets.Enmity,{hands="Runeist's Mitons +3"})
  sets.precast.JA['Rayke'] = set_combine(sets.Enmity,{feet="Futhark Boots +1"})
  sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity,{body="Futhark Coat +1"})
  sets.precast.JA['Swordplay'] = set_combine(sets.Enmity,{hands="Futhark Mitons +1"})
  sets.precast.JA['Embolden'] = set_combine(sets.Enmity,{back="Evasionist's Cape"})
  sets.precast.JA['One For All'] = set_combine(sets.Enmity,{})
  sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

  sets.precast.JA['Vallation'].DT = set_combine(sets.Enmity.DT,{
		body="Runeist's Coat +3",
		legs="Futhark Trousers +1",
		back=gear.RUN_HP_Cape,
	})
  sets.precast.JA['Valiance'].DT = sets.precast.JA['Vallation'].DT
  sets.precast.JA['Pflug'].DT = set_combine(sets.Enmity.DT,{feet="Runeist's Boots +3"})
  sets.precast.JA['Battuta'].DT = set_combine(sets.Enmity.DT,{head="Futhark Bandeau +1"})
  sets.precast.JA['Liement'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +1"})
  sets.precast.JA['Gambit'].DT = set_combine(sets.Enmity.DT,{hands="Runeist's Mitons +3"})
  sets.precast.JA['Rayke'].DT = set_combine(sets.Enmity.DT,{feet="Futhark Boots +1"})
  sets.precast.JA['Elemental Sforzo'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +1"})
  sets.precast.JA['Swordplay'].DT = set_combine(sets.Enmity.DT,{hands="Futhark Mitons +1"})
  sets.precast.JA['Embolden'].DT = set_combine(sets.Enmity.DT,{back="Evasionist's Cape"})
  sets.precast.JA['One For All'].DT = set_combine(sets.Enmity.DT,{})
  sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Animated Flourish'].DT = set_combine(sets.Enmity.DT, {})

  sets.precast.JA['Lunge'] = {
		ammo="Seeth. Bomblet +1",
		head=gear.Herc_MAB_head,
		body="Samnuha Coat",
		hands="Carmine Finger Gauntlets +1",
		--legs="Limbo Trousers",
		feet=gear.Herc_MAB_feet,
		neck="Eddy Necklace",
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
    back="Argocham. Mantle",
		waist="Eschan Stone",
		--legs=gear.herculean_nuke_legs,
		--feet=gear.herculean_nuke_feet
		}

	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	sets.element.Earth = {}

	-- Pulse sets, different stats for different rune modes, stat aligned.
  sets.precast.JA['Vivacious Pulse'] = {
		head="Erilaz Galea +1",
		neck="Incanter's Torque",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		legs="Rune. Trousers +3",
		back="Altruistic Cape",
	}
  sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})


  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
		ammo="Yamarang",
    head="Carmine Mask +1",
		neck="Unmoving Collar +1",
		ear1="Enchntr. Earring +1",
		ear2="Handler's Earring +1",
    --body=gear.herculean_waltz_body,
		--hands=gear.herculean_waltz_hands,
		ring1="Moonlight Ring",				--5/5
		ring2="Defending Ring", 			--10/10
    back="Moonlight Cape",
		waist="Chaac Belt",
		--legs="Dashing Subligar",
		--feet=gear.herculean_waltz_feet,
	}

  -- Don't need any special gear for Healing Waltz.
  sets.precast.Waltz['Healing Waltz'] = {}

  sets.precast.Step = {}

	sets.precast.JA['Violent Flourish'] = {}

	-- Fast cast sets for spells
  sets.precast.FC = {
		--68 with cape --> 87 with 2 merits
		ammo="Sapience Orb", 					--2
		head="Runeist's Bandeau +3", 	--14
		body="Taeon Tabard",					--9
		hands="Leyline Gloves", 			--6
		legs="Aya. Cosciales +2", 		--5
		feet="Carmine Greaves +1",		--8
		neck="Voltsurge Torque", 			--4
		ear1="Etiolation Earring", 		--1
		ear2="Loquacious Earring", 		--2
		ring1="Kishar Ring", 					--4
		ring2="Prolix Ring", 					--2
		back=gear.RUN_HP_Cape, 				--10
		waist="Ninurta's Sash",
	}

	sets.precast.FC.DT = set_combine(sets.precast.FC,{
		-- add SIR equipment
		ammo="Staunch Tathlum +1",		-- 3
		neck="Loricate Torque +1",		-- 6
		hands="Regal Gauntlets", 			-- SIR 10
		ear1="Odnowa Earring +1",
		ear2="Odnowa Earring",
		ring1="Moonlight Ring",				-- 5/5
		ring2="Defending Ring", 			-- 10/10
	})

  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers +1"})
  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck='Magoraga beads', back="Mujin Mantle"})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS = {
		ammo="Knobkierrie",
		head="Lustratio Cap +1",
		body="Adhemar Jacket +1",
		hands="Meg. Gloves +2",
		legs=gear.Herc_WS_legs,
		feet=gear.Herc_TA_feet,
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Sherida Earring",
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		--ring2="Regal Ring",
		back=gear.RUN_WSD_Cape,
		waist="Fotia Belt",
	}

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS,{
		ammo="Seeth. Bomblet +1",
		legs="Meg. Chausses +2",
	})
	sets.precast.WS.Acc = set_combine(sets.precast.WS.SomeAcc,{
		head="Dampening Tam",
		body="Ayanmo Corazza +2",
		ring2="Regal Ring",
	})
	sets.precast.WS.HighAcc = set_combine(sets.precast.WS.Acc,{})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS.HighAcc,{})

  sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,{
		ammo="Knobkierrie",
		head="Lustratio Cap +1",
		body="Lustratio Harness +1",
		hands="Adhemar Wrist. +1",
		legs="Samnuha Tights",
    feet="Lustra. Leggings +1",
		neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1="Moonshade Earring",
    ear2="Sherida Earring",
    ring1="Niqmaddu Ring",
    ring2="Regal Ring",
    back=gear.RUN_DA_Cape,
	})
  sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'],{
		body="Adhemar Jacket +1",
	})
  sets.precast.WS['Resolution'].HighAcc = set_combine(sets.precast.WS['Resolution'].Acc,{
		legs="Meg. Chausses +2",
		ammo="Seething Bomblet +1"
	})
	sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS['Resolution'].HighAcc,{})

  sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS,{
		ammo="Knobkierrie",
		head="Adhemar bonnet +1",
		--legs=gear.Herc_WS_legs,
		legs="Lustratio subligar +1",
		feet=gear.Herc_WS_feet,
		ring1="Ilabrat Ring",
		back=gear.RUN_WSD_Cape,
	})
  sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'],{
		--feet=gear.Herc_Acc_feet,
		ammo="Seething Bomblet +1",
		feet="Lustratio Leggings +1",
		ring1="Rufescent Ring"
	})
	sets.precast.WS['Dimidiation'].HighAcc = set_combine(sets.precast.WS['Dimidiation'].Acc,{})
	sets.precast.WS['Dimidiation'].FullAcc = set_combine(sets.precast.WS['Dimidiation'].HighAcc,{})

  sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS,{})
  sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc,{})
	sets.precast.WS['Ground Strike'].HighAcc = set_combine(sets.precast.WS.HighAcc,{})
	sets.precast.WS['Ground Strike'].FullAcc = set_combine(sets.precast.WS.FullAcc,{})

  sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {})
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast['Lunge'], {})
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet=gear.Herc_TA_feet,
		neck="Caro Necklace",
		--ring1="Ifrit Ring +1",
		ring2="Shukuyu Ring",
		--waist="Prosilio Belt +1",
		back=gear.RUN_WSD_Cape,
		})

	--------------------------------------
	-- Midcast sets
	--------------------------------------

  sets.midcast.FastRecast = sets.precast.FC
	sets.midcast.FastRecast.DT = sets.precast.FC.DT

  sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,{
		--500 // 541 (544 cap w/ +1 earring) atm (24% Temper)
		head="Carmine Mask +1",				--11
		body="Manasa Chasuble", 			--12
		hands="Regal Gauntlets", 			--19
		legs="Futhark trousers +1", 	--18
		neck="Incanter's Torque", 		--10
		ear2="Andoaa Earring",				--5
		ring1="Stikini Ring +1", 			--8
		ring2="Stikini Ring +1", 			--8
		waist="Olympus Sash",					--5
		back="Merciful Cape", 				--5
	})
  sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'],{
		head="Futhark Bandeau +1",
		body=gear.Phalanx_body,		--3
		hands=gear.Phalanx_hands,	--3
		legs=gear.Phalanx_legs,		--3
		feet=gear.Phalanx_feet,		--3
	})
	sets.midcast['Temper'] = set_combine(sets.midcast['Enhancing Magic'],{
		hands="Runeist's Mitons +3", 	--19
		legs="Carmine Cuisses +1", 		--18
	})
  sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'],{head="Runeist's Bandeau +3"})
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'],{head="Erilaz Galea +1"})
  sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {ear2="Earthcry Earring",waist="Siegel Sash"})
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Foil = set_combine(sets.Enmity, {})
  sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})

  sets.midcast.Cure = {
		ammo="Staunch Tathlum +1",
		head=gear.Herc_DT_head,
		--body="Vrikodara Jupon", 	-- 13  fenrir htbcnm
		--hands="Buremte Gloves", 	--(13)
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		--neck="Phalaina Locket", 	-- 4(4)
		--ear1="Roundel Earring", 	-- 5
		--ear2="Mendi. Earring", 		-- 5
		ring1="Vocane Ring", 				-- R 5
		ring2="Lebeche Ring",				-- 3
		back="Solemnity Cape",			-- 7
		waist="Flume Belt +1",
	}

	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {})

	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

  sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
  sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = {}

  sets.idle = {	--41/28
		ammo="Staunch Tathlum +1",		--3/3
		head=gear.Herc_DT_head, 			--4/4
		body="Runeist's Coat +3",			--Refresh 3
		--hands=gear.Herc_DT_hands, 		--5/3
		hands="Regal Gauntlets",			--Regen+10,Refresh+1
		legs=gear.Herc_Refresh_legs, 	--2/0 --Refresh 2
		feet="Erilaz Greaves +1",			--5/0
		neck="Loricate Torque +1",		--6/6
		waist="Flume Belt +1",				--4/0
		ear1="Genmei Earring",				--2/0
		ear2="Infused Earring",
		ring1="Sheltered Ring",
		ring2="Defending Ring",				--10/10
		back="Moonlight Cape",				--5/5
	}

	sets.idle.Refresh = set_combine(sets.idle,{
		ammo="Homiliary",
		body="Runeist's Coat +3",
		legs=gear.Herc_Refresh_legs,
		feet=gear.Herc_Refresh_feet,
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
	})

	sets.idle.Regain = set_combine(sets.idle,{
		neck="Opo-Opo Necklace",
		head="Turms cap +1",
		--ring1="Nesanica Ring",
		ring2="Roller's ring",
	})

	sets.idle.Tank = {
		ammo="Staunch Tathlum +1", 		--3/3
		head="Erilaz Galea +1",
		body="Erilaz Surcoat +1",
		legs="Eri. Leg Guards +1",		--7/0
		feet="Erilaz Greaves +1", 		--5/0
		neck="Loricate Torque +1",		--6/6
		ear1="Genmei Earring", 				--2/0
		ear2="Etiolation Earring", 		--0/3
		ring1="Moonlight Ring",				--5/5
		ring2="Defending Ring", 			--10/10
		back="Evasionist's Cape", 		--7/3
		waist="Flume Belt +1", 				--4/0
	}

	sets.idle.KiteTank = set_combine(sets.idle.Tank,{
		legs="Carmine Cuisses +1"
	})

	sets.idle.Weak = {}

	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

  -- Extra defense sets.  Apply these on top of melee or defense sets.
  sets.Knockback = {
		ring1="Vocane Ring",
		back="Repulse Mantle",
	}
  sets.MP = {ear2="Ethereal Earring",waist="Flume Belt"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Aettir = {main="Aettir",sub="Refined Grip +1"}
	sets.weapons.Epeolatry = {main="Epeolatry",sub="Refined Grip +1"}
	sets.weapons.Lionheart = {main="Lionheart",sub="Utu Grip"}
	sets.weapons.DualWeapons = {main="Firangi",sub="Reikiko"}

	-- Defense Sets

	sets.defense.PDT = {
		ammo="Staunch Tathlum +1", 		--3/3
		head=gear.Herc_DT_head, 			--4/4
		body="Futhark Coat +1",				--7/7
		hands="Turms mittens +1",			--HP When Parry
		legs="Eri. Leg Guards +1", 		--7/0
		feet="Turms Leggings +1",	 		--0/0
		neck="Loricate Torque +1", 		--6/6
		ear1="Genmei Earring", 				--2/0
		ear2="Etiolation Earring", 		--0/3
		ring1="Vocane Ring", 					--7/7
		ring2="Defending Ring", 			--10/10
		back=gear.RUN_HP_Cape,
		waist="Flume Belt +1", 				--4/0
	}
	sets.defense.PDT_HP = {
		ammo="Staunch Tathlum +1", 		--3/3
		head="Erilaz Galea +1",
		body="Erilaz Surcoat +1",
		hands="Runeist's Mitons +3", 	--3/0
		legs="Eri. Leg Guards +1", 		--7/0
		feet="Carmine greaves +1", 		--4/0
		neck="Loricate Torque +1", 		--6/6
		ear1="Odnowa Earring", 				--0/1
		ear2="Odnowa Earring +1", 		--0/2
		ring1="Moonlight Ring",				--5/5
		ring2="Defending Ring", 			--10/10
		back="Moonlight Cape",				--6/6
		waist="Flume Belt +1", 				--4/0
	}

	sets.defense.MDT = {
		ammo="Staunch Tathlum +1", 		--3/3
		head="Erilaz Galea +1",
		body="Futhark Coat +1", 			--7/7
		hands="Erilaz Gauntlets +1",
		legs="Eri. Leg Guards +1", 		--7/0
		feet="Erilaz Greaves +1",			--5/0
		neck="Warder's Charm +1",
		ear1="Etiolation Earring", 		--0/3
		ear2="Genmei Earring", 				--2/0
		ring1="Vocane Ring", 					--7/7
		ring2="Defending Ring", 			--10/10
		back="Moonlight Cape", 				--5/5
		waist="Flume Belt +1", 				--4/0
	}
	sets.defense.MDT_HP = {
		ammo="Staunch Tathlum +1", 		--3/3
		head="Erilaz Galea +1",
		body="Futhark Coat +1", 			--7/7
		hands="Erilaz Gauntlets +1",
		legs="Eri. Leg Guards +1", 		--7/0
		feet="Erilaz Greaves +1",			--5/0
		neck="Warder's Charm +1",
		ear1="Etiolation Earring", 		--0/3
		ear2="Genmei Earring", 				--2/0
		ring1="Moonlight Ring",				--5/5
		ring2="Defending Ring", 			--10/10
		back="Moonlight Cape",				--6/6
		waist="Flume Belt +1", 				--4/0
	}

	sets.defense.BDT = {}
	sets.defense.BDT_HP = {}

	sets.defense.MEVA = {
		ammo="Staunch Tathlum +1",
    head="Erilaz Galea +1",
		neck="Warder's Charm +1",
		ear1="Odnowa Earring +1",
		ear2="Sanare Earring",
    body="Runeist's Coat +3",
		hands="Erilaz Gauntlets +1",
		ring1="Purity Ring",
		ring2="Vengeful Ring",
    back="Moonlight Cape",
		waist="Engraved Belt",
		legs="Rune. Trousers +3",
		feet="Erilaz Greaves +1"
	}
	sets.defense.MEVA_HP = {
		ammo="Staunch Tathlum +1",
    head="Erilaz Galea +1",
		neck="Warder's Charm +1",
		ear1="Odnowa Earring +1",
		ear2="Sanare Earring",
    body="Runeist's Coat +3",
		hands="Erilaz Gauntlets +1",
		ring1="Moonlight Ring",				--5/5
		ring2="Defending Ring", 			--10/10
    back="Moonlight Cape",
		waist="Engraved Belt",
		legs="Rune. Trousers +3",
		feet="Erilaz Greaves +1"
	}

	sets.defense.Death = {
		body="Samnuha Coat",
		--ring1="Warden's Ring",		--on BSE
		--ring2="Eihwaz Ring",
	}

	sets.defense.Charm = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring"}
	sets.AccMaxTP = {ear1="Telos Earring"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

  sets.engaged = {
		ammo="Ginsen",
		head="Adhemar bonnet +1",
		body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
		legs="Samnuha Tights",
		feet=gear.Herc_TA_feet,
		neck="Anu Torque",
		ear1="Brutal Earring",
		ear2="Sherida earring",
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back=gear.RUN_DA_Cape,
		--waist="Windbuffet Belt +1",
		waist="Ioskeha Belt +1",
	}
  sets.engaged.SomeAcc = set_combine(sets.engaged,{
		ammo="Yamarang",
	})
	sets.engaged.Acc = set_combine(sets.engaged,{
		ear1="Digni. Earring",
		ear2="Telos Earring",
		ring2="Chirich Ring",
	})
	sets.engaged.HighAcc = set_combine(sets.engaged,{
		head=gear.Herc_Acc_head,
		legs="Carmine Cuisses +1",
		feet=gear.Herc_Acc_feet,
		neck="Sanctity Necklace",
		ear1="Mache Earring +1",
		waist="Kentarch Belt +1",
	})
	sets.engaged.FullAcc = set_combine(sets.engaged,{})
  sets.engaged.DTLite = {
		ammo="Yamarang",
    head="Aya. Zucchetto +2",
		neck="Loricate Torque +1",
		ear1="Brutal Earring",
		ear2="Sherida Earring",
    body="Ayanmo Corazza +2",
		hands="Turms mittens +1",
		ring1="Defending Ring",
		ring2="Patricius Ring",
    back=gear.RUN_TP_Cape,
		waist="Windbuffet Belt +1",
		legs="Meg. Chausses +2",
		feet="Ahosi Leggings",
		--feet="Carmine Greaves +1",
	}
  sets.engaged.SomeAcc.DTLite = set_combine(sets.engaged.DTLite,{
		ammo="Falcon Eye",
		ear1="Cessance Earring",
    body="Ayanmo Corazza +2",
	})
	sets.engaged.Acc.DTLite = set_combine(sets.engaged.SomeAcc.DTLite,{})
	sets.engaged.HighAcc.DTLite = set_combine(sets.engaged.Acc.DTLite,{})
	sets.engaged.FullAcc.DTLite = set_combine(sets.engaged.HighAcc.DTLite,{})

  sets.engaged.Tank = {
		ammo="Staunch Tathlum +1", 		--3/3
		head=gear.Herc_DT_head, 			--4/4
		body="Futhark Coat +1",				--7/7
		hands="Turms mittens +1",			--HP When Parry
		legs="Eri. Leg Guards +1", 		--7/0
		feet="Turms Leggings +1",	 		--0/0
		neck="Loricate Torque +1", 		--6/6
		ear1="Genmei Earring", 				--2/0
		ear2="Etiolation Earring", 		--0/3
		ring1="Vocane Ring", 					--7/7
		ring2="Defending Ring", 			--10/10
		back=gear.RUN_HP_Cape,
		waist="Flume Belt +1", 				--4/0
	}
  sets.engaged.SomeAcc.Tank = sets.engaged.Tank
	sets.engaged.Acc.Tank = sets.engaged.Tank
	sets.engaged.HighAcc.Tank = sets.engaged.Tank
	sets.engaged.FullAcc.Tank = sets.engaged.Tank

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {
		ring1="Saida Ring",
		ring2="Saida Ring",
		waist="Gishdubar Sash",
	})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Battuta = {hands="Turms mittens +1",}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(4, 19)
	elseif player.sub_job == 'RDM' then
		set_macro_page(5, 19)
	elseif player.sub_job == 'SCH' then
		set_macro_page(5, 19)
	elseif player.sub_job == 'BLU' then
		set_macro_page(6, 19)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 19)
	elseif player.sub_job == 'SAM' then
		set_macro_page(8, 19)
	elseif player.sub_job == 'DRK' then
		set_macro_page(9, 19)
	elseif player.sub_job == 'NIN' then
		set_macro_page(10, 19)
	else
		set_macro_page(5, 19)
	end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

				if spell_recasts[980] == 0 and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[952] == 0 and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[979] == 0 and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[967] == 0 and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[914] == 0 and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = 250
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 15')
end


function user_bind_ws(var)
	-- custom WS Binds
	if state.Weapons.value == 'Lionheart' or state.Weapons.value == 'Epeolatry' or state.Weapons.value == 'Aettir' then
		--- Bind Ragnarok WeaponSkills
		send_command('bind %q input /ws "Resolution" <t>')
		send_command('bind ^q input /ws "Dimidation" <t>')
		send_command('bind !q input /ws "Ground Strike" <t>')
	elseif state.Weapons.value == 'DualWeapons' then
		--- Bind Ragnarok WeaponSkills
		send_command('bind %q input /ws "Savage Blade" <t>')
		send_command('bind ^q input /ws "Requiescat" <t>')
	end
	-- Trigger on unbind.
	if var == 'unload' then
		send_command('unbind %q')
		send_command('unbind ^q')
		send_command('unbind !q')
	end
end
