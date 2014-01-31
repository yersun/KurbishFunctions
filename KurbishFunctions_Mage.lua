function BossAttackMageRogueLite(usefangritual, useshadow, useenergywell, useinflux, useelemental, useIntensification, usecatalyst, useplazma, usefireball, forcecursefang, usecursedfang, electricbolttimeout, useflame, useexplosion, warntbufflist)
local friendly = (not UnitCanAttack("player","target"))
local secselapsed = os.time() - g_lastcasttime
local pbuffs = BuffList("player")
local tbuffs = BuffList("target");
local tdebuffs 
local penergy = PctS("player")
    
	if((nil ~= warntbufflist) and UnitIsPlayer("target")) then
		if(friendly) then 
			WarnBuffs(tbuffs, warntbufflist);
		else
			WarnBuffs(ActualBuffList("target"), warntbufflist);
		end
	end
	
	if (useelemental or (electricbolttimeout>0) or usecursedfang) then
		tdebuffs = ActualDebuffList("target")
	end
	
	if(usefangritual and (not pbuffs["Fang Ritual"])) then
		CastSpellByName("Fang Ritual"); 
	elseif (useshadow and (not pbuffs["Shadow Protection"])) then
		CastSpellByName("Shadow Protection");
	elseif (useenergywell and CD("Energy Well") and (not pbuffs["Energy Well"])) then
		CastSpellByName("Energy Well");
	elseif (useinflux and CD("Energy Influx") and (not pbuffs["Energy Influx"])) then
		CastSpellByName("Energy Influx");
	elseif (useelemental and CD("Elemental Weakness") and (not tdebuffs["Elemental Weakness"])) then
		CastSpellByName("Elemental Weakness");
	elseif (useIntensification and CD("Intensification")) then 
		CastSpellByName("Intensification"); 
	elseif (usecatalyst and CD("Elemental Catalysis")) then
		CastSpellByName("Elemental Catalysis");
	elseif (usefireball and CD("Fireball")) then 
		CastSpellByName("Fireball"); 
	elseif(usecursedfang and forcecursefang and penergy >= .30)then
	    CastSpellByName("Cursed Fangs");
	elseif(usecursedfang and (not forcecursefang) and CursedFangCastableOnTarget(tdebuffs,penergy,11))then
	    CastSpellByName("Cursed Fangs");
	elseif ((electricbolttimeout > 0) and (not g_currentlyCasting) and ElectricBoltCastableOnTarget(electricbolttimeout, tdebuffs)) then
		CastSpellByName("Electric Bolt");
	elseif (useflame and (not g_currentlyCasting) and (not ((g_lastcast == "Flame") and (g_lastcasttarget == UnitGUID("target")) and (secselapsed < 1)))) then
		CastSpellByName("Flame");
	elseif (useplazma and (not g_currentlyCasting) and (not ((g_lastcast == "Plasma Arrow") and (g_lastcasttarget == UnitGUID("target"))))) then
		CastSpellByName("Plasma Arrow");
	elseif (useexplosion and (not g_currentlyCasting) and pbuffs["Static Field Charge"]) then
		CastSpellByName("Electric Explosion");
	else
		CastSpellByName("Flame");
	end
end

function BossAttackHeavy(warn)
	local tbuffs = BuffList("target");
	local pbuffs = BuffList("player");
	
	local tti, cdi = CDLeft("Intensification");
	local tte, cde = CDLeft("Elemental Catalysis");
	
	if(cdi> 1 and cde > 1) then
	
		if( not(pbuffs["Intensification"] or pbuffs["Elemental Catalysis"]) and warn) then
			SendSystemMsg("BUFFS EXPIRED, ABORT BossAttackHeavy()");
		end
		
		if(pbuffs["Static Field Charge"]) then 
			CastSpellByName("Electric Explosion");
			return
		else
			CastSpellByName("Plasma Arrow");
			return;
		end
	else
		if(cdi == 0) then CastSpellByName("Intensification"); return; end
		if(cde == 0) then CastSpellByName("Elemental Catalysis"); return; end
	end
end

