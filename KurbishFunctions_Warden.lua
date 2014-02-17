local manaprotectionofnature = 330;
local manabriarshield = 282;
local manapoweroftheoak = 330;
local manasavagepower = 240;
local manaatestopu = 180;
local manacrosschop = 350;
local manadelidiken = 490;
local manawindchop = 120;
local manachargedchop = 140;
local manapowerofthewoodspirit = 105;
local manakorumabicagi = 120;
local manaelfduasi = 188;
local manadoublechop = 60;
local manafrantic = 70;

-- local manaprotectionofnature = 330;
-- local manabriarshield = 210;
-- local manapoweroftheoak = 330;
-- local manasavagepower = 240;
-- local manaatestopu = 180;
-- local manacrosschop = 350;
-- local manadelidiken = 490;
-- local manawindchop = 120;
-- local manachargedchop = 140;
-- local manapowerofthewoodspirit = 105;


function BossAttackWardenWarriorLite(manaslot, manapct, elvenguidencepct, useprotectionofnature, usebriarshield, useoak, usesavagepower, useenraged, useberserk, usecoatofarms, usehiddet, usesinyal,usecross, forcesinyal, usecanavar, usecift, useslash, usecharged, atakslot)
local phealth = PctH("player")
local prage = PctS("player")
local pmana = UnitMana("player");
local pctmana = PctM("player");
local friendly = (not UnitCanAttack("player","target"))
local pbuffs = BuffList("player");
local tdebuffs = ActualDebuffList("target");
local ispetout = UnitExists("playerpet");
local isdead = UnitIsDeadOrGhost("target");
-- local tbuffs = BuffList("target");
 
	if (isdead) then
		SendSystemMsg("Target Dead..");
	elseif (nil ~= manaslot and manaslot > 0 and PctM("player") < manapct and GetPotUsable(manaslot)) then
		UseAction(manaslot);
		PrintSkill("Used Mana Pot!");
	elseif(ispetout and (nil ~= elvenguidencepct) and (elvenguidencepct > 0) and (pctmana < elvenguidencepct) and CD("Elven Guidance")) then
		CastSpellByName("Elven Guidance");
		PrintSkill("Elven Guidance");
	elseif(useprotectionofnature and not pbuffs["Protection of Nature"] and pmana >= manaprotectionofnature) then
		CastSpellByName("Protection of Nature");
		PrintSkill("Protection of Nature");
	elseif(usebriarshield and not pbuffs["Briar Shield"] and pmana >= manabriarshield) then
		CastSpellByName("Briar Shield");
		PrintSkill("Briar Shield");
	elseif(useoak and CD("Power of the Oak") and pmana >= manapoweroftheoak) then
		CastSpellByName("Power of the Oak");
		PrintSkill("Power of the Oak");
	elseif(usesavagepower and ispetout and CD("Savage Power") and pmana >= manasavagepower) then
		CastSpellByName("Savage Power");
		PrintSkill("Savage Power");
	elseif(useenraged and CD("Enraged") and prage < 0.80) then
		CastSpellByName("Enraged");
		PrintSkill("Enraged");
	-- elseif(usedefensiveformation and CD("Defensive Formation") and prage >= 0.25) then
	--	CastSpellByName("Defensive Formation");
	elseif(useberserk and CD("Berserk") and prage >= 0.25) then
		CastSpellByName("Berserk");
		PrintSkill("Berserk");
	elseif(usecoatofarms and pctmana >= 0.02 and pmana >= 35 and CD("Coat of Arms")) then
		CastSpellByName("Coat of Arms");
		PrintSkill("Coat of Arms");
	elseif(usehiddet and pmana >= 35 and CD("Hiddet")) then
		CastSpellByName("Hiddet");
		PrintSkill("Hiddet");
	elseif(usesinyal and tdebuffs["Beast Sigil"] and CD("Pulse Mastery") and prage >= 0.20 and (not pbuffs["Pulse Mastery"])) then -- Check and correct player buff here, actual buff is not Pulse Mastery
		CastSpellByName("Pulse Mastery");
		PrintSkill("Pulse Mastery");
	elseif (usecross and CD("Cross Chop") and pmana >= manacrosschop) then
		CastSpellByName("Cross Chop");
		PrintSkill("Cross Chop");
	elseif (usecanavar and CD("Beast Chop") and prage >= 0.20) then
		CastSpellByName("Beast Chop");
		PrintSkill("Beast Chop");		
	elseif(forcesinyal and tdebuffs["Beast Sigil"] and CD("Pulse Mastery") and prage >= 0.20) then
		CastSpellByName("Pulse Mastery");
		PrintSkill("Pulse Mastery");
	elseif (usecift and CD("Double Chop") and pmana >= manadoublechop) then
		CastSpellByName("Double Chop"); 
		PrintSkill("Double Chop");
	elseif (useslash and prage >= 0.25) then
		CastSpellByName("Slash");
		PrintSkill("Slash");
	elseif (usecharged and pmana >= manachargedchop) then
		CastSpellByName("Charged Chop");
		PrintSkill("Charged Chop");
	elseif(nil ~= atakslot and atakslot > 0) then
		UseAction(atakslot);
		PrintSkill("White Attack Skill Used..");
	else
		SendSystemMsg("WARNING! Check Mana/Rage!.");
	end
