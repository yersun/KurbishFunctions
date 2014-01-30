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
      CastSpellByName("İyileştirme");
  elseif (health <= earthhealth) then
    CastSpellByName("Toprak Ananın Koruması");
  elseif ((friendly) and (phealth <= rockhealth)) then
    CastSpellByName("Kaya Koruması");
  elseif ((not buffs["Çiçek Açan Hayat"]) and (health <= blossominghealth)) then
    CastSpellByName("Çiçek Açan Hayat");
  elseif (health <= recoverhealth) then
    CastSpellByName("İyileştirme");
  elseif ((health <= cameliahealth2) and (cameliacount < 2)) then
    CastSpellByName("Camellia Flower");
  elseif ((health <= cameliahealth3) and (cameliacount < 3) ) then
    CastSpellByName("Camellia Flower");
  elseif ((not friendly) and (isshift == true) and (naturepower >= 2) and (not tdebuffs["Zayıflatıcı Tohum"])) then
    CastSpellByName("Zayıflatıcı Tohum");
  elseif ((not friendly) and (isshift == true) and (naturepower >= 2) and (not tdebuffs["Solan Tohum"])) then
    CastSpellByName("Solan Tohum");
  elseif ((userockslide == true) and CD("Heyelan") and (not friendly)) then
    CastSpellByName("Heyelan");
  elseif ((usebriar == true) and (not friendly) and (not tdebuffs["Sarılı Dikenli Çalı"])) then
    CastSpellByName("Sarılı Dikenli Çalı");
  elseif ((usevampirearrow == true) and (not friendly) and (not tdebuffs["VampireArrows"])) then
      CastSpellByName("Vampire Arrows");
  elseif ((usefireball == true) and CD("Ateş Topu") and (not friendly)) then
      CastSpellByName("Ateş Topu");
  elseif ((useearthpulse == true) and CD("Toprağın Nabzı") and (not friendly)) then
	  CastSpellByName("Toprağın Nabzı");
  elseif ((useeartharrow == true) and (not friendly)) then
	  CastSpellByName("Toprak Oku");
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
    CastSpellByName("Toprak Ananın Koruması");
  elseif ((friendly) and CD("Kaya Koruması") and (health <= rockhealth)) then
    CastSpellByName("Kaya Koruması");
  elseif ((not buffs["Çiçek Açan Hayat"]) and (health <= blossominghealth)) then
    CastSpellByName("Çiçek Açan Hayat");
  elseif (health <= recoverhealth) then
    CastSpellByName("İyileştirme");
  elseif ((not friendly) and (useweakening == true) and CD("Zayıflatıcı Tohum")) then
    CastSpellByName("Zayıflatıcı Tohum");
  elseif ((not friendly) and (usewithering == true) and CD("Solan Tohum")) then
    CastSpellByName("Solan Tohum");
  elseif ((usewrath == true) and CD("Tabiat Ana'nın Gazabı") and (not friendly)) then
    CastSpellByName("Tabiat Ana'nın Gazabı");
  elseif ((userockslide == true) and CD("Heyelan") and (not friendly)) then
    CastSpellByName("Heyelan");
  elseif ((usebriar == true) and (not friendly) and BriarEntwinementCastableOnTarget(tdebuffs,11)) then
    CastSpellByName("Sarılı Dikenli Çalı");
  elseif ((usecorrosive == true) and (not friendly) and (penergy >= .3) and CorrosivePoisonCastableOnTarget(tdebuffs,11)) then
    CastSpellByName("Corrosive Poison");
  elseif ((usewidow == true) and (not friendly) and (penergy >= .3)) then
    CastSpellByName("Poisonous Widow Embrace");
  elseif ((useearthpulse == true) and CD("Toprağın Nabzı") and (not friendly)) then
	  CastSpellByName("Toprağın Nabzı");
  elseif ((useeartharrow == true) and (not friendly)) then
	  CastSpellByName("Toprak Oku");
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
		SendSystemMsg("Hedef Ölü..");
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
  
  if (CD("Kaya Koruması") and (phealth <= rockhealth)) then
    CastSpellByName("Kaya Koruması");
  elseif ((not buffs["Çiçek Açan Hayat"]) and (health <= blossominghealth)) then
    CastSpellByName("Çiçek Açan Hayat");
  elseif ((friendly) and (health <= earthhealth) and (not buffs["Kaya Koruması"])) then
    CastSpellByName("Toprak Ananın Koruması");
  elseif (health <= recoverhealth) then
    CastSpellByName("İyileştirme");
  elseif ((not friendly) and (useweakening == true) and CD("Zayıflatıcı Tohum")) then
    CastSpellByName("Zayıflatıcı Tohum");
  elseif ((not friendly) and (usewithering == true) and CD("Solan Tohum")) then
    CastSpellByName("Solan Tohum");
   elseif ((usefireball == true) and CD("Ateş Topu") and (not friendly)) then
    CastSpellByName("Ateş Topu");
  elseif ((usewrath == true) and CD("Tabiat Ana'nın Gazabı") and (not friendly)) then
    CastSpellByName("Tabiat Ana'nın Gazabı");
  elseif ((userockslide == true) and CD("Heyelan") and (not friendly)) then
    CastSpellByName("Heyelan");
  elseif ((usebriar == true) and (not friendly) and BriarEntwinementCastableOnTarget(tdebuffs,11)) then
    CastSpellByName("Sarılı Dikenli Çalı");
  elseif ((useearthpulse == true) and CD("Toprağın Nabzı") and (not friendly)) then
	  CastSpellByName("Toprağın Nabzı");
  elseif ((useeartharrow == true) and (not friendly)) then
	  CastSpellByName("Toprak Oku");
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
		SendSystemMsg("Hedef Ölü..");
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
	recoverleft = BuffTimeLeft("target", "İyileştirme")
  else
    health = phealth
    buffs = pbuffs
	recoverleft = BuffTimeLeft("player", "İyileştirme")
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
  
  if ((phealth <= rockhealth) and CD("Kaya Koruması")) then
    CastSpellByName("Kaya Koruması");
  elseif ((not friendly) and (not pbuffs["Çiçek Açan Hayat"]) and (phealth <= selfblossominghealth)) then
    CastSpellByName("Çiçek Açan Hayat");
  elseif (friendly and (not isself) and (not buffs["Çiçek Açan Hayat"]) and (health <= blossominghealth)) then
    CastSpellByName("Çiçek Açan Hayat");
  elseif ((friendly) and (health <= earthhealth) and combatstate and CD("Toprak Ananın Koruması") and (not buffs["Kaya Koruması"])) then
    CastSpellByName("Toprak Ananın Koruması");
  elseif (friendly and (health <= recoverhealth) and (not buffs["İyileştirme"]) ) then
	CastSpellByName("İyileştirme");
  elseif ((friendly) and (health <= recoverhealth) and forcerecoverifbuffed) then
	CastSpellByName("İyileştirme");
  elseif ((friendly) and (health <= restorehealth)) then
	CastSpellByName("Yaşam Desteği");
  elseif ((not friendly) and (useweakening == true) and CD("Zayıflatıcı Tohum")) then
    CastSpellByName("Zayıflatıcı Tohum");
  elseif ((not friendly) and (usewithering == true) and CD("Solan Tohum")) then
    CastSpellByName("Solan Tohum");
  elseif ((not friendly) and (not doattack) and CD("Zayıflatıcı Tohum") and CD("Solan Tohum")) then
    SendSystemMsg("SEEDS COOLING DOWN!");
	castdone = false;
  elseif (friendly) then
    if((sendsystemmessage ~= nil) and (sendsystemmessage == true)) then SendSystemMsg("PLAYER FULLY HEALED"); end
	castdone = false;
  elseif (doattack) then

  	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Gardiyan") then
		NatureAttackDruidMage(false, false, 0,0,0,0,true, false, true, false, false, true);
	elseif(secondclass == "Büyücü") then
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
	  
	   if(not tbuffs["Çiçek Açan Hayat"]) then isallblossomed = false; end
	   if(thealth <= criticalhealth) then iscriticalinparty = true; end
	   
	   if(UnitName(trgt) == g_tank) then 
			tankpartyid = num;
			tankhealthpct = thealth;
			if(tankhealthpct <= criticalhealth) then istankcritical = true; end
			-- if(tbuffs["Çiçek Açan Hayat"]) then istankblossomed = true end
			if(not BlossomingCastableOnTarget(12,g_tank,tbuffs)) then istankblossomed = true end
			-- if(BuffTimeLeft(trgt, "İyileştirme") > 2) then istankrecovered = true end
			-- if(tbuffs["İyileştirme"] and tbuffs["İyileştirme"].time > 2) then istankrecovered = true end
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
   
		if(useSpring and CD("Kutsama Pınarı")) then
			-- if(UnitIsPlayer("target") and friendly) then TargetUnit("player"); end;
			CastSpellByName("Kutsama Pınarı");
			return;
		elseif(useyasaminruhu and CD("Yaşamın Ruhu")) then
			CastSpellByName("Yaşamın Ruhu");
			return;
		end;
		
	   local healthtable = GetPartyHealthInfo();
	   local unitisdead = false;
	   
	   -- Do Çiçek Açan Hayat For Party Next
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
					-- if((thealth <= blossominghealth) and (not tbuffs["Çiçek Açan Hayat"])) then
					if((thealth <= blossominghealth) and (thealth > 0) and (BlossomingCastableOnTarget(12, UnitName("target"), tbuffs))) then 
						CastSpellByName("Çiçek Açan Hayat");
						return;
					end;
				elseif ((id == 0) and (phealth < blossominghealth) and not pbuffs["Çiçek Açan Hayat"]) then
					CastSpellByName("Çiçek Açan Hayat");
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
  
  local isMage = (((UnitClass("target") == "Büyücü") or (UnitClass("target") == "Rahip") or (UnitClass("target") == "Doğa Alimi")) and (not (UnitName("target") == UnitName("player"))))
  
  
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
  local recoverleft = BuffTimeLeft("player", "İyileştirme")
  local selfhealed = true;
  local combatstate = GetPlayerCombatState();
  
  if ((nil ~= recoverleft) and (recoverleft <= 2.0)) then forcerecoverifbuffed = true; end

  -- if ((usecamelia == true) and (cameliacount < 1)) then
	-- 	CastSpellByName("Camellia Flower", 1);
	if ((useGlove == true) and GetActionUsable(gloveslot) and (glcd == 0)) then
		UseAction(gloveslot);
	elseif((phealth <= rockhealth) and combatstate and CD("Kaya Koruması")) then
		CastSpellByName("Kaya Koruması");
	elseif((useCandy == true) and combatstate and (phealth <= crystalCandyPercent) and GetPotUsable(crystalCandySlot) and (cccd == 0)) then
		UseAction(crystalCandySlot);
	elseif((usePhirus == true) and (phealth <= phirusPercent) and GetPotUsable(phirusSlot) and (phcd == 0)) then
		UseAction(phirusSlot);
	elseif ((phealth <= earthhealth) and combatstate  and CD("Toprak Ananın Koruması") and (not pbuffs["Kaya Koruması"]) and (not pbuffs["Gökkuşağı Kristal Şekeri"]) and (not pbuffs["Yumuşak Ormanşarkısı Pastası"]) and (not pbuffs["Serenstum"])) then
		CastSpellByName("Toprak Ananın Koruması");
	elseif ((useblossoming == true) and (not pbuffs["Çiçek Açan Hayat"])) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Çiçek Açan Hayat");
	elseif ((phealth <= recoverhealth) and not pbuffs["İyileştirme"]) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("İyileştirme");
	elseif ((phealth <= recoverhealth) and forcerecoverifbuffed) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("İyileştirme");
	elseif (phealth <= restorehealth) then
		if (friendly and (not isself)) then TargetUnit("player") end;
		CastSpellByName("Yaşam Desteği");
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
  
  if (useconcentration and (not pbuffs["Konsantrasyon Duası"] or pbuffs["Konsantrasyon Duası"].time < 300)) then
    CastSpellByName("Konsantrasyon Duası");
  elseif (useblessing and (not pbuffs["Mother Earth's Blessing"])) then
    CastSpellByName("Mother Earth's Blessing");
  elseif (usemagicturmoil and (not pbuffs["Magic Turmoil"])) then
    CastSpellByName("Magic Turmoil");
  elseif (usesavage and (not pbuffs["Yabani Kutsama"] or pbuffs["Yabani Kutsama"].time < 600)) then
	if((not isself) and friendly) then TargetUnit("player"); end
    CastSpellByName("Vahşi Kutsama");
  elseif (usefireward and (not pbuffs["Ateş Koruması"] or pbuffs["Ateş Koruması"].time < 300)) then
    CastSpellByName("Ateş Koruması");
  end
  