function BossAttackMageDruidLite(recoverhealth, earthhealth, useFireball, usemagma, electricbolttimeout, useexplosion, useflame, usemeteor, useplazma, useperception, usemagictarget, useinflux, useenergywell, useelemental, warntbufflist, finalskill, donthealpvp)
local phealth = PctH("player")
local secselapsed = os.time() - g_lastcasttime
local friendly = (not UnitCanAttack("player","target"))
local pbuffs
local tbuffs = BuffList("target");
local tdebuffs 
local pdebuffs
local isdead = UnitIsDeadOrGhost("target");

	if (isdead) then
		SendSystemMsg("Hedef Ölü..");
		return;
	end
	
	if(usemeteor) then
		pdebuffs = ActualDebuffList("player");
	end

	if((nil ~= warntbufflist) and UnitIsPlayer("target")) then
		if(friendly) then 
			WarnBuffs(tbuffs, warntbufflist);
		else
			WarnBuffs(ActualBuffList("target"), warntbufflist);
		end
	end
  
	if (useinflux or useenergywell or useexplosion) then
		pbuffs = BuffList("player")
	end
	
	if (useelemental or (electricbolttimeout>0)) then
		tdebuffs = ActualDebuffList("target")
	end
	
	local isplayer = UnitIsPlayer("target");
	if(donthealpvp and isplayer and (not friendly)) then 
		-- blossominghealth = 0;
		earthhealth = 0;
		recoverhealth = 0;
	end
  

	if ((phealth <= earthhealth) and CD("Mother Earth's Protection")) then
		CastSpellByName("Mother Earth's Protection"); 
	elseif ((phealth <= recoverhealth) or friendly) then
		CastSpellByName("Recover");
	elseif(useperception and (not pbuffs["Perception"])) then
		CastSpellByName("Perception"); 
	elseif (usemagictarget and (not pbuffs["Magic Target"])) then
		CastSpellByName("Magic Target");
	elseif (useinflux and CD("Energy Influx") and (not pbuffs["Energy Influx"])) then
		CastSpellByName("Energy Influx");
	elseif (useenergywell and CD("Energy Well") and (not pbuffs["Energy Well"])) then
		CastSpellByName("Energy Well");
	elseif (useelemental and CD("Elemental Weakness") and (not tdebuffs["Elemental Weakness"])) then
		CastSpellByName("Elemental Weakness");
	elseif (usemagma and CD("Magma Blade")) then
		CastSpellByName("Magma Blade");
	elseif (useFireball and CD("Fireball")) then 
		CastSpellByName("Fireball"); 
	elseif ((electricbolttimeout > 0) and (not g_currentlyCasting) and ElectricBoltCastableOnTarget(electricbolttimeout, tdebuffs)) then
		CastSpellByName("Electric Bolt");
	elseif ((useexplosion) and (not g_currentlyCasting) and (pbuffs["Static Field Charge"])) then
		CastSpellByName("Electric Explosion");
	elseif (useflame and (not g_currentlyCasting) and (not ((g_lastcast == "Flame") and (g_lastcasttarget == UnitGUID("target")) and (secselapsed < 1)))) then
		CastSpellByName("Flame");
	elseif (usemeteor and (not g_currentlyCasting) and (not ((g_lastcast == "Meteor Shower") and (g_lastcasttarget == UnitGUID("target")))) and ((nil ~= pdebuffs) and (not pdebuffs["Mind Attack"]))) then
		CastSpellByName("Meteor Shower");
	elseif (useplazma and (not g_currentlyCasting) and (not ((g_lastcast == "Plasma Arrow") and (g_lastcasttarget == UnitGUID("target"))))) then
		CastSpellByName("Plasma Arrow");
	elseif ((nil ~= finalskill) and (finalskill ~= "")) then
		CastSpellByName(finalskill);
	else
		CastSpellByName("Flame");
	end
end