end

function BuffSelfWardenWarrior(useprotectionofnature, usebriarshield, useoak, usesavagepower, useenraged, useberserk, usecoatofarms)
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local pmana = UnitMana("player");
	local ispetout = UnitExists("playerpet");
	local pctmana = PctM("player");
	
	if(useprotectionofnature and not pbuffs["Protection of Nature"] and pmana >= manaprotectionofnature) then
		CastSpellByName("Protection of Nature");
		PrintSkill("Protection of Nature");
	elseif(usebriarshield and (not pbuffs["Briar Shield"]  or pbuffs["Briar Shield"].time < 600) and pmana >= manabriarshield) then
		CastSpellByName("Briar Shield");
		PrintSkill("Briar Shield");
	elseif(useoak and CD("Power of the Oak") and pmana >= manapoweroftheoak) then
		CastSpellByName("Power of the Oak");
		PrintSkill("Power of the Oak");
	elseif(usesavagepower and ispetout and CD("Savage Power") and pmana >= manasavagepower) then
		CastSpellByName("Savage Power");
		PrintSkill("Savage Power");
	elseif(useenraged and CD("Enraged") and prage < 0.80) then
		CastSpellByName("Enraged");
		PrintSkill("Enraged");
	-- elseif(usedefensiveformation and CD("Defensive Formation") and prage >= 0.25) then
	--	CastSpellByName("Defensive Formation");
	elseif(useberserk and CD("Berserk") and prage >= 0.25) then
		CastSpellByName("Berserk");
		PrintSkill("Berserk");
	elseif(usecoatofarms and pctmana >= 0.02 and pmana >= 35 and CD("Coat of Arms")) then
		CastSpellByName("Coat of Arms");
		PrintSkill("Coat of Arms");
	elseif(CD("Briar Shield")) then
		SendSystemMsg("Buffs All Done!");
	end
end

local printSkill = false;

function ToggleSkillPrint()

	if(printSkill) then printSkill = false; Msg("Skill takibi kapatıldı.."); else printSkill = true; Msg("Skill takibi açıldı..");end
end

function PrintSkill(skillname)
	if(printSkill) then Msg("-->"..skillname); end
end

