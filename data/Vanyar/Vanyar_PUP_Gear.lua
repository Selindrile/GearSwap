-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('Normal','Acc','FullAcc','Fodder')
  state.HybridMode:options('Pet','DT','Normal')
  state.WeaponskillMode:options('Match','Normal','Acc','FullAcc','Fodder')
  state.PhysicalDefenseMode:options('PDT')
	state.IdleMode:options('Normal','PDT','Refresh')
	state.Weapons:options('None','Godhands','PetWeapons')

  -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
  defaultManeuvers = {
    ['Melee'] = {'Fire Maneuver','Thunder Maneuver','Wind Maneuver','Light Maneuver'},
    ['Ranged'] = {'Wind Maneuver','Fire Maneuver','Thunder Maneuver','Light Maneuver'},
    ['Tank'] = {'Earth Maneuver','Fire Maneuver', 'Light Maneuver','Dark Maneuver'},
    ['LightTank'] = {'Earth Maneuver','Fire Maneuver','Light Maneuver','Dark Maneuver'},
    ['Magic'] = {'Ice Maneuver','Light Maneuver','Dark Maneuver','Earth Maneuver'},
    ['Heal'] = {'Light Maneuver','Dark Maneuver','Water Maneuver','Earth Maneuver'},
    ['Nuke'] = {'Ice Maneuver','Dark Maneuver', 'Light Maneuver','Earth Maneuver'}
  }

  --select_default_macro_book()
	send_command('bind @` gs c cycle SkillchainMode')
  send_command('bind !` gs c cycle PetMode')
	send_command('bind @f8 gs c toggle AutoPuppetMode')
	send_command('bind @f7 gs c toggle AutoRepairMode')
  send_command('bind ^f8 gs c toggle PetWSGear')
end