function BossAttackMageWardenLite(usebladefirst, usesurge, useblade, useFireball, electricbolttimeout, useexplosion, useflame, usemeteor, useplazma, usescepter, usebriar, useinflux, useenergywell, useelemental, usebriar, usemarking, warntbufflist, finalskill)
local phealth = PctH("player")
local penergy = PctS("player")
local secselapsed = os.time() - g_lastcasttime
local friendly = (not UnitCanAttack("player","target"))
local pbuffs
local tbuffs = BuffList("target");
local tdebuffs 
local pdebuffs
local isdead = UnitIsDeadOrGhost("target");

	if (isdead) then
		SendSystemMsg("Hedef Ölü..");
		return;
	end

	if(usemeteor) then
		pdebuffs = ActualDebuffList("player");
	end

	if((nil ~= warntbufflist) and UnitIsPlayer("target")) then
		if(friendly) then 
			WarnBuffs(tbuffs, warntbufflist);
		else
			WarnBuffs(ActualBuffList("target"), warntbufflist);
		end
	end
  
	if (useinflux or useenergywell or useexplosion or usescepter) then
		pbuffs = BuffList("player")
	end
	
	if (useelemental or (electricbolttimeout>0)) then
		tdebuffs = ActualDebuffList("target")
	end
	
	if(usescepter and (not pbuffs["Toprak Asası"])) then
		CastSpellByName("Toprak Asası"); 
	elseif (usebriar and CD("Dikenli Kalkan") and (not pbuffs["Dikenli Kalkan"])) then
		CastSpellByName("Dikenli Kalkan");
	elseif (useinflux and CD("Energy Influx") and (not pbuffs["Energy Influx"])) then
		CastSpellByName("Energy Influx");
	elseif (useenergywell and CD("Energy Well") and (not pbuffs["Energy Well"])) then
		CastSpellByName("Energy Well");
	elseif (useelemental and CD("Elemental Weakness") and (not tdebuffs["Elemental Weakness"])) then
		CastSpellByName("Elemental Weakness");
	elseif (usemarking and CD("Dünya İşaretlemesi")) then
		CastSpellByName("Dünya İşaretlemesi");
	elseif(usebladefirst and useblade and CD("Toprak İnleten Rüzgar Kılıcı")) then
		CastSpellByName("Toprak İnleten Rüzgar Kılıcı");
	elseif (usesurge and CD("Deprem")) then
		CastSpellByName("Deprem");
	elseif ((not usebladefirst) and useblade and CD("Toprak İnleten Rüzgar Kılıcı")) then
		CastSpellByName("Toprak İnleten Rüzgar Kılıcı");
	elseif (useFireball and CD("Fireball")) then 
		CastSpellByName("Fireball"); 
	elseif ((electricbolttimeout > 0) and (not g_currentlyCasting) and ElectricBoltCastableOnTarget(electricbolttimeout, tdebuffs)) then
		CastSpellByName("Electric Bolt");
	elseif ((useexplosion) and (not g_currentlyCasting) and (pbuffs["Static Field Charge"])) then
		CastSpellByName("Electric Explosion");
	elseif (useflame and (not g_currentlyCasting) and (not ((g_lastcast == "Flame") and (g_lastcasttarget == UnitGUID("target")) and (secselapsed < 1)))) then
		CastSpellByName("Flame");
	elseif (usemeteor and (not g_currentlyCasting) and (not ((g_lastcast == "Meteor Shower") and (g_lastcasttarget == UnitGUID("target")))) and ((nil ~= pdebuffs) and (not pdebuffs["Mind Attack"]))) then
		CastSpellByName("Meteor Shower");
	elseif (useplazma and (not g_currentlyCasting) and (not ((g_lastcast == "Plasma Arrow") and (g_lastcasttarget == UnitGUID("target"))))) then
		CastSpellByName("Plasma Arrow");
	elseif ((nil ~= finalskill) and (finalskill ~= "")) then
		CastSpellByName(finalskill);
	else
		CastSpellByName("Flame");
	end
end

