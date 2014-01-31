function ProtectSelfPriest(holyauropercent, wavehealth, regeneratepct, urgentPercent, crystalCandySlot, crystalCandyPercent, phirusSlot, phirusPercent, glovedebuflist, gloveslot, usemageelectrostatic)
  local pbuffs = BuffList("player")
  local pdebuffs = ActualDebuffList("player")
  local phealth = PctH("player")
  local useCandy = false
  local usePhirus = false
  local useGlove = false
  local isMage = (((UnitClass("target") == "Mage") or (UnitClass("target") == "Priest") or (UnitClass("target") == "Druid")) and (not (UnitName("target") == UnitName("player"))))
  local unitIsPlayer = UnitIsPlayer("target")
  local tdead = UnitIsDeadOrGhost("target")
  local itemgloveslot = gloveslot + 10;
  local combatstate = GetPlayerCombatState();
  
  local friendly = (not UnitCanAttack("player","target"))
  local isself = (UnitName("target") == UnitName("player"));
  
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
  
  if((phealth <= holyauropercent) and combatstate and CD("Kutsal Hale")) then
    CastSpellByName("Kutsal Hale");
  elseif(phealth <= wavehealth and CD("Dalga Zırhı") and (not pbuffs["Dalga Zırhı"]) and (not pdebuffs["Dalga Zırhı Etkisiz"])) then
		if (friendly and not isself) then TargetUnit("player") end
		CastSpellByName("Dalga Zırhı");
  elseif(usemageelectrostatic and CD("Elektrostatik Yük") and (not pbuffs["Elektrostatik Yük"])) then
		CastSpellByName("Elektrostatik Yük");
  elseif((useCandy == true)  and combatstate and (phealth <= crystalCandyPercent) and GetActionUsable(crystalCandySlot) and (cccd == 0)) then
    UseAction(crystalCandySlot);
  elseif((usePhirus == true) and (phealth <= phirusPercent) and GetActionUsable(phirusSlot) and (phcd == 0)) then
    UseAction(phirusSlot);
  elseif ((useGlove == true) and GetActionUsable(gloveslot) and (glcd == 0)) then
	UseAction(gloveslot);
  elseif ((phealth <= regeneratepct) and (not pbuffs["Yenile"])) then
	if (friendly and not isself) then TargetUnit("player") end
	CastSpellByName("Yenileme");
  elseif (phealth <= urgentPercent) then
    if (friendly and not isself) then TargetUnit("player") end
	CastSpellByName("Anlık Recover");
  elseif (gloveslot > 0) then
	UseAction(itemgloveslot);
	PlaySoundByPath("interface/AddOns/KurbishFunctions/sounds/WindowsError.wav")
  end
  
end

function PriestGroupHeal(useLastPrayer)
	if(useLastPrayer and CD("Son Duacı")) then
		CastSpellByName("Son Duacı");
	else
		CastSpellByName("Grup Recover");
	end
end

function BossAttackPriestKnight(holyauropercent, regeneratepct, urgentPercent, useMagicBarrier, useBlessedWater, useGrace, useEnchancedArmor, useBoneChill, useRisingTide, donthealpvp)
local phealth = PctH("player")
local penergy = PctS("player")
local secselapsed = os.time() - g_lastcasttime
local friendly = (not UnitCanAttack("player","target"))
local pbuffs = BuffList("player");
local tdebuffs = ActualDebuffList("target")
local isplayer = UnitIsPlayer("target");

	if(donthealpvp and isplayer and (not friendly)) then 
		-- blossominghealth = 0;
		regeneratepct = 0;
		urgentPercent = 0;
	end
  
	if ((phealth <= holyauropercent) and CD("Kutsal Hale")) then
		CastSpellByName("Kutsal Hale"); 
	elseif ((phealth <= regeneratepct) and (not pbuffs["Yenile"])) then
		if(friendly) then TargetUnit("player"); end;
		CastSpellByName("Yenileme"); 
	elseif ((phealth <= urgentPercent)) then
		if(friendly) then TargetUnit("player"); end;
		CastSpellByName("Anlık Recover");
	elseif(useMagicBarrier and (not pbuffs["Büyü Engeli"])) then
		CastSpellByName("Büyü Engeli"); 
	elseif(useBlessedWater and (not pbuffs["Yağmurun Kutsaması"])) then
		CastSpellByName("Yağmurun Kutsaması"); 
	elseif(useGrace and (not pbuffs["Gelişmiş Savage Blessing"])) then
		CastSpellByName("Savage Blessing");
	elseif(useEnchancedArmor and (not pbuffs["Gelişmiş Zırh"])) then
		CastSpellByName("Geliştirilmiş Zırh"); 
	elseif(useBoneChill and (not friendly) and (not tdebuffs["Kemik Donduran"])) then
		CastSpellByName("Kemik Donduran");
	elseif((not friendly) and useRisingTide) then
		CastSpellByName("Medcezir");
	else
		CastSpellByName("Anlık Recover");
	end
	
