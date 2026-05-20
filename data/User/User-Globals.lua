--Place for your settings and custom functions that are meant to affect all of your jobs and characters.
latency = .25
--If this is set to true it will prevent you from casting shadows when you have more up than that spell would generate.
conserveshadows = false
--Display related settings.
include('CastStill.lua')
--Options for automation.
state.ReEquip 		  		= M(true, 'ReEquip Mode')		 --Set this to false if you don't want to equip your current Weapon set when you aren't wearing any weapons.
state.AutoArts 		  		= M(true, 'AutoArts') 		 --Set this to false if you don't want to automatically try to keep up Solace/Arts.
state.AutoLockstyle	 	    = M(true, 'AutoLockstyle Mode') --Set this to false if you don't want gearswap to automatically lockstyle on load and weapon change.
state.CancelStoneskin 		= M(true, 'Cancel Stone Skin') --Set this to false if you don't want to automatically cancel stoneskin when you're slept.
state.SkipProcWeapons 		= M(true, 'Skip Proc Weapons') --Set this to false if you want to display weapon sets fulltime rather than just Aby/Voidwatch.
state.NotifyBuffs	  		= M(false, 'Notify Buffs') 	 --Set this to true if you want to notify your party when you recieve a specific buff/debuff. (List Below)
 
--[[Binds you may want to change.
	Bind special characters.
	@ = Windows Key
	% = Works only when text bar not up.
	$ = Works only when text bar is up.
	^ = Control Key
	! = Alt Key
	~ = Shift Key
	# = Apps Key
]]
send_command('bind !f1 gs c toggle AutoWSMode') --Turns auto-ws mode on and off.
send_command('bind !^f1 gs c toggle AutoFoodMode') --Turns auto-ws mode on and off.
send_command('bind !q gs c cycle Weapons') --Cycle th2rough weapons sets.
send_command('bind ^q gs c cycleback Weapons') --Cycle through weapons sets.
send_command('bind @f8 gs c toggle AutoNukeMode') --Turns auto-nuke mode on and off.
send_command('bind ^f8 gs c toggle AutoStunMode') --Turns auto-stun mode off and on.
send_command('bind !f8 gs c toggle AutoDefenseMode') --Turns auto-defense mode off and on.
send_command('bind ^@!f8 gs c toggle AutoTrustMode') --Summons trusts automatically.
send_command('bind @pause gs c cycle AutoBuffMode') --Automatically keeps certain buffs up, job-dependant.
send_command('bind @scrolllock gs c cycle Passive') --Changes offense settings such as accuracy.
send_command('bind f9 gs c cycle OffenseMode') --Changes offense settings such as accuracy.
send_command('bind ^f9 gs c cycle HybridMode') --Changes defense settings for melee such as PDT.
send_command('bind @f9 gs c cycle RangedMode') --Changes ranged offense settings such as accuracy.
send_command('bind !f9 gs c cycle WeaponskillMode') --Changes weaponskill offense settings such as accuracy.
send_command('bind f10 gs c set DefenseMode Physical') --Turns your physical defense set on.
send_command('bind ^f10 gs c cycle PhysicalDefenseMode') --Changes your physical defense set.
send_command('bind !f10 gs c toggle Kiting') --Keeps your kiting gear on..
send_command('bind f11 gs c set DefenseMode Magical') --Turns your magical defense set on.
send_command('bind ^f11 gs c cycle MagicalDefenseMode') --Changes your magical defense set.
send_command('bind @f11 gs c cycle CastingMode') --Changes your castingmode options such as magic accuracy.
send_command('bind !f11 gs c cycle ExtraMeleeMode') --Adds another set layered on top of your engaged set.
send_command('bind ^f12 gs c cycle ResistDefenseMode') --Changes your resist defense set.
send_command('bind f12 gs c set DefenseMode Resist') --Turns your resist defense set on.
send_command('bind @f12 gs c cycle IdleMode') --Changes your idle mode options such as refresh.
send_command('bind !f12 gs c reset DefenseMode') --Turns your defensive mode off.
send_command('bind ^@!f12 gs reload') --Reloads gearswap.
send_command('bind pause gs c update user') --Runs a quick check to make sure you have the right gear on and checks variables.
send_command('bind ^@!pause gs org') --Runs organizer.
send_command('bind ^@!backspace gs c buffup') --Buffup macro because buffs are love.
send_command('bind ^` gs c cycle TreasureMode')
NotifyBuffs = S{'doom','petrification'}

send_command('bind !backspace input //mr')
	
	if player.sub_job == 'WAR' then
        send_command('bind !numpad/ input /ja "Berserk" <me>')
        send_command('bind !numpad* input /ja "Warcry" <me>')
        send_command('bind !numpad- input /ja "Aggressor" <me>')
	elseif player.sub_job == 'SAM' then
        send_command('bind !numpad/ input /ja "Meditate" <me>')
        send_command('bind !numpad* input /ja "Sekkanoki" <me>')
        send_command('bind !numpad- input /ja "Third Eye" <me>')
		send_command('bind !numpad+ input /ja "Hasso" <me>')
	elseif player.sub_job == 'THF' then
        send_command('bind !numpad/ input /ja "Sneak Attack" <me>')
        send_command('bind !numpad* input /ja "Trick Attack" <me>')
        send_command('bind !numpad- input /ja "Third Eye" <me>')
	elseif player.sub_job == 'DNC' then
        send_command('bind !numpad/ input /ja "Haste Samba" <me>')
        send_command('bind !numpad* input /ja "Box Step" <t>')
        send_command('bind !numpad- input /ja "Quick Step" <t>')
	elseif player.sub_job == 'NIN' then
        send_command('bind !numpad/ input /ma "Utsusemi: Ni" <me>')
        send_command('bind !numpad* input /ma "Utsusemi: Ichi" <me>')
        send_command('bind !numpad- input /ja "Quick Step" <me>')
	elseif player.sub_job == 'DRG' then
        send_command('bind !numpad/ input /ja "Jump" <t>')
        send_command('bind !numpad* input /ja "High Jump" <t>')
        send_command('bind !numpad- input /ja "Super Jump" <t>')
	elseif player.sub_job == 'RUN' then
        send_command('bind !numpad/ input /ja "Pflug" <me>')
        send_command('bind !numpad* input /ja "Vallation" <me>')
        send_command('bind !numpad- input /ja "Valiance" <me>')
	elseif player.sub_job == 'SCH' then
        send_command('bind !numpad/ input /ja Accession <me>')
        send_command('bind !numpad* input /ja "Manifestation" <me>')
        send_command('bind !numpad- input /ja "Sublimation" <me>')
		send_command('bind !numpad+ input /ja "Light Arts" <me>')
		send_command('bind !numpadenter input /ja "Dark Arts" <me>')
	elseif player.sub_job == 'WHM' then
		send_command('bind !numpad/ input /ja "Divine seal" <me>')
        --send_command('bind !numpad* input /ja "Manifestation" <me>')
        --send_command('bind !numpad- input /ja "Sublimation" <me>')
		--send_command('bind !numpad+ input /ja "Light Arts" <me>')
		--send_command('bind !numpadenter input /ja "Dark Arts" <me>')
		

    end