function ProtectSelfWardenWarrior(cpslot, cptct, useelvenamulet, useheartoftheoak, useimmortalpower, usedefensiveformation, usedamagetransfer)
	local pctHealth = PctH("player")
	local pmana = UnitMana("player");
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local ispetout = UnitExists("playerpet");
	
	if (nil ~= cpslot and cpslot > 0 and pctHealth < cptct and GetPotUsable(cpslot)) then
		UseAction(cpslot);
		PrintSkill("Used Health Pot!");
	elseif(useelvenamulet and CD("Elven Amulet") and pmana >= 150) then
		CastSpellByName("Elven Amulet");
		PrintSkill("Elven Amulet");
	elseif(useheartoftheoak and CD("Heart of the Oak")) then
		CastSpellByName("Heart of the Oak");
		PrintSkill("Heart of the Oak");
	elseif(useimmortalpower and CD("Immortal Power") and PctM("player") >= 0.02 and (pmana >= 35)) then
		CastSpellByName("Immortal Power");
		PrintSkill("Immortal Power");
	elseif(usedefensiveformation and CD("Defensive Formation") and prage >= 0.25) then
		CastSpellByName("Defensive Formation");
		PrintSkill("Defensive Formation");
	-- elseif(usedefensiveformation and CD("Defensive Formation") and prage >= 0.25) then
	--	CastSpellByName("Defensive Formation");
	elseif(usedamagetransfer and CD("Damage Transfer") and pmana >= 30 and ispetout) then
		CastSpellByName("Damage Transfer");
		PrintSkill("Damage Transfer");
	elseif(CD("Briar Shield")) then
		SendSystemMsg("All Protection Skills on Cooldown!!!");
	end
		
end

function BossAttackWardenMageLite(manaslot, manapct, elvenguidencepct, useprotectionofnature, usebriarshield, useoak, usesavagepower, usefireball, usecross, usethorny, usewindchop, usecharged, usewoodspirit, atakslot)
local phealth = PctH("player")
local prage = PctS("player")
local pmana = UnitMana("player");
local pctmana = PctM("player");
local friendly = (not UnitCanAttack("player","target"))
local pbuffs = BuffList("player");
local tdebuffs = ActualDebuffList("target");
local ispetout = UnitExists("playerpet");
local isdead = UnitIsDeadOrGhost("target");
-- local tbuffs = BuffList("target");
 
	if (isdead) then
		SendSystemMsg("Target Dead..");
	elseif (nil ~= manaslot and manaslot > 0 and PctM("player") < manapct and GetPotUsable(manaslot)) then
		UseAction(manaslot);
		PrintSkill("Used Mana Pot!");
	elseif(ispetout and (nil ~= elvenguidencepct) and (elvenguidencepct > 0) and (pctmana < elvenguidencepct) and CD("Elven Guidance")) then
		CastSpellByName("Elven Guidance");
		PrintSkill("Elven Guidance");
	elseif(useprotectionofnature and not pbuffs["Protection of Nature"] and pmana >= manaprotectionofnature) then
		CastSpellByName("Protection of Nature");
		PrintSkill("Protection of Nature");
	elseif(usebriarshield and not pbuffs["Briar Shield"] and pmana >= manabriarshield) then
		CastSpellByName("Briar Shield");
		PrintSkill("Briar Shield");
	elseif(useoak and CD("Power of the Oak") and pmana >= manapoweroftheoak) then
		CastSpellByName("Power of the Oak");
		PrintSkill("Power of the Oak");
	elseif(usesavagepower and ispetout and CD("Savage Power") and pmana >= manasavagepower) then
		CastSpellByName("Savage Power");
		PrintSkill("Savage Power");
	elseif (usefireball and CD("Fireball") and pmana >= manaatestopu) then
		CastSpellByName("Fireball");
		PrintSkill("Fireball");
	elseif (usecross and CD("Cross Chop") and pmana >= manacrosschop) then
		CastSpellByName("Cross Chop");
		PrintSkill("Cross Chop");
	elseif (usethorny and CD("Thorny Vines") and pmana >= manadelidiken) then
		CastSpellByName("Thorny Vines"); 
		PrintSkill("Thorny Vines");
	elseif (usewindchop and pmana >= manawindchop) then
		CastSpellByName("Wind Chop");
		PrintSkill("Wind Chop");
	elseif (usecharged and pmana >= manachargedchop) then
		CastSpellByName("Charged Chop");
		PrintSkill("Charged Chop");
	elseif (usewoodspirit and pmana >= manapowerofthewoodspirit) then
		CastSpellByName("Power of the Wood Spirit");
		PrintSkill("Power of the Wood Spirit");
	elseif(nil ~= atakslot and atakslot > 0) then
		UseAction(atakslot);
		PrintSkill("White Attack Skill Used..");
	else
		SendSystemMsg("WARNING! Check Mana/Rage!.");
	end