-- Define sets used by this job file.
function init_gear_sets()
  -- Precast Sets

  -- Fast cast sets for spells
  sets.precast.FC = {
  	head=gear.Herc_FC_head,
    neck="Voltsurge Torque",
    ear1="Enchntr. Earring +1",
    ear2="Loquacious Earring",
  	body="Zendik Robe",
    ring1="Lebeche Ring",
    ring2="Prolix Ring",
  	back="Perimede Cape",
    waist="Isa Belt",
    legs="Rawhide Trousers",
    feet="Regal Pumps +1"
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


  -- Precast sets to enhance JAs
  sets.precast.JA['Tactical Switch'] = {} --feet="Cirque Scarpe +2"
  sets.precast.JA['Repair'] = {ammo="Automat. Oil +3"} --feet="Foire Babouches"
	sets.precast.JA['Maintenance'] = {ammo="Automat. Oil +3"}

  sets.precast.JA.Maneuver = {
    --neck="Buffoon's Collar +1",
    --hands="Foire Dastanas",
    --body="Cirque Farsetto +2",
    back="Visucius's Mantle"
  }

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {}
  sets.precast.Waltz['Healing Waltz'] = {}


  -- Weaponskill sets
  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = { --s.pummel + v.smite
    head="Rao Kabuto +1",
    neck="Caro necklace",
    ear1="Moonshade Earring",
    ear2="Brutal Earring",
    body=gear.Herc_WS_body,
    hands="Ryuo Tekko +1",
    ring1="Niqmaddu Ring",
    ring2="Regal Ring",
    back="Visucius's Mantle",
    waist="Moonbow Belt +1",
    legs="Hiza. Hizayoroi +2",
    feet="Ryuo Sune-Ate +1",
  }
	sets.precast.WS.Acc = set_combine(sets.precast.WS,{})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS,{})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS,{})

  -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
  sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Stringing Pummel'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Stringing Pummel'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Stringing Pummel'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Victory Smite'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Victory Smite'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Victory Smite'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
    head=gear.Herc_TA_head,
    body=gear.Herc_TA_body,
    hands=gear.Herc_TA_hands,
    legs=gear.Herc_TA_legs,
    feet=gear.Herc_TA_feet,
  })
  sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Shijin Spiral'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Shijin Spiral'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Asuran Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Asuran Fists'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Dragon Kick'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Dragon Kick'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Dragon Kick'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Tornado Kick'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tornado Kick'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Tornado Kick'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Asuran Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Asuran Fists'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Raging Fists'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Raging Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Raging Fists'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Howling Fist'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Howling Fist'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Howling Fist'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  sets.precast.WS['Backhand Blow'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Backhand Blow'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Backhand Blow'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Backhand Blow'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Spinning Attack'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Spinning Attack'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Spinning Attack'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  sets.precast.WS['Shoulder Tackle'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Shoulder Tackle'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Shoulder Tackle'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Shoulder Tackle'].Fodder = set_combine(sets.precast.WS.Fodder, {})
    -- Midcast Sets

  sets.midcast.FastRecast = {
  	head=gear.Herc_FC_head,
    neck="Voltsurge Torque",
    ear1="Enchntr. Earring +1",
    ear2="Loquacious Earring",
  	body="Zendik Robe",
    ring1="Lebeche Ring",
    ring2="Prolix Ring",
  	back="Perimede Cape",
    waist="Isa Belt",
    legs="Rawhide Trousers",
    feet="Regal Pumps +1"
  }

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

  -- Midcast sets for pet actions
  sets.midcast.Pet.Cure = {}
	sets.midcast.Pet['Enfeebling Magic'] = {
    head="Tali'ah Turban +2",
    body="Tali'ah Manteel +2",
    hands="Tali'ah Gages +1",
    legs="Tali'ah Sera. +2",
    feet="Tali'ah Crackows +2",
    neck="Adad Amulet",
    ear1="Enmerkar Earring",
    ear2="Burana Earring",
    ring1="Tali'ah Ring",
    ring2="Varar Ring",
    waist="Ukko Sash",
  }
  sets.midcast.Pet['Elemental Magic'] = {
    head="Tali'ah Turban +2",
    body="Tali'ah Manteel +2",
    hands="Tali'ah Gages +1",
    legs="Tali'ah Sera. +2",
    feet="Tali'ah Crackows +2",
    neck="Adad Amulet",
    ear1="Enmerkar Earring",
    ear2="Burana Earring",
    ring1="Tali'ah Ring",
    ring2="Varar Ring",
    waist="Ukko Sash",
  }
	sets.midcast.Pet.PetWSGear = {
    neck="Shulmanu Collar",
    ear1="Enmerkar Earring",
    ear2="Handler's Earring +1",
    ring1="Varar Ring",
    ring2="Varar Ring",
    back="Dispersal Mantle",
    waist="Incarnation Sash",
    legs="Tali'ah Sera. +2"
  }

  sets.midcast.Pet.PetWSGear.Ranged = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Melee = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Tank = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.LightTank = set_combine(sets.midcast.Pet.PetWSGear, {})
  sets.midcast.Pet.PetWSGear.Magic = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Heal = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Nuke = set_combine(sets.midcast.Pet.PetWSGear, {})

	-- Currently broken, preserved in case of future functionality.
	sets.midcast.Pet.WeaponSkill = {}


  -- Sets to return to when not performing an action.

  -- Resting sets
  sets.resting = {}


  -- Idle sets
  sets.idle = {
      head=gear.Herc_DT_head,
      neck="Loricate Torque +1",
      ear1="Etiolation Earring",
      ear2="Sanare Earring",
      body="Hiza. Haramaki +2",
      hands=gear.Herc_DT_hands,
      ring1="Defending Ring",
      ring2="Vocane Ring",
      back="Moonlight Cape",
      waist="Moonbow Belt +1",
      legs=gear.Herc_DT_legs,
      --feet="Hippo. Socks +1"
    }

	sets.idle.Refresh = sets.idle

  -- Set for idle while pet is out (eg: pet regen gear)
  sets.idle.Pet = {
    --head="Rawhide Mask",
    neck="Loricate Torque +1",
    ear1="Enmerkar Earring",
    ear2="Handler's Earring +1",
    body="Taeon Tabard",
    hands=gear.Herc_DT_hands,
    ring1="Defending Ring",
    ring2="Vocane Ring",
    back="Moonlight Cape",
    waist="Isa Belt",
    legs="Tali'ah Sera. +2",
    --feet="Hippo. Socks +1"
  }

  -- Idle sets to wear while pet is engaged
  sets.idle.Pet.Engaged = {
      head="Anwig Salade",
      neck="Shulmanu Collar",
      ear1="Enmerkar Earring",
      ear2="Handler's Earring +1",
      body="Taeon Tabard",
      --hands="Regimen Mittens",
      ring1="Varar Ring",
      ring2="Varar Ring",
      back="Visucius's Mantle",
      --waist="Klouskap Sash",
      legs="Tali'ah Sera. +2",
      feet="Tali'ah Crackows +2"
    }

  sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Melee = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Tank = set_combine(sets.idle.Pet.Engaged, {
    -- 44 %
    --main="Condemners",      -- 5
    head="Anwig Salade",      -- 10
    body="Rao Togi",          -- 4
    hands="Rao Kote +1",      -- 4
    legs="Rao Haidate +1",    -- 4
    feet="Rao Sune-Ate +1",   -- 4
    neck="Shepherd's Chain",  -- 2
    waist="Isa Belt",         -- 3
    ear1="Enmerkar Earring",  -- 4
    ear2="Rimeice Earring",   -- 3
    ring1="Varar Ring",       -- 1
    ring2="Overbearing Ring",
    back="Visucius's Mantle",
  })
	sets.idle.Pet.Engaged.LightTank = set_combine(sets.idle.Pet.Engaged, {waist="Isa Belt"})
  sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Heal = sets.idle.Pet.Engaged.Magic
	sets.idle.Pet.Engaged.Nuke = sets.idle.Pet.Engaged.Magic


  -- Defense sets
  sets.defense.PDT = {}
  sets.defense.MDT = {}
  sets.defense.MEVA = {}

  sets.Kiting = {feet="Hermes' Sandals"}

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- Normal melee group
  sets.engaged = {
    head=gear.Herc_TA_head,
    body=gear.Herc_TA_body,
    hands="Ryuo Tekko +1",
    legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    neck="Shulmanu Collar",
    waist="Moonbow Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Epona's Ring",
    right_ring="Niqmaddu Ring",
    }
  sets.engaged.Acc = set_combine(sets.engaged,{
    head="Ryuo Somen +1",
  })
  sets.engaged.FullAcc = set_combine(sets.engaged,{})
	sets.engaged.Fodder = set_combine(sets.engaged,{})
  sets.engaged.DT = set_combine(sets.engaged,{})
  sets.engaged.Acc.DT = set_combine(sets.engaged,{})
  sets.engaged.FullAcc.DT = set_combine(sets.engaged,{})
  sets.engaged.Fodder.DT = set_combine(sets.engaged,{})
  sets.engaged.Pet = set_combine(sets.engaged,{})
  sets.engaged.Acc.Pet = set_combine(sets.engaged,{})
  sets.engaged.FullAcc.Pet = set_combine(sets.engaged,{})
  sets.engaged.Fodder.Pet = set_combine(sets.engaged,{})

	-- Weapons sets
	sets.weapons.PetWeapons = {main="Midnights",range="Animator P +1",}
	sets.weapons.Godhands = {main="Godhands",range="Animator P +1",}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 20)
    else
        set_macro_page(2, 20)
    end
end
