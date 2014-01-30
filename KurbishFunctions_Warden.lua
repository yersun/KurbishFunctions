local manadogakoruma = 330;
local manadikenlikalkan = 282;
local manameseningucu = 330;
local manavahsiguc = 240;
local manaatestopu = 180;
local manacaprazvurus = 350;
local manadelidiken = 490;
local manaruzgardograma = 120;
local manayukludarbe = 140;
local manaorman = 105;
local manakorumabicagi = 120;
local manaelfduasi = 188;
local manaciftdograma = 60;

-- local manadogakoruma = 330;
-- local manadikenlikalkan = 210;
-- local manameseningucu = 330;
-- local manavahsiguc = 240;
-- local manaatestopu = 180;
-- local manacaprazvurus = 350;
-- local manadelidiken = 490;
-- local manaruzgardograma = 120;
-- local manayukludarbe = 140;
-- local manaorman = 105;


function BossAttackWardenWarriorLite(manaslot, manapct, elfrehberipct, usedogakoruma, usedikenli, usemese, usevahsi, useofkeli, usecilginlik, usehanedan, usehiddet, usesinyal,usecapraz, forcesinyal, usecanavar, usecift, usekesme, useyuklu, atakslot)
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
		SendSystemMsg("Hedef Ölü..");
	elseif (nil ~= manaslot and manaslot > 0 and PctM("player") < manapct and GetPotUsable(manaslot)) then
		UseAction(manaslot);
		PrintSkill("Mana Potu Kullandin!");
	elseif(ispetout and (nil ~= elfrehberipct) and (elfrehberipct > 0) and (pctmana < elfrehberipct) and CD("Elf Rehberi")) then
		CastSpellByName("Elf Rehberi");
		PrintSkill("Elf Rehberi");
	elseif(usedogakoruma and not pbuffs["Doğanın Koruması"] and pmana >= manadogakoruma) then
		CastSpellByName("Doğanın Koruması");
		PrintSkill("Doğanın Koruması");
	elseif(usedikenli and not pbuffs["Dikenli Kalkan"] and pmana >= manadikenlikalkan) then
		CastSpellByName("Dikenli Kalkan");
		PrintSkill("Dikenli Kalkan");
	elseif(usemese and CD("Meşenin Gücü") and pmana >= manameseningucu) then
		CastSpellByName("Meşenin Gücü");
		PrintSkill("Meşenin Gücü");
	elseif(usevahsi and CD("Vahşi Güç") and pmana >= manavahsiguc) then
		CastSpellByName("Vahşi Güç");
		PrintSkill("Vahşi Güç");
	elseif(useofkeli and CD("Öfkeli") and prage < 0.80) then
		CastSpellByName("Öfkeli");
		PrintSkill("Öfkeli");
	-- elseif(usesavunmaduzeni and CD("Savunma Düzeni") and prage >= 0.25) then
	--	CastSpellByName("Savunma Düzeni");
	elseif(usecilginlik and CD("Çılgınlık") and prage >= 0.25) then
		CastSpellByName("Çılgınlık");
		PrintSkill("Çılgınlık");
	elseif(usehanedan and pctmana >= 0.02 and pmana >= 35 and CD("Hanedan Arması")) then
		CastSpellByName("Hanedan Arması");
		PrintSkill("Hanedan Arması");
	elseif(usehiddet and pmana >= 35 and CD("Hiddet")) then
		CastSpellByName("Hiddet");
		PrintSkill("Hiddet");
	elseif(usesinyal and tdebuffs["Canavar Mührü"] and CD("Sinyal Uzmanlığı") and prage >= 0.20 and (not pbuffs["Sinyal Uzmanlığının Gücü"])) then
		CastSpellByName("Sinyal Uzmanlığı");
		PrintSkill("Sinyal Uzmanlığı");
	elseif (usecapraz and CD("Çapraz Vuruş") and pmana >= manacaprazvurus) then
		CastSpellByName("Çapraz Vuruş");
		PrintSkill("Çapraz Vuruş");
	elseif (usecanavar and CD("Canavar Doğrama") and prage >= 0.20) then
		CastSpellByName("Canavar Doğrama");
		PrintSkill("Canavar Doğrama");		
	elseif(forcesinyal and tdebuffs["Canavar Mührü"] and CD("Sinyal Uzmanlığı") and prage >= 0.20) then
		CastSpellByName("Sinyal Uzmanlığı");
		PrintSkill("Sinyal Uzmanlığı");
	elseif (usecift and CD("Çift Doğrama") and pmana >= manaciftdograma) then
		CastSpellByName("Çift Doğrama"); 
		PrintSkill("Çift Doğrama");
	elseif (usekesme and prage >= 0.25) then
		CastSpellByName("Kesme");
		PrintSkill("Kesme");
	elseif (useyuklu and pmana >= manayukludarbe) then
		CastSpellByName("Yüklü Darbe");
		PrintSkill("Yüklü Darbe");
	elseif(nil ~= atakslot and atakslot > 0) then
		UseAction(atakslot);
		PrintSkill("Duz atak skili kullandin..");
	else
		SendSystemMsg("DIKKAT! Mana/Ofke kontrol edin.");
	end