end

function ProtectSelfWardenMage(cpslot, cptct, useheartoftheoak, usekristalkorumasi, useelvenamulet, usedamagetransfer)
	local pctHealth = PctH("player")
	local pmana = UnitMana("player");
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local ispetout = UnitExists("playerpet");
	
	if (nil ~= cpslot and cpslot > 0 and pctHealth < cptct and GetPotUsable(cpslot)) then
		UseAction(cpslot);
		PrintSkill("Used Health Pot!");
	elseif(useheartoftheoak and CD("Heart of the Oak")) then
		CastSpellByName("Heart of the Oak");
		PrintSkill("Heart of the Oak");
	elseif(usekristalkorumasi and CD("Kristal Koruması")) then
		CastSpellByName("Kristal Koruması");
		PrintSkill("Kristal Koruması");
	elseif(useelvenamulet and CD("Elven Amulet") and pmana >= 150) then
		CastSpellByName("Elven Amulet");
		PrintSkill("Elven Amulet");
	elseif(usedamagetransfer and CD("Damage Transfer") and pmana >= 30 and ispetout) then
		CastSpellByName("Damage Transfer");
		PrintSkill("Damage Transfer");
	elseif(CD("Briar Shield")) then
		SendSystemMsg("All Protection Skills on Cooldown!!!");
	end
		
end

function BuffSelfWardenMage(useprotectionofnature, usebriarshield, useateskorumasi, useoak, usesavagepower,  elvenguidencepct, usecoatofarms, useyogunlastirma)
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local pmana = UnitMana("player");
	local ispetout = UnitExists("playerpet");
	local pctmana = PctM("player");
	
	if(useprotectionofnature and not pbuffs["Protection of Nature"] and pmana >= manaprotectionofnature) then
		CastSpellByName("Protection of Nature");
		PrintSkill("Protection of Nature");
	elseif(usebriarshield and not pbuffs["Briar Shield"] and pmana >= manabriarshield) then
		CastSpellByName("Briar Shield");
		PrintSkill("Briar Shield");
	elseif((useateskorumasi == true ) and (not pbuffs["Fire Ward"])) then
		CastSpellByName("Fire Ward");
	elseif(useoak and CD("Power of the Oak") and pmana >= manapoweroftheoak) then
		CastSpellByName("Power of the Oak");
		PrintSkill("Power of the Oak");
	elseif(usesavagepower and ispetout and CD("Savage Power") and pmana >= manasavagepower) then
		CastSpellByName("Savage Power");
		PrintSkill("Savage Power");
	-- elseif(usedefensiveformation and CD("Defensive Formation") and prage >= 0.25) then
	--	CastSpellByName("Defensive Formation");
	elseif(ispetout and (nil ~= elvenguidencepct) and (elvenguidencepct > 0) and (pctmana < elvenguidencepct) and CD("Elven Guidance")) then
		CastSpellByName("Elven Guidance");
		PrintSkill("Elven Guidance");
	elseif(usecoatofarms and pctmana >= 0.02 and pmana >= 35 and CD("Coat of Arms")) then
		CastSpellByName("Coat of Arms");
		PrintSkill("Coat of Arms");
	elseif(useyogunlastirma and CD("Intensification")) then
		CastSpellByName("Intensification");
		PrintSkill("Intensification");
	elseif(CD("Briar Shield")) then
		SendSystemMsg("Buffs All Done!");
	end
end

function AreaAttackWarden(usefrantic, usewoodspirit)
	local pmana = UnitMana("player");
	local isdead = UnitIsDeadOrGhost("target");
	local friendly = (not UnitCanAttack("player","target"));
	
	if (usefrantic and CD("Frantic Briar") and pmana >= manafrantic) then
		CastSpellByName("Frantic Briar"); 
		PrintSkill("Frantic Briar");
	elseif (usewoodspirit and (isdead or friendly)) then
		SendSystemMsg("Target Dead or not enemy.");
	elseif (usewoodspirit and pmana >= manapowerofthewoodspirit) then
		CastSpellByName("Power of the Wood Spirit");
		PrintSkill("Power of the Wood Spirit");
	else
		SendSystemMsg("Area skills on cooldown.");
	end