end

function BuffAllDruidWarden(usedikenli, useconcentration, usegizlizarafet, useormaninzerafeti, usesavage)
  local pbuffs = BuffList("player")
  local isself = UnitName("target") == UnitName("player");
  local friendly = (not UnitCanAttack("player","target"))
  
  if(usedikenli and (not pbuffs["Dikenli Kalkan"] or pbuffs["Dikenli Kalkan"].time < 600)) then
	if((not isself) and friendly) then TargetUnit("player"); end
	CastSpellByName("Dikenli Kalkan");
  elseif (useconcentration and (not pbuffs["Konsantrasyon Duası"] or pbuffs["Konsantrasyon Duası"].time < 300)) then
    CastSpellByName("Konsantrasyon Duası");
  elseif (usegizlizarafet and (not pbuffs["Gizemli Zarafet"] or pbuffs["Gizemli Zarafet"].time < 600)) then
    CastSpellByName("Gizli Zarafet");
  elseif (useormaninzerafeti and (not pbuffs["Ormanın Zerafeti"]  or pbuffs["Ormanın Zerafeti"].time < 600)) then
    CastSpellByName("Ormanın Zerafeti");
  elseif (usesavage and (not pbuffs["Yabani Kutsama"] or pbuffs["Yabani Kutsama"].time < 600)) then
	if((not isself) and friendly) then TargetUnit("player"); end
    CastSpellByName("Vahşi Kutsama");
  elseif(CD("Dikenli Kalkan")) then
		SendSystemMsg("Bütün Bufflar Atıldı!!!");
  end