end

function BuffSelfWardenWarrior(usedogakoruma, usedikenli, usemese, usevahsi, useofkeli, usecilginlik, usehanedan)
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local pmana = UnitMana("player");
	local ispetout = UnitExists("playerpet");
	local pctmana = PctM("player");
	
	if(usedogakoruma and not pbuffs["Doğanın Koruması"] and pmana >= manadogakoruma) then
		CastSpellByName("Doğanın Koruması");
		PrintSkill("Doğanın Koruması");
	elseif(usedikenli and not pbuffs["Dikenli Kalkan"] and pmana >= manadikenlikalkan) then
		CastSpellByName("Dikenli Kalkan");
		PrintSkill("Dikenli Kalkan");
	elseif(usemese and CD("Meşenin Gücü") and pmana >= manameseningucu) then
		CastSpellByName("Meşenin Gücü");
		PrintSkill("Meşenin Gücü");
	elseif(usevahsi and CD("Vahşi Güç") and pmana >= manavahsiguc) then
		CastSpellByName("Vahşi Güç");
		PrintSkill("Vahşi Güç");
	elseif(useofkeli and CD("Öfkeli") and prage < 0.80) then
		CastSpellByName("Öfkeli");
		PrintSkill("Öfkeli");
	-- elseif(usesavunmaduzeni and CD("Savunma Düzeni") and prage >= 0.25) then
	--	CastSpellByName("Savunma Düzeni");
	elseif(usecilginlik and CD("Çılgınlık") and prage >= 0.25) then
		CastSpellByName("Çılgınlık");
		PrintSkill("Çılgınlık");
	elseif(usehanedan and pctmana >= 0.02 and pmana >= 35 and CD("Hanedan Arması")) then
		CastSpellByName("Hanedan Arması");
		PrintSkill("Hanedan Arması");
	elseif(CD("Dikenli Kalkan")) then
		SendSystemMsg("Bufflar Tamam!");
	end
end

local printSkill = false;

function ToggleSkillPrint()

	if(printSkill) then printSkill = false; Msg("Skill takibi kapatıldı.."); else printSkill = true; Msg("Skill takibi açıldı..");end
end

function PrintSkill(skillname)
	if(printSkill) then Msg("-->"..skillname); end
end

