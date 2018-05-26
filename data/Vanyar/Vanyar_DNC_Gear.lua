-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('Normal', 'SomeAcc','Acc','FullAcc','Fodder')
  state.HybridMode:options('Normal','DTLite','PDT','MDT')
  state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
  state.IdleMode:options('Normal', 'Sphere')
  state.PhysicalDefenseMode:options('PDT')
  state.MagicalDefenseMode:options('MDT')
  state.ResistDefenseMode:options('MEVA')
  state.Weapons:options('Aeneas','MagicWeapons')
  state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWEarrings','DWMax'}

  gear.stp_jse_back = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
  gear.wsd_jse_back = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

  -- Additional local binds
  send_command('bind ^` input /ja "Saber Dance" <me>')
  send_command('bind !` input /ja "Fan Dance" <me>')
  send_command('bind ^\\\\ input /ja "Chocobo Jig II" <me>')
  send_command('bind !\\\\ input /ja "Spectral Jig" <me>')
  send_command('bind !backspace input /ja "Reverse Flourish" <me>')
  send_command('bind ^backspace input /ja "No Foot Rise" <me>')
  send_command('bind @` gs c cycle SkillchainMode')

  select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  --------------------------------------
  -- Start defining the sets
  --------------------------------------
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

  -- Extra Melee sets.  Apply these on top of melee sets.
	sets.Suppa = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket +1",hands="Floral Gauntlets",waist="Shetal Stone"}

	-- Weapons sets
	sets.weapons.Aeneas = {main="Aeneas",sub="Taming Sari"}
	sets.weapons.MagicWeapons = {main="Malevolence",sub="Malevolence"}

  -- Precast Sets

  -- Precast sets to enhance JAs

  sets.precast.JA['No Foot Rise'] = {} --body="Horos Casaque +1"

  sets.precast.JA['Trance'] = {} --head="Horos Tiara +1"


  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
    ammo="Yamarang",
    head="Mummu Bonnet +1",
    neck="Unmoving Collar +1",
    ear1="Enchntr. Earring +1",
    ear2="Handler's Earring +1",
    --body=gear.herculean_waltz_body,
    --hands=gear.herculean_waltz_hands,
    ring1="Defending Ring",
    --ring2="Valseur's Ring",
    back="Toetapper Mantle",
    waist="Chaac Belt",
    --legs="Dashing Subligar",
    --feet=gear.herculean_waltz_feet
  }

	sets.Self_Waltz = {
    head="Mummu Bonnet +1",
    body="Passion Jacket",
    ring1="Asklepian Ring"
  }

  -- Don't need any special gear for Healing Waltz.
  sets.precast.Waltz['Healing Waltz'] = {}

  sets.precast.Samba = {back=gear.stp_jse_back} --head="Maxixi Tiara"

  sets.precast.Jig = {} --legs="Horos Tights", feet="Maxixi Toe Shoes"

  sets.precast.Step = {
    ammo="Falcon Eye",
    head="Dampening Tam",
    neck="Combatant's Torque",
    ear1="Telos Earring",
    ear2="Digni. Earring",
    body="Mummu Jacket +1",
    hands="Adhemar Wrist. +1",
    ring1="Ramuh Ring +1",
    ring2="Ramuh Ring +1",
    back=gear.stp_jse_back,
    waist="Olseni Belt",
    legs="Meg. Chausses +2",
    feet=gear.Herc_Acc_feet
  }

  sets.Enmity = {
    --ammo="Paeapua",
    head="Genmei Kabuto",
    neck="Unmoving Collar +1",
    ear1="Friomisi Earring",
    ear2="Trux Earring",
    body="Emet Harness +1",
    hands=gear.Herc_DT_hands,
    ring1="Petrov Ring",
    ring2="Vengeful Ring",
    back="Solemnity Cape",
    waist="Goading Belt",
    legs=gear.Herc_DT_legs,
    feet=gear.Herc_DT_feet
  }

  sets.precast.JA.Provoke = sets.Enmity

  sets.precast.Flourish1 = {}
  sets.precast.Flourish1['Violent Flourish'] = {
    ammo="Falcon Eye",
    head="Dampening Tam",
    neck="Combatant's Torque",
    ear1="Telos Earring",
    ear2="Digni. Earring",
    body="Mummu Jacket +1",
    hands="Adhemar Wrist. +1",
    ring1="Ramuh Ring +1",
    ring2="Ramuh Ring +1",
    back=gear.stp_jse_back,
    waist="Olseni Belt",
    legs="Meg. Chausses +2",
    feet=gear.Herc_Acc_feet
  }

  sets.precast.Flourish1['Animated Flourish'] = sets.Enmity

  sets.precast.Flourish1['Desperate Flourish'] = {
    ammo="Falcon Eye",
    head="Dampening Tam",
    neck="Combatant's Torque",
    ear1="Telos Earring",
    ear2="Digni. Earring",
    body="Mummu Jacket +1",
    hands="Adhemar Wrist. +1",
    ring1="Ramuh Ring +1",
    ring2="Ramuh Ring +1",
    back=gear.stp_jse_back,
    waist="Olseni Belt",
    legs="Meg. Chausses +2",
    feet=gear.Herc_Acc_feet
  }

  sets.precast.Flourish2 = {}
  sets.precast.Flourish2['Reverse Flourish'] = {back="Toetapper Mantle"} --hands="Charis Bangles +2"

  sets.precast.Flourish3 = {}
  sets.precast.Flourish3['Striking Flourish'] = {} --body="Charis Casaque +2"
  sets.precast.Flourish3['Climactic Flourish'] = {}

  -- Fast cast sets for spells

  sets.precast.FC = {
    ammo="Impatiens",
  	head=gear.Herc_FC_head,
    neck="Voltsurge Torque",
    ear1="Enchntr. Earring +1",
    ear2="Loquacious Earring",
  	body="Samnuha Coat",
    hands="Leyline Gloves",
    ring1="Lebeche Ring",
    ring2="Prolix Ring",
  	legs="Rawhide Trousers"
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


  -- Weaponskill sets
  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo="Seeth. Bomblet +1",
    head="Lustratio Cap +1",
    body=gear.Herc_WS_body,
    hands="Meghanada Gloves +2",
    --legs="Samnuha Tights",
    legs="Lustratio Subligar +1",
    feet="Lustratio Leggings +1",
    neck="Fotia Gorget",
    --waist="Fotia Belt",
    waist="Grunfeld Rope",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back=gear.wsd_jse_back,
  }
  sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
  sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Proc = {
    ammo="Yamarang",
    head="Wh. Rarab Cap +1",
    neck="Loricate Torque +1",
    ear1="Brutal Earring",
    ear2="Sanare Earring",
    body="Emet Harness +1",
    hands="Kurys Gloves",
    ring1="Defending Ring",
    ring2="Vocane Ring",
    back="Moonlight Cape",
    waist="Flume Belt +1",
    legs="Carmine Cuisses +1",
    feet="Ahosi Leggings"
  }

  -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
  sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
    ammo="Seeth. Bomblet +1",
    head="Lustratio Cap +1",
    body=gear.Herc_WS_body,
    hands="Meghanada Gloves +2",
    --legs="Samnuha Tights",
    legs="Lustratio Subligar +1",
    feet="Lustratio Leggings +1",
    neck="Fotia Gorget",
    --waist="Fotia Belt",
    waist="Grunfeld Rope",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back=gear.wsd_jse_back,

  })
  sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
  sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
  sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})

  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    ammo="Yetshila +1",
    head="Maculele tiara +1",
    neck="Fotia Gorget",
    body="Meghanada cuirie +2",
    hands=gear.Herc_TA_hands,
		legs="Samnuha Tights",
		feet=gear.Herc_TA_feet,
    ring1="Begrudging Ring",
    waist="Fotia Belt",
  })
  sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
  sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})

  sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
		legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    ear2="Mache Earring +1",
    ring1="Regal Ring",
  })
  sets.precast.WS['Pyrrhic Kleos'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
  sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Pyrrhic Kleos'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Pyrrhic Kleos'].Fodder = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})

  sets.precast.WS['Aeolian Edge'] = {
    ammo="Seeth. Bomblet +1",
    head=gear.herculean_nuke_head,
    neck="Baetyl Pendant",
    ear1="Friomisi Earring",
    ear2="Crematio Earring",
    body=gear.Herc_MAB_bod,
    hands="Leyline Gloves",
    ring1="Shiva Ring +1",
    ring2="Shiva Ring +1",
    back=gear.wsd_jse_back,
    waist="Chaac Belt",
    legs=gear.Herc_WS_legs,
    feet=gear.Herc_WS_feet,
  }

  sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Sherida Earring"}
	sets.AccMaxTP = {ear1="Zennaroi Earring",ear2="Sherida Earring"}

  sets.Skillchain = {} --hands="Charis Bangles +2"


  -- Midcast Sets
  sets.midcast.FastRecast = {}

    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})


  -- Sets to return to when not performing an action.

  -- Resting sets
  sets.resting = {}
  sets.ExtraRegen = {}


  -- Idle sets
  sets.idle = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam",
    body="Meghanada cuirie +2",
		hands="Meghanada Gloves +2",
		legs="Meg. Chausses +2",
		feet="Skd. Jambeaux +1",
    neck="Loricate Torque +1",
    ear1="Etiolation Earring",
    ear2="Sanare Earring",
    ring1="Defending Ring",
    ring2="Sheltered Ring",
    back="Moonlight Cape",
    waist="Flume Belt +1",
  }

  sets.idle.Sphere = set_combine(sets.idle, {})--body="Mekosu. Harness"

  -- Defense sets
  sets.defense.PDT = {
    ammo="Staunch Tathlum +1",
    head=gear.Herc_DT_head,
    neck="Loricate Torque +1",
    ear1="Etiolation Earring",
    ear2="Sanare Earring",
    body="Meg. Cuirie +2",
    hands=gear.Herc_DT_hands,
    ring1="Defending Ring",
    ring2="Vocane Ring",
    back="Moonlight Cape",
    waist="Flume Belt +1",
    legs=gear.Herc_DT_legs,
    feet="Ahosi Leggings"
  }

  sets.defense.MDT = sets.defense.PDT

	sets.defense.MEVA = sets.defense.PDT

  sets.Kiting = {feet="Skadi's Jambeaux +1"}

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- Normal melee group
  sets.engaged = {
    ammo="Yamarang",
    head="Adhemar Bonnet +1",
    body="Adhemar Jacket +1",
    hands="Adhemar Wristbands +1",
    legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    ring1="Petrov Ring",
    ring2="Epona's Ring",
    back=gear.stp_jse_back,
  }

  sets.engaged.DTLite = set_combine(sets.engaged,{
    head="Dampening Tam",
    neck="Loricate Torque +1",
    ring1="Moonlight Ring",
  })

  sets.engaged.SomeAcc = set_combine(sets.engaged,{
    neck="Combatant's Torque",
  })

	sets.engaged.Acc = set_combine(sets.engaged.SomeAcc,{
    body="Mummu Jacket +1",
    hands="Floral Gauntlets",
    ring1="Ilabrat Ring",
    waist="Reiki Yotai",
  })

  sets.engaged.FullAcc = set_combine(sets.engaged.Acc,{
    ammo="Falcon Eye",
    ear2="Digni. Earring",
    legs="Meg. Chausses +2",
  })

  sets.engaged.Fodder = set_combine(sets.engaged,{})

  sets.engaged.PDT = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam",
    neck="Loricate Torque +1",
    ear1="Dudgeon Earring",
    ear2="Heartseeker Earring",
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    ring1="Defending Ring",
    ring2="Moonlight Ring",
    back="Moonlight Cape",
    waist="Flume Belt +1",
    legs="Meg. Chausses +2",
    feet="Ahosi Leggings"
  }

  sets.engaged.SomeAcc.PDT = sets.engaged.PDT
  sets.engaged.Acc.PDT = sets.engaged.PDT
  sets.engaged.FullAcc.PDT = sets.engaged.PDT
  sets.engaged.Fodder.PDT = sets.engaged.PDT

  -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
  sets.buff['Saber Dance'] = {} --legs="Horos Tights"
  sets.buff['Climactic Flourish'] = {ammo="Charis Feather",head="Adhemar Bonnet +1",body="Meg. Cuirie +2"} --head="Charis Tiara +2"
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(10, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'SAM' then
        set_macro_page(9, 9)
    elseif player.sub_job == 'THF' then
        set_macro_page(8, 9)
    else
        set_macro_page(10, 9)
    end
end