function BossAttackMagePriestLite(anlikhealth, halehealth, useFireball, usemedcezir, electricbolttimeout, useexplosion, useflame, usemeteor, useplazma, usebuyuengeli, useyagmurkutsamasi, usebuyuozu, useenergywell, useinflux, useelemental, warntbufflist, finalskill, donthealpvp)
local phealth = PctH("player")
local penergy = PctS("player")
local secselapsed = os.time() - g_lastcasttime
local friendly = (not UnitCanAttack("player","target"))
local pbuffs
local tbuffs = BuffList("target");
local tdebuffs 
local pdebuffs
local isdead = UnitIsDeadOrGhost("target");
local isself = UnitIsUnit("player","target");

	if (isdead) then
		SendSystemMsg("Hedef Ölü..");
		return;
	end
	
	if(usemeteor) then
		pdebuffs = ActualDebuffList("player");
	end

	if((nil ~= warntbufflist) and UnitIsPlayer("target")) then
		if(friendly) then 
			WarnBuffs(tbuffs, warntbufflist);
		else
			WarnBuffs(ActualBuffList("target"), warntbufflist);
		end
	end
  
	if (usebuyuozu or useinflux or useenergywell or useexplosion) then
		pbuffs = BuffList("player")
	end
	
	if (useelemental or (electricbolttimeout>0)) then
		tdebuffs = ActualDebuffList("target")
	end
	
	local isplayer = UnitIsPlayer("target");
	if(donthealpvp and isplayer and (not friendly)) then 
		-- blossominghealth = 0;
		halehealth = 0;
		anlikhealth = 0;
	end
  

	if ((phealth <= halehealth) and CD("Kutsal Hale")) then
		CastSpellByName("Kutsal Hale"); 
	elseif ((phealth <= anlikhealth) or friendly) then
		CastSpellByName("Anlık Recover");
	elseif(usebuyuengeli and (not pbuffs["Büyü Engeli"])) then
		CastSpellByName("Büyü Engeli"); 
	elseif (useyagmurkutsamasi and (not pbuffs["Yağmurun Kutsaması"])) then
		CastSpellByName("Yağmurun Kutsaması");
	elseif (usebuyuozu and (not pbuffs["Büyünün Özü"])  and (isself or not friendly)) then
		CastSpellByName("Büyünün Özü");
	elseif (useenergywell and CD("Energy Well") and (not pbuffs["Energy Well"])) then
		CastSpellByName("Energy Well");
	elseif (useinflux and CD("Energy Influx") and (not pbuffs["Energy Influx"])) then
		CastSpellByName("Energy Influx");
	elseif (useelemental and CD("Elemental Weakness") and (not tdebuffs["Elemental Weakness"])) then
		CastSpellByName("Elemental Weakness");
	elseif (usemedcezir and CD("Medcezir")) then
		CastSpellByName("Medcezir");
	elseif (useFireball and CD("Fireball")) then 
		CastSpellByName("Fireball"); 
	elseif ((electricbolttimeout > 0) and (not g_currentlyCasting) and ElectricBoltCastableOnTarget(electricbolttimeout, tdebuffs)) then
		CastSpellByName("Electric Bolt");
	elseif ((useexplosion) and (not g_currentlyCasting) and (pbuffs["Static Field Charge"])) then
		CastSpellByName("Electric Explosion");
	elseif (useflame and (not g_currentlyCasting) and (not ((g_lastcast == "Flame") and (g_lastcasttarget == UnitGUID("target")) and (secselapsed < 1)))) then
		CastSpellByName("Flame");
	elseif (usemeteor and (not g_currentlyCasting) and (not ((g_lastcast == "Meteor Shower") and (g_lastcasttarget == UnitGUID("target")))) and ((nil ~= pdebuffs) and (not pdebuffs["Mind Attack"]))) then
		CastSpellByName("Meteor Shower");
	elseif (useplazma and (not g_currentlyCasting) and (not ((g_lastcast == "Plasma Arrow") and (g_lastcasttarget == UnitGUID("target"))))) then
		CastSpellByName("Plasma Arrow");
	elseif ((nil ~= finalskill) and (finalskill ~= "")) then
		CastSpellByName(finalskill);
	else
		CastSpellByName("Flame");
	end
end

function MageStun(usedischarge, usephoenix, usepurgatory, rapidpurgatory, dischargemessage)
  
  	if (usedischarge and CD("Discharge")) then
		CastSpellByName("Discharge");
		if((nil ~= dischargemessage) and (dischargemessage ~= "")) then SendChatMessage(dischargemessage, "SAY"); end
	elseif (usephoenix and CD("Phoenix")) then 
		CastSpellByName("Phoenix");
	elseif (usepurgatory and CD("Purgatory Fire")) then 
		CastSpellByName("Purgatory Fire");
	elseif (usepurgatory and rapidpurgatory) then
		CastSpellByName("Purgatory Fire");
	end

end