end

function BreakSkillDruidScout(usebinding, usethroat)
  local friendly = (not UnitCanAttack("player","target"))
  
  if((usebinding == true) and (not friendly) and CD("Zorunlu Sessizlik")) then
	CastSpellByName("Zorunlu Sessizlik");
  elseif (( usethroat == true) and (not friendly)) then
	CastSpellByName("Boğaz Saldırısı");
  end
  
end

function BreakSkillDruidRogue(usebinding, useblind)
  local friendly = (not UnitCanAttack("player","target"))
  
  if((usebinding == true) and (not friendly) and CD("Zorunlu Sessizlik")) then
	CastSpellByName("Zorunlu Sessizlik");
  elseif (( useblind == true) and (not friendly)) then
	CastSpellByName("Blind Stab");
  end
  
end

function BreakSkillDruidMage(usehumanrules, uselightning, usesilence, usebinding, usesilencefirst, warntbufflist, castifwarning, lightningmessage)
	
	local isplayer = UnitIsPlayer("target");
	local targetclass = UnitClass("target");
	if(usehumanrules and isplayer) then
		if((targetclass == "Büyücü") or (targetclass == "Rahip") or (targetclass == "Doğa Alimi")) then 
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
	
	if (usesilence and castable and usesilencefirst and CD("Sessizlik")) then
		CastSpellByName("Sessizlik");
    elseif (uselightning and castable and CD("Yıldırım")) then
		CastSpellByName("Yıldırım"); 
		if((nil ~= lightningmessage) and (lightningmessage ~= "")) then SendChatMessage(lightningmessage, "SAY"); end
	elseif (usesilence and castable and CD("Sessizlik") and (not usesilencefirst)) then 
		CastSpellByName("Sessizlik");
	elseif (usebinding and castable and CD("Zorunlu Sessizlik")) then 
		CastSpellByName("Zorunlu Sessizlik");
	elseif (usehumanrules and castable and CD("Toprak Oku")) then
		CastSpellByName("Toprak Oku");
	end
	
end

function BriarEntwinementCastableOnTarget(tbuffs, briartimeout)
  -- This function may fail to return proper value if the player moves while casting ElectricBolt and the target has Electric Flow Debuff cast by another player.
  -- First check if target does not have electric flow debuff
  
  local secselapsed = 0
  local castresult = false;
  local targetguid = UnitGUID("target");

	secselapsed = os.time() - g_lastBriarEntwinement.LastCast
	-- PrintDebugMessage("Seconds elapsed since Elektrik Topu: " .. secselapsed )

	if(targetguid == g_lastBriarEntwinement.TargetGUID and (secselapsed < 1)) then
		castresult = false;
	elseif((not tbuffs["Sarılı Dikenli Çalı"]) and (secselapsed > 1)) then
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
  elseif (not tbuffs["Çiçek Açan Hayat"] and (secselapsed > 1)) then
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
	PrintDebugMessage("İyileştirme Sec Elapsed : " .. (os.time() - g_RecoverTable[targetname]) )
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
	elseif((blossomingpct > 0) and (phealth < blossomingpct) and (not pbuffs["Çiçek Açan Hayat"])) then
		CastSpellByName("Çiçek Açan Hayat");
	elseif((recoverpct > 0) and (phealth < recoverpct) and (not pbuffs["İyileştirme"])) then
		CastSpellByName("İyileştirme");
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
	if (secondclass == "Gardiyan") then
		NatureBossDruidMage(useseeds,useseeds,.95,1.9,.4,1.1, false, 1.8,.2,true,true);
	elseif(secondclass == "Büyücü") then
		NatureBossDruidMage(useseeds,useseeds,.95,1.9,.4,1.1, false, 1.8,.2,true,true);
	end
	
end

function BossAttackDruidMainDps()
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Gardiyan") then
		NatureAttackDruidMage(false, false, .99,.4,.5,.3,false, false, true, true, false, true,true);
	elseif(secondclass == "Büyücü") then
		NatureAttackDruidMage(false, false, .99,.4,.5,.3,false, true, true, true, false, true,true);
	end
end

function BuffAllDruidMain(buffplus)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Gardiyan") then
		if(not buffplus) then
			BuffAllDruidWarden(true, true,true,true,true);
		 else
			BuffAllDruidWarden(true, true,true,true,true);
		 end
	elseif(secondclass == "Büyücü") then
		if(not buffplus) then
			BuffAllDruid(true,false,false,true,true);
		else
			BuffAllDruid(true,false,false,true,true);
		end
	end
end

function BreakSkillDruidMain(warnlist)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Gardiyan") then
		BreakSkillDruidMage(false, false, false, true, false, warnlist, false, '');
	elseif(secondclass == "Büyücü") then
		BreakSkillDruidMage(true, true, true, true, false, warnlist, false, '');
	end
end

function DruidMainTimedHeal(targetableSkillSlot,useyasam, blossominghealth)
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Gardiyan") then
		DruidTimedHeal(targetableSkillSlot, false, useyasam, blossominghealth)
	elseif(secondclass == "Büyücü") then
		DruidTimedHeal(targetableSkillSlot, true, false, blossominghealth)
	end
end