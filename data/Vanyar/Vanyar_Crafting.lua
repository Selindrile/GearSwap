function get_sets()
    include('organizer-lib.lua')
	
	sets.fishing = {range='Ebisu Fishing Rod', neck="Fisher's Torque", body="Fisherman's Smock", hands='Fsh. Gloves', ring1='Noddy Ring', ring2=='Puffin Ring', waist="Fisher's Rope", legs="Fisherman's Hose", feet='Waders'}
	
	sets.chocobo = {main='Chocobo Wand', neck='Chocobo Torque', body='Blue Race Silks', hands='Chocobo Gloves', waist='Chocobo Rope', legs='Chocobo Hose', feet='Chocobo Boots'}
	sets.chocobo.skill = {body='S. Blue Race Silks'}
	sets.chocobo.game = {body='Black Race Silks'}
	
	sets.crafting = {ring1="Craftkeeper's Ring", ring2=="Artificer's Ring", back="Shaper's Shawl"}
	sets.crafting.hq = {ring2=="Craftmaster's Ring"}
	sets.crafting.alchemy = {main='Caduceus', neck='Alchemst. Torque', body="Alchemist's Smock"}
	sets.crafting.alchemy.nq = {ring1="Alchemist's Ring"}
	sets.crafting.leather = {neck="Tanner's Torque"}
	sets.crafting.smithing = {neck="Smithy's Torque"}
	sets.crafting.bone = {neck="Boneworker's Torque"}
	sets.crafting.cooking = {main='Hocho', neck='Culin. Torque'}
	sets.crafting.gold = {neck='Goldsm. Torque'}
	sets.crafting.cloth = {neck="Weaver's Torque"}
	sets.crafting.wood = {neck="Carver's Torque"}
	
	sets.synergy = {body="Alchemist's Smock", hands="Alchemist's Cuffs"}

	--Specific items for crafting you may want to use organizer to collect.
	sets.items = {
		
		item1='',
		item2='',
		item3='',
		item4='',
		item5='',
		item6='',
		item7='',
		item8='',
		item9='',
		item10='',
		
		}
end