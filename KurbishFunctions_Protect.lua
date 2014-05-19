function ProtectSelf(usedistract, earthProtectionPercent, recoverPercent, crystalCandySlot, crystalCandyPercent, phirusSlot, phirusPercent, glovedebuflist, gloveslot)
  local pbuffs = BuffList("player")
  local pdebuffs = ActualDebuffList("player")
  local phealth = PctH("player")
  local useCandy = false
  local usePhirus = false
  local useGlove = false
  local isMage = (((UnitClass("target") == "Mage") or (UnitClass("target") == "Priest")) and (not (UnitName("target") == UnitName("player"))))
  local unitIsPlayer = UnitIsPlayer("target")
  local tdead = UnitIsDeadOrGhost("target")
  local friendly = (not UnitCanAttack("player","target"))
  local isself = UnitName("target") == UnitName("player");
  local itemgloveslot = gloveslot + 10;
  
  if ( (crystalCandySlot > 0) and isMage) then
	crystalCandySlot = crystalCandySlot + 1;
  end
  
  if( crystalCandySlot > 0 ) then
	useCandy = true;
  end
  
  if( phirusSlot > 0 ) then
	usePhirus = true;
  end
  
  if( (glovedebuflist ~= nil) and (gloveslot > 0)) then
	useGlove = HasBuffsFromList(pdebuffs, glovedebuflist)
  end
  
  local cc, cccd = GetActionCooldown(crystalCandySlot);
  local ph, phcd = GetActionCooldown(phirusSlot);
  local gl, glcd = GetActionCooldown(gloveslot);
  
  local combatstate = GetPlayerCombatState();
  
  if ((usedistract == true) and (not unitIsPlayer) and (not friendly) and (tdead == false)) then
	CastSpellByName("Distract");
  elseif((useCandy == true) and combatstate and (phealth <= crystalCandyPercent) and GetPotUsable(crystalCandySlot) and (cccd == 0)) then
    UseAction(crystalCandySlot);
  elseif ((not pbuffs["Electrostatic Charge"]) and CD("Electrostatic Charge")) then
    CastSpellByName("Electrostatic Charge");
  elseif((usePhirus == true) and (phealth <= phirusPercent) and GetPotUsable(phirusSlot) and (phcd == 0)) then
    UseAction(phirusSlot);
  elseif ((useGlove == true) and GetActionUsable(gloveslot) and (glcd == 0)) then
	UseAction(gloveslot);
  elseif ((phealth <= earthProtectionPercent) and CD("Mother Earth's Protection") and combatstate and (not pbuffs["Crystal Candy"])) then
	CastSpellByName("Mother Earth's Protection");
  elseif (phealth <= recoverPercent) then
    if (friendly and (not isself)) then TargetUnit("player") end;
	CastSpellByName("Recover");
  elseif (gloveslot > 0) then
	UseAction(itemgloveslot);
	PlaySoundByPath("interface/AddOns/KurbishFunctions/sounds/WindowsError.wav")
  end
  
end

function ProtectSelfMageWarden(cpslot, cptct, useelvenamulet, glovedebuflist, gloveslot)
	local pctHealth = PctH("player")
	local pmana = UnitMana("player");
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local useGlove = false;
	local itemgloveslot = gloveslot + 10;
	local gl, glcd = GetActionCooldown(gloveslot);
	
	 if( (glovedebuflist ~= nil) and (gloveslot > 0)) then
		itemgloveslot = gloveslot + 10;
		useGlove = HasBuffsFromList(pdebuffs, glovedebuflist)
	end
  
	if ((not pbuffs["Electrostatic Charge"]) and CD("Electrostatic Charge")) then
		CastSpellByName("Electrostatic Charge");
		PrintSkill("Electrostatic Charge");
	elseif (nil ~= cpslot and cpslot > 0 and pctHealth < cptct and GetPotUsable(cpslot)) then
		UseAction(cpslot);
		PrintSkill("Used Health Pot!");
	elseif(useelvenamulet and CD("Elven Amulet") and pmana >= 150) then
		CastSpellByName("Elven Amulet");
		PrintSkill("Elven Amulet");
	elseif ((useGlove == true) and GetActionUsable(gloveslot) and (glcd == 0)) then
		UseAction(gloveslot);
	else
		PrintSkill("No Skill Left for Protection..");
	end
end

function ProtectSelfWarriorMage(cpslot, cptct, usetehlike, useicgudu, savunmaduzenipct, glovedebuflist, gloveslot)
	local pctHealth = PctH("player")
	local pmana = UnitSkill("player");
	local pbuffs = BuffList("player");
	local prage = PctM("player");
	local useGlove = false;
	local itemgloveslot = gloveslot + 10;
	local gl, glcd = GetActionCooldown(gloveslot);
	
	 if( (glovedebuflist ~= nil) and (gloveslot > 0)) then
		itemgloveslot = gloveslot + 10;
		useGlove = HasBuffsFromList(pdebuffs, glovedebuflist)
	end
	
	if (usetehlike and pctHealth < .3 and CD("Tehlike Hissi")) then
		CastSpellByName("Tehlike Hissi");
		PrintSkill("Tehlike Hissi");
	elseif (useicgudu and pctHealth < .5 and CD("Hayatta Kalma İç Güdüsü")) then
		CastSpellByName("Hayatta Kalma İç Güdüsü");
		PrintSkill("Hayatta Kalma İç Güdüsü");
	elseif (nil ~= cpslot and cpslot > 0 and pctHealth < cptct and GetPotUsable(cpslot)) then
		UseAction(cpslot);
		PrintSkill("Used Health Pot!");
	elseif(pctHealth <= savunmaduzenipct and CD("Defensive Formation") and prage >= .25) then
		CastSpellByName("Defensive Formation");
		PrintSkill("Defensive Formation");
	elseif ((useGlove == true) and GetActionUsable(gloveslot) and (glcd == 0)) then
		UseAction(gloveslot);
	else
		PrintSkill("Koruma için başka skill atılamıyor..");
	end
end

function WarnBuffs(tbuffs, tbufflist)
	local haswarning = false
	if(nil ~= tbufflist) then
		local cnt = 1
		local buff = tbufflist[cnt]

		while buff ~= nil do
			PrintDebugMessage(buff);
			if(tbuffs[buff]) then 
				SendSystemMsg("BUFF = "..buff);
				haswarning = true
				break;
			end
			cnt = cnt + 1
			buff = tbufflist[cnt]
		end
	end
	return haswarning
end