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

function BuffAllRogueDruid(usehysteric, useinformer, useassasin, usekillin)
  
  local pbuffs = BuffList("player")
  if ((usehysteric == true ) and (not pbuffs["Hysteric Vengeance"])) then
	CastSpellByName("Hysteric Vengeance");
  elseif ((useinformer == true ) and CD("Informer") and (not pbuffs["Informer"])) then
	CastSpellByName("Informer");
  elseif ((useassasin == true ) and CD("Assassins Rage") and (not pbuffs["Assassins Rage"])) then
	CastSpellByName("Assassins Rage");
	  elseif ((usekillin == true ) and CD("Killin' Time") and (not pbuffs["Killin' Time"])) then
	CastSpellByName("Killin' Time");
  end
end