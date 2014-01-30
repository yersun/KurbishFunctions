function FullAttack(usefangritual, useshadow, useenergywell, useinflux, useelemental, useIntensification, usecatalyst, useplazma, electricbolttimeout, useflame, useexplosion)
local friendly = (not UnitCanAttack("player","target"))
local pbuffs = BuffList("player")
local tbuffs = BuffList("target");
local tdebuffs 

	if (useelemental or (electricbolttimeout>0)) then
		tdebuffs = ActualDebuffList("target")
	end
	
	if(usefangritual and (not pbuffs["Diş Ayini"])) then
		CastSpellByName("Diş Ayini"); 
	elseif (useshadow and (not pbuffs["Shadow Protection"])) then
		CastSpellByName("Shadow Protection");
	elseif (useenergywell and CD("Enerji Pınarı") and (not pbuffs["Enerji Pınarı"])) then
		CastSpellByName("Enerji Pınarı");
	elseif (useinflux and CD("Enerji Akısı") and (not pbuffs["Enerji Akısı"])) then
		CastSpellByName("Enerji Akısı");
	elseif (useelemental and CD("Element Zafiyeti") and (not tdebuffs["E	lemental Weakness"])) then
		CastSpellByName("Element Zafiyeti");
	elseif (useIntensification and CD("Yoğunlaştırma")) then 
		CastSpellByName("Yoğunlaştırma"); 
	elseif (usecatalyst and CD("Element Katalizi")) then
		CastSpellByName("Element Katalizi");
	elseif (useplazma and (not ((g_lastcast == "Plazma Oku") and (g_lastcasttarget == UnitGUID("target")))) and (not pbuffs["Yüklü"])) then
		CastSpellByName("Plazma Oku");
	elseif ((electricbolttimeout > 0) and (not g_currentlyCasting) and ElectricBoltCastableOnTarget(electricbolttimeout, tdebuffs)) then
		CastSpellByName("Elektrik Topu");
	elseif (useflame) then
		CastSpellByName("Alev");
	elseif (useexplosion and (not g_currentlyCasting) and pbuffs["Yüklü"]) then
		CastSpellByName("Elektrik Patlaması");
	else
		CastSpellByName("Alev");
	end
end

function BossAttackHeavy(warn)
	local tbuffs = BuffList("target");
	local pbuffs = BuffList("player");
	
	local tti, cdi = CDLeft("Yoğunlaştırma");
	local tte, cde = CDLeft("Element Katalizi");
	
	if(cdi> 1 and cde > 1) then
	
		if( not(pbuffs["Yoğunlaştırma"] or pbuffs["Element Katalizi"]) and warn) then
			SendSystemMsg("BUFFS EXPIRED, ABORT BossAttackHeavy()");
		end
		
		if(pbuffs["Yüklü"]) then 
			CastSpellByName("Elektrik Patlaması");
			return
		else
			CastSpellByName("Plazma Oku");
			return;
		end
	else
		if(cdi == 0) then CastSpellByName("Yoğunlaştırma"); return; end
		if(cde == 0) then CastSpellByName("Element Katalizi"); return; end
	end
end