function ProtectSelfWardenWarrior(cpslot, cptct, useelftilsimi, usemeseninkalbi, useolumsuzguc, usesavunmaduzeni, usehasartransferi)
	local pctHealth = PctH("player")
	local pmana = UnitMana("player");
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local ispetout = UnitExists("playerpet");
	
	if (nil ~= cpslot and cpslot > 0 and pctHealth < cptct and GetPotUsable(cpslot)) then
		UseAction(cpslot);
		PrintSkill("Sağlık Potu Kullandın!");
	elseif(useelftilsimi and CD("Elf Tılsımı") and pmana >= 150) then
		CastSpellByName("Elf Tılsımı");
		PrintSkill("Elf Tılsımı");
	elseif(usemeseninkalbi and CD("Meşenin Kalbi")) then
		CastSpellByName("Meşenin Kalbi");
		PrintSkill("Meşenin Kalbi");
	elseif(useolumsuzguc and CD("Ölümsüz Güç") and PctM("player") >= 0.02 and (pmana >= 35)) then
		CastSpellByName("Ölümsüz Güç");
		PrintSkill("Ölümsüz Güç");
	elseif(usesavunmaduzeni and CD("Savunma Düzeni") and prage >= 0.25) then
		CastSpellByName("Savunma Düzeni");
		PrintSkill("Savunma Düzeni");
	-- elseif(usesavunmaduzeni and CD("Savunma Düzeni") and prage >= 0.25) then
	--	CastSpellByName("Savunma Düzeni");
	elseif(usehasartransferi and CD("Hasar Transferi") and pmana >= 30 and ispetout) then
		CastSpellByName("Hasar Transferi");
		PrintSkill("Hasar Transferi");
	elseif(CD("Dikenli Kalkan")) then
		SendSystemMsg("Bütün Koruma Skilleri Atıldı!!!");
	end
		
end

function BossAttackWardenMageLite(manaslot, manapct, elfrehberipct, usedogakoruma, usedikenli, usemese, usevahsi, usehanedan, useatestopu, usecapraz, usedeli, useruzgar, useyuklu, useorman, atakslot)
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
		SendSystemMsg("Hedef Ölü..");
	elseif (nil ~= manaslot and manaslot > 0 and PctM("player") < manapct and GetPotUsable(manaslot)) then
		UseAction(manaslot);
		PrintSkill("Mana Potu Kullandin!");
	elseif(ispetout and (nil ~= elfrehberipct) and (elfrehberipct > 0) and (pctmana < elfrehberipct) and CD("Elf Rehberi")) then
		CastSpellByName("Elf Rehberi");
		PrintSkill("Elf Rehberi");
	elseif(usedogakoruma and not pbuffs["Doğanın Koruması"] and pmana >= manadogakoruma) then
		CastSpellByName("Doğanın Koruması");
		PrintSkill("Doğanın Koruması");
	elseif(usedikenli and not pbuffs["Dikenli Kalkan"] and pmana >= manadikenlikalkan) then
		CastSpellByName("Dikenli Kalkan");
		PrintSkill("Dikenli Kalkan");
	elseif(usemese and CD("Meşenin Gücü") and pmana >= manameseningucu) then
		CastSpellByName("Meşenin Gücü");
		PrintSkill("Meşenin Gücü");
	elseif(usevahsi and CD("Vahşi Güç") and pmana >= manavahsiguc) then
		CastSpellByName("Vahşi Güç");
		PrintSkill("Vahşi Güç");
	elseif(usehanedan and pctmana >= 0.02 and pmana >= 35 and CD("Hanedan Arması")) then
		CastSpellByName("Hanedan Arması");
		PrintSkill("Hanedan Arması");
	elseif (useatestopu and CD("Ateş Topu") and pmana >= manaatestopu) then
		CastSpellByName("Ateş Topu");
		PrintSkill("Ateş Topu");
	elseif (usecapraz and CD("Çapraz Vuruş") and pmana >= manacaprazvurus) then
		CastSpellByName("Çapraz Vuruş");
		PrintSkill("Çapraz Vuruş");
	elseif (usedeli and CD("Deli Diken") and pmana >= manadelidiken) then
		CastSpellByName("Deli Diken"); 
		PrintSkill("Deli Diken");
	elseif (useruzgar and pmana >= manaruzgardograma) then
		CastSpellByName("Rüzgar Doğraması");
		PrintSkill("Rüzgar Doğraması");
	elseif (useyuklu and pmana >= manayukludarbe) then
		CastSpellByName("Yüklü Darbe");
		PrintSkill("Yüklü Darbe");
	elseif (useorman and pmana >= manaorman) then
		CastSpellByName("Orman Ruhu'nun Gücü");
		PrintSkill("Orman Ruhu'nun Gücü");
	elseif(nil ~= atakslot and atakslot > 0) then
		UseAction(atakslot);
		PrintSkill("Duz atak skili kullandin..");
	else
		SendSystemMsg("DIKKAT! Mana/Ofke kontrol edin.");
	end