end

function BossAttackWardenDruidLite(recoverpct, motherearthpct, manaslot, manapct, elvenguidencepct, useprotectionofnature, usebriarshield, useearthspirit, useoak, usesavagepower, useelfduasi, usethornsigil, usecross, korumabicagitimer, usethorny, usecharged, usewoodspirit, atakslot)
local phealth = PctH("player")
local prage = PctS("player")
local pmana = UnitMana("player");
local pctmana = PctM("player");
local friendly = (not UnitCanAttack("player","target"))
local pbuffs = BuffList("player");
local tdebuffs = ActualDebuffList("target");
local ispetout = UnitExists("playerpet");
local isdead = UnitIsDeadOrGhost("target");
local isself = UnitIsUnit("target","player");
-- local tbuffs = BuffList("target");
 
	if (isdead) then
		SendSystemMsg("Target Dead..");
	elseif (friendly and (not isself)) then
		PrintSkill("Recover");
		CastSpellByName("Recover");
	elseif ((phealth <= motherearthpct) and CD("Mother Earth's Protection") and pmana >= 100) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Mother Earth's Protection");
	elseif ((phealth <= recoverpct)) then
		PrintSkill("Recover");
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Recover");
	elseif (nil ~= manaslot and manaslot > 0 and PctM("player") < manapct and GetPotUsable(manaslot)) then
		PrintSkill("Used Mana Pot!");
		UseAction(manaslot);
	elseif(ispetout and (nil ~= elvenguidencepct) and (elvenguidencepct > 0) and (pctmana < elvenguidencepct) and CD("Elven Guidance")) then
		PrintSkill("Elven Guidance");
		CastSpellByName("Elven Guidance");
	elseif(useprotectionofnature and not pbuffs["Protection of Nature"] and pmana >= manaprotectionofnature) then
		PrintSkill("Protection of Nature");
		CastSpellByName("Protection of Nature");
	elseif(usebriarshield and not pbuffs["Briar Shield"] and pmana >= manabriarshield) then
		PrintSkill("Briar Shield");
		CastSpellByName("Briar Shield");
	elseif((useearthspirit == true ) and (not pbuffs["Earth Spirit Essence"])) then
		PrintSkill("Earth Spirit Essence");
		CastSpellByName("Earth Spirit Essence");
	elseif(useoak and CD("Power of the Oak") and pmana >= manapoweroftheoak) then
		PrintSkill("Power of the Oak");
		CastSpellByName("Power of the Oak");
	elseif(usesavagepower and ispetout and CD("Savage Power") and pmana >= manasavagepower) then
		PrintSkill("Savage Power");
		CastSpellByName("Savage Power");
	elseif(useelfduasi and ispetout and CD("Elven Prayer") and pmana >= manaelfduasi) then
		PrintSkill("Elven Prayer");
		CastSpellByName("Elven Prayer");
	elseif(usethornsigil and (not friendly) and CD("Thorn Sigil") and pmana >= 35) then
		PrintSkill("Thorn Sigil");	
		CastSpellByName("Thorn Sigil");
	elseif (usecross and CD("Cross Chop") and pmana >= manacrosschop) then
		PrintSkill("Cross Chop");
		CastSpellByName("Cross Chop");
	elseif ((not pbuffs["Blade of Protection"] or pbuffs["Blade of Protection"].time <= korumabicagitimer) and CD("Blade of Protection") and pmana >= manakorumabicagi) then
		PrintSkill("Blade of Protection");
		CastSpellByName("Blade of Protection");
	elseif (usethorny and CD("Thorny Vines") and pmana >= manadelidiken) then
		PrintSkill("Thorny Vines");
		CastSpellByName("Thorny Vines"); 
	elseif (usecharged and CD("Charged Chop") and pmana >= manachargedchop) then
		PrintSkill("Charged Chop");
		CastSpellByName("Charged Chop");
	elseif (usewoodspirit and pmana >= manapowerofthewoodspirit) then
		PrintSkill("Power of the Wood Spirit");
		CastSpellByName("Power of the Wood Spirit");
	elseif(nil ~= atakslot and atakslot > 0) then
		PrintSkill("White Attack Skill Used..");
		UseAction(atakslot);
	else
		SendSystemMsg("WARNING! Check Mana/Rage!.");
	end