function BossAttackMageDruidLite(recoverhealth, earthhealth, useFireball, usemagma, electricbolttimeout, useexplosion, useflame, usemeteor, useplazma, useperception, usemagictarget, useinflux, useenergywell, useelemental, warntbufflist, finalskill, donthealpvp)
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
  

	if ((phealth <= earthhealth) and CD("Toprak Ananın Koruması")) then
		CastSpellByName("Toprak Ananın Koruması"); 
	elseif ((phealth <= recoverhealth) or friendly) then
		CastSpellByName("İyileştirme");
	elseif(useperception and (not pbuffs["Algı"])) then
		CastSpellByName("Algı"); 
	elseif (usemagictarget and (not pbuffs["Büyü Hedefi"])) then
		CastSpellByName("Büyü Hedefi");
	elseif (useinflux and CD("Enerji Akısı") and (not pbuffs["Enerji Akısı"])) then
		CastSpellByName("Enerji Akısı");
	elseif (useenergywell and CD("Enerji Pınarı") and (not pbuffs["Enerji Pınarı"])) then
		CastSpellByName("Enerji Pınarı");
	elseif (useelemental and CD("Element Zafiyeti") and (not tdebuffs["Element Zafiyeti"])) then
		CastSpellByName("Element Zafiyeti");
	elseif (usemagma and CD("Mağma Kılıcı")) then
		CastSpellByName("Mağma Kılıcı");
	elseif (useFireball and CD("Ateş Topu")) then 
		CastSpellByName("Ateş Topu"); 
	elseif ((electricbolttimeout > 0) and (not g_currentlyCasting) and ElectricBoltCastableOnTarget(electricbolttimeout, tdebuffs)) then
		CastSpellByName("Elektrik Topu");
	elseif ((useexplosion) and (not g_currentlyCasting) and (pbuffs["Yüklü"])) then
		CastSpellByName("Elektrik Patlaması");
	elseif (useflame and (not g_currentlyCasting) and (not ((g_lastcast == "Alev") and (g_lastcasttarget == UnitGUID("target")) and (secselapsed < 1)))) then
		CastSpellByName("Alev");
	elseif (usemeteor and (not g_currentlyCasting) and (not ((g_lastcast == "Meteor Yağmuru") and (g_lastcasttarget == UnitGUID("target")))) and ((nil ~= pdebuffs) and (not pdebuffs["Cesur Saldırı"]))) then
		CastSpellByName("Meteor Yağmuru");
	elseif (useplazma and (not g_currentlyCasting) and (not ((g_lastcast == "Plazma Oku") and (g_lastcasttarget == UnitGUID("target"))))) then
		CastSpellByName("Plazma Oku");
	elseif ((nil ~= finalskill) and (finalskill ~= "")) then
		CastSpellByName(finalskill);
	else
		CastSpellByName("Alev");
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
	elseif (useinflux and CD("Enerji Akısı") and (not pbuffs["Enerji Akısı"])) then
		CastSpellByName("Enerji Akısı");
	elseif (useenergywell and CD("Enerji Pınarı") and (not pbuffs["Enerji Pınarı"])) then
		CastSpellByName("Enerji Pınarı");
	elseif (useelemental and CD("Element Zafiyeti") and (not tdebuffs["Element Zafiyeti"])) then
		CastSpellByName("Element Zafiyeti");
	elseif (usemarking and CD("Dünya İşaretlemesi")) then
		CastSpellByName("Dünya İşaretlemesi");
	elseif(usebladefirst and useblade and CD("Toprak İnleten Rüzgar Kılıcı")) then
		CastSpellByName("Toprak İnleten Rüzgar Kılıcı");
	elseif (usesurge and CD("Deprem")) then
		CastSpellByName("Deprem");
	elseif ((not usebladefirst) and useblade and CD("Toprak İnleten Rüzgar Kılıcı")) then
		CastSpellByName("Toprak İnleten Rüzgar Kılıcı");
	elseif (useFireball and CD("Ateş Topu")) then 
		CastSpellByName("Ateş Topu"); 
	elseif ((electricbolttimeout > 0) and (not g_currentlyCasting) and ElectricBoltCastableOnTarget(electricbolttimeout, tdebuffs)) then
		CastSpellByName("Elektrik Topu");
	elseif ((useexplosion) and (not g_currentlyCasting) and (pbuffs["Yüklü"])) then
		CastSpellByName("Elektrik Patlaması");
	elseif (useflame and (not g_currentlyCasting) and (not ((g_lastcast == "Alev") and (g_lastcasttarget == UnitGUID("target")) and (secselapsed < 1)))) then
		CastSpellByName("Alev");
	elseif (usemeteor and (not g_currentlyCasting) and (not ((g_lastcast == "Meteor Yağmuru") and (g_lastcasttarget == UnitGUID("target")))) and ((nil ~= pdebuffs) and (not pdebuffs["Cesur Saldırı"]))) then
		CastSpellByName("Meteor Yağmuru");
	elseif (useplazma and (not g_currentlyCasting) and (not ((g_lastcast == "Plazma Oku") and (g_lastcasttarget == UnitGUID("target"))))) then
		CastSpellByName("Plazma Oku");
	elseif ((nil ~= finalskill) and (finalskill ~= "")) then
		CastSpellByName(finalskill);
	else
		CastSpellByName("Alev");
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
		CastSpellByName("Anlık İyileştirme");
	elseif(usebuyuengeli and (not pbuffs["Büyü Engeli"])) then
		CastSpellByName("Büyü Engeli"); 
	elseif (useyagmurkutsamasi and (not pbuffs["Yağmurun Kutsaması"])) then
		CastSpellByName("Yağmurun Kutsaması");
	elseif (usebuyuozu and (not pbuffs["Büyünün Özü"])  and (isself or not friendly)) then
		CastSpellByName("Büyünün Özü");
	elseif (useenergywell and CD("Enerji Pınarı") and (not pbuffs["Enerji Pınarı"])) then
		CastSpellByName("Enerji Pınarı");
	elseif (useinflux and CD("Enerji Akısı") and (not pbuffs["Enerji Akısı"])) then
		CastSpellByName("Enerji Akısı");
	elseif (useelemental and CD("Element Zafiyeti") and (not tdebuffs["Element Zafiyeti"])) then
		CastSpellByName("Element Zafiyeti");
	elseif (usemedcezir and CD("Medcezir")) then
		CastSpellByName("Medcezir");
	elseif (useFireball and CD("Ateş Topu")) then 
		CastSpellByName("Ateş Topu"); 
	elseif ((electricbolttimeout > 0) and (not g_currentlyCasting) and ElectricBoltCastableOnTarget(electricbolttimeout, tdebuffs)) then
		CastSpellByName("Elektrik Topu");
	elseif ((useexplosion) and (not g_currentlyCasting) and (pbuffs["Yüklü"])) then
		CastSpellByName("Elektrik Patlaması");
	elseif (useflame and (not g_currentlyCasting) and (not ((g_lastcast == "Alev") and (g_lastcasttarget == UnitGUID("target")) and (secselapsed < 1)))) then
		CastSpellByName("Alev");
	elseif (usemeteor and (not g_currentlyCasting) and (not ((g_lastcast == "Meteor Yağmuru") and (g_lastcasttarget == UnitGUID("target")))) and ((nil ~= pdebuffs) and (not pdebuffs["Cesur Saldırı"]))) then
		CastSpellByName("Meteor Yağmuru");
	elseif (useplazma and (not g_currentlyCasting) and (not ((g_lastcast == "Plazma Oku") and (g_lastcasttarget == UnitGUID("target"))))) then
		CastSpellByName("Plazma Oku");
	elseif ((nil ~= finalskill) and (finalskill ~= "")) then
		CastSpellByName(finalskill);
	else
		CastSpellByName("Alev");
	end
end

function MageStun(usedischarge, usephoenix, usepurgatory, rapidpurgatory, dischargemessage)
  
  	if (usedischarge and CD("Ateşleme")) then
		CastSpellByName("Ateşleme");
		if((nil ~= dischargemessage) and (dischargemessage ~= "")) then SendChatMessage(dischargemessage, "SAY"); end
	elseif (usephoenix and CD("Phoenix")) then 
		CastSpellByName("Phoenix");
	elseif (usepurgatory and CD("Araf Ateşi")) then 
		CastSpellByName("Araf Ateşi");
	elseif (usepurgatory and rapidpurgatory) then
		CastSpellByName("Araf Ateşi");
	end

end

function BuffAllMage(useIntensification, intensificationfirst, useenergywell, useperception, usemagictarget, useenergyinflux, usefireward, usesavageblessing, usefangritual, useshadowprotection, usebriar, usescepter, usemarking, usecatalysis, usebuyuengeli, useyagmurkutsamasi, usebuyuozu)
  
  local pbuffs = BuffList("player")
  local friendly = (not UnitCanAttack("player","target"));
  
  if ((usefangritual == true ) and (not pbuffs["Diş Ayini"])) then
	CastSpellByName("Diş Ayini");
  elseif ((useshadowprotection == true ) and (not pbuffs["Shadow Protection"])) then
	CastSpellByName("Shadow Protection");
  elseif (usebriar and CD("Dikenli Kalkan") and (not pbuffs["Dikenli Kalkan"] or pbuffs["Dikenli Kalkan"].time < 600)) then
	CastSpellByName("Dikenli Kalkan");
  elseif(usescepter and (not pbuffs["Toprak Asası"] or pbuffs["Toprak Asası"].time < 600)) then
	CastSpellByName("Toprak Asası");
  elseif ((useIntensification == true ) and CD("Yoğunlaştırma") and (not pbuffs["Yoğunlaştırma"]) and (intensificationfirst == true)) then
	CastSpellByName("Yoğunlaştırma");
  elseif ((useenergywell == true ) and CD("Enerji Pınarı") and (not pbuffs["Enerji Pınarı"])) then
	CastSpellByName("Enerji Pınarı");
  elseif ((useperception == true ) and (not pbuffs["Algı"] or pbuffs["Algı"].time < 600)) then
	CastSpellByName("Algı");
  elseif((usemagictarget == true ) and (not pbuffs["Büyü Hedefi"] or pbuffs["Büyü Hedefi"].time < 600)) then
	CastSpellByName("Büyü Hedefi");
  elseif((useenergyinflux == true ) and CD("Enerji Akısı") and (not pbuffs["Enerji Akısı"])) then
    CastSpellByName("Enerji Akısı");
  elseif((usefireward == true ) and (not pbuffs["Ateş Koruması"] or pbuffs["Ateş Koruması"].time < 400)) then
    CastSpellByName("Ateş Koruması");
  elseif((usesavageblessing == true ) and (not pbuffs["Yabani Kutsama"] or pbuffs["Yabani Kutsama"].time < 600)) then
    if(friendly) then TargetUnit("player"); end
	CastSpellByName("Vahşi Kutsama");
  elseif (usemarking and CD("Dünya İşaretlemesi")) then
	CastSpellByName("Dünya İşaretlemesi");
  elseif (usebuyuengeli and (not pbuffs["Büyü Engeli"] or pbuffs["Büyü Engeli"].time < 600)) then
	CastSpellByName("Büyü Engeli");
  elseif (useyagmurkutsamasi and (not pbuffs["Yağmurun Kutsaması"] or pbuffs["Yağmurun Kutsaması"].time < 600)) then
	CastSpellByName("Yağmurun Kutsaması");
  elseif (usebuyuozu and (not pbuffs["Büyünün Özü"] or pbuffs["Büyünün Özü"].time < 600)) then
	if(friendly) then TargetUnit("player"); end
	CastSpellByName("Büyünün Özü");
  elseif((useIntensification == true ) and CD("Yoğunlaştırma") and (not intensificationfirst)) then
    CastSpellByName("Yoğunlaştırma");
  elseif (usecatalysis and CD("Element Katalizi")) then
	CastSpellByName("Element Katalizi");
  elseif(CD("Ateş Koruması")) then
		SendSystemMsg("Bufflar Tamam!");
  end
end

function ChargeUp(chargeonly)  
  local enemy = UnitCanAttack("player", "target")
  local pBuffs = BuffList("player")
  local tBuffs= BuffList("target")
  
  local plasmaelapsed = os.time() - g_lastPlasmaArrow.LastCast

  if((not chargeonly) and (pBuffs["Statik Alan Yükü"])) then
	CastSpellByName("Statik Alan");
	PlaySoundByPath("interface/AddOns/KurbishFunctions/sounds/WindowsError.wav");
  elseif((pBuffs["Yüklü"]) and (not pBuffs["Statik Alan Yükü"])) then
	CastSpellByName("Elektrik Sıkıştırma");
  elseif(chargeonly and (pBuffs["Statik Alan Yükü"])) then
    CastSpellByName("Plazma Oku")
  elseif((not tBuffs["Statik Alan"]) and (plasmaelapsed > 1)) then
	CastSpellByName("Plazma Oku")
  end
	  
  if((chargeonly) and (pBuffs["Yüklü"])) then PlaySoundByPath("interface/AddOns/KurbishFunctions/sounds/WindowsError.wav"); end
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
	
	if (usesilence and castable and usesilencefirst and CD("Sessizlik")) then
		CastSpellByName("Sessizlik");
    elseif (uselightning and castable and CD("Yıldırım")) then
		CastSpellByName("Yıldırım"); 
		if((nil ~= lightningmessage) and (lightningmessage ~= "")) then SendChatMessage(lightningmessage, "SAY"); end
	elseif (usesilence and castable and CD("Sessizlik")) then 
		CastSpellByName("Sessizlik");
	elseif (usehumanrules and castable and CD("Alev")) then
		CastSpellByName("Alev");
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
	-- PrintDebugMessage("Seconds elapsed since Elektrik Topu: " .. secselapsed )

	-- if((not tbuffs["Electric Flow"]) and (secselapsed > 1)) then
	if((not tbuffs["Elektrik Akımı"]) and (secselapsed > 1)) then
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
-- 	-- PrintDebugMessage("Seconds elapsed since Elektrik Topu: " .. secselapsed )
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

function CursedFangCastableOnTarget(tbuffs, fangtimeout)
  -- This function may fail to return proper value if the player moves while casting ElectricBolt and the target has Electric Flow Debuff cast by another player.
  -- First check if target does not have electric flow debuff
  
  local secselapsed = 0
  local castresult = false;
  local targetguid = UnitGUID("target");

  if (g_lastCursedFangs ~= nil) then
	secselapsed = os.time() - g_lastCursedFangs.LastCast
	-- PrintDebugMessage("Seconds elapsed since Elektrik Topu: " .. secselapsed )

	if((not tbuffs["Cursed Fangs"]) and (secselapsed > 1)) then
		castresult = true;
	elseif((g_lastCursedFangs.TargetGUID == targetguid) and (secselapsed >= fangtimeout)) then
		castresult = false;
	end
  end
  return castresult;
end

function BossAttackMageMain(useelemental)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Gardiyan") then
		BossAttackMageWardenLite(false,true, true, true, 11, false, true, false, true, true, true, true, false, useelemental, true, true, g_bossAttackMageMainWarnBuffs, "Plazma Oku");
	elseif(secondclass == "Doğa Alimi") then
		BossAttackMageDruidLite(.5,.6,true,true,11,false,true,false,true,true,true, true, false, useelemental, g_bossAttackMageMainWarnBuffs, "Plazma Oku", true);
	elseif(secondclass == "Rahip") then
		BossAttackMagePriestLite(.5, .4, true, true, 11, false, true, false, true, true, true, true, true, true, useelemental, g_bossAttackMageMainWarnBuffs, "Plazma Oku", true)
	end
end

function BossAttackMageMainDps()
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Gardiyan") then
		BossAttackMageWardenLite(true,true, true, true, 11, false, false, true, true, true, true, false, false, false, false, false, g_bossAttackMageMainWarnBuffs, nil);
	elseif(secondclass == "Doğa Alimi") then
		BossAttackMageDruidLite(.5,.6,true,true,11,false,false,true,true,false,false,false,false,false,g_bossAttackMageMainWarnBuffs,"Plazma Oku",true);
	elseif(secondclass == "Rahip") then
		BossAttackMagePriestLite(.5, .4, true, true, 11, false, false, true, true, false, false, false, false, false, false, g_bossAttackMageMainWarnBuffs, "Plazma Oku", true)
	end
end

function ProtectSelfMageMain(phirusslot, phiruspct, recoverpct, gloveslot,holyauropercent,regeneratepct)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Gardiyan") then
		ProtectSelfMageWarden(phirusslot,phiruspct,true, g_useGloveDebuffList,gloveslot);
	elseif(secondclass == "Doğa Alimi") then
		ProtectSelf(false,recoverpct,1.5,0,0,phirusslot,phiruspct,g_useGloveDebuffList,gloveslot);
	elseif(secondclass == "Rahip") then
		ProtectSelfPriest(holyauropercent, 0, regeneratepct, recoverpct, 0, 0, phirusslot, phiruspct, g_useGloveDebuffList, gloveslot, true);
	end
end

function BreakSkillMageMain()
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Gardiyan") then
		BreakSkill(true,true,true,false,g_mageBreakSkillAvoidBuffs,false,'');
	elseif(secondclass == "Doğa Alimi") then
		BreakSkill(true,true,true,false,g_mageBreakSkillAvoidBuffs,false,'');
	elseif(secondclass == "Rahip") then
		BreakSkill(true,true,true,false,g_mageBreakSkillAvoidBuffs,false,'');
	elseif(secondclass == "Büyücü") then
		BreakSkill(true,true,true,false,g_mageBreakSkillAvoidBuffs,false,'');
	end
end

function BuffAllMageMain(buffplus)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Gardiyan") then
		BuffAllMage(buffplus, false, true, false, false, true, true, false, false, false, true, true, false,buffplus, false, false, false);
	elseif(secondclass == "Doğa Alimi") then
		BuffAllMage(buffplus,false,true,true,true,true,true,true,false,false,false,false,false,buffplus,false,false,false);
	elseif(secondclass == "Rahip") then
		BuffAllMage(buffplus,false,true,false,false,true,true,false,false,false,false,false,false,buffplus,true,true,true);
	end
end
