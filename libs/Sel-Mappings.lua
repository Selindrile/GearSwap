-------------------------------------------------------------------------------------------------------------------
-- Mappings, lists and sets to describe game relationships that aren't easily determinable otherwise.
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Spell Degration
-------------------------------------------------------------------------------------------------------------------
degrade_tables = {}
degrade_tables.Cure = {"Cure","Cure II","Cure III","Cure IV","Cure V","Cure VI"}
degrade_tables.Curaga = {"Curaga","Curaga II","Curaga III","Curaga IV","Curaga V"}
degrade_tables.Holy = {"Holy","Holy II"}
degrade_tables.Raise = {"Raise","Raise II","Raise III","Arise"}
degrade_tables.Reraise = {"Reraise","Reraise II","Reraise III","Reraise IV"}
degrade_tables.Fire = {"Fire","Fire II","Fire III","Fire IV","Fire V","Fire VI"}
degrade_tables.Stone = {"Stone","Stone II","Stone III","Stone IV","Stone V","Stone VI"}
degrade_tables.Blizzard = {"Blizzard","Blizzard II","Blizzard III","Blizzard IV","Blizzard V","Blizzard VI"}
degrade_tables.Water = {"Water","Water II","Water III","Water IV","Water V","Water VI"}
degrade_tables.Aero = {"Aero","Aero II","Aero III","Aero IV","Aero V","Aero VI"}
degrade_tables.Thunder = {"Thunder","Thunder II","Thunder III","Thunder IV","Thunder V","Thunder VI"}
degrade_tables.Firaga = {'Firaga', 'Firaga II','Firaga III','Firaja'}
degrade_tables.Blizzaga = {'Blizzaga', 'Blizzaga II','Blizzaga III','Blizzaja'}
degrade_tables.Aeroga = {'Aeroga', 'Aeroga II','Aeroga III','Aeroja'}
degrade_tables.Stonega = {'Stonega','Stonega II','Stonega III','Stoneja'}
degrade_tables.Thundaga = {'Thundaga','Thundaga II','Thundaga III','Thundaja'}
degrade_tables.Waterga = {'Waterga','Waterga II','Waterga III','Waterja'}
degrade_tables.Fira = {'Fira', 'Fira II','Fira III'}
degrade_tables.Blizzara = {'Blizzara', 'Blizzara II','Blizzara III'}
degrade_tables.Aera = {'Aera', 'Aera II','Aera III'}
degrade_tables.Stonera = {'Stonera','Stonera II','Stonera III'}
degrade_tables.Thundara = {'Thundara','Thundara II','Thundara III'}
degrade_tables.Watera = {'Watera','Watera II','Watera III'}
degrade_tables.Aspir = {"Aspir","Aspir II","Aspir III"}
degrade_tables.Drain = {"Drain","Drain II","Drain III"}
degrade_tables.Sleep = {"Sleep","Sleep II"}
degrade_tables.Sleepga = {"Sleepga","Sleepga II"}
degrade_tables.Utsusemi = {"Utsusemi: Ichi","Utsusemi: Ni","Utsusemi: San"}

degrade_tables_light = {}
degrade_tables_light.Aspir = {"Aspir","Aspir II","Aspir III"}
degrade_tables_light.Sleep = {"Sleep","Sleep II"}
degrade_tables_light.Sleepga = {"Sleepga","Sleepga II"}
degrade_tables_light.Raise = {"Raise","Raise II","Raise III","Arise"}
degrade_tables_light.Reraise = {"Reraise","Reraise II","Reraise III","Reraise IV"}
--degrade_tables.HordeLullaby = {"Horde Lullaby","Horde Lullaby II"} --need to check the correct name
--degrade_tables.FoeLullaby = {"Foe Lullaby","Foe Lullaby II"}
-------------------------------------------------------------------------------------------------------------------
-- Elemental mappings for element relationships and certain types of spells and gear.
-------------------------------------------------------------------------------------------------------------------

-- Basic elements
elements = {}

elements.list = S{'Light','Dark','Fire','Ice','Wind','Earth','Lightning','Water'}

elements.weak_to = {['Light']='Dark', ['Dark']='Light', ['Fire']='Ice', ['Ice']='Wind', ['Wind']='Earth', ['Earth']='Lightning',
        ['Lightning']='Water', ['Water']='Fire'}

elements.strong_to = {['Light']='Dark', ['Dark']='Light', ['Fire']='Water', ['Ice']='Fire', ['Wind']='Ice', ['Earth']='Wind',
        ['Lightning']='Earth', ['Water']='Lightning'}

storms = S{"Aurorastorm", "Voidstorm", "Firestorm", "Sandstorm", "Rainstorm", "Windstorm", "Hailstorm", "Thunderstorm",
		"Aurorastorm II", "Voidstorm II", "Firestorm II", "Sandstorm II", "Rainstorm II", "Windstorm II", "Hailstorm II", "Thunderstorm II"}

