local manaelektriksaldirisi = 264;
local manalavsilahi = 156;
local managurleyenkilic = 30;
local manayildirimindokunusu = 30;
-- local manavahsiguc = 240;
-- local manaatestopu = 180;
-- local manacaprazvurus = 350;
-- local manadelidiken = 490;
-- local manaruzgardograma = 120;
-- local manayukludarbe = 148;
-- local manaorman = 105;
-- local manakorumabicagi = 140;
-- local manaelfduasi = 140;
-- local manaciftdograma = 60;

function BossAttackWarriorMageLite(manaslot, manapct, useelektrik, uselavsilahi, useatestopu, usegurleyen, useasabiyet, useintensification, useofkeli, usecinnet, elektrikliofkecount, useyildirimdokunusu, atakslot, elecktricbufftimer)
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
local maxelectricbuffname = "Yüksek Voltaj "..elektrikliofkecount;
-- local tbuffs = BuffList("target");
 
	if (isdead) then
		SendSystemMsg("Hedef Ölü..");
	elseif (nil ~= manaslot and manaslot > 0 and pctmana < manapct and GetPotUsable(manaslot)) then
		UseAction(manaslot);
		PrintSkill("Mana Potu Kullandin!");
	elseif(useelektrik and not pbuffs["Elektrik Saldırısı"] and pmana >= manaelektriksaldirisi) then
		CastSpellByName("Elektrik Saldırısı");
		PrintSkill("Elektrik Saldırısı");
	elseif(uselavsilahi and not pbuffs["Lav Silahı"] and pmana >= manalavsilahi) then
		CastSpellByName("Lav Silahı");
		PrintSkill("Lav Silahı");
	elseif (useatestopu and CD("Ateş Topu")) then 
		CastSpellByName("Ateş Topu"); 
	elseif(usegurleyen and CD("Gürleyen Kılıç") and pmana >= managurleyenkilic) then
		CastSpellByName("Gürleyen Kılıç");
		PrintSkill("Gürleyen Kılıç");
	elseif(useasabiyet and CD("Asabiyet")) then
		CastSpellByName("Asabiyet");
		PrintSkill("Asabiyet");
	elseif((useintensification == true ) and CD("Yoğunlaştırma")) then
		CastSpellByName("Yoğunlaştırma");
		PrintSkill("Yoğunlaştırma");
	elseif(useofkeli and CD("Öfkeli") and prage < 0.80) then
		CastSpellByName("Öfkeli");
		PrintSkill("Öfkeli");
	elseif(usecinnet and CD("Cinnet")) then
		CastSpellByName("Cinnet");
		PrintSkill("Cinnet");
	elseif((pelectriccount < elektrikliofkecount or (pbuffs[maxelectricbuffname] and pbuffs[maxelectricbuffname].time < elecktricbufftimer)) and prage >= .15)then
		CastSpellByName("Elektrikli Öfke");
		PrintSkill("Elektrikli Öfke");
	elseif(useyildirimdokunusu and CD("Yıldırımın Dokunuşu") and pmana >= manayildirimindokunusu) then
		CastSpellByName("Yıldırımın Dokunuşu");
		PrintSkill("Yıldırımın Dokunuşu");	
	elseif(nil ~= atakslot and atakslot > 0) then
		UseAction(atakslot);
		PrintSkill("Beyaz vurus kullandin..");
	else
		SendSystemMsg("DIKKAT! Skill Atilamiyor.");
	end
end

function GetElectricCount(pbuffs)
	local electriccount = 0;
	if(pbuffs["Yüksek Voltaj 1"]) then
		electriccount = 1;
	elseif(pbuffs["Yüksek Voltaj 2"]) then
		electriccount = 2;
	elseif(pbuffs["Yüksek Voltaj 3"]) then
		electriccount = 3;
	end
	return electriccount;	
end

function BuffSelfWarriorMage(useelektrik, uselavsilahi,usefireward, useasabiyet, useintensification, useofkeli, usecinnet)
	local pbuffs = BuffList("player");
	local prage = PctM("player");
	local pmana = UnitSkill("player");
	local ispetout = UnitExists("playerpet");
	-- local pctmana = PctS("player");
	
	if(useelektrik and (not pbuffs["Elektrik Saldırısı"]  or pbuffs["Elektrik Saldırısı"].time < 600) and pmana >= manaelektriksaldirisi) then
		CastSpellByName("Elektrik Saldırısı");
		PrintSkill("Elektrik Saldırısı");
	elseif(uselavsilahi and (not pbuffs["Lav Silahı"] or pbuffs["Lav Silahı"].time < 600) and pmana >= manalavsilahi) then
		CastSpellByName("Lav Silahı");
		PrintSkill("Lav Silahı");
	elseif((usefireward == true ) and (not pbuffs["Ateş Koruması"] or pbuffs["Ateş Koruması"].time < 400)) then
		CastSpellByName("Ateş Koruması");
	elseif(useasabiyet and CD("Asabiyet")) then
		CastSpellByName("Asabiyet");
	elseif((useintensification == true ) and CD("Yoğunlaştırma")) then
		CastSpellByName("Yoğunlaştırma");
	elseif(useofkeli and CD("Öfkeli") and prage < 0.80) then
		CastSpellByName("Öfkeli");
	elseif(usecinnet and CD("Cinnet")) then
		CastSpellByName("Cinnet");
	elseif(CD("Elektrik Saldırısı")) then
		SendSystemMsg("Bufflar Tamam!");
	end
end

