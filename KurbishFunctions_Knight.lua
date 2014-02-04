function BossAttackKnightPriest(rangecheckskillslot, doattack, attackslot, hphiruspct, hphirusslot, mphiruspct, mphirusslot, pctmanacritic, usearmor, useholyseal, usehatred, usethreaten, usepunishment, disarmamentcount, usewhirl, usekutsalceza, useatonement,  useholystrike)
local phealth = PctH("player")
local penergy = PctS("player")
local pmana = PctM("player")
local inrange = GetActionUsable(rangecheckskillslot);
-- local secselapsed = os.time() - g_lastcasttime
local friendly = (not UnitCanAttack("player","target"))
local pbuffs = ActualBuffList("player");
local tdebuffs = ActualDebuffList("target");
local hscount = GetHolySealCount(tdebuffs);
-- PrintDebugMessage("Holy Seal Count :"..tostring(hscount));
local discount = GetDisarmamentCount(tdebuffs);
-- PrintDebugMessage("Disarmament Count :"..tostring(discount));
local lscount = GetLightSealCount(tdebuffs);
-- PrintDebugMessage("Light Seal Count :"..tostring(lscount));

	-- PrintDebugMessage("Holy Seals Count : "..hscount);
	-- PrintDebugMessage("Disarmament Count : "..discount);
	-- PrintDebugMessage("Light Seals Count : "..lscount);
	
	--local ph, phcd = GetActionCooldown(hphirusslot);
	--local pm, pmcd = GetActionCooldown(mphirusslot);
	--local Hicon_path, Hname, Hcount, Hlocked, Hwore, Hcontinued  = GetActionInfo(hphirusslot);
	--local Micon_path, Mname, Mcount, Mlocked, Mwore, Mcontinued  = GetActionInfo(mphirusslot);

  
	if ((phealth <= hphiruspct) and (hphirusslot > 0) and GetPotUsable(hphirusslot)) then
		PrintDebugMessage("TANK ACTION : Use health firus!");
		UseAction(hphirusslot);
	elseif ((pmana <= mphiruspct) and (mphirusslot > 0) and GetPotUsable(mphirusslot)) then
		PrintDebugMessage("TANK ACTION : Use mana firus!");
		UseAction(mphirusslot);
	elseif (usearmor and (not pbuffs["Gelişmiş Zırh"])) then
		PrintDebugMessage("TANK ACTION : Geliştirilmiş Zırh");
		CastSpellByName("Geliştirilmiş Zırh");
	elseif (useholyseal and (not pbuffs["Kutsal Damga"])) then
		PrintDebugMessage("TANK ACTION : Kutsal Damga!");
		CastSpellByName("Kutsal Damga");
	elseif (usehatred and CD("Nefret Darbesi")) then
		PrintDebugMessage("TANK ACTION : Nefret Darbesi");
		CastSpellByName("Nefret Darbesi");
	elseif ((hscount == 3) and usethreaten and CD("Tehdit")) then
		PrintDebugMessage("TANK ACTION : Tehdit!");
		CastSpellByName("Tehdit");
	elseif ((lscount == 3) and usepunishment and CD("Cezalandırma")) then
		PrintDebugMessage("TANK ACTION : Cezalandırma!");
		CastSpellByName("Cezalandırma");
	elseif ((disarmamentcount > 0) and (discount < disarmamentcount) and (CD("Silahsızlandırma"))) then
		PrintDebugMessage("TANK ACTION : Silahsızlandırma!");
		CastSpellByName("Silahsızlandırma");
	elseif (GetManaReturnCastableOnTarget(pmana, pctmanacritic, hscount) and (CD("Mana Dönüşü"))) then
		PrintDebugMessage("TANK ACTION : Mana Dönüşü");
		CastSpellByName("Mana Dönüşü");
	elseif (usewhirl and CD("Kasırga Kalkanı") and inrange) then
		PrintDebugMessage("TANK ACTION : Kasırga Kalkanı");
		CastSpellByName("Kasırga Kalkanı");
	elseif (pmana < (pctmanacritic/3)) then
		if(doattack) then
			UseAction(attackslot);
		else
			SendSystemMsg("Mana Critic -- Attacking!");
		end
	elseif (usekutsalceza and CD("Kutsal Ceza") and tdebuffs["Holy Light's Fury"]) then
		PrintDebugMessage("TANK ACTION : Kasırga Kalkanı");
		CastSpellByName("Kutsal Ceza");	
	elseif (useatonement and CD("Kefaret Kalkanı")) then
		PrintDebugMessage("TANK ACTION : Kefaret Kalkanı!");
		CastSpellByName("Kefaret Kalkanı");
	elseif (useholystrike and CD("Kutsal Saldırı")) then
		PrintDebugMessage("TANK ACTION : Kutsal Saldırı!");
		CastSpellByName("Kutsal Saldırı");
	elseif (doattack) then
		PrintDebugMessage("TANK ACTION : ATTACK!");
		UseAction(attackslot);
	end
end

