function BossAttackRogueMainDps(atakslot)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Scout") then
		BossAttackRogueScout(attackslot, true, true, true, true,  true, true);
		-- BossAttackWardenDruidLite(0, 0, 0, .4, 0, false, false, true, false, false, false, false, false, 2, false, true, false, atakslot);
	elseif(secondclass == "Druid") then
		BossAttackRogueDruid(attackslot, .5, false, true, true, true,  true)
	else
		SendSystemMsg("Side class undefined??");
	end
end

function BossAttackRogueScout(attackslot, usemeditation, usevampire, useshadow, uselowblow,  usewound, useshot)
local phealth = PctH("player")
local penergy = PctM("player")
local secselapsed = os.time() - g_lastcasttime
local friendly = (not UnitCanAttack("player","target"))
local pbuffs = BuffList("player");
local tbuffs = BuffList("target");
-- local tbuffs = BuffList("target");
local combatstate = GetPlayerCombatState();
	
	if (usemeditation  and (not combatstate) and (not pbuffs["Premeditation"]  or pbuffs["Premeditation"].time < 5)) then
		CastSpellByName("Premeditation");
	elseif (usevampire and not tbuffs["Vampire Arrows"]) then
		CastSpellByName("Vampire Arrows");
	elseif (useshadow and (penergy >= .20)) then
		CastSpellByName("Shadowstab");
	elseif (uselowblow and (not tbuffs["Grievous Wound"]) and (penergy >= .30)) then
		CastSpellByName("Low Blow");
	elseif (usewound and (penergy >= .35) and CD("Wound Attack")) then
		CastSpellByName("Wound Attack");
	elseif (uselowblow and (penergy >= .30)) then
		CastSpellByName("Low Blow");
	elseif (useshot) then
		CastSpellByName("Shot");
	else
		UseAction(attackslot);
	end
end

function BossAttackRogueDruid(attackslot, recoverhealth, usehysteric, useinformer, useshadow, uselowblow,  usewound)
local phealth = PctH("player")
local penergy = PctM("player")
local secselapsed = os.time() - g_lastcasttime
local friendly = (not UnitCanAttack("player","target"))
local pbuffs = BuffList("player");
local tbuffs = BuffList("target");
-- local tbuffs = BuffList("target");

	
	if (phealth <= recoverhealth) then
		CastSpellByName("Recover"); 
	elseif(usehysteric and (not pbuffs["Hysteric Vengeance"])) then
		CastSpellByName("Hysteric Vengeance"); 
	elseif (useinformer and CD("Informer")) then
		CastSpellByName("Informer");
	elseif (useshadow and (not tbuffs["Bleed"]) and (penergy >= .20)) then
		CastSpellByName("Shadowstab");
	elseif (uselowblow and (not tbuffs["Grievous Wound"]) and (penergy >= .30)) then
		CastSpellByName("Low Blow");
	elseif (usewound and (penergy >= .35) and CD("Wound Attack")) then
		CastSpellByName("Wound Attack");
	else
		UseAction(attackslot);
	end
end

function BossAttackRoguePriest(attackslot, regeneratehealth, urgentPercent, useinformer, useshadow, uselowblow,  usewound)
local phealth = PctH("player")
local penergy = PctM("player")
local secselapsed = os.time() - g_lastcasttime
local friendly = (not UnitCanAttack("player","target"))
local pbuffs = BuffList("player");
local tbuffs = BuffList("target");
-- local tbuffs = BuffList("target");

	
	if ((phealth <= regeneratehealth) and (not pbuffs["Regenerate"])) then
		CastSpellByName("Regenerate");
	elseif (phealth <= urgentPercent) then
		CastSpellByName("Urgent Heal");
	elseif (useinformer and CD("Informer")) then
		CastSpellByName("Informer");
	elseif (useshadow and (not tbuffs["Bleed"]) and (penergy >= .20)) then
		CastSpellByName("Shadowstab");
	elseif (uselowblow and (not tbuffs["Grievous Wound"]) and (penergy >= .30)) then
		CastSpellByName("Low Blow");
	elseif (usewound and (penergy >= .35) and CD("Wound Attack")) then
		CastSpellByName("Wound Attack");
	else
		UseAction(attackslot);
	end
end

function LookAroundAndAttackRogue(attackslot, turnaround, recoverpct, manapct, manaslot, manabuffname)
	local pmana = PctS("player")
	local pbuffs = BuffList("player")

	-- First check if we currently have a target
	local tgt=UnitClass("target"); 
	local friendly = (not UnitCanAttack("player","target"))
	local isdead = UnitIsDeadOrGhost("target")

	if((manaslot > 0) and (pmana < manapct) and (not pbuffs[manabuffname])) then
		UseAction(manaslot);
	elseif((nil == tgt) or friendly) then
		if(turnaround) then TurnLeftStart(); end
		TargetNearestEnemy();
	elseif ((nil ~= tgt) and isdead) then
		if(turnaround) then TurnLeftStop(); end
		UseAction(attackslot);
	else
		if(turnaround) then TurnLeftStop(); end
		BossAttackRogueDruid(attackslot, recoverpct, true, true, true, true);
	end
end

function BuffAllRogueMain(buffplus)
	local mainclass, secondclass = UnitClass("player")
	if(secondclass == "Druid") then
			BuffAllRogue(false, true, true, true, true, true, true);
	elseif (secondclass == "Scout") then
		BuffAllRogue(true, false, false, true, true, false, true);
	else
		SendSystemMsg("Side class undefined??");
	end
end

function BuffAllRogue(usecombatmaster, usesavage, usehysteric, useinformer, useassasin, usekillin, usepremeditation)
  local combatstate = GetPlayerCombatState();
	
  local pbuffs = BuffList("player")
  if ((usecombatmaster == true ) and (not pbuffs["Combat Master"] or pbuffs["Combat Master"].time < 600)) then
	CastSpellByName("Combat Master");
  elseif ((usesavage == true ) and (not pbuffs["Savage Blessing"] or pbuffs["Savage Blessing"].time < 600)) then
	CastSpellByName("Savage Blessing");
  elseif ((usehysteric == true ) and (not pbuffs["Hysteric Vengeance"] or pbuffs["Hysteric Vengeance"].time < 600)) then
	CastSpellByName("Hysteric Vengeance");
  elseif ((useinformer == true ) and CD("Informer") and (not pbuffs["Informer"])) then
	CastSpellByName("Informer");
  elseif ((useassasin == true ) and CD("Assassins Rage") and (not pbuffs["Assassins Rage"])) then
	CastSpellByName("Assassins Rage");
	  elseif ((usekillin == true ) and CD("Killin' Time") and (not pbuffs["Killin' Time"])) then
	CastSpellByName("Killin' Time");
  elseif (usemeditation and (not combatstate) and (not pbuffs["Premeditation"]  or pbuffs["Premeditation"].time < 5)) then
		CastSpellByName("Premeditation");
  end
end