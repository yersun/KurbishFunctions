-- For SCOUT -> NatureAttackCombo(.85, .65, .60, .80, .45, .50, .40, true, true, true, false, true, true);
function NatureAttackDruidScout(cameliahealth1, cameliahealth2, cameliahealth3, blossominghealth, earthhealth, recoverhealth, rockhealth, forcerecoverfriendlyhealth, userockslide, usebriar, usevampirearrow, usefireball, useearthpulse, useeartharrow)
  local friendly = (not UnitCanAttack("player","target"))
  local pbuffs = BuffList("player")
  local tbuffs= BuffList("target")
  local tdebuffs = ActualDebuffList("target")
  local tspell,ttime,telapsed = UnitCastingTime("target")

  local phealth = PctH("player")
  local thealth = PctH("target")

  local buffs
  local health
  local forcerecover

  local pmana = PctM("player")
  local cameliacount = BuffCount("player",  "Camellia Flower")
  local naturepower = BuffCount("player", "Nature's Power")

  if(((friendly) and (phealth < forcerecoverfriendlyhealth) and (thealth < forcerecoverfriendlyhealth)) or (phealth < recoverhealth)) then
     forcerecover = true
     health = thealth
     buffs = tbuffs
     cameliacount = BuffCount("target",  "Camellia Flower")
  elseif(friendly) then
    health = thealth
    buffs = tbuffs
    cameliacount = BuffCount("target",  "Camellia Flower")
  elseif(not friendly) then
    health = phealth
    buffs = pbuffs
  end

  local isshift = IsShiftKeyDown()

--  combat = GetPlayerCombatState()
-- Below routine is no longer necessary, we do not need to reset last_action in current execution logic.
--  local tdead = UnitIsDeadOrGhost("target")
  if (tdead) then
       g_lastcast = ""
       PrintDebugMessage("Target is DEAD!");
  end
  
  if ((health <= cameliahealth1) and (cameliacount < 1) ) then
	CastSpellByName("Camellia Flower");
  elseif (forcerecover) then
      CastSpellByName("Recover");
  elseif (health <= earthhealth) then
    CastSpellByName("Mother Earth's Protection");
  elseif ((friendly) and (phealth <= rockhealth)) then
    CastSpellByName("Rock Protection");
  elseif ((not buffs["Blossoming Life"]) and (health <= blossominghealth)) then
    CastSpellByName("Blossoming Life");
  elseif (health <= recoverhealth) then
    CastSpellByName("Recover");
  elseif ((health <= cameliahealth2) and (cameliacount < 2)) then
    CastSpellByName("Camellia Flower");
  elseif ((health <= cameliahealth3) and (cameliacount < 3) ) then
    CastSpellByName("Camellia Flower");
  elseif ((not friendly) and (isshift == true) and (naturepower >= 2) and (not tdebuffs["Weakening Seed"])) then
    CastSpellByName("Weakening Seed");
  elseif ((not friendly) and (isshift == true) and (naturepower >= 2) and (not tdebuffs["Withering Seed"])) then
    CastSpellByName("Withering Seed");
  elseif ((userockslide == true) and CD("Rockslide") and (not friendly)) then
    CastSpellByName("Rockslide");
  elseif ((usebriar == true) and (not friendly) and (not tdebuffs["Briar Entwinement"])) then
    CastSpellByName("Briar Entwinement");
  elseif ((usevampirearrow == true) and (not friendly) and (not tdebuffs["VampireArrows"])) then
      CastSpellByName("Vampire Arrows");
  elseif ((usefireball == true) and CD("Fireball") and (not friendly)) then
      CastSpellByName("Fireball");
  elseif ((useearthpulse == true) and CD("Earth Pulse") and (not friendly)) then
	  CastSpellByName("Earth Pulse");
  elseif ((useeartharrow == true) and (not friendly)) then
	  CastSpellByName("Earth Arrow");
  end
  
end

function NatureAttackDruidRogue(useweakening, usewithering , blossominghealth, earthhealth, recoverhealth, rockhealth, userockslide, usewrath, usebriar, usecorrosive, usewidow, useearthpulse, useeartharrow, donthealpvp)

  -- local spell = UnitCastingTime("player")  -- Spell being cast?
  -- if (spell ~= nil) then return end
   
  local friendly = (not UnitCanAttack("player","target"))
  local isself = UnitName("target") == UnitName("player");
  local pbuffs = BuffList("player")
  local tbuffs= ActualBuffList("target")
  local tdebuffs = ActualDebuffList("target")
  local tspell,ttime,telapsed = UnitCastingTime("target")
  local penergy = PctS("player");
  
  local phealth = PctH("player")
  local thealth = PctH("target")

  local buffs
  local health
  
  local pmana = PctM("player")
  local naturepower = BuffCount("player", "Nature's Power")

  local isplayer = UnitIsPlayer("target");
  if(donthealpvp and isplayer and (not friendly)) then 
	-- blossominghealth = 0;
	earthhealth = 0;
	recoverhealth = 0;
	rockhealth = 0;
  end
  
  if(friendly and (not isself)) then
    health = thealth
    buffs = tbuffs
  else
    health = phealth
    buffs = pbuffs
  end

--  combat = GetPlayerCombatState()
-- Below routine is no longer necessary, we do not need to reset last_action in current execution logic.
--  local tdead = UnitIsDeadOrGhost("target")
  if (tdead) then
       g_lastcast = ""
       PrintDebugMessage("Target is DEAD!");
  end
  
  if ((friendly) and (health <= earthhealth)) then
    CastSpellByName("Mother Earth's Protection");
  elseif ((friendly) and CD("Rock Protection") and (health <= rockhealth)) then
    CastSpellByName("Rock Protection");
  elseif ((not buffs["Blossoming Life"]) and (health <= blossominghealth)) then
    CastSpellByName("Blossoming Life");
  elseif (health <= recoverhealth) then
    CastSpellByName("Recover");
  elseif ((not friendly) and (useweakening == true) and CD("Weakening Seed")) then
    CastSpellByName("Weakening Seed");
  elseif ((not friendly) and (usewithering == true) and CD("Withering Seed")) then
    CastSpellByName("Withering Seed");
  elseif ((usewrath == true) and CD("Mother Nature's Wrath") and (not friendly)) then
    CastSpellByName("Mother Nature's Wrath");
  elseif ((userockslide == true) and CD("Rockslide") and (not friendly)) then
    CastSpellByName("Rockslide");
  elseif ((usebriar == true) and (not friendly) and BriarEntwinementCastableOnTarget(tdebuffs,11)) then
    CastSpellByName("Briar Entwinement");
  elseif ((usecorrosive == true) and (not friendly) and (penergy >= .3) and CorrosivePoisonCastableOnTarget(tdebuffs,11)) then
    CastSpellByName("Corrosive Poison");
  elseif ((usewidow == true) and (not friendly) and (penergy >= .3)) then
    CastSpellByName("Poisonous Widow Embrace");
  elseif ((useearthpulse == true) and CD("Earth Pulse") and (not friendly)) then
	  CastSpellByName("Earth Pulse");
  elseif ((useeartharrow == true) and (not friendly)) then
	  CastSpellByName("Earth Arrow");
  end
  
end

function NatureAttackDruidMage(useweakening, usewithering , blossominghealth, earthhealth, recoverhealth, rockhealth, userockslide, usefireball, usewrath, usebriar, useearthpulse, useeartharrow, donthealpvp)

  -- local spell = UnitCastingTime("player")  -- Spell being cast?
  -- if (spell ~= nil) then return end
   
  local friendly = (not UnitCanAttack("player","target"))
  local pbuffs = BuffList("player")
  local tbuffs= ActualBuffList("target")
  local tdebuffs = ActualDebuffList("target")
  local tspell,ttime,telapsed = UnitCastingTime("target")
  local penergy = PctS("player");
  local isself = UnitName("target") == UnitName("player");
  
  local phealth = PctH("player")
  local thealth = PctH("target")

  local buffs
  local health
  local isdead = UnitIsDeadOrGhost("target");

	if (isdead) then
		SendSystemMsg("Target Dead..");
		return;
	end
  
  local pmana = PctM("player")
  local naturepower = BuffCount("player", "Nature's Power")
  
  local isplayer = UnitIsPlayer("target");
  if(donthealpvp and isplayer and (not friendly)) then 
	-- blossominghealth = 0;
	earthhealth = 0;
	recoverhealth = 0;
	rockhealth = 0;
  end
  
  if(friendly and (not isself)) then
    health = thealth
    buffs = tbuffs
  else
    health = phealth
    buffs = pbuffs
  end

--  combat = GetPlayerCombatState()
-- Below routine is no longer necessary, we do not need to reset last_action in current execution logic.
--  local tdead = UnitIsDeadOrGhost("target")
  if (tdead) then
       g_lastcast = ""
       PrintDebugMessage("Target is DEAD!");
  end
  
  if (CD("Rock Protection") and (phealth <= rockhealth)) then
    CastSpellByName("Rock Protection");
  elseif ((not buffs["Blossoming Life"]) and (health <= blossominghealth)) then
    CastSpellByName("Blossoming Life");
  elseif ((friendly) and (health <= earthhealth) and (not buffs["Rock Protection"])) then
    CastSpellByName("Mother Earth's Protection");
  elseif (health <= recoverhealth) then
    CastSpellByName("Recover");
  elseif ((not friendly) and (useweakening == true) and CD("Weakening Seed")) then
    CastSpellByName("Weakening Seed");
  elseif ((not friendly) and (usewithering == true) and CD("Withering Seed")) then
    CastSpellByName("Withering Seed");
   elseif ((usefireball == true) and CD("Fireball") and (not friendly)) then
    CastSpellByName("Fireball");
  elseif ((usewrath == true) and CD("Mother Nature's Wrath") and (not friendly)) then
    CastSpellByName("Mother Nature's Wrath");
  elseif ((userockslide == true) and CD("Rockslide") and (not friendly)) then
    CastSpellByName("Rockslide");
  elseif ((usebriar == true) and (not friendly) and BriarEntwinementCastableOnTarget(tdebuffs,11)) then
    CastSpellByName("Briar Entwinement");
  elseif ((useearthpulse == true) and CD("Earth Pulse") and (not friendly)) then
	  CastSpellByName("Earth Pulse");
  elseif ((useeartharrow == true) and (not friendly)) then
	  CastSpellByName("Earth Arrow");
  end
  
end

function NatureBossDruidMage(useweakening, usewithering , selfblossominghealth, blossominghealth, earthhealth, recoverhealth, forcerecoverifbuffed, restorehealth, rockhealth, sendsystemmessage, doattack)
  local friendly = (not UnitCanAttack("player","target"))
  local isself = (UnitName("target") == UnitName("player"));
  local pbuffs = BuffList("player")
  local tbuffs= ActualBuffList("target")
  local tdebuffs = ActualDebuffList("target")
  local tspell,ttime,telapsed = UnitCastingTime("target")
  local penergy = PctS("player")
  local castdone = true
  local isdead = UnitIsDeadOrGhost("target");

	if (isdead) then
		SendSystemMsg("Target Dead..");
		return;
	end
	
  local phealth = PctH("player")
  local thealth = PctH("target")

  local buffs
  local health
  local recoverleft
  
  local pmana = PctM("player")
  local naturepower = BuffCount("player", "Nature's Power")
  local combatstate = GetPlayerCombatState()

  if(friendly and (not isself)) then
    health = thealth
    buffs = tbuffs
	recoverleft = BuffTimeLeft("target", "Recover")
  else
    health = phealth
    buffs = pbuffs
	recoverleft = BuffTimeLeft("player", "Recover")
  end

--  combat = GetPlayerCombatState()
-- Below routine is no longer necessary, we do not need to reset last_action in current execution logic.
--  local tdead = UnitIsDeadOrGhost("target")
  if (tdead) then
       g_lastcast = ""
       PrintDebugMessage("Target is DEAD!");
	   return
  end
  
  if((recoverhealth > 0) and (nil ~= recoverleft) and (recoverleft <= 2)) then forcerecoverifbuffed = true; end
  
  if ((phealth <= rockhealth) and CD("Rock Protection")) then
    CastSpellByName("Rock Protection");
  elseif ((not friendly) and (not pbuffs["Blossoming Life"]) and (phealth <= selfblossominghealth)) then
    CastSpellByName("Blossoming Life");
  elseif (friendly and (not isself) and (not buffs["Blossoming Life"]) and (health <= blossominghealth)) then
    CastSpellByName("Blossoming Life");
  elseif ((friendly) and (health <= earthhealth) and combatstate and CD("Mother Earth's Protection") and (not buffs["Rock Protection"])) then
    CastSpellByName("Mother Earth's Protection");
  elseif (friendly and (health <= recoverhealth) and (not buffs["Recover"]) ) then
	CastSpellByName("Recover");
  elseif ((friendly) and (health <= recoverhealth) and forcerecoverifbuffed) then
	CastSpellByName("Recover");
  elseif ((friendly) and (health <= restorehealth)) then
	CastSpellByName("Restore Life");
  elseif ((not friendly) and (useweakening == true) and CD("Weakening Seed")) then
    CastSpellByName("Weakening Seed");
  elseif ((not friendly) and (usewithering == true) and CD("Withering Seed")) then
    CastSpellByName("Withering Seed");
  elseif ((not friendly) and (not doattack) and CD("Weakening Seed") and CD("Withering Seed")) then
    SendSystemMsg("SEEDS COOLING DOWN!");
	castdone = false;
  elseif (friendly) then
    if((sendsystemmessage ~= nil) and (sendsystemmessage == true)) then SendSystemMsg("PLAYER FULLY HEALED"); end
	castdone = false;
  elseif (doattack) then

  	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Warden") then
		NatureAttackDruidMage(false, false, 0,0,0,0,true, false, true, false, false, true);
	elseif(secondclass == "Mage") then
		NatureAttackDruidMage(false, false, 0,0,0,0,false, true, true, false, false, true);
	end
  end
  return castdone;
end


function PrintPartyInfo(criticalhealth)
	-- local healthtable, tankpartyid, istankdead, tankhealthpct, isallblossommed, istankblossomed, istankrecovered, istankcritical, isselfcritical, iscriticalinparty = GetPartyInfo(criticalhealth)
	local healthtable = GetPartyHealthInfo()
			Msg("================== PARTY INFO ================");
			for k=1, GetNumPartyMembers() do
				if(nil ~= healthtable[k]) then
					local unitpointer = "";
					if(healthtable[k].id == 0) then unitpointer = "player"; else unitpointer = "party"..healthtable[k].id; end
					Msg("NO:"..k..UnitName(unitpointer).." <-> %".. healthtable[k].health);
				else
					Msg("NO:"..k.."IS NULL");
				end
			end
			Msg("==============================================");
end

function GetPartyInfo(criticalhealth)
   local healthtable = {}
   local pbuffs = BuffList("player")
   local selfhealthpct = PctH("player")
   local tankhealthpct = 0
   local tankpartyid = 0
   local selfpartyid = 0
   local isallblossomed = true
   local istankblossomed = false;
   local istankrecovered = false;
   local istankcritical = false
   local isselfcritical = false
   local iscriticalinparty = false
   local istankdead = false
   
   if(selfhealthpct <= criticalhealth) then isselfcritical = true; end
  
   for num=1,GetNumPartyMembers()-1 do
       local trgt = "party"..num
       -- TargetUnit(trgt)
	   -- local tbuffs= ActualBuffList("target")
	   -- local thealth = PctH("target")
       local tbuffs= ActualBuffList(trgt)
	   local thealth = PctH(trgt)
	  
	   if(not tbuffs["Blossoming Life"]) then isallblossomed = false; end
	   if(thealth <= criticalhealth) then iscriticalinparty = true; end
	   
	   if(UnitName(trgt) == g_tank) then 
			tankpartyid = num;
			tankhealthpct = thealth;
			if(tankhealthpct <= criticalhealth) then istankcritical = true; end
			-- if(tbuffs["Blossoming Life"]) then istankblossomed = true end
			if(not BlossomingCastableOnTarget(12,g_tank,tbuffs)) then istankblossomed = true end
			-- if(BuffTimeLeft(trgt, "Recover") > 2) then istankrecovered = true end
			-- if(tbuffs["Recover"] and tbuffs["Recover"].time > 2) then istankrecovered = true end
			if(not RecoverCastableOnTarget(tbuffs,g_tank,10)) then istankrecovered = true end
			
			if (UnitIsDeadOrGhost(trgt)) then istankdead = true; end
		end
		
		for k=1, GetNumPartyMembers()-1 do

			if(nil == healthtable[k]) then
				healthtable[k] = { ["id"] = num, ["health"] = thealth}
				break
			else
				local hel = healthtable[k].health;
				local id = healthtable[k].id;
				if(hel > thealth) then
					table.insert(healthtable,k,{ ["id"] = num, ["health"] = thealth });
					-- now move the rest of the table 1 up, and insert the new record here
					-- for j=GetNumPartyMembers()-1, k do
					-- 	healthtable[j] = healthtable[j-1];
					-- end
					-- now set the current record into the current location
					-- healthtable[k] = { ["id"] = num, ["health"] = thealth };
					break
				end
			end
		end
		
   end

   return healthtable, tankpartyid, istankdead, tankhealthpct, isallblossommed, istankblossomed, istankrecovered, istankcritical, isselfcritical, iscriticalinparty;
end

function GetPartyHealthInfo()
   local healthtable = {}
   local selfhealthpct = PctH("player")
   
   -- healthtable[1] = { ["id"] = 0, ["health"] = selfhealthpct}
   table.insert(healthtable,1,{ ["id"] = 0, ["health"] = selfhealthpct });
   
   for num=1,GetNumPartyMembers()-1 do
       local trgt = "party"..num
       local thealth = PctH(trgt)
	  
		for k=1, GetNumPartyMembers()-1 do
			local hel = healthtable[k].health;
			local id = healthtable[k].id;
			if(hel > thealth) then
				table.insert(healthtable,k,{ ["id"] = num, ["health"] = thealth });
				break
			elseif (hel == thealth) then
				table.insert(healthtable,k+1,{ ["id"] = num, ["health"] = thealth });
				break
			elseif (hel < thealth) then
				for o=k, GetNumPartyMembers() do
					if(nil == healthtable[o+1]) then
						table.insert(healthtable,o+1,{ ["id"] = num, ["health"] = thealth });
						break;
					elseif(thealth >= healthtable[o].health and thealth <= healthtable[o+1].health) then
						table.insert(healthtable,o+1,{ ["id"] = num, ["health"] = thealth });
						break;
					end
				end
				break;
			end
		end
		
	end

   return healthtable;
end

function SetTank()
	if(UnitInParty("target") or UnitInRaid("target") or (UnitName("target") == UnitName("player")) and g_tank ~= UnitName("target")) then
		g_tank = UnitName("target")
		Msg("Tank is set to : "..g_tank)
	else 
		g_tank = ""
		Msg("Error tank is not set!")
	end
end
-- /run PartyHeal(2,1,.4,1,false,.8,.4,false);

function DruidTimedHeal(targetableSkillSlot, useSpring, useyasaminruhu, blossominghealth)
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
   
		if(useSpring and CD("Mother Earth's Fountain")) then
			-- if(UnitIsPlayer("target") and friendly) then TargetUnit("player"); end;
			CastSpellByName("Mother Earth's Fountain");
			return;
		elseif(useyasaminruhu and CD("Yaşamın Ruhu")) then
			CastSpellByName("Yaşamın Ruhu");
			return;
		end;
		
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
					if((thealth <= blossominghealth) and (thealth > 0) and (BlossomingCastableOnTarget(12, UnitName("target"), tbuffs))) then 
						CastSpellByName("Blossoming Life");
						return;
					end;
				elseif ((id == 0) and (phealth < blossominghealth) and not pbuffs["Blossoming Life"]) then
					CastSpellByName("Blossoming Life");
					return;
				end
			end
		end

end

-- /run SelfHeal(true,1,false,.8,.3,true, true);
function DruidSelfHeal(useblossoming, recoverhealth, forcerecoverifbuffed, restorehealth, rockhealth, crystalCandySlot, crystalCandyPercent, phirusSlot, phirusPercent, earthhealth, glovedebuflist, gloveslot, sendsystemmessage)
  
  local spell = UnitCastingTime("player")  -- Spell being cast?
  
  if (spell ~= nil) then return; end
  
  -- local isplayer = UnitIsPlayer("target");
  
  local friendly = (not UnitCanAttack("player","target"));
  local isself = UnitName("target") == UnitName("player");
  
  local Skill = {}
  local i = 0
  local pbuffs = BuffList("player")
  local pdebuffs = ActualDebuffList("player")
  
  local useGlove = false
  local itemgloveslot = gloveslot + 10;
  local useCandy = false
  local usePhirus = false
  local useGlove = false
  local gl, glcd = GetActionCooldown(gloveslot);
  
  if( (glovedebuflist ~= nil) and (gloveslot > 0)) then
	useGlove = HasBuffsFromList(pdebuffs, glovedebuflist)
  end
  
  local isMage = (((UnitClass("target") == "Mage") or (UnitClass("target") == "Priest") or (UnitClass("target") == "Druid")) and (not (UnitName("target") == UnitName("player"))))
  
  
  if ( (crystalCandySlot > 0) and isMage) then
	crystalCandySlot = crystalCandySlot + 1;
  end
  
  if( crystalCandySlot > 0 ) then
	useCandy = true;
  end
  
  if( phirusSlot > 0 ) then
	usePhirus = true;
  end
  
  local cc, cccd = GetActionCooldown(crystalCandySlot);
  local ph, phcd = GetActionCooldown(phirusSlot);
  
  -- local cameliacount = BuffCount("player",  "Camellia Flower")
  local phealth = PctH("player")
  local recoverleft = BuffTimeLeft("player", "Recover")
  local selfhealed = true;
  local combatstate = GetPlayerCombatState();
  
  if ((nil ~= recoverleft) and (recoverleft <= 2.0)) then forcerecoverifbuffed = true; end

  -- if ((usecamelia == true) and (cameliacount < 1)) then
	-- 	CastSpellByName("Camellia Flower", 1);
	if ((useGlove == true) and GetActionUsable(gloveslot) and (glcd == 0)) then
		UseAction(gloveslot);
	elseif((phealth <= rockhealth) and combatstate and CD("Rock Protection")) then
		CastSpellByName("Rock Protection");
	elseif((useCandy == true) and combatstate and (phealth <= crystalCandyPercent) and GetPotUsable(crystalCandySlot) and (cccd == 0)) then
		UseAction(crystalCandySlot);
	elseif((usePhirus == true) and (phealth <= phirusPercent) and GetPotUsable(phirusSlot) and (phcd == 0)) then
		UseAction(phirusSlot);
	elseif ((phealth <= earthhealth) and combatstate  and CD("Mother Earth's Protection") and (not pbuffs["Rock Protection"]) and (not pbuffs["Gökkuşağı Kristal Şekeri"]) and (not pbuffs["Forestsong Soft Cake"]) and (not pbuffs["Serenstum"])) then
		CastSpellByName("Mother Earth's Protection");
	elseif ((useblossoming == true) and (not pbuffs["Blossoming Life"])) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Blossoming Life");
	elseif ((phealth <= recoverhealth) and not pbuffs["Recover"]) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Recover");
	elseif ((phealth <= recoverhealth) and forcerecoverifbuffed) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Recover");
	elseif (phealth <= restorehealth) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Restore Life");
	-- elseif (cameliacount < 3) then
	-- 	CastSpellByName("Camellia Flower", 1);
	elseif (gloveslot > 0) then
		UseAction(itemgloveslot);
		PlaySoundByPath("interface/AddOns/KurbishFunctions/sounds/WindowsError.wav")
    else
		selfhealed = false;
		if((sendsystemmessage ~= nil) and (sendsystemmessage == true)) then SendSystemMsg("SELF FULLY HEALED"); end
	end
	
	return selfhealed;
end

function BuffAllDruid(useconcentration, useblessing, usemagicturmoil, usesavage, usefireward)
  local pbuffs = BuffList("player")
  local isself = UnitName("target") == UnitName("player");
  local friendly = (not UnitCanAttack("player","target"))
  
  if (useconcentration and (not pbuffs["Concentration Prayer"] or pbuffs["Concentration Prayer"].time < 300)) then
    CastSpellByName("Concentration Prayer");
  elseif (useblessing and (not pbuffs["Mother Earth's Blessing"])) then
    CastSpellByName("Mother Earth's Blessing");
  elseif (usemagicturmoil and (not pbuffs["Magic Turmoil"])) then
    CastSpellByName("Magic Turmoil");
  elseif (usesavage and (not pbuffs["Savage Blessing"] or pbuffs["Savage Blessing"].time < 600)) then
	if((not isself) and friendly) then TargetUnit("player"); end
    CastSpellByName("Savage Blessing");
  elseif (usefireward and (not pbuffs["Fire Ward"] or pbuffs["Fire Ward"].time < 300)) then
    CastSpellByName("Fire Ward");
  end
  
end

function BuffAllDruidWarden(usebriarshield, useconcentration, usemysteriousgrace, usegraceofforest, usesavage)
  local pbuffs = BuffList("player")
  local isself = UnitName("target") == UnitName("player");
  local friendly = (not UnitCanAttack("player","target"))
  
  if(usebriarshield and (not pbuffs["Briar Shield"] or pbuffs["Briar Shield"].time < 600)) then
	if((not isself) and friendly) then TargetUnit("player"); end
	CastSpellByName("Briar Shield");
  elseif (useconcentration and (not pbuffs["Concentration Prayer"] or pbuffs["Concentration Prayer"].time < 300)) then
    CastSpellByName("Concentration Prayer");
  elseif (usemysteriousgrace and (not pbuffs["Mysterious Grace"] or pbuffs["Mysterious Grace"].time < 600)) then
    CastSpellByName("Mysterious Grace");
  elseif (usegraceofforest and (not pbuffs["Grace of the Forest "]  or pbuffs["Grace of the Forest "].time < 600)) then
    CastSpellByName("Grace of the Forest ");
  elseif (usesavage and (not pbuffs["Savage Blessing"] or pbuffs["Savage Blessing"].time < 600)) then
	if((not isself) and friendly) then TargetUnit("player"); end
    CastSpellByName("Savage Blessing");
  elseif(CD("Briar Shield")) then
		SendSystemMsg("Bütün Bufflar Atıldı!!!");
  end
end

function BreakSkillDruidScout(usebinding, usethroat)
  local friendly = (not UnitCanAttack("player","target"))
  
  if((usebinding == true) and (not friendly) and CD("Binding Silence")) then
	CastSpellByName("Binding Silence");
  elseif (( usethroat == true) and (not friendly)) then
	CastSpellByName("Boğaz Saldırısı");
  end
  
end

function BreakSkillDruidRogue(usebinding, useblind)
  local friendly = (not UnitCanAttack("player","target"))
  
  if((usebinding == true) and (not friendly) and CD("Binding Silence")) then
	CastSpellByName("Binding Silence");
  elseif (( useblind == true) and (not friendly)) then
	CastSpellByName("Blind Stab");
  end
  
end

function BreakSkillDruidMage(usehumanrules, uselightning, usesilence, usebinding, usesilencefirst, warntbufflist, castifwarning, lightningmessage)
	
	local isplayer = UnitIsPlayer("target");
	local targetclass = UnitClass("target");
	if(usehumanrules and isplayer) then
		if((targetclass == "Mage") or (targetclass == "Priest") or (targetclass == "Druid")) then 
			usesilence = true;
			usesilencefirst = true;
		elseif (targetclass == "Düzenbaz") then
			usesilence = true;
			usesilencefirst = false;
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
	elseif (usesilence and castable and CD("Silence") and (not usesilencefirst)) then 
		CastSpellByName("Silence");
	elseif (usebinding and castable and CD("Binding Silence")) then 
		CastSpellByName("Binding Silence");
	elseif (usehumanrules and castable and CD("Earth Arrow")) then
		CastSpellByName("Earth Arrow");
	end
	
end

function BriarEntwinementCastableOnTarget(tbuffs, briartimeout)
  -- This function may fail to return proper value if the player moves while casting ElectricBolt and the target has Electric Flow Debuff cast by another player.
  -- First check if target does not have electric flow debuff
  
  local secselapsed = 0
  local castresult = false;
  local targetguid = UnitGUID("target");

	secselapsed = os.time() - g_lastBriarEntwinement.LastCast
	-- PrintDebugMessage("Seconds elapsed since Electric Bolt: " .. secselapsed )

	if(targetguid == g_lastBriarEntwinement.TargetGUID and (secselapsed < 1)) then
		castresult = false;
	elseif((not tbuffs["Briar Entwinement"]) and (secselapsed > 1)) then
		castresult = true;
	elseif((g_lastBriarEntwinement.TargetGUID == targetguid) and (secselapsed >= briartimeout)) then
		castresult = true;
	end
  return castresult;
end

function CorrosivePoisonCastableOnTarget(tbuffs, corrosivetimeout)
  -- This function may fail to return proper value if the player moves while casting ElectricBolt and the target has Electric Flow Debuff cast by another player.
  -- First check if target does not have electric flow debuff
  
  local secselapsed = 0
  local castresult = false;
  local targetguid = UnitGUID("target");

  secselapsed = os.time() - g_lastCorrosivePoison.LastCast

	if(targetguid == g_lastCorrosivePoison.TargetGUID and (secselapsed < 1)) then
		castresult = false;
	elseif((not tbuffs["Corrosive Poison"]) and (secselapsed > 1)) then
		castresult = true;
	elseif((g_lastCorrosivePoison.TargetGUID == targetguid) and (secselapsed >= corrosivetimeout)) then
		castresult = true;
	end
	
  return castresult;
end

function BlossomingCastableOnTarget(blossomingTimeOut, targetname, tbuffs)
  -- This function may fail to return proper value if the player moves while casting ElectricBolt and the target has Electric Flow Debuff cast by another player.
  -- First check if target does nrot have electric flow debuff

  local secselapsed = 0
  local castresult = true;
  if(nil ~= g_blossomingTable[targetname]) then
	secselapsed = os.time() - g_blossomingTable[targetname];
  else
	secelapsed = 999;
  end
  
  if(targetname == g_lastBlossoming.TargetName and (secselapsed < 1)) then
	castresult = false;
  elseif (not tbuffs["Blossoming Life"] and (secselapsed > 1)) then
	castresult = true;
  elseif ((g_blossomingTable ~= nil) and (nil ~= g_blossomingTable[targetname]) and ((os.time() - g_blossomingTable[targetname]) < blossomingTimeOut)) then
	PrintDebugMessage("Blossoming Sec Elapsed : " .. (os.time() - g_blossomingTable[targetname]) )
		castresult = false;
  end
  return castresult;
end

function RecoverCastableOnTarget(recovertimeout, targetname, tbuffs)
  -- This function may fail to return proper value if the player moves while casting ElectricBolt and the target has Electric Flow Debuff cast by another player.
  -- First check if target does nrot have electric flow debuff

  local secselapsed = 0
  local castresult = true;
  secselapsed = os.time() - g_lastRecover.LastCast
  
  if(targetname == g_lastRecover.TargetName and (secselapsed < 1)) then
	castresult = false;
  elseif ((g_RecoverTable ~= nil) and (nil ~= g_RecoverTable[targetname]) and ((os.time() - g_RecoverTable[targetname]) < recovertimeout) ) then
	PrintDebugMessage("Recover Sec Elapsed : " .. (os.time() - g_RecoverTable[targetname]) )
		castresult = false;
  end
  return castresult;
end

function LookAroundAndAttackDruid(attackslot, attackfirst, turnaround, blossomingpct, recoverpct, manapct, manaslot, manabuffname)
	local phealth = PctH("player")
	local thealth = PctH("target")
	local penergy = PctS("player")
	local pmana = PctM("player")
	local pbuffs = BuffList("player")

	-- First check if we currently have a target
	local tgt=UnitClass("target"); 
	local friendly = (not UnitCanAttack("player","target"))
	local isdead = UnitIsDeadOrGhost("target")

	if((manaslot > 0) and ((pmana < manapct) or (penergy < manapct)) and (not pbuffs[manabuffname])) then
		UseAction(manaslot);
	elseif((blossomingpct > 0) and (phealth < blossomingpct) and (not pbuffs["Blossoming Life"])) then
		CastSpellByName("Blossoming Life");
	elseif((recoverpct > 0) and (phealth < recoverpct) and (not pbuffs["Recover"])) then
		CastSpellByName("Recover");
	elseif((nil == tgt) or friendly) then
		if(turnaround) then TurnLeftStart(); end
		TargetNearestEnemy();
	elseif ((nil ~= tgt) and isdead) then
		if(turnaround) then TurnLeftStop(); end
		UseAction(attackslot);
	else
		if(turnaround) then TurnLeftStop(); end
		if(attackfirst and (thealth == 1.0)) then
			UseAction(attackslot);
		else
			NatureAttackDruidRogue(false, false, blossomingpct,.4,recoverpct,.3,true, true, true, true, false, false, true);
		end
	end
end

function BossAttackDruidMain(useseeds)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Warden") then
		NatureBossDruidMage(useseeds,useseeds,.95,1.9,.4,1.1, false, 1.8,.2,true,true);
	elseif(secondclass == "Mage") then
	NatureBossDruidMage(useseeds, useseeds , .9, .9, 0, .5, false, 1.8, 0, true, true);
		--NatureBossDruidMage(useseeds,useseeds,.95,1.9,.4,1.1, false, 1.8,.2,true,true);
	end
	
end

function BossAttackDruidMainDps()
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Warden") then
		NatureAttackDruidMage(false, false , .99, 0, .5, 0, true, false, true, true, false, true, true)
		--NatureAttackDruidMage(false, false, .99,.4,.5,.3,false, false, true, true, false, true,true);
	elseif(secondclass == "Mage") then
		NatureAttackDruidMage(false, false , .99, 0, .5, 0, false, true, false, true, false, true, true);
		--NatureAttackDruidMage(false, false, .99,.4,.5,.3,false, true, true, true, false, true,true);
	end
end

function BuffAllDruidMain(buffplus)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Warden") then
		if(not buffplus) then
			BuffAllDruidWarden(true, true, true, false, true)
			--BuffAllDruidWarden(true, true,true,true,true);
		 else
		    BuffAllDruidWarden(true, true, true, false, true)
			--BuffAllDruidWarden(true, true,true,true,true);
		 end
	elseif(secondclass == "Mage") then
		if(not buffplus) then
			BuffAllDruid(true, false, false, true, false);
			--BuffAllDruid(true,false,false,true,true);
		else
			BuffAllDruid(true, false, false, true, false);
			--BuffAllDruid(true,false,false,true,true);
		end
	end
end

function BreakSkillDruidMain(warnlist)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Warden") then
		BreakSkillDruidMage(false, false, false, true, false, warnlist, false, '');
	elseif(secondclass == "Mage") then
		BreakSkillDruidMage(true, true, true, true, false, warnlist, false, '')
		-- BreakSkillDruidMage(true, true, true, true, false, warnlist, false, '');
	end
end

function DruidMainTimedHeal(targetableSkillSlot,useyasam, blossominghealth)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Warden") then
		DruidTimedHeal(targetableSkillSlot, false, useyasam, blossominghealth)
	elseif(secondclass == "Mage") then
		DruidTimedHeal(targetableSkillSlot, true, false, blossominghealth)
	end
end