function BuffAllMage(useIntensification, intensificationfirst, useenergywell, useperception, usemagictarget, useenergyinflux, usefireward, usesavageblessing, usefangritual, useshadowprotection, usebriar, usescepter, usemarking, usecatalysis, usebuyuengeli, useyagmurkutsamasi, usebuyuozu)
  
  local pbuffs = BuffList("player")
  local friendly = (not UnitCanAttack("player","target"));
  
  if ((usefangritual == true ) and (not pbuffs["Fang Ritual"])) then
	CastSpellByName("Fang Ritual");
  elseif ((useshadowprotection == true ) and (not pbuffs["Shadow Protection"])) then
	CastSpellByName("Shadow Protection");
  elseif (usebriar and CD("Dikenli Kalkan") and (not pbuffs["Dikenli Kalkan"] or pbuffs["Dikenli Kalkan"].time < 600)) then
	CastSpellByName("Dikenli Kalkan");
  elseif(usescepter and (not pbuffs["Toprak Asası"] or pbuffs["Toprak Asası"].time < 600)) then
	CastSpellByName("Toprak Asası");
  elseif((usefireward == true ) and (not pbuffs["Fire Ward"] or pbuffs["Fire Ward"].time < 400)) then
    CastSpellByName("Fire Ward");
  elseif ((useIntensification == true ) and CD("Intensification") and (not pbuffs["Intensification"]) and (intensificationfirst == true)) then
	CastSpellByName("Intensification");
  elseif ((useenergywell == true ) and CD("Energy Well") and (not pbuffs["Energy Well"])) then
	CastSpellByName("Energy Well");
  elseif ((useperception == true ) and (not pbuffs["Perception"] or pbuffs["Perception"].time < 600)) then
	CastSpellByName("Perception");
  elseif((usemagictarget == true ) and (not pbuffs["Magic Target"] or pbuffs["Magic Target"].time < 600)) then
	CastSpellByName("Magic Target");
  elseif((useenergyinflux == true ) and CD("Energy Influx") and (not pbuffs["Energy Influx"])) then
    CastSpellByName("Energy Influx");
  elseif((usesavageblessing == true ) and (not pbuffs["Savage Blessing"] or pbuffs["Savage Blessing"].time < 600)) then
    if(friendly) then TargetUnit("player"); end
	CastSpellByName("Savage Blessing");
  elseif (usemarking and CD("Dünya İşaretlemesi")) then
	CastSpellByName("Dünya İşaretlemesi");
  elseif (usebuyuengeli and (not pbuffs["Büyü Engeli"] or pbuffs["Büyü Engeli"].time < 600)) then
	CastSpellByName("Büyü Engeli");
  elseif (useyagmurkutsamasi and (not pbuffs["Yağmurun Kutsaması"] or pbuffs["Yağmurun Kutsaması"].time < 600)) then
	CastSpellByName("Yağmurun Kutsaması");
  elseif (usebuyuozu and (not pbuffs["Büyünün Özü"] or pbuffs["Büyünün Özü"].time < 600)) then
	if(friendly) then TargetUnit("player"); end
	CastSpellByName("Büyünün Özü");
  elseif((useIntensification == true ) and CD("Intensification") and (not intensificationfirst)) then
    CastSpellByName("Intensification");
  elseif (usecatalysis and CD("Elemental Catalysis")) then
	CastSpellByName("Elemental Catalysis");
  elseif(CD("Fire Ward")) then
		SendSystemMsg("Bufflar Tamam!");
  end
end

function ChargeUp(chargeonly)  
  local enemy = UnitCanAttack("player", "target")
  local pBuffs = BuffList("player")
  local tBuffs= BuffList("target")
  
  local plasmaelapsed = os.time() - g_lastPlasmaArrow.LastCast

  if((not chargeonly) and (pBuffs["Static Field Charge"])) then
	CastSpellByName("Static Field");
	PlaySoundByPath("interface/AddOns/KurbishFunctions/sounds/WindowsError.wav");
  elseif((pBuffs["Static Field Charge"]) and (not pBuffs["Static Field Charge"])) then
	CastSpellByName("Electric Compression");
  elseif(chargeonly and (pBuffs["Static Field Charge"])) then
    CastSpellByName("Plasma Arrow")
  elseif((not tBuffs["Static Field"]) and (plasmaelapsed > 1)) then
	CastSpellByName("Plasma Arrow")
  end
	  
  if((chargeonly) and (pBuffs["Static Field Charge"])) then PlaySoundByPath("interface/AddOns/KurbishFunctions/sounds/WindowsError.wav"); end
end

