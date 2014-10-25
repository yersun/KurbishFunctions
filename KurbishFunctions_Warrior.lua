local manaelectricattack = 264;
local manalavaweapon = 156;
local manathundersword = 30;
local manayildirimindokunusu = 30;

-- PctM() == Rage for Warrior
-- PctS() == Mana for Warrior
-- local manasavagepower = 240;
-- local manaatestopu = 180;
-- local manacrosschop = 350;
-- local manadelidiken = 490;
-- local manawindchop = 120;
-- local manachargedchop = 148;
-- local manapowerofthewoodspirit = 105;
-- local manakorumabicagi = 140;
-- local manaelfduasi = 140;
-- local manadoublechop = 60;

function BossAttackWarriorMageLite(manaslot, manapct, useelektrik, uselavsilahi, usefireball, usegurleyen, useBerserk, useintensification, useenraged, useBerserk, elektrikliofkecount, useyildirimdokunusu, atakslot, elecktricbufftimer)
local phealth = PctH("player")
local pmana = UnitSkill("player")
local prage = PctM("player");
local pctmana = PctS("player");
local friendly = (not UnitCanAttack("player","target"))
local pbuffs = BuffList("player");
local tdebuffs = ActualDebuffList("target");
local isdead = UnitIsDeadOrGhost("target");
local pelectriccount = GetElectricCount(pbuffs);
if(nil == elecktricbufftimer) then elecktricbufftimer = 2; end
local maxelectricbuffname = "High Voltage III";
-- local tbuffs = BuffList("target");
 
	if (isdead) then
		SendSystemMsg("Target Dead..");
	elseif (nil ~= manaslot and manaslot > 0 and pctmana < manapct and GetPotUsable(manaslot)) then
		UseAction(manaslot);
		PrintSkill("Used Mana Pot!");
	elseif(useelektrik and not pbuffs["Electric Attack"] and pmana >= manaelectricattack) then
		CastSpellByName("Electric Attack");
		PrintSkill("Electric Attack");
	elseif(uselavsilahi and not pbuffs["Lava Weapon"] and pmana >= manalavaweapon) then
		CastSpellByName("Lava Weapon");
		PrintSkill("Lava Weapon");
	elseif (usefireball and CD("Fireball")) then 
		CastSpellByName("Fireball"); 
	elseif(usegurleyen and CD("Thunder Sword") and pmana >= manathundersword) then
		CastSpellByName("Thunder Sword");
		PrintSkill("Thunder Sword");
	elseif(useBerserk and CD("Berserk")) then
		CastSpellByName("Berserk");
		PrintSkill("Berserk");
	elseif((useintensification == true ) and CD("Intensification")) then
		CastSpellByName("Intensification");
		PrintSkill("Intensification");
	elseif(useenraged and CD("Enraged") and prage < 0.80) then
		CastSpellByName("Enraged");
		PrintSkill("Enraged");
	elseif(useBerserk and CD("Berserk")) then
		CastSpellByName("Berserk");
		PrintSkill("Berserk");
	elseif(prage >= .15 and (pelectriccount < elektrikliofkecount or (pbuffs[maxelectricbuffname] and pbuffs[maxelectricbuffname].time < elecktricbufftimer)))then
		CastSpellByName("Electrical Rage");
		PrintSkill("Electrical Rage");
	elseif(useyildirimdokunusu and CD("Lightning's Touch") and pmana >= manayildirimindokunusu) then
		CastSpellByName("Lightning's Touch");
		PrintSkill("Lightning's Touch");	
	elseif(nil ~= atakslot and atakslot > 0) then
		UseAction(atakslot);
		PrintSkill("White Attack Skill Used..");
	else
		SendSystemMsg("WARNING! No Skill can be used!!");
	end
end

function GetElectricCount(pbuffs)
	local electriccount = 0;
	if(pbuffs["High Voltage I"]) then
		electriccount = 1;
	elseif(pbuffs["High Voltage II"]) then
		electriccount = 2;
	elseif(pbuffs["High Voltage III"]) then
		electriccount = 3;
	end
	return electriccount;	
end

function BuffSelfWarriorMage(useelektrik, uselavsilahi,usefireward, useintensification, useenraged, useBerserk, useAggressiveness, useFrenzy)
	local pbuffs = BuffList("player");
	local prage = PctM("player");
	local pmana = UnitSkill("player");
	local ispetout = UnitExists("playerpet");
	-- local pctmana = PctS("player");
	
	if(useelektrik and (not pbuffs["Electric Attack"]  or pbuffs["Electric Attack"].time < 600) and pmana >= manaelectricattack) then
		CastSpellByName("Electric Attack");
		PrintSkill("Electric Attack");
	elseif(uselavsilahi and (not pbuffs["Lava Weapon"] or pbuffs["Lava Weapon"].time < 600) and pmana >= manalavaweapon) then
		CastSpellByName("Lava Weapon");
		PrintSkill("Lava Weapon");
	elseif((usefireward == true ) and (not pbuffs["Fire Ward"] or pbuffs["Fire Ward"].time < 400)) then
		CastSpellByName("Fire Ward");
	elseif((useintensification == true ) and CD("Intensification")) then
		CastSpellByName("Intensification");
	elseif(useenraged and CD("Enraged") and prage < 0.80) then
		CastSpellByName("Enraged");
	elseif(useBerserk and CD("Berserk")) then
		CastSpellByName("Berserk");
	elseif(useAggressiveness and CD("Aggressiveness")) then
		CastSpellByName("Aggressiveness");
	elseif(useFrenzy and CD("Frenzy")) then
		CastSpellByName("Frenzy");
	elseif(CD("Electric Attack")) then
		SendSystemMsg("Buffs All Done!");
	end
end