end

function BuffAllPriest(useMagicBarrier, useBlessedWater, useGrace, useEnchancedArmor, useDivine, useWave)
	
	local pbuffs = BuffList("player")
	local pdebuffs = ActualDebuffList("target")
	
	if(useMagicBarrier and (not pbuffs["Büyü Engeli"])) then
		CastSpellByName("Büyü Engeli"); 
	elseif(useBlessedWater and (not pbuffs["Yağmurun Kutsaması"])) then
		CastSpellByName("Yağmurun Kutsaması"); 
	elseif(useGrace and (not pbuffs["Gelişmiş Savage Blessing"])) then
		CastSpellByName("Savage Blessing");
	elseif(useEnchancedArmor and (not pbuffs["Gelişmiş Zırh"])) then
		CastSpellByName("Geliştirilmiş Zırh"); 
	elseif(useDivine and (not pbuffs["Kutsal Cisimleşme"])) then
		CastSpellByName("Kutsal Cisimleşme"); 
	elseif(useWave and CD("Dalga Zırhı") and (not pbuffs["Dalga Zırhı"]) and (not pdebuffs["Dalga Zırhı Etkisiz"])) then
		if (not UnitCanAttack("player","target") and not (UnitName("target") == UnitName("player"))) then TargetUnit("player") end
		CastSpellByName("Dalga Zırhı");
  end
  
end

function PriestTimedHeal(targetableSkillSlot, urgenthealth, regenhealth)
--    targetableSkillSlot = Quickbar slot # for targetable, instant-cast buff without a cooldown (eg. Amp Attack) for range checking.

   local pbuffs = BuffList("player")
   local phealth = PctH("player")
   
   local friendly = (not UnitCanAttack("player","target"))
   local isself = (UnitName("target") == UnitName("player"));
  
   local spell = UnitCastingTime("player")  -- Spell being cast?
   local partycount = GetNumPartyMembers();
   
   -- If there is noone in the party, make sure ourself is included by setting the party member count to 1
   if (partycount == 0) then partycount = 1; end
   
   if (spell ~= nil) then return end
   
	   local healthtable = GetPartyHealthInfo();
	   local unitisdead = false;
	   
	   -- Do Blossoming Life For Party Next
		for i=1,partycount do
			local id = healthtable[i].id
			if(id == 0) then 
				TargetUnit("player");
			else
				TargetUnit("party"..id);
				unitisdead = UnitIsDeadOrGhost("target");
			end
			
			if (GetActionUsable(targetableSkillSlot) and (not unitisdead)) then
				if (id > 0) and UnitIsUnit("target","party"..id) then
					local tbuffs= ActualBuffList("target")
					local thealth = PctH("target")
					-- if((thealth <= blossominghealth) and (not tbuffs["Blossoming Life"])) then
					if((thealth <= urgenthealth) and (thealth > 0)) then 
						CastSpellByName("Anlık Recover");
						return;
					end;
				elseif ((id == 0) and (phealth < urgenthealth)) then
					CastSpellByName("Anlık Recover");
					return;
				end
			end
		end
		
		for i=1,partycount do
			local id = healthtable[i].id
			if(id == 0) then 
				TargetUnit("player");
			else
				TargetUnit("party"..id);
				unitisdead = UnitIsDeadOrGhost("target");
			end
			
			if (GetActionUsable(targetableSkillSlot) and (not unitisdead)) then
				if (id > 0) and UnitIsUnit("target","party"..id) then
					local tbuffs= ActualBuffList("target")
					local thealth = PctH("target")
					-- if((thealth <= blossominghealth) and (not tbuffs["Blossoming Life"])) then
					if((thealth <= regenhealth) and (thealth > 0) and (not tbuffs["Yenile"])) then 
						CastSpellByName("Yenileme");
						return;
					end;
				elseif ((id == 0) and (phealth < regenhealth) and (not pbuffs["Yenile"])) then
					CastSpellByName("Yenileme");
					return;
				end
			end
		end

end