function BreakSkill(usehumanrules, uselightning, usesilence, usesilencefirst, warntbufflist, castifwarning, lightningmessage)
	
	local isplayer = UnitIsPlayer("target");
	local targetclass = UnitClass("target");
	if(usehumanrules and isplayer) then
		if((targetclass == "Mage") or (targetclass == "Priest")) then 
			usesilence = true;
			usesilencefirst = true;
		else
			usesilencefirst = false;
			local tSpell,tMax,tElapsed = UnitCastingTime("target")
			usesilence = tSpell and ((tMax - tElapsed) >= 0.2)
		end
	end
	
	local castable = true;
	
	if((nil ~= warntbufflist) and UnitIsPlayer("target")) then
		castable = (not WarnBuffs(ActualBuffList("target"), warntbufflist));
	end
	
	-- Switch castable if there is a warning and (castifwarning == true)
	if((nil ~= castifwarning) and castifwarning and (not castable)) then castable =true; end;
	
	if (usesilence and castable and usesilencefirst and CD("Silence")) then
		CastSpellByName("Silence");
    elseif (uselightning and castable and CD("Lightning")) then
		CastSpellByName("Lightning"); 
		if((nil ~= lightningmessage) and (lightningmessage ~= "")) then SendChatMessage(lightningmessage, "SAY"); end
	elseif (usesilence and castable and CD("Silence")) then 
		CastSpellByName("Silence");
	elseif (usehumanrules and castable and CD("Flame")) then
		CastSpellByName("Flame");
	end
	
end

function CastDemoralized(dontcasttdebuff)

	local castable = true;
	local tt, tr = GetSkillCooldown(4,14);
	local isplayer = UnitIsPlayer("target");
	
	if (not isplayer) then
		castable = false;
	elseif(nil ~= warntbufflist) then
		castable = (not WarnBuffs(ActualBuffList("target"), dontcasttdebuff));
	end

	if (castable and (tr==0)) then
		CastSpellByName("Demoralize");
	elseif (not isplayer) then
		SendSystemMsg("Unit is not a player!");
	elseif (tr > 0) then
		SendSystemMsg("Demoralize COOLED DOWN Left = "..tr);
	end
end

function ElectricBoltCastableOnTarget(electricbolttimeout, tbuffs)
  -- This function may fail to return proper value if the player moves while casting ElectricBolt and the target has Electric Flow Debuff cast by another player.
  -- First check if target does nrot have electric flow debuff

  local secselapsed = 0
  local castresult = true;
  local targetguid = UnitGUID("target");
  if(electricbolttimeout == 0) then
	castresult = false
  elseif (g_lastElectricBolt ~= nil) then
	secselapsed = os.time() - g_lastElectricBolt.LastCast
	-- PrintDebugMessage("Seconds elapsed since Electric Bolt: " .. secselapsed )

	-- if((not tbuffs["Electric Flow"]) and (secselapsed > 1)) then
	if((not tbuffs["Electric Current"]) and (secselapsed > 1)) then
		castresult = true;
	elseif((g_lastElectricBolt ~= nil)  and (g_lastElectricBolt.TargetGUID ~= nil) and (g_lastElectricBolt.TargetGUID == targetguid) and (secselapsed < electricbolttimeout)) then
		castresult = false;
	end
  end
  return castresult;
end

-- function CursedFangCastableOnTarget(tbuffs, fangtimeout)
--   -- This function may fail to return proper value if the player moves while casting ElectricBolt and the target has Electric Flow Debuff cast by another player.
--   -- First check if target does not have electric flow debuff
--   
--   local secselapsed = 0
--   local castresult = true;
--   local targetguid = UnitGUID("target");
-- 
--   if (g_lastCursedFangs ~= nil) then
-- 	secselapsed = os.time() - g_lastCursedFangs.LastCast
-- 	-- PrintDebugMessage("Seconds elapsed since Electric Bolt: " .. secselapsed )
-- 
-- 	if((not tbuffs["Cursed Fangs"]) and (secselapsed > 1)) then
-- 		castresult = true;
-- 	elseif((not tbuffs["Cursed Fangs"]) and (secselapsed <= 1)) then
-- 		castresult = false;
-- 	elseif((g_lastCursedFangs.TargetGUID == targetguid) and (secselapsed < fangtimeout)) then
-- 		castresult = false;
-- 	end
--   end
--   return castresult;
-- end

function CursedFangCastableOnTarget(tbuffs,penergy,fangtimeout)
  -- This function may fail to return proper value if the player moves while casting ElectricBolt and the target has Electric Flow Debuff cast by another player.
  -- First check if target does not have electric flow debuff
  
  local secselapsed = 0
  local castresult = false;
  local targetguid = UnitGUID("target");

  if (g_lastCursedFangs ~= nil) then
	secselapsed = os.time() - g_lastCursedFangs.LastCast
	-- PrintDebugMessage("Seconds elapsed since Electric Bolt: " .. secselapsed )

	if((not tbuffs["Cursed Fangs"]) and (penergy >= 0.3) and secselapsed > fangtimeout) then
		castresult = true;
	elseif((g_lastCursedFangs.TargetGUID == targetguid)) then
		castresult = false;
	end
  end
  return castresult;
end

function BossAttackMageMain(useelemental)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Warden") then
		BossAttackMageWardenLite(false,true, true, true, 11, false, true, false, true, true, true, true, false, useelemental, true, true, g_bossAttackMageMainWarnBuffs, "Plasma Arrow");
	elseif(secondclass == "Druid") then
		BossAttackMageDruidLite(.5,.6,true,true,11,false,true,false,true,true,true, true, false, useelemental, g_bossAttackMageMainWarnBuffs, "Plasma Arrow", true);
	elseif(secondclass == "Priest") then
		BossAttackMagePriestLite(.5, .4, true, true, 11, false, true, false, true, true, true, true, true, true, useelemental, g_bossAttackMageMainWarnBuffs, "Plasma Arrow", true)
	elseif(secondclass == "Rogue") then
		BossAttackMageRogueLite(true, true, true, true, useelemental, true, true, false, true, false, true, 11, true, false, g_bossAttackMageMainWarnBuffs)
	end
end

function BossAttackMageMainDps()
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Warden") then
		BossAttackMageWardenLite(true,true, true, true, 11, false, false, true, true, true, true, false, false, false, false, false, g_bossAttackMageMainWarnBuffs, nil);
	elseif(secondclass == "Druid") then
		BossAttackMageDruidLite(.5,.6,true,true,11,false,false,true,true,false,false,false,false,false,g_bossAttackMageMainWarnBuffs,"Plasma Arrow",true);
	elseif(secondclass == "Priest") then
		BossAttackMagePriestLite(.5, .4, true, true, 11, false, false, true, true, false, false, false, false, false, false, g_bossAttackMageMainWarnBuffs, "Plasma Arrow", true)
	elseif(secondclass == "Rogue") then	
		BossAttackMageRogueLite(false, false, false, false, false, false, false, false, true, true, true, 11, true, false, g_bossAttackMageMainWarnBuffs)
	end
end

function ProtectSelfMageMain(phirusslot, phiruspct, recoverpct, gloveslot,holyauropercent,regeneratepct)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Warden") then
		ProtectSelfMageWarden(phirusslot,phiruspct,true, g_useGloveDebuffList,gloveslot);
	elseif (secondclass == "Rogue") then
		ProtectSelfMageWarden(phirusslot,phiruspct,true, g_useGloveDebuffList,gloveslot);
	elseif(secondclass == "Druid") then
		ProtectSelf(false,recoverpct,1.5,0,0,phirusslot,phiruspct,g_useGloveDebuffList,gloveslot);
	elseif(secondclass == "Priest") then
		ProtectSelfPriest(holyauropercent, 0, regeneratepct, recoverpct, 0, 0, phirusslot, phiruspct, g_useGloveDebuffList, gloveslot, true);
	end
end

function BreakSkillMageMain()
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Warden") then
		BreakSkill(true,true,true,false,g_mageBreakSkillAvoidBuffs,false,'');
	elseif(secondclass == "Druid") then
		BreakSkill(true,true,true,false,g_mageBreakSkillAvoidBuffs,false,'');
	elseif(secondclass == "Priest") then
		BreakSkill(true,true,true,false,g_mageBreakSkillAvoidBuffs,false,'');
	elseif(secondclass == "Mage") then
		BreakSkill(true,true,true,false,g_mageBreakSkillAvoidBuffs,false,'');
	elseif(secondclass == "Rogue") then
		BreakSkill(true, true, true, false, g_mageBreakSkillAvoidBuffs, false, '')
	end
end

function BuffAllMageMain(buffplus)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Warden") then
		BuffAllMage(buffplus, false, true, false, false, true, true, false, false, false, true, true, false,buffplus, false, false, false);
	elseif(secondclass == "Druid") then
		BuffAllMage(buffplus,false,true,true,true,true,true,true,false,false,false,false,false,buffplus,false,false,false);
	elseif(secondclass == "Priest") then
		BuffAllMage(buffplus,false,true,false,false,true,true,false,false,false,false,false,false,buffplus,true,true,true);
	elseif(secondclass == "Rogue") then
		BuffAllMage(buffplus,false,true,false,false,true,true,false,true, true, false, false,false, buffplus, false, false, false);
	end
end