elements.storm_of = {['Light']="Aurorastorm", ['Dark']="Voidstorm", ['Fire']="Firestorm", ['Earth']="Sandstorm",
        ['Water']="Rainstorm", ['Wind']="Windstorm", ['Ice']="Hailstorm", ['Lightning']="Thunderstorm",['Light']="Aurorastorm II",
		['Dark']="Voidstorm II", ['Fire']="Firestorm II", ['Earth']="Sandstorm II", ['Water']="Rainstorm II", ['Wind']="Windstorm II",
		['Ice']="Hailstorm II", ['Lightning']="Thunderstorm II"}

spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
elements.spirit_of = {['Light']="Light Spirit", ['Dark']="Dark Spirit", ['Fire']="Fire Spirit", ['Earth']="Earth Spirit",
        ['Water']="Water Spirit", ['Wind']="Air Spirit", ['Ice']="Ice Spirit", ['Lightning']="Thunder Spirit"}

runes = S{'Lux', 'Tenebrae', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda'}
elements.rune_of = {['Light']='Lux', ['Dark']='Tenebrae', ['Fire']='Ignis', ['Ice']='Gelus', ['Wind']='Flabra',
     ['Earth']='Tellus', ['Lightning']='Sulpor', ['Water']='Unda'}

elements.obi_of = {['Light']='Hachirin-no-obi', ['Dark']='Hachirin-no-obi', ['Fire']='Hachirin-no-obi', ['Ice']='Hachirin-no-obi', ['Wind']='Hachirin-no-obi',
     ['Earth']='Hachirin-no-obi', ['Lightning']='Hachirin-no-obi', ['Water']='Hachirin-no-obi'}

elements.gorget_of = {['Light']='Fotia Gorget', ['Dark']='Fotia Gorget', ['Fire']='Fotia Gorget', ['Ice']='Fotia Gorget',
    ['Wind']='Fotia Gorget', ['Earth']='Fotia Gorget', ['Lightning']='Fotia Gorget', ['Water']='Fotia Gorget'}

elements.belt_of = {['Light']='Fotia Belt', ['Dark']='Fotia Belt', ['Fire']='Fotia Belt', ['Ice']='Fotia Belt',
    ['Wind']='Fotia Belt', ['Earth']='Fotia Belt', ['Lightning']='Fotia Belt', ['Water']='Fotia Belt'}

elements.fastcast_staff_of = {['Light']='Arka I', ['Dark']='Xsaeta I', ['Fire']='Atar I', ['Ice']='Vourukasha I',
    ['Wind']='Vayuvata I', ['Earth']='Vishrava I', ['Lightning']='Apamajas I', ['Water']='Haoma I', ['Thunder']='Apamajas I'}

elements.recast_staff_of = {['Light']='Arka II', ['Dark']='Xsaeta II', ['Fire']='Atar II', ['Ice']='Vourukasha II',
    ['Wind']='Vayuvata II', ['Earth']='Vishrava II', ['Lightning']='Apamajas II', ['Water']='Haoma II', ['Thunder']='Apamajas II'}

elements.perpetuance_staff_of = {['Light']='Arka III', ['Dark']='Xsaeta III', ['Fire']='Atar III', ['Ice']='Vourukasha III',
    ['Wind']='Vayuvata III', ['Earth']='Vishrava III', ['Lightning']='Apamajas III', ['Water']='Haoma III', ['Thunder']='Apamajas III'}


-- Elements for skillchain names
skillchain_elements = {}
skillchain_elements.Light = S{'Light','Fire','Wind','Lightning'}
skillchain_elements.Darkness = S{'Dark','Ice','Earth','Water'}
skillchain_elements.Fusion = S{'Light','Fire'}
skillchain_elements.Fragmentation = S{'Wind','Lightning'}
skillchain_elements.Distortion = S{'Ice','Water'}
skillchain_elements.Gravitation = S{'Dark','Earth'}
skillchain_elements.Transfixion = S{'Light'}
skillchain_elements.Compression = S{'Dark'}
skillchain_elements.Liquification = S{'Fire'}
skillchain_elements.Induration = S{'Ice'}
skillchain_elements.Detonation = S{'Wind'}
skillchain_elements.Scission = S{'Earth'}
skillchain_elements.Impaction = S{'Lightning'}
skillchain_elements.Reverberation = S{'Water'}


-------------------------------------------------------------------------------------------------------------------
-- Mappings for weaponskills
-------------------------------------------------------------------------------------------------------------------

-- REM weapons and their corresponding weaponskills
data = {}
data.weaponskills = {}
data.weaponskills.relic = {
    ["Spharai"] = "Final Heaven",
    ["Mandau"] = "Mercy Stroke",
    ["Excalibur"] = "Knights of Round",
    ["Ragnarok"] = "Scourge",
    ["Guttler"] = "Onslaught",
    ["Bravura"] = "Metatron Torment",
    ["Apocalypse"] = "Catastrophe",
    ["Gungnir"] = "Gierskogul",
    ["Kikoku"] = "Blade: Metsu",
    ["Amanomurakumo"] = "Tachi: Kaiten",
    ["Mjollnir"] = "Randgrith",
    ["Claustrum"] = "Gates of Tartarus",
    ["Annihilator"] = "Coronach",
    ["Yoichinoyumi"] = "Namas Arrow"}
data.weaponskills.mythic = {
    ["Conqueror"] = "King's Justice",
    ["Glanzfaust"] = "Ascetic's Fury",
    ["Yagrush"] = "Mystic Boon",
    ["Laevateinn"] = "Vidohunir",
    ["Murgleis"] = "Death Blossom",
    ["Vajra"] = "Mandalic Stab",
    ["Burtgang"] = "Atonement",
    ["Liberator"] = "Insurgency",
    ["Aymur"] = "Primal Rend",
    ["Carnwenhan"] = "Mordant Rime",
    ["Gastraphetes"] = "Trueflight",
    ["Kogarasumaru"] = "Tachi: Rana",
    ["Nagi"] = "Blade: Kamu",
    ["Ryunohige"] = "Drakesbane",
    ["Nirvana"] = "Garland of Bliss",
    ["Tizona"] = "Expiacion",
    ["Death Penalty"] = "Leaden Salute",
    ["Kenkonken"] = "Stringing Pummel",
    ["Terpsichore"] = "Pyrrhic Kleos",
    ["Tupsimati"] = "Omniscience",
    ["Idris"] = "Exudation",
    ["Epeolatry"] = "Dimidiation"}
data.weaponskills.empyrean = {
    ["Verethragna"] = "Victory Smite",
    ["Twashtar"] = "Rudra's Storm",
    ["Almace"] = "Chant du Cygne",
    ["Caladbolg"] = "Torcleaver",
    ["Farsha"] = "Cloudsplitter",
    ["Ukonvasara"] = "Ukko's Fury",
    ["Redemption"] = "Quietus",
    ["Rhongomiant"] = "Camlann's Torment",
    ["Kannagi"] = "Blade: Hi",
    ["Masamune"] = "Tachi: Fudo",
    ["Gambanteinn"] = "Dagann",
    ["Hvergelmir"] = "Myrkr",
    ["Gandiva"] = "Jishnu's Radiance",
    ["Armageddon"] = "Wildfire"}

-- Weaponskills that can be used at range.
data.weaponskills.ranged = S{"Flaming Arrow","Piercing Arrow","Dulling Arrow","Sidewinder","Arching Arrow",
    "Empyreal Arrow","Refulgent Arrow","Apex Arrow","Namas Arrow","Jishnu's Radiance",
    "Hot Shot","Split Shot","Sniper Shot","Slug Shot","Heavy Shot","Detonator","Last Stand",
    "Coronach","Trueflight","Leaden Salute","Wildfire","Myrkr"}

ranged_weaponskills = data.weaponskills.ranged

mythic_weapons = S{'Conqueror','Glanzfaust','Yagrush','Laevateinn','Murgleis','Vajra','Burtgang','Liberator',
'Aymur','Carnwenhan','Gastraphetes','Kogarasumaru','Nagi','Ryunohige','Nirvana','Tizona','Death Penalty','Kenkonken',
'Terpsichore','Tupsimati','Idris','Epeolatry'}

elemental_obi_weaponskills = S{'Wildfire','Leaden Salute','Sanguine Blade','Aeolian Edge','Cataclysm','Trueflight','Tachi: Jinpu'}

-------------------------------------------------------------------------------------------------------------------
-- Spell mappings allow defining a general category or description that each of sets of related
-- spells all fall under.
-------------------------------------------------------------------------------------------------------------------

spell_maps = {
  ['Cure']='Cure',['Cure II']='Cure',['Cure III']='Cure',['Cure IV']='Cure',['Cure V']='Cure',['Cure VI']='Cure',['Full Cure']='Cure',
  ['Cura']='Curaga',['Cura II']='Curaga',['Cura III']='Curaga',
  ['Curaga']='Curaga',['Curaga II']='Curaga',['Curaga III']='Curaga',['Curaga IV']='Curaga',['Curaga V']='Curaga',
  -- Status Removal doesn't include Esuna or Sacrifice, since they work differently than the rest
  ['Poisona']='StatusRemoval',['Paralyna']='StatusRemoval',['Silena']='StatusRemoval',['Blindna']='StatusRemoval',['Cursna']='StatusRemoval',
  ['Stona']='StatusRemoval',['Viruna']='StatusRemoval',['Erase']='StatusRemoval',
  ['Barfire']='BarElement',['Barstone']='BarElement',['Barwater']='BarElement',['Baraero']='BarElement',['Barblizzard']='BarElement',['Barthunder']='BarElement',
  ['Barfira']='BarElement',['Barstonra']='BarElement',['Barwatera']='BarElement',['Baraera']='BarElement',['Barblizzara']='BarElement',['Barthundra']='BarElement',
	['Baramnesia']='BarStatus',['Baramnesra']='BarStatus',['Barvirus']='BarStatus',['Barvira']='BarStatus',['Barparalyze']='BarStatus',['Barparalyzra']='BarStatus',
	['Barsilence']='BarStatus',['Barsilencera']='BarStatus',['Barpetrify']='BarStatus',['Barpetra']='BarStatus',['Barpoison']='BarStatus',['Barpoisonra']='BarStatus',
	['Barblind']='BarStatus',['Barblindra']='BarStatus',['Barsleep']='BarStatus',['Barsleepra']='BarStatus',
	['Boost-AGI']='BoostStat',['Boost-CHR']='BoostStat',['Boost-DEX']='BoostStat',['Boost-INT']='BoostStat',['Boost-MND']='BoostStat',['Boost-STR']='BoostStat',['Boost-VIT']='BoostStat',
	['Gain-AGI']='BoostStat',['Gain-CHR']='BoostStat',['Gain-DEX']='BoostStat',['Gain-INT']='BoostStat',['Gain-MND']='BoostStat',['Gain-STR']='BoostStat',['Gain-VIT']='BoostStat',
  ['Raise']='Raise',['Raise II']='Raise',['Raise III']='Raise',['Arise']='Raise',
  ['Reraise']='Reraise',['Reraise II']='Reraise',['Reraise III']='Reraise',['Reraise IV']='Reraise',
	['Dia']='Dia',['Dia II']='Dia',['Dia III']='Dia',['Diaga']='Dia',['Diaga II']='Dia',
	['Bio']='Bio',['Bio II']='Bio',['Bio III']='Bio',
  ['Protect']='Protect',['Protect II']='Protect',['Protect III']='Protect',['Protect IV']='Protect',['Protect V']='Protect',
  ['Shell']='Shell',['Shell II']='Shell',['Shell III']='Shell',['Shell IV']='Shell',['Shell V']='Shell',
  ['Protectra']='Protectra',['Protectra II']='Protectra',['Protectra III']='Protectra',['Protectra IV']='Protectra',['Protectra V']='Protectra',
  ['Shellra']='Shellra',['Shellra II']='Shellra',['Shellra III']='Shellra',['Shellra IV']='Shellra',['Shellra V']='Shellra',
  ['Regen']='Regen',['Regen II']='Regen',['Regen III']='Regen',['Regen IV']='Regen',['Regen V']='Regen',
  ['Refresh']='Refresh',['Refresh II']='Refresh',['Refresh III']='Refresh',
  ['Teleport-Holla']='Teleport',['Teleport-Dem']='Teleport',['Teleport-Mea']='Teleport',['Teleport-Altep']='Teleport',['Teleport-Yhoat']='Teleport',
  ['Teleport-Vahzl']='Teleport',['Recall-Pashh']='Teleport',['Recall-Meriph']='Teleport',['Recall-Jugner']='Teleport',['Warp']='Teleport',['Escape']='Teleport',['Retrace']='Teleport',
	['Temper']='Temper',['Temper II']='Temper',
  ['Valor Minuet']='Minuet',['Valor Minuet II']='Minuet',['Valor Minuet III']='Minuet',['Valor Minuet IV']='Minuet',['Valor Minuet V']='Minuet',
  ["Knight's Minne"]='Minne',["Knight's Minne II"]='Minne',["Knight's Minne III"]='Minne',["Knight's Minne IV"]='Minne',["Knight's Minne V"]='Minne',
  ['Advancing March']='March',['Victory March']='March',['Honor March']='March',
  ['Sword Madrigal']='Madrigal',['Blade Madrigal']='Madrigal',
  ["Hunter's Prelude"]='Prelude',["Archer's Prelude"]='Prelude',
  ['Sheepfoe Mambo']='Mambo',['Dragonfoe Mambo']='Mambo',
  ['Raptor Mazurka']='Mazurka',['Chocobo Mazurka']='Mazurka',
	['Enfire']='Enspell',['Enfire II']='Enspell',['Enblizzard']='Enspell',['Enblizzard II']='Enspell',['Enaero']='Enspell',['Enaero II']='Enspell',['Enstone']='Enspell',['Enstone II']='Enspell',
	['Enthunder']='Enspell',['Enthunder II']='Enspell',['Enwater']='Enspell',['Enwater II']='Enspell',['Enlight']='Enspell',['Enlight II']='Enspell',['Endark']='Enspell',['Endark II']='Enspell',
  ['Sinewy Etude']='Etude',['Dextrous Etude']='Etude',['Vivacious Etude']='Etude',['Quick Etude']='Etude',['Learned Etude']='Etude',['Spirited Etude']='Etude',['Enchanting Etude']='Etude',
  ['Herculean Etude']='Etude',['Uncanny Etude']='Etude',['Vital Etude']='Etude',['Swift Etude']='Etude',['Sage Etude']='Etude',['Logical Etude']='Etude',['Bewitching Etude']='Etude',
  ["Mage's Ballad"]='Ballad',["Mage's Ballad II"]='Ballad',["Mage's Ballad III"]='Ballad',
  ["Army's Paeon"]='Paeon',["Army's Paeon II"]='Paeon',["Army's Paeon III"]='Paeon',["Army's Paeon IV"]='Paeon',["Army's Paeon V"]='Paeon',["Army's Paeon VI"]='Paeon',
  ['Fire Carol']='Carol',['Ice Carol']='Carol',['Wind Carol']='Carol',['Earth Carol']='Carol',['Lightning Carol']='Carol',['Water Carol']='Carol',['Light Carol']='Carol',['Dark Carol']='Carol',
  ['Fire Carol II']='Carol',['Ice Carol II']='Carol',['Wind Carol II']='Carol',['Earth Carol II']='Carol',['Lightning Carol II']='Carol',['Water Carol II']='Carol',['Light Carol II']='Carol',['Dark Carol II']='Carol',
  ['Foe Lullaby']='Lullaby',['Foe Lullaby II']='Lullaby',['Horde Lullaby']='Lullaby',['Horde Lullaby II']='Lullaby',
  ['Fire Threnody']='Threnody',['Ice Threnody']='Threnody',['Wind Threnody']='Threnody',['Earth Threnody']='Threnody',['Lightning Threnody']='Threnody',['Water Threnody']='Threnody',['Light Threnody']='Threnody',['Dark Threnody']='Threnody',
	['Fire Threnody II']='Threnody',['Ice Threnody II']='Threnody',['Wind Threnody II']='Threnody',['Earth Threnody II']='Threnody',['Lightning Threnody II']='Threnody',['Water Threnody II']='Threnody',['Light Threnody II']='Threnody',['Dark Threnody II']='Threnody',
  ['Battlefield Elegy']='Elegy',['Carnage Elegy']='Elegy',
  ['Foe Requiem']='Requiem',['Foe Requiem II']='Requiem',['Foe Requiem III']='Requiem',['Foe Requiem IV']='Requiem',['Foe Requiem V']='Requiem',['Foe Requiem VI']='Requiem',['Foe Requiem VII']='Requiem',
  ['Utsusemi: Ichi']='Utsusemi',['Utsusemi: Ni']='Utsusemi',['Utsusemi: San']='Utsusemi',
  ['Katon: Ichi'] = 'ElementalNinjutsu',['Suiton: Ichi'] = 'ElementalNinjutsu',['Raiton: Ichi'] = 'ElementalNinjutsu',
  ['Doton: Ichi'] = 'ElementalNinjutsu',['Huton: Ichi'] = 'ElementalNinjutsu',['Hyoton: Ichi'] = 'ElementalNinjutsu',
  ['Katon: Ni'] = 'ElementalNinjutsu',['Suiton: Ni'] = 'ElementalNinjutsu',['Raiton: Ni'] = 'ElementalNinjutsu',
  ['Doton: Ni'] = 'ElementalNinjutsu',['Huton: Ni'] = 'ElementalNinjutsu',['Hyoton: Ni'] = 'ElementalNinjutsu',
  ['Katon: San'] = 'ElementalNinjutsu',['Suiton: San'] = 'ElementalNinjutsu',['Raiton: San'] = 'ElementalNinjutsu',
  ['Doton: San'] = 'ElementalNinjutsu',['Huton: San'] = 'ElementalNinjutsu',['Hyoton: San'] = 'ElementalNinjutsu',
  ['Banish']='Banish',['Banish II']='Banish',['Banish III']='Banish',['Banishga']='Banish',['Banishga II']='Banish',
  ['Holy']='Holy',['Holy II']='Holy',['Drain']='Drain',['Drain II']='Drain',['Drain III']='Drain',['Aspir']='Aspir',['Aspir II']='Aspir',['Aspir III']='Aspir',
  ['Absorb-Str']='Absorb',['Absorb-Dex']='Absorb',['Absorb-Vit']='Absorb',['Absorb-Agi']='Absorb',['Absorb-Int']='Absorb',['Absorb-Mnd']='Absorb',['Absorb-Chr']='Absorb',
  ['Absorb-Acc']='Absorb',['Absorb-TP']='Absorb',['Absorb-Attri']='Absorb',
  ['Burn']='ElementalEnfeeble',['Frost']='ElementalEnfeeble',['Choke']='ElementalEnfeeble',['Rasp']='ElementalEnfeeble',['Shock']='ElementalEnfeeble',['Drown']='ElementalEnfeeble',
  ['Pyrohelix']='Helix',['Cryohelix']='Helix',['Anemohelix']='Helix',['Geohelix']='Helix',['Ionohelix']='Helix',['Hydrohelix']='Helix',['Luminohelix']='Helix',['Noctohelix']='Helix',
	['Pyrohelix II']='Helix',['Cryohelix II']='Helix',['Anemohelix II']='Helix',['Geohelix II']='Helix',['Ionohelix II']='Helix',['Hydrohelix II']='Helix',['Luminohelix II']='Helix',['Noctohelix II']='Helix',
  ['Firestorm']='Storm',['Hailstorm']='Storm',['Windstorm']='Storm',['Sandstorm']='Storm',['Thunderstorm']='Storm',['Rainstorm']='Storm',['Aurorastorm']='Storm',['Voidstorm']='Storm',
	['Firestorm II']='Storm',['Hailstorm II']='Storm',['Windstorm II']='Storm',['Sandstorm II']='Storm',['Thunderstorm II']='Storm',['Rainstorm II']='Storm',['Aurorastorm II']='Storm',['Voidstorm II']='Storm',
  ['Fire Maneuver']='Maneuver',['Ice Maneuver']='Maneuver',['Wind Maneuver']='Maneuver',['Earth Maneuver']='Maneuver',['Thunder Maneuver']='Maneuver',
  ['Water Maneuver']='Maneuver',['Light Maneuver']='Maneuver',['Dark Maneuver']='Maneuver',
	['Haste']='Haste',['Haste II']='Haste',
}

no_skill_spells_list = S{ 'Haste','Haste II', 'Refresh','Refresh II',
                          'Regen','Regen II','Regen III','Regen IV','Regen V',
                          'Protect','Protect II','Protect III','Protect IV','Protect V',
                          'Protectra','Protectra II','Protectra III','Protectra IV','Protectra V',
              						'Shell','Shell II','Shell III','Shell IV','Shell V',
                          'Shellra','Shellra II','Shellra III','Shellra IV','Shellra V',
                          'Raise','Raise II','Raise III','Arise',
                          'Reraise','Reraise II','Reraise III','Reraise IV',
              						'Sneak', 'Invisible', 'Deodorize','Tractor'}
over500_enhancing = S{'Temper','Temper II','Phalanx','Phalanx II',}

white_stratagems = S{'Penury','Celerity','Accession','Rapture','Perpetuance','Altruism','Tranquility','Addendum: White'}

black_stratagems = S{'Parsimony','Alacrity','Manifestation','Ebullience','Focalization','Equanimity','Immanence','Addendum: Black'}

geo_debuffs = S{'Frailty','Torpor','Wilt','Fade','Malaise','Slip','Torpor','Vex','Languor','Slow','Paralysis','Gravity','Poison'}
geo_buffs = S{'Regen','Refresh','Haste','STR','DEX','VIT','AGI','INT','MND','CHR','Fury','Barrier','Acumen','Fend','Precision','Voidance','Focus','Attunement'}

addendum_white = {[14]="Poisona",[15]="Paralyna",[16]="Blindna",[17]="Silena",[18]="Stona",[19]="Viruna",[20]="Cursna",
    [143]="Erase",[13]="Raise II",[140]="Raise III",[141]="Reraise II",[142]="Reraise III",[135]="Reraise"}

addendum_black = {[253]="Sleep",[259]="Sleep II",[260]="Dispel",[162]="Stone IV",[163]="Stone V",[167]="Thunder IV",
    [168]="Thunder V",[157]="Aero IV",[158]="Aero V",[152]="Blizzard IV",[153]="Blizzard V",[147]="Fire IV",[148]="Fire V",
    [172]="Water IV",[173]="Water V",[255]="Break"}

unbridled_learning_set = {['Thunderbolt']=true,['Harden Shell']=true,['Absolute Terror']=true,
    ['Gates of Hades']=true,['Tourbillion']=true,['Pyric Bulwark']=true,['Bilgestorm']=true,
    ['Bloodrake']=true,['Droning Whirlwind']=true,['Carcharian Verve']=true,['Blistering Roar']=true,
    ['Uproot']=true,['Crashing Thunder']=true,['Polar Roar']=true,['Mighty Guard']=true,['Cruel Joke']=true,
    ['Cesspool']=true,['Tearing Gust']=true}

--Job Related mappings.

mageJobs = S{'WHM','BLM','SCH','RDM','BRD','SMN','GEO'}
meleeJobs = S{'WAR','MNK','THF','PLD','DRK','SAM','NIN','BLU','DNC','RUN','COR','PUP','PLD','DRK','BST'}

-- Item related Mappings.

bayld_items = {'Tlalpoloani','Macoquetza','Camatlatia','Icoyoca','Tlamini','Suijingiri Kanemitsu','Zoquittihuitz',
'Quauhpilli Helm','Chocaliztli Mask','Xux Hat','Quauhpilli Gloves','Xux Trousers','Chocaliztli Boots','Maochinoli',
'Hatxiik','Kuakuakait','Azukinagamitsu','Atetepeyorg','Kaquljaan','Ajjub Bow','Baqil Staff','Ixtab','Otomi Helm',
'Otomi Gloves','Kaabnax Hat','Kaabnax Trousers','Ejekamal Mask','Ejekamal Boots','Quiahuiz Helm','Quiahuiz Trousers',
'Uk\'uxkaj Cap'}

cprings = L{"Trizek Ring","Vocation Ring","Capacity Ring","Facility Ring"}
cprings_count = 1

tool_map = {
        ['Katon: Ichi'] = res.items[1161],
        ['Katon: Ni'] = res.items[1161],
        ['Katon: San'] = res.items[1161],
        ['Hyoton: Ichi'] = res.items[1164],
        ['Hyoton: Ni'] = res.items[1164],
        ['Hyoton: San'] = res.items[1164],
        ['Huton: Ichi'] = res.items[1167],
        ['Huton: Ni'] = res.items[1167],
        ['Huton: San'] = res.items[1167],
        ['Doton: Ichi'] = res.items[1170],
        ['Doton: Ni'] = res.items[1170],
        ['Doton: San'] = res.items[1170],
        ['Raiton: Ichi'] = res.items[1173],
        ['Raiton: Ni'] = res.items[1173],
        ['Raiton: San'] = res.items[1173],
        ['Suiton: Ichi'] = res.items[1176],
        ['Suiton: Ni'] = res.items[1176],
        ['Suiton: San'] = res.items[1176],
        ['Utsusemi: Ichi'] = res.items[1179],
        ['Utsusemi: Ni'] = res.items[1179],
        ['Utsusemi: San'] = res.items[1179],
        ['Jubaku: Ichi'] = res.items[1182],
        ['Jubaku: Ni'] = res.items[1182],
        ['Jubaku: San'] = res.items[1182],
        ['Hojo: Ichi'] = res.items[1185],
        ['Hojo: Ni'] = res.items[1185],
        ['Hojo: San'] = res.items[1185],
        ['Kurayami: Ichi'] = res.items[1188],
        ['Kurayami: Ni'] = res.items[1188],
        ['Kurayami: San'] = res.items[1188],
        ['Dokumori: Ichi'] = res.items[1191],
        ['Dokumori: Ni'] = res.items[1191],
        ['Dokumori: San'] = res.items[1191],
        ['Tonko: Ichi'] = res.items[1194],
        ['Tonko: Ni'] = res.items[1194],
        ['Tonko: San'] = res.items[1194],
        ['Monomi: Ichi'] = res.items[2553],
        ['Monomi: Ni'] = res.items[2553],
        ['Aisha: Ichi'] = res.items[2555],
        ['Myoshu: Ichi'] = res.items[2642],
        ['Yurin: Ichi'] = res.items[2643],
        ['Migawari: Ichi'] = res.items[2970],
        ['Kakka: Ichi'] = res.items[2644],
        ['Gekka: Ichi'] = res.items[8803],
        ['Yain: Ichi'] = res.items[8804],
    }

universal_tool_map = {
        ['Katon: Ichi'] = res.items[2971],
        ['Katon: Ni'] = res.items[2971],
        ['Katon: San'] = res.items[2971],
        ['Hyoton: Ichi'] = res.items[2971],
        ['Hyoton: Ni'] = res.items[2971],
        ['Hyoton: San'] = res.items[2971],
        ['Huton: Ichi'] = res.items[2971],
        ['Huton: Ni'] = res.items[2971],
        ['Huton: San'] = res.items[2971],
        ['Doton: Ichi'] = res.items[2971],
        ['Doton: Ni'] = res.items[2971],
        ['Doton: San'] = res.items[2971],
        ['Raiton: Ichi'] = res.items[2971],
        ['Raiton: Ni'] = res.items[2971],
        ['Raiton: San'] = res.items[2971],
        ['Suiton: Ichi'] = res.items[2971],
        ['Suiton: Ni'] = res.items[2971],
        ['Suiton: San'] = res.items[2971],
        ['Utsusemi: Ichi'] = res.items[2972],
        ['Utsusemi: Ni'] = res.items[2972],
        ['Utsusemi: San'] = res.items[2972],
        ['Jubaku: Ichi'] = res.items[2973],
        ['Jubaku: Ni'] = res.items[2973],
        ['Jubaku: San'] = res.items[2973],
        ['Hojo: Ichi'] = res.items[2973],
        ['Hojo: Ni'] = res.items[2973],
        ['Hojo: San'] = res.items[2973],
        ['Kurayami: Ichi'] = res.items[2973],
        ['Kurayami: Ni'] = res.items[2973],
        ['Kurayami: San'] = res.items[2973],
        ['Dokumori: Ichi'] = res.items[2973],
        ['Dokumori: Ni'] = res.items[2973],
        ['Dokumori: San'] = res.items[2973],
        ['Tonko: Ichi'] = res.items[2972],
        ['Tonko: Ni'] = res.items[2972],
        ['Tonko: San'] = res.items[2972],
        ['Monomi: Ichi'] = res.items[2972],
        ['Aisha: Ichi'] = res.items[2973],
        ['Myoshu: Ichi'] = res.items[2972],
        ['Yurin: Ichi'] = res.items[2973],
        ['Migawari: Ichi'] = res.items[2972],
        ['Kakka: Ichi'] = res.items[2972],
        ['Gekka: Ichi'] = res.items[2972],
        ['Yain: Ichi'] = res.items[2972],
    }

-- Command related mappings.

outgoing_action_category_table = {['/ma']=3,['/ws']=7,['/ja']=9,['/ra']=16,['/ms']=25}

unify_prefix = {['/ma'] = '/ma', ['/magic']='/ma',['/jobability'] = '/ja',['/ja']='/ja',['/item']='/item',['/song']='/ma',
    ['/so']='/ma',['/ninjutsu']='/ma',['/weaponskill']='/ws',['/ws']='/ws',['/ra']='/ra',['/rangedattack']='/ra',['/nin']='/ma',
    ['/throw']='/ra',['/range']='/ra',['/shoot']='/ra',['/monsterskill']='/ms',['/ms']='/ms',['/pet']='/ja',['Monster']='Monster',['/bstpet']='/ja'}

-------------------------------------------------------------------------------------------------------------------
-- Tables to specify general area groupings.  Creates the 'areas' table to be referenced in job files.
-- Zone names provided by world.area/world.zone are currently in all-caps, so defining the same way here.
-------------------------------------------------------------------------------------------------------------------

areas = {}

-- City areas for town gear and behavior.
areas.Cities = S{
  "Ru'Lude Gardens",
  "Upper Jeuno",
  "Lower Jeuno",
  "Port Jeuno",
  "Port Windurst",
  "Windurst Waters",
  "Windurst Woods",
  "Windurst Walls",
  "Heavens Tower",
  "Port San d'Oria",
  "Northern San d'Oria",
  "Southern San d'Oria",
	"Chateau d'Oraguille",
  "Port Bastok",
  "Bastok Markets",
  "Bastok Mines",
  "Metalworks",
  "Aht Urhgan Whitegate",
	"The Colosseum",
  "Tavanazian Safehold",
  "Nashmau",
  "Selbina",
  "Mhaura",
	"Rabao",
  "Norg",
  "Kazham",
  "Eastern Adoulin",
  "Western Adoulin",
	"Celennia Memorial Library",
	"Mog Garden",
	"Leafallia"
}
-- Adoulin areas, where Ionis will grant special stat bonuses.
areas.Adoulin = S{
  "Yahse Hunting Grounds",
  "Ceizak Battlegrounds",
  "Foret de Hennetiel",
  "Morimar Basalt Fields",
  "Yorcia Weald",
  "Yorcia Weald [U]",
  "Cirdas Caverns",
  "Cirdas Caverns [U]",
  "Marjami Ravine",
  "Kamihr Drifts",
  "Sih Gates",
  "Moh Gates",
  "Dho Gates",
  "Woh Gates",
  "Rala Waterways",
  "Rala Waterways [U]",
  "Outer Ra'Kaznar",
  "Outer Ra'Kaznar [U]",
	"Ra'Kaznar Inner Court"
}
-- Assault/Salvage areas, where Aht Urghan Rings will grant special stat bonuses.
areas.Assault = S{
  "Nyzul Isle",
  "Leujaoam Sanctum",
  "Mamool Ja Training Grounds",
  "Periqia",
  "Lebros Cavern",
  "Ilrusi Atoll",
  "Zhayolm Remnants",
  "Arrapago Remnants",
  "Bhaflau Remnants",
  "Silver Sea Remnants"
}


-------------------------------------------------------------------------------------------------------------------
-- Lists of certain NPCs.
-------------------------------------------------------------------------------------------------------------------

npcs = {}
npcs.Trust = S{'ArkEV','ArkGK','ArkHM','ArkMR','ArkTT','Abenzio','Abquhbah','Adelheid','Ajido-Marujido','Aldo','Amchuchu','Apururu','Arciela','Areuhat','August','Ayame',
		'Babban','Balamor','Brygid','Chacharoon','Cherukiki','Cid','Curilla','D.Shantotto','Darrcuiln','Elivira','Excenmille','Fablinix',
		'FerreousCoffin','Flaviria','Gadalar','Gessho','Gilgamesh','Halver','I.Shield','Ingrid','Ingrid','Iroha','IronEater','Jakoh','Joachim','Karaha-Baruha',
		'Kayeel-Payeel','KingOfHearts','Klara','Koru-Moru','Kukki-Chebukki','Kupipi','Kupofried','KuyinHathdenna','LehkoHabhoka','Leonoyne','LheLhangavo',
		'LhuMhakaracca','Lilisette','Lion','Luzaf','Maat','Makki-Chebukki','Margret','Maximilian','Mayakov','MihliAliapoh','Mildaurion','Mnejing','Moogle','Morimar','Mumor','NajaSalaheem',
		'Naja','Najelith','Naji','NanaaMihgo','Nashmeira','Noillurie','Ovjang','Pieuje','Prishe','Qultada','Rahal','Rainemard','Robel-Akbel','RomaaMihgo',
		'Rongelouts','Rosulatia','Rughadjeen','Sakura',"Selh'teus",'SemihLafihna','Shantotto','ShikareeZ','StarSibyl','Sylvie','Teodor','Tenzen','Trion',
		'UkaTotlihn','Ullegore','Ulmia','Valaineral','Volker','Yoran-Oran','Zazarg','Zeid'}