end

function ProtectSelfWardenMage(cpslot, cptct, usemeseninkalbi, usekristalkorumasi, useelftilsimi, usehasartransferi)
	local pctHealth = PctH("player")
	local pmana = UnitMana("player");
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local ispetout = UnitExists("playerpet");
	
	if (nil ~= cpslot and cpslot > 0 and pctHealth < cptct and GetPotUsable(cpslot)) then
		UseAction(cpslot);
		PrintSkill("Sağlık Potu Kullandın!");
	elseif(usemeseninkalbi and CD("Meşenin Kalbi")) then
		CastSpellByName("Meşenin Kalbi");
		PrintSkill("Meşenin Kalbi");
	elseif(usekristalkorumasi and CD("Kristal Koruması")) then
		CastSpellByName("Kristal Koruması");
		PrintSkill("Kristal Koruması");
	elseif(useelftilsimi and CD("Elf Tılsımı") and pmana >= 150) then
		CastSpellByName("Elf Tılsımı");
		PrintSkill("Elf Tılsımı");
	elseif(usehasartransferi and CD("Hasar Transferi") and pmana >= 30 and ispetout) then
		CastSpellByName("Hasar Transferi");
		PrintSkill("Hasar Transferi");
	elseif(CD("Dikenli Kalkan")) then
		SendSystemMsg("Bütün Koruma Skilleri Atıldı!!!");
	end
		
end

function BuffSelfWardenMage(usedogakoruma, usedikenli, useateskorumasi, usemese, usevahsi,  elfrehberipct, usehanedan, useyogunlastirma)
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local pmana = UnitMana("player");
	local ispetout = UnitExists("playerpet");
	local pctmana = PctM("player");
	
	if(usedogakoruma and not pbuffs["Doğanın Koruması"] and pmana >= manadogakoruma) then
		CastSpellByName("Doğanın Koruması");
		PrintSkill("Doğanın Koruması");
	elseif(usedikenli and not pbuffs["Dikenli Kalkan"] and pmana >= manadikenlikalkan) then
		CastSpellByName("Dikenli Kalkan");
		PrintSkill("Dikenli Kalkan");
	elseif((useateskorumasi == true ) and (not pbuffs["Ateş Koruması"])) then
		CastSpellByName("Ateş Koruması");
	elseif(usemese and CD("Meşenin Gücü") and pmana >= manameseningucu) then
		CastSpellByName("Meşenin Gücü");
		PrintSkill("Meşenin Gücü");
	elseif(usevahsi and CD("Vahşi Güç") and pmana >= manavahsiguc) then
		CastSpellByName("Vahşi Güç");
		PrintSkill("Vahşi Güç");
	-- elseif(usesavunmaduzeni and CD("Savunma Düzeni") and prage >= 0.25) then
	--	CastSpellByName("Savunma Düzeni");
	elseif(ispetout and (nil ~= elfrehberipct) and (elfrehberipct > 0) and (pctmana < elfrehberipct) and CD("Elf Rehberi")) then
		CastSpellByName("Elf Rehberi");
		PrintSkill("Elf Rehberi");
	elseif(usehanedan and pctmana >= 0.02 and pmana >= 35 and CD("Hanedan Arması")) then
		CastSpellByName("Hanedan Arması");
		PrintSkill("Hanedan Arması");
	elseif(useyogunlastirma and CD("Yoğunlaştırma")) then
		CastSpellByName("Yoğunlaştırma");
		PrintSkill("Yoğunlaştırma");
	elseif(CD("Dikenli Kalkan")) then
		SendSystemMsg("Bufflar Tamam!");
	end
end

function AreaAttackWarden(usedeli, useorman)
	local pmana = UnitMana("player");
	local isdead = UnitIsDeadOrGhost("target");
	local friendly = (not UnitCanAttack("player","target"));
	
	if (usedeli and CD("Deli Diken") and pmana >= manadelidiken) then
		CastSpellByName("Deli Diken"); 
		PrintSkill("Deli Diken");
	elseif (useorman and (isdead or friendly)) then
		SendSystemMsg("Hedef ölü veya düşman değil.");
	elseif (useorman and pmana >= manaorman) then
		CastSpellByName("Orman Ruhu'nun Gücü");
		PrintSkill("Orman Ruhu'nun Gücü");
	else
		SendSystemMsg("Alan Skilleri Beklemede.");
	end