function BuffKnightPriest(usegelismiszirh, usebuyuengeli, useyagmurunkutsamasi, usekutsaldamga, usekararlilik, usecesaretkalkani)
local pbuffs = ActualBuffList("player");
	if(usegelismiszirh and (not pbuffs["Gelişmiş Zırh"])) then
		PrintDebugMessage("TANK BUFF : Geliştirilmiş Zırh!");
		CastSpellByName("Geliştirilmiş Zırh");
	elseif(usebuyuengeli and (not pbuffs["Büyü Engeli"])) then
		PrintDebugMessage("TANK BUFF : Büyü Engeli!");
		CastSpellByName("Büyü Engeli");
	elseif(useyagmurunkutsamasi and (not pbuffs["Yağmurun Kutsaması"])) then
		PrintDebugMessage("TANK BUFF : Yağmurun Kutsaması!");
		CastSpellByName("Yağmurun Kutsaması");
	elseif(usekutsaldamga and (not pbuffs["Kutsal Damga"])) then
		PrintDebugMessage("TANK BUFF : Kutsal Damga!");
		CastSpellByName("Kutsal Damga");
	elseif(usekararlilik and CD("Kararlılık") and (not pbuffs["Kararlılık"])) then
		PrintDebugMessage("TANK BUFF : Kararlılık!");
		CastSpellByName("Kararlılık");
	elseif(usecesaretkalkani and CD("Cesaret Kalkanı") and (not pbuffs["Cesaret Kalkanı"])) then
		PrintDebugMessage("TANK BUFF : Cesaret Kalkanı!");
		CastSpellByName("Cesaret Kalkanı");
	elseif(CD("Büyü Engeli")) then
		SendSystemMsg("Bütün Bufflar Atıldı!!!");
	end
end

function ProtectKnightPriest(hphiruspct, hphirusslot, useyenileme, usekararlilik, usecesaretkalkani, anlikpct, usedisiplinkalkani, mphiruspct, mphirusslot)
	local pbuffs = ActualBuffList("player");
	local phealth = PctH("player");
	local pctmana = PctM("player");
	local friendly = (not UnitCanAttack("player","target"))
	local isself = UnitName("target") == UnitName("player");
  
	
	if ((phealth <= hphiruspct) and (hphirusslot > 0) and GetPotUsable(hphirusslot)) then
		PrintDebugMessage("TANK ACTION : Use health firus!");
		UseAction(hphirusslot);
	elseif (useyenileme and (not pbuffs["Yenile"])) then
	    if (friendly and (not isself)) then TargetUnit("player") end;
		PrintDebugMessage("TANK BUFF : Yenileme!");
		CastSpellByName("Yenileme");
	elseif(usekararlilik and CD("Kararlılık") and (not pbuffs["Kararlılık"])) then
		PrintDebugMessage("TANK BUFF : Kararlılık!");
		CastSpellByName("Kararlılık");
	elseif(usecesaretkalkani and CD("Cesaret Kalkanı") and (not pbuffs["Cesaret Kalkanı"])) then
		PrintDebugMessage("TANK BUFF : Cesaret Kalkanı!");
		CastSpellByName("Cesaret Kalkanı");
	elseif((phealth <= anlikpct) and(not pbuffs["Anlık Recover"])) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		PrintDebugMessage("TANK BUFF : Anlık Recover!");
		CastSpellByName("Anlık Recover");	
	elseif(usedisiplinkalkani and CD("Disiplin Kalkanı") and (not pbuffs["Kişisel Disiplin Kalkanı"])) then
		PrintDebugMessage("TANK BUFF : Disiplin Kalkanı!");
		CastSpellByName("Disiplin Kalkanı");
	elseif ((pctmana <= mphiruspct) and (mphirusslot > 0) and GetPotUsable(mphirusslot)) then
		PrintDebugMessage("TANK ACTION : Use mana firus!");
		UseAction(mphirusslot);
	elseif(CD("Büyü Engeli")) then
		SendSystemMsg("All Protection Skills on Cooldown!!!");
	end
end

function GetManaReturnCastableOnTarget(pmana, pctmanacritic, hscount)
	local castable = false;
	if ((pmana <= pctmanacritic) and (hscount > 0)) then
		castable = true;
	-- elseif (hscount == 3) then
	--	local timeleft = DebuffTimeLeft("target","Holy Seals (3)");
	--	PrintDebugMessage("Holy Seals (3) Time Left : "..timeleft);
	--	if (timeleft <= 2) then castable = true; end
	end
	return castable;
end

function GetHolySealCount(tdebuffs)
	local cnt = 0;
	if(tdebuffs["Kutsal Damga 1"]) then
		cnt = 1;
	elseif(tdebuffs["Kutsal Damga 2"]) then
		cnt = 2;
	elseif(tdebuffs["Kutsal Damga 3"]) then
		cnt = 3;
	end
	return cnt;
end

function GetLightSealCount(tdebuffs)
	local cnt = 0;
	if(tdebuffs["Işık Damgası 1"]) then
		cnt = 1;
	elseif(tdebuffs["Işık Damgası 2"]) then
		cnt = 2;
	elseif(tdebuffs["Işık Damgası 3"]) then
		cnt = 3;
	end
	return cnt;
end

function GetDisarmamentCount(tdebuffs)
	local cnt = 0;
	if(tdebuffs["Silahsızlandırma 1"]) then
		cnt = 1;
	elseif(tdebuffs["Silahsızlandırma 2"]) then
		cnt = 2;
	elseif(tdebuffs["Silahsızlandırma 3"]) then
		cnt = 3;
	elseif(tdebuffs["Silahsızlandırma 4"]) then
		cnt = 4;		
	end
	return cnt;
end