end

function ProtectSelfWardenDruid(recoverpct, cpslot, cptct, motherearthpct, useelvenamulet, useheartoftheoak,  usedamagetransfer)
	local pctHealth = PctH("player")
	local pmana = UnitMana("player");
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local ispetout = UnitExists("playerpet");
	local friendly = (not UnitCanAttack("player","target"));
	local isself = UnitIsUnit("target","player");
	
	if ((pctHealth <= recoverpct) and not pbuffs["Recover"]) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Recover");
	elseif (nil ~= cpslot and cpslot > 0 and pctHealth < cptct and GetPotUsable(cpslot)) then
		UseAction(cpslot);
		PrintSkill("Used Health Pot!");
	elseif ((pctHealth <= motherearthpct) and CD("Mother Earth's Protection") and pmana >= 100) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Mother Earth's Protection");
	elseif(useelvenamulet and CD("Elven Amulet") and pmana >= 150) then
		CastSpellByName("Elven Amulet");
		PrintSkill("Elven Amulet");
	elseif(useheartoftheoak and CD("Heart of the Oak")) then
		CastSpellByName("Heart of the Oak");
		PrintSkill("Heart of the Oak");
	elseif(usedamagetransfer and CD("Damage Transfer") and pmana >= 30 and ispetout) then
		CastSpellByName("Damage Transfer");
		PrintSkill("Damage Transfer");
	elseif (pctHealth <= recoverpct) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Recover");
	elseif(CD("Briar Shield")) then
		SendSystemMsg("All Protection Skills on Cooldown!!!");
	end
		
end

function BuffSelfWardenDruid(useprotectionofnature, usebriarshield, useearthspirit, usesavage, useoak, usesavagepower,  elvenguidencepct, useelfduasi)
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local pmana = UnitMana("player");
	local ispetout = UnitExists("playerpet");
	local pctmana = PctM("player");
	local friendly = (not UnitCanAttack("player","target"));
	local isself = UnitName("target") == UnitName("player");
	
	if(useprotectionofnature and (not pbuffs["Protection of Nature"] or pbuffs["Protection of Nature"].time < 240) and pmana >= manaprotectionofnature) then
		CastSpellByName("Protection of Nature");
		PrintSkill("Protection of Nature");
	elseif(usebriarshield and (not pbuffs["Briar Shield"] or pbuffs["Briar Shield"].time < 600) and pmana >= manabriarshield) then
		CastSpellByName("Briar Shield");
		PrintSkill("Briar Shield");
	elseif((useearthspirit == true ) and (not pbuffs["Earth Spirit Essence"]  or pbuffs["Earth Spirit Essence"].time < 600)) then
		CastSpellByName("Earth Spirit Essence");
	elseif (usesavage and (not pbuffs["Savage Blessing"] or pbuffs["Savage Blessing"].time < 600)) then
		if((not isself) and friendly) then TargetUnit("player"); end
		CastSpellByName("Savage Blessing");
	elseif(useoak and CD("Power of the Oak") and pmana >= manapoweroftheoak) then
		CastSpellByName("Power of the Oak");
		PrintSkill("Power of the Oak");
	elseif(usesavagepower and ispetout and CD("Savage Power") and pmana >= manasavagepower) then
		CastSpellByName("Savage Power");
		PrintSkill("Savage Power");
	-- elseif(usedefensiveformation and CD("Defensive Formation") and prage >= 0.25) then
	--	CastSpellByName("Defensive Formation");
	elseif(ispetout and (nil ~= elvenguidencepct) and (elvenguidencepct > 0) and (pctmana < elvenguidencepct) and CD("Elven Guidance")) then
		CastSpellByName("Elven Guidance");
		PrintSkill("Elven Guidance");
	elseif(useelfduasi and ispetout and CD("Elven Prayer") and pmana >= manaelfduasi) then
		CastSpellByName("Elven Prayer");
		PrintSkill("Elven Prayer");
	elseif(CD("Briar Shield")) then
		SendSystemMsg("Buffs All Done!");
	end
end

function GetPetOut()
	local combatstate = GetPlayerCombatState();
	local ispetout = UnitExists("playerpet");
	local spell_name = UnitCastingTime("player")
	
	if(combatstate and CD("Heart of the Oak")) then
		CastSpellByName("Heart of the Oak");
		PrintSkill("Heart of the Oak");
	elseif((nil == spell_name) and (not ispetout)) then
		CastSpellByName("Summon Spirit of the Oak");
		PrintSkill("Summon Spirit of the Oak");
	elseif(ispetout) then
		SendSystemMsg("Pet Already Out!");
	end
end

function BossAttackWardenMain(getagro,recoverpct, motherearthpct, manaslot, manapct,elvenguidencepct, atakslot, forcesinyal,usehiddet)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Druid") then
		BossAttackWardenDruidLite(recoverpct, motherearthpct, manaslot, manapct, elvenguidencepct, true, true, true, false, false, true, getagro, getagro, 2, false, true, false, atakslot);
	elseif(secondclass == "Warrior") then
		BossAttackWardenWarriorLite(manaslot, manapct, elvenguidencepct, true, true, true, true, true, false, true, usehiddet, true,true, forcesinyal, true, true, true, true, 1);
	elseif(secondclass == "Mage") then
		BossAttackWardenMageLite(manaslot, manapct, elvenguidencepct, true, usebriarshield, true, true, true, true, false, true, true, false, 1);
	else
		SendSystemMsg("Side class undefined??");
	end
end

function BossAttackWardenMainDps(atakslot)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Druid") then
		BossAttackWardenDruidLite(.5, .4, 25, .4, 0, true, true, true, false, false, true, false, false, 2, false, true, false, atakslot);
		-- BossAttackWardenDruidLite(0, 0, 0, .4, 0, false, false, true, false, false, false, false, false, 2, false, true, false, atakslot);
	elseif(secondclass == "Warrior") then
		BossAttackWardenWarriorLite(0, 0, 0, false, false, false, false, false, false, false, false, false,false, false, true, true, true, true, atakslot);
	elseif(secondclass == "Mage") then
		BossAttackWardenMageLite(manaslot, manapct, elvenguidencepct, false, true, false, false, true, true, true, true, true, false, 1);
	else
		SendSystemMsg("Side class undefined??");
	end
end

function BuffAllWardenMain(buffplus)
	local mainclass, secondclass = UnitClass("player")
	if(secondclass == "Druid") then
			BuffSelfWardenDruid(true, true, true, true, buffplus, buffplus,  0, true)
	elseif (secondclass == "Warrior") then
		if(not buffplus) then
			BuffSelfWardenWarrior(true, true, false, false, false, false, false);
		 else
			BuffSelfWardenWarrior(true, true, true, true, true, false, true);
		 end
	elseif(secondclass == "Mage") then
		BuffSelfWardenMage(true, true, true, buffplus, buffplus,  .5, true, buffplus)
	else
		SendSystemMsg("Side class undefined??");
	end
end

function ProtectSelfWardenMain(recoverpct, cpslot, cptct, toprakanpct, useelvenamulet, useheartoftheoak,  usedamagetransfer, useimmortalpower, usedefensiveformation)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Druid") then
		ProtectSelfWardenDruid(recoverpct, cpslot, cptct, toprakanpct, useelvenamulet, useheartoftheoak,  usedamagetransfer)
	elseif(secondclass == "Warrior") then
		ProtectSelfWardenWarrior(cpslot, cptct, useelvenamulet, useheartoftheoak, useimmortalpower, usedefensiveformation, usedamagetransfer)
	else
		SendSystemMsg("Side class undefined??");
	end
end

function AttackMuhafiz()
	if(UnitName("target") == "Dev Muhafız") then 
		if CD("Earth Pulse") then 
			CastSpellByName("Earth Pulse"); 
		else 
			BossAttackWardenMain(false,.4,0,.6,0,1,true,false);
		end 
	else 
		TargetNearestEnemy(); 
	end
end