end

function BossAttackWardenDruidLite(recoverpct, toprakanapct, manaslot, manapct, elfrehberipct, usedogakoruma, usedikenli, usetoprakruhu, usemese, usevahsi, useelfduasi, usethornsigil, usecapraz, korumabicagitimer, usedeli, useyuklu, useorman, atakslot)
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
		SendSystemMsg("Hedef Ölü..");
	elseif (friendly and (not isself)) then
		PrintSkill("İyileştirme");
		CastSpellByName("İyileştirme");
	elseif ((phealth <= toprakanapct) and CD("Toprak Ananın Koruması") and pmana >= 100) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Toprak Ananın Koruması");
	elseif ((phealth <= recoverpct)) then
		PrintSkill("İyileştirme");
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("İyileştirme");
	elseif (nil ~= manaslot and manaslot > 0 and PctM("player") < manapct and GetPotUsable(manaslot)) then
		PrintSkill("Mana Potu Kullandin!");
		UseAction(manaslot);
	elseif(ispetout and (nil ~= elfrehberipct) and (elfrehberipct > 0) and (pctmana < elfrehberipct) and CD("Elf Rehberi")) then
		PrintSkill("Elf Rehberi");
		CastSpellByName("Elf Rehberi");
	elseif(usedogakoruma and not pbuffs["Doğanın Koruması"] and pmana >= manadogakoruma) then
		PrintSkill("Doğanın Koruması");
		CastSpellByName("Doğanın Koruması");
	elseif(usedikenli and not pbuffs["Dikenli Kalkan"] and pmana >= manadikenlikalkan) then
		PrintSkill("Dikenli Kalkan");
		CastSpellByName("Dikenli Kalkan");
	elseif((usetoprakruhu == true ) and (not pbuffs["Toprak Ruhu Esansı"])) then
		PrintSkill("Toprak Ruhu Esansı");
		CastSpellByName("Toprak Ruhu Esansı");
	elseif(usemese and CD("Meşenin Gücü") and pmana >= manameseningucu) then
		PrintSkill("Meşenin Gücü");
		CastSpellByName("Meşenin Gücü");
	elseif(usevahsi and CD("Vahşi Güç") and pmana >= manavahsiguc) then
		PrintSkill("Vahşi Güç");
		CastSpellByName("Vahşi Güç");
	elseif(useelfduasi and ispetout and CD("Elf Duası") and pmana >= manaelfduasi) then
		PrintSkill("Elf Duası");
		CastSpellByName("Elf Duası");
	elseif(usethornsigil and (not friendly) and CD("Diken Mühürü") and pmana >= 35) then
		PrintSkill("Diken Mühürü");	
		CastSpellByName("Diken Mühürü");
	elseif (usecapraz and CD("Çapraz Vuruş") and pmana >= manacaprazvurus) then
		PrintSkill("Çapraz Vuruş");
		CastSpellByName("Çapraz Vuruş");
	elseif ((not pbuffs["Koruma Bıçağı"] or pbuffs["Koruma Bıçağı"].time <= korumabicagitimer) and CD("Koruma Bıçağı") and pmana >= manakorumabicagi) then
		PrintSkill("Koruma Bıçağı");
		CastSpellByName("Koruma Bıçağı");
	elseif (usedeli and CD("Deli Diken") and pmana >= manadelidiken) then
		PrintSkill("Deli Diken");
		CastSpellByName("Deli Diken"); 
	elseif (useyuklu and CD("Yüklü Darbe") and pmana >= manayukludarbe) then
		PrintSkill("Yüklü Darbe");
		CastSpellByName("Yüklü Darbe");
	elseif (useorman and pmana >= manaorman) then
		PrintSkill("Orman Ruhu'nun Gücü");
		CastSpellByName("Orman Ruhu'nun Gücü");
	elseif(nil ~= atakslot and atakslot > 0) then
		PrintSkill("Duz atak skili kullandin..");
		UseAction(atakslot);
	else
		SendSystemMsg("DIKKAT! Mana/Ofke kontrol edin.");
	end
end

function ProtectSelfWardenDruid(recoverpct, cpslot, cptct, toprakanapct, useelftilsimi, usemeseninkalbi,  usehasartransferi)
	local pctHealth = PctH("player")
	local pmana = UnitMana("player");
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local ispetout = UnitExists("playerpet");
	local friendly = (not UnitCanAttack("player","target"));
	local isself = UnitIsUnit("target","player");
	
	if ((pctHealth <= recoverpct) and not pbuffs["İyileştirme"]) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("İyileştirme");
	elseif (nil ~= cpslot and cpslot > 0 and pctHealth < cptct and GetPotUsable(cpslot)) then
		UseAction(cpslot);
		PrintSkill("Sağlık Potu Kullandın!");
	elseif ((pctHealth <= toprakanapct) and CD("Toprak Ananın Koruması") and pmana >= 100) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Toprak Ananın Koruması");
	elseif(useelftilsimi and CD("Elf Tılsımı") and pmana >= 150) then
		CastSpellByName("Elf Tılsımı");
		PrintSkill("Elf Tılsımı");
	elseif(usemeseninkalbi and CD("Meşenin Kalbi")) then
		CastSpellByName("Meşenin Kalbi");
		PrintSkill("Meşenin Kalbi");
	elseif(usehasartransferi and CD("Hasar Transferi") and pmana >= 30 and ispetout) then
		CastSpellByName("Hasar Transferi");
		PrintSkill("Hasar Transferi");
	elseif (pctHealth <= recoverpct) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("İyileştirme");
	elseif(CD("Dikenli Kalkan")) then
		SendSystemMsg("Bütün Koruma Skilleri Atıldı!!!");
	end
		
end

function BuffSelfWardenDruid(usedogakoruma, usedikenli, usetoprakruhu, usesavage, usemese, usevahsi,  elfrehberipct, useelfduasi)
	local pbuffs = BuffList("player");
	local prage = PctS("player");
	local pmana = UnitMana("player");
	local ispetout = UnitExists("playerpet");
	local pctmana = PctM("player");
	local friendly = (not UnitCanAttack("player","target"));
	local isself = UnitName("target") == UnitName("player");
	
	if(usedogakoruma and (not pbuffs["Doğanın Koruması"] or pbuffs["Doğanın Koruması"].time < 240) and pmana >= manadogakoruma) then
		CastSpellByName("Doğanın Koruması");
		PrintSkill("Doğanın Koruması");
	elseif(usedikenli and (not pbuffs["Dikenli Kalkan"] or pbuffs["Dikenli Kalkan"].time < 600) and pmana >= manadikenlikalkan) then
		CastSpellByName("Dikenli Kalkan");
		PrintSkill("Dikenli Kalkan");
	elseif((usetoprakruhu == true ) and (not pbuffs["Toprak Ruhu Esansı"]  or pbuffs["Toprak Ruhu Esansı"].time < 600)) then
		CastSpellByName("Toprak Ruhu Esansı");
	elseif (usesavage and (not pbuffs["Yabani Kutsama"] or pbuffs["Yabani Kutsama"].time < 600)) then
		if((not isself) and friendly) then TargetUnit("player"); end
		CastSpellByName("Vahşi Kutsama");
	elseif(usemese and CD("Meşenin Gücü") and pmana >= manameseningucu) then
		CastSpellByName("Meşenin Gücü");
		PrintSkill("Meşenin Gücü");
	elseif(usevahsi and CD("Vahşi Güç") and pmana >= manavahsiguc) then
		CastSpellByName("Vahşi Güç");
		PrintSkill("Vahşi Güç");
	-- elseif(usesavunmaduzeni and CD("Savunma Düzeni") and prage >= 0.25) then
	--	CastSpellByName("Savunma Düzeni");
	elseif(ispetout and (nil ~= elfrehberipct) and (elfrehberipct > 0) and (pctmana < elfrehberipct) and CD("Elf Rehberi")) then
		CastSpellByName("Elf Rehberi");
		PrintSkill("Elf Rehberi");
	elseif(useelfduasi and ispetout and CD("Elf Duası") and pmana >= manaelfduasi) then
		CastSpellByName("Elf Duası");
		PrintSkill("Elf Duası");
	elseif(CD("Dikenli Kalkan")) then
		SendSystemMsg("Bufflar Tamam!");
	end
end

function GetPetOut()
	local combatstate = GetPlayerCombatState();
	local ispetout = UnitExists("playerpet");
	local spell_name = UnitCastingTime("player")
	
	if(combatstate and CD("Meşenin Kalbi")) then
		CastSpellByName("Meşenin Kalbi");
		PrintSkill("Meşenin Kalbi");
	elseif((nil == spell_name) and (not ispetout)) then
		CastSpellByName("Meşenin Ruhunu Çağır");
		PrintSkill("Meşenin Ruhunu Çağır");
	elseif(ispetout) then
		SendSystemMsg("Pet Dışarıda!");
	end
end

function BossAttackWardenMain(getagro,recoverpct, toprakanapct, manaslot, manapct,elfrehberipct, atakslot, forcesinyal,usehiddet)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Doğa Alimi") then
		BossAttackWardenDruidLite(recoverpct, toprakanapct, manaslot, manapct, elfrehberipct, true, true, true, false, false, true, getagro, getagro, 2, false, true, false, atakslot);
	elseif(secondclass == "Savaşçı") then
		BossAttackWardenWarriorLite(manaslot, manapct, elfrehberipct, true, true, true, true, true, false, true, usehiddet, true,true, forcesinyal, true, true, true, true, 1);
	else
		SendSystemMsg("Yan Sınıf Tanımsız??");
	end
end

function BossAttackWardenMainDps(atakslot)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Doğa Alimi") then
		BossAttackWardenDruidLite(0, 0, 0, .4, 0, false, false, true, false, false, false, false, false, 2, false, true, false, atakslot);
	elseif(secondclass == "Savaşçı") then
		BossAttackWardenWarriorLite(0, 0, 0, false, false, false, false, false, false, false, false, false,false, false, true, true, true, true, atakslot);
	else
		SendSystemMsg("Yan Sınıf Tanımsız??");
	end
end

function BuffAllWardenMain(buffplus)
	local mainclass, secondclass = UnitClass("player")
	if(secondclass == "Doğa Alimi") then
		if(not buffplus) then
			BuffSelfWardenDruid(true, true, true, true, false, false,  0, true);
		else
			BuffSelfWardenDruid(true, true, true, true, true, true,  0, true);
		end
	elseif (secondclass == "Savaşçı") then
		if(not buffplus) then
			BuffSelfWardenWarrior(true, true, false, false, false, false, false);
		 else
			BuffSelfWardenWarrior(true, true, true, true, true, false, true);
		 end
	else
		SendSystemMsg("Yan Sınıf Tanımsız??");
	end
end

function ProtectSelfWardenMain(recoverpct, cpslot, cptct, toprakanpct, useelftilsimi, usemeseninkalbi,  usehasartransferi, useolumsuzguc, usesavunmaduzeni)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Doğa Alimi") then
		ProtectSelfWardenDruid(recoverpct, cpslot, cptct, toprakanpct, useelftilsimi, usemeseninkalbi,  usehasartransferi)
	elseif(secondclass == "Savaşçı") then
		ProtectSelfWardenWarrior(cpslot, cptct, useelftilsimi, usemeseninkalbi, useolumsuzguc, usesavunmaduzeni, usehasartransferi)
	else
		SendSystemMsg("Yan Sınıf Tanımsız??");
	end
end

function AttackMuhafiz()
	if(UnitName("target") == "Dev Muhafız") then 
		if CD("Toprağın Nabzı") then 
			CastSpellByName("Toprağın Nabzı"); 
		else 
			BossAttackWardenMain(false,.4,0,.6,0,1,true,false);
		end 
	else 
		TargetNearestEnemy(); 
	end
end