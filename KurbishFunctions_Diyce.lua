-- /run DirectDPS(false, true, 12, true, true, false, false,true, false, false, .45, .30);
function DirectDPSMage(useintensification, useboltfirst, electricbolttimeout, usemagma, usefireball, useearthpulse, uselighting, useflame, usemeteor, useplasma, earthhealth, recoverhealth)
local Skill = {}
  local i = 0
  local friendly = (not UnitCanAttack("player","target"))
  local pbuffs = BuffList("player")
  local tbuffs= BuffList("target")
  local isshift = IsShiftKeyDown()
  local phealth = PctH("player")
  
  local pmana = PctM("player")
  local penergy = PctS("player")
  
  local tdead = UnitIsDeadOrGhost("target")
--  combat = GetPlayerCombatState()
  if (tdead) then
       g_lastcast = ""
       PrintDebugMessage("Target is DEAD!");
  end
  local electricBoltCastable = ElectricBoltCastableOnTarget(electricbolttimeout, tbuffs)

  if(isshift == true) then
	useintensification = (not useintensification)
  end
  Skill = {
		{ name = "Custom: Mother Earth's Protection", use = (phealth <= earthhealth) },
		{ name = "Custom: Recover", use = (phealth <= recoverhealth) },
		{ name = "Custom: Intensification", use = ((useintensification == true) and (not pbuffs["Intensification"])) },
		{ name = "Custom: Electric Bolt", use = ((useboltfirst == true) and (not friendly) and (electricBoltCastable)) },
		{ name = "Custom: Magma Blade", use = ((usemagma == true) and (not friendly)) },
		{ name = "Custom: Fireball", use = ( (usefireball == true) and (not friendly)) },
		{ name = "Custom: Earth Pulse", use = ((useearthpulse == true) and (not friendly)) },
		{ name = "Custom: Lightning", use = ((uselighting == true) and (not friendly)) },
		{ name = "Custom: Electric Bolt", use = ((useboltfirst == false) and (not friendly) and (electricBoltCastable)) },
		{ name = "Custom: Flame", use = ((useflame == true) and (not friendly)) },
		{ name = "Meteor Shower", use = ( (usemeteor == true) and (not friendly)) },
		{ name = "Plasma Arrow", use = ((useplasma == true) and (not friendly)) }
	}
  MyCombat(Skill)

end

-- /run DirectDPS(false, true, 12, true, true, false, false,true, false, false, .45, .30);
function DirectDPSMage(useintensification, useboltfirst, electricbolttimeout, usemagma, usefireball, useearthpulse, uselighting, useflame, usemeteor, useplasma, earthhealth, recoverhealth)
local Skill = {}
  local i = 0
  local friendly = (not UnitCanAttack("player","target"))
  local pbuffs = BuffList("player")
  local tbuffs= BuffList("target")
  local isshift = IsShiftKeyDown()
  local phealth = PctH("player")
  
  local pmana = PctM("player")
  local penergy = PctS("player")
  
  local tdead = UnitIsDeadOrGhost("target")
--  combat = GetPlayerCombatState()
  if (tdead) then
       g_lastcast = ""
       PrintDebugMessage("Target is DEAD!");
  end
  local electricBoltCastable = ElectricBoltCastableOnTarget(electricbolttimeout, tbuffs)

  if(isshift == true) then
	useintensification = (not useintensification)
  end
  Skill = {
		{ name = "Custom: Mother Earth's Protection", use = (phealth <= earthhealth) },
		{ name = "Custom: Recover", use = (phealth <= recoverhealth) },
		{ name = "Custom: Intensification", use = ((useintensification == true) and (not pbuffs["Intensification"])) },
		{ name = "Custom: Electric Bolt", use = ((useboltfirst == true) and (not friendly) and (electricBoltCastable)) },
		{ name = "Custom: Magma Blade", use = ((usemagma == true) and (not friendly)) },
		{ name = "Custom: Fireball", use = ( (usefireball == true) and (not friendly)) },
		{ name = "Custom: Earth Pulse", use = ((useearthpulse == true) and (not friendly)) },
		{ name = "Custom: Lightning", use = ((uselighting == true) and (not friendly)) },
		{ name = "Custom: Electric Bolt", use = ((useboltfirst == false) and (not friendly) and (electricBoltCastable)) },
		{ name = "Custom: Flame", use = ((useflame == true) and (not friendly)) },
		{ name = "Meteor Shower", use = ( (usemeteor == true) and (not friendly)) },
		{ name = "Plasma Arrow", use = ((useplasma == true) and (not friendly)) }
	}
  MyCombat(Skill)

end

function DirectDPSMageRogue(useintensification, useboltfirst, wampirehealth, electricbolttimeout, usecursedfangs, forcecursedfangs, usefireball,  uselighting, useflame, usemeteor, useplasma, phirusPercent, phirusSlot)
  local Skill1 = {}
  local Skill2 = {}
  local friendly = (not UnitCanAttack("player","target"))
  local pbuffs = BuffList("player")
  local tbuffs= BuffList("target")
  local phealth = PctH("player")
  local usePhirus = false;
  local usePhirusAction = "";
  local penergy = PctS("player")
  local electricBoltCastable = ElectricBoltCastableOnTarget(electricbolttimeout, tbuffs)
  
  if( (phirusSlot ~= nil) and (phirusSlot > 0) ) then
	usePhirus = true
	usePhirusAction = "Action: "..phirusSlot.." (Phirus)"
  end

  Skill1 = {
    { name = "Intensification", use = ((useintensification == true) and (not pbuffs["Intensification"])) },
	-- { name = "Electric Bolt", use = ((useboltfirst == true) and (electricbolttimeout > 0) and (not friendly) and (not tbuffs["Electric Flow"])) },
	{ name = "Electric Bolt", use = ((useboltfirst == true) and (not friendly) and (electricBoltCastable == true)) },
    { name = "Kiss of the Vampire", use = ((phealth <= wampirehealth) and (penergy >= .40) and (not friendly)) },
	{ name = usePhirusAction, use = ((usePhirus == true) and (phealth <= phirusPercent)) },
	{ name = "Fireball", use = ( (usefireball == true) and (not friendly)) },
	{ name = "Cursed Fangs", use = ((forcecursedfangs == true) and (usecursedfangs == true) and (penergy >= .30) and (not friendly)) }
  }
  
  Skill2 = {
		
		{ name = "Custom: Cursed Fangs", use = ((forcecursedfangs == false) and (usecursedfangs == true) and (penergy >= .30) and (not friendly)) },
		{ name = "Lightning", use = ((uselighting == true) and (not friendly)) },
		-- { name = "Electric Bolt", use = ((useboltfirst == false) and  (electricbolttimeout > 0) and (not friendly) and (not tbuffs["Electric Flow"])) },
		{ name = "Electric Bolt", use = ((useboltfirst == false) and (not friendly) and (electricBoltCastable == true)) },
		{ name = "Custom: Flame", use = ((useflame == true) and (not friendly)) },
		{ name = "Custom: Plasma Arrow", use = ((useplasma == true) and (not friendly)) },
		{ name = "Meteor Shower", use = ( (usemeteor == true) and (not friendly)) }
  }

  if(not MyCombat(Skill1)) then
	MyCombat(Skill2)
  end

end

function BossAttackMage(shieldon, usefangritual, useshadowprotection, useintensification, useenergywell, useperception, usemagictarget, useenergyinflux, dointerrupt, interrupt_list, useweakness , wampirehealth, electricbolttimeout, usecursedfangs, forcecursedfangs, usemagma, usefireball, usemystic, useplasma, useflame, usemeteor, earthhealth, recoverhealth, phirusPercent, phirusSlot)
  local Skill = {}
  local i = 0
  local friendly = (not UnitCanAttack("player","target"))
  local pbuffs = BuffList("player")
  local tbuffs= BuffList("target")
  local tspell,ttime,telapsed = UnitCastingTime("target")
  local electricBoltCastable = ElectricBoltCastableOnTarget(electricbolttimeout, tbuffs)
  local usePhirusAction = "";
  local usePhirus = false;
  
  local phealth = PctH("player")
  local pmana = PctM("player")
  local penergy = PctS("player")
  local isshift = IsShiftKeyDown()
  
   -- local behind = (not UnitIsUnit("player", "targettarget"))
   -- local melee = GetActionUsable(13) -- # is your melee range spell slot number
   -- local a1,a2,a3,a4,a5,ASon = GetActionInfo(14)  -- # is your Autoshot slot number
   -- local LockedOn = UnitExists("target")
   -- local boss = UnitSex("target") > 2
   -- local elite = UnitSex("target") == 2

   

--  combat = GetPlayerCombatState()
-- Below routine is no longer necessary, we do not need to reset last_action in current execution logic.
--  local tdead = UnitIsDeadOrGhost("target")
  if (tdead) then
       g_lastcast = ""
       PrintDebugMessage("Target is DEAD!");
  end
  
  if( (phirusSlot ~= nil) and (phirusSlot > 0) ) then
	usePhirus = true
	usePhirusAction = "Action: "..phirusSlot.." (Phirus)"
  end

  if(isshift == true) then
     shieldon = false
     usebuffs = false
     dointerrupt = false
     useweakness = false
     recoverhealth = 0.0
     earthhealth = 0.0
  end
 
  Skill = {
	  { name = "Custom: Kiss of the Vampire", use = ((phealth <= wampirehealth) and (penergy >= .40) and (not friendly)) },
	  { name = usePhirusAction, use = ((usePhirus == true) and (phealth <= phirusPercent)) },
	 
	  { name = "Custom: Silence", use = ( (dointerrupt == true) and (not friendly) and (tspell ~= nil) and string.find(interrupt_list, tspell) and ((ttime - telapsed) > 0.5) ) },
	  { name = "Custom: Electrostatic Charge", use = ((shieldon == true) and (not pbuffs["Electrostatic Charge"])) },
	  
	  { name = "Custom: Fang Ritual", use = ((usefangritual == true ) and (not pbuffs["Fang Ritual"])) },
	  { name = "Custom: Shadow Protection", use = ((useshadowprotection == true ) and (not pbuffs["Shadow Protection"])) },
	  { name = "Custom: Mother Earth's Protection", use = (phealth <=  earthhealth) },
	  { name = "Custom: Recover", use = ((phealth <= recoverhealth) or (friendly == true)) },
	  { name = "Custom: Intensification", use = ((useintensification == true) and (not pbuffs["Intensification"])) },
	  { name = "Custom: Energy Well", use = ((useenergywell == true) and (not pbuffs["Energy Well"])) },
	
	  { name = "Custom: Perception", use = ((useperception == true) and (not pbuffs["Perception"])) },
	  { name = "Custom: Magic Target", use = ((usemagictarget == true) and (not pbuffs["Magic Target"])) },
	  { name = "Custom: Energy Influx", use = ((useenergyinflux == true) and (not pbuffs["Energy Influx"])) },
	  { name = "Custom: Elemental Weakness", use = ((useweakness == true) and (not friendly) and (not tbuffs["Elemental Weakness"])) },
	  { name = "Custom: Elven Mystic", use = ((usemystic == true) and (not friendly)) },
	--  Somehow Add Mystic Energy here if Elven Mystic is to be used
	--  i=i+1; Skill[i] = { name = "Custom: Mystic Energy", use = ((isboss == true) and (not friendly)) }
	  
	  { name = "Custom: Electric Bolt", use = ((not friendly) and (electricBoltCastable) and (not pbuffs["Intensification"])) },
	  { name = "Custom: Cursed Fangs", use = ((forcecursedfangs == false) and (usecursedfangs == true) and (penergy >= .30) and (not friendly)) },
	  { name = "Custom: Magma Blade", use = ((usemagma == true) and (not friendly)) },
	  { name = "Custom: Fireball", use = ((usefireball) and (not friendly)) },
	  { name = "Cursed Fangs", use = ((forcecursedfangs == true) and (usecursedfangs == true) and (penergy >= .30) and (not friendly)) },
	  { name = "Custom: Flame", use = ((useflame == true) and (not friendly)) },
	  { name = "Plasma Arrow", use = ((useplasma == true) and (not friendly)) },
	  { name = "Meteor Shower", use = ((usemeteor == true) and (not friendly)) }
	 }
  
 
  MyCombat(Skill)
end

function CustomAction(action)
	local result = false
    -- if ((CD(action)) and (not g_currentlyCasting)) then
	if (CD(action)) then
		local secselapsed = 0
		secselapsed = os.time() - g_lastcasttime
		--Do Not cast Flame twice back to back
		if ((action == g_lastcast) and (g_lastcasttarget == UnitGUID("target")) and (secselapsed < 1)) then
			PrintDebugMessage("DOUBLE ACTION DETECTED! ->" .. action)
			result = false -- Change this false to allow Plasma Arrow
		elseif(action == "Cursed Fangs") then
			local tbuffs = BuffList("target");
			local castable = CursedFangCastableOnTarget(tbuffs)
			if(castable == true) then
				g_lastCursedFangs.LastCast = os.time()
				g_lastCursedFangs.TargetGUID = UnitGUID("target")
				CastSpellByName(action)
				PrintDebugMessage("CASTED -> " .. action)
				result = true;
			end
		else
			CastSpellByName(action)
			PrintDebugMessage("CASTED -> " .. action)
			result = true;
		end
	end
	return result
end

-- -- For SCOUT -> NatureAttackCombo(.85, .65, .60, .80, .45, .50, .40, true, true, true, false, true, true);
-- function NatureAttackDruid(cameliahealth1, cameliahealth2, cameliahealth3, blossominghealth, earthhealth, recoverhealth, rockhealth, forcerecoverfriendlyhealth, userockslide, usebriar, usevampirearrow, usefireball, useearthpulse, useeartharrow)
--   local Skill = {}
--   local i = 0
--   local friendly = (not UnitCanAttack("player","target"))
--   local pbuffs = BuffList("player")
--   local tbuffs= BuffList("target")
--   local tspell,ttime,telapsed = UnitCastingTime("target")

--   local phealth = PctH("player")
--   local thealth = PctH("target")

--   local buffs
--   local health
--   local forcerecover

--   local pmana = PctM("player")
--   local cameliacount = BuffCount("player",  "Camellia Flower")
--   local naturepower = BuffCount("player", "Nature's Power")

--   if(((friendly) and (phealth < forcerecoverfriendlyhealth) and (thealth < forcerecoverfriendlyhealth)) or (phealth < recoverhealth)) then
--      forcerecover = true
--      health = thealth
--      buffs = tbuffs
--      cameliacount = BuffCount("target",  "Camellia Flower")
--   elseif(friendly) then
--     health = thealth
--     buffs = tbuffs
--     cameliacount = BuffCount("target",  "Camellia Flower")
--   elseif(not friendly) then
--     health = phealth
--     buffs = pbuffs
--   end

--   local isshift = IsShiftKeyDown()

-- --  combat = GetPlayerCombatState()
-- -- Below routine is no longer necessary, we do not need to reset last_action in current execution logic.
-- --  local tdead = UnitIsDeadOrGhost("target")
--   if (tdead) then
--        g_lastcast = ""
--        PrintDebugMessage("Target is DEAD!");
--   end
  
--   Skill = {
--   { name = "Camellia Flower", use = ((health <= cameliahealth1) and (cameliacount < 1) )},
--   { name = "Recover", use = (forcerecover) },
--   { name = "Mother Earth's Protection", use = (health <= earthhealth) },
--   { name = "Rock Protection", use = ((not friendly) and (naturepower >= 2) and (health <= rockhealth)) },
--   { name = "Blossoming Life", use = ( (not buffs["Blossoming Life"]) and (health <= blossominghealth)) },
--   { name = "Recover", use = (health <= recoverhealth) },
  
--   { name = "Camellia Flower", use = ((health <= cameliahealth2) and (cameliacount < 2) )},
--   { name = "Camellia Flower", use = ((health <= cameliahealth3) and (cameliacount < 3) )},

--   { name = "Weakening Seed", use = ((not friendly) and (isshift == true) and (naturepower >= 2) and (not tbuffs["Weakening Seed"])) },
--   { name = "Withering Seed", use = ((not friendly) and (isshift == true) and (naturepower >= 2) and (not tbuffs["Withering Seed"])) },
--   { name = "Rockslide", use = ((userockslide == true) and (not friendly)) },
--   { name = "Briar Entwinement", use = ((usebriar == true) and (not friendly) and (not tbuffs["Briar Entwinement"])) },
--   { name = "Vampire Arrows", use = ((usevampirearrow == true) and (not friendly) and (not tbuffs["VampireArrows"])) },
--   { name = "Fireball", use = ((usefireball == true) and (not friendly)) },
--   { name = "Earth Pulse", use = ((useearthpulse == true) and (not friendly)) },
--   { name = "Earth Arrow", use = ((useeartharrow == true) and (not friendly)) }
--  }
--   MyCombat(Skill)
-- end

-- function BreakSkillDruidScout(usesilence, usethroat)
--   local friendly = (not UnitCanAttack("player","target"))
--   local Skill = {}
--   local i = 0
--   Skill = {
-- 	  { name = "Custom: Binding Silence", use = ((usesilence == true) and (not friendly)) },
-- 	  { name = "Custom: Throat Attack", use = (( usethroat == true) and (not friendly)) }
--   }
--   MyCombat(Skill)
-- end

-- function BuffAllDruid()
--   local Skill = {}
--   local i = 0
--   local pbuffs = BuffList("player")
--   i=i+1; Skill[i] = { name = "Custom: Concentration Prayer", use = (not pbuffs["Concentration Prayer"]) }
--   i=i+1; Skill[i] = { name = "Custom: Mother Earth's Blessing", use = (not pbuffs["Mother Earth's Blessing"]) }

--   MyCombat(Skill)
-- end



-- For SCOUT -> NatureAttackCombo(.85, .65, .60, .80, .45, .50, .40, true, true, true, false, true, true);
-- function SelfHeal(usecamelia, useblossoming, recoverhealth, rockhealth)
--   TargetUnit("player");
  
--   local Skill = {}
--   local i = 0
--   local pbuffs = BuffList("player")
--   local cameliacount = BuffCount("player",  "Camellia Flower")
--   local naturepower = BuffCount("player", "Nature's Power")
--   local phealth = PctH("player")
  
--   local isshift = IsShiftKeyDown()

-- --  combat = GetPlayerCombatState()
-- -- Below routine is no longer necessary, we do not need to reset last_action in current execution logic.

-- 	Skill = {
-- 	  { name = "Camellia Flower", use = ((usecamelia == true) and (cameliacount < 1)) },
-- 	  { name = "Blossoming Life", use = ((useblossoming == true) and (not pbuffs["Blossoming Life"])) },
-- 	  { name = "Recover", use = (phealth <= recoverhealth) },
-- 	  { name = "Rock Protection", use = ((not friendly) and (naturepower >= 2) and (phealth <= rockhealth)) },
-- 	  { name = "Camellia Flower", use = (cameliacount < 2) },
-- 	  { name = "Camellia Flower", use = (cameliacount < 3) }
-- 	}
--   MyCombat(Skill, "" , true)
-- end

-- function ProtectSelf(usedistract, earthProtectionPercent, recoverPercent, crystalCandySlot, crystalCandyPercent, phirusSlot, phirusPercent, glovedebuflist, gloveslot)
--   local Skill = {}
--   local i = 0
--   local friendly = (not UnitCanAttack("player","target"))
--   local tdead = UnitIsDeadOrGhost("target")
--   local pbuffs = BuffList("player")
--   local phealth = PctH("player")
--   local useCandy = false
--   local useCandyAction = ""
--   local usePhirus = false
--   local usePhirusAction = ""
--   local useGlove = false
--   local isMage = ((UnitClass("target") == "Mage") or (UnitClass("target") == "Priest"))
  
--   if ( (crystalCandySlot > 0) and isMage) then
-- 	crystalCandySlot = crystalCandySlot + 1
--   end
  
--   if( crystalCandySlot > 0 ) then
-- 	useCandy = true
-- 	useCandyAction = "Action: "..crystalCandySlot.." (Crystal Candy)"
--   end
  
--   if( phirusSlot > 0 ) then
-- 	usePhirus = true
-- 	usePhirusAction = "Action: "..phirusSlot.." (Phirus)"
--   end
  
--   if( (glovedebuflist ~= null) and (gloveslot > 0)) then
-- 	useGlove = HasDebuffFromList("player", glovedebuflist)
--   end
  
--  local useGloveAction = "Action: "..gloveslot.." (Glove)"
  
--   Skill = {
-- 	  { name = "Distract", use = ((not friendly) and (tdead == false) and (usedistract == true)) },
-- 	  { name = useCandyAction, use = ((useCandy == true) and (phealth <= crystalCandyPercent)) },
-- 	  { name = usePhirusAction, use = ((usePhirus == true) and (phealth <= phirusPercent)) },
-- 	  { name = useGloveAction, use = (useGlove == true) },
-- 	  
-- 	  { name = "Electrostatic Charge", use = (not pbuffs["Electrostatic Charge"]) },
-- 	  { name = "Mother Earth's Protection", use = ((phealth <= earthProtectionPercent) and (not pbuffs["Crystal Candy"])) },
-- 	  { name = "Recover", use = (phealth <= recoverPercent)}
-- 	}
--   MyCombat(Skill)
-- end

-- function MageStun(usedischarge, usephoenix, usepurgatory, rapidpurgatory)
  -- local Skill = {}
  -- local i = 0
  
  -- Skill = {
  -- { name = "Discharge", use = (usedischarge == true) },
  -- { name = "Phoenix", use = (usephoenix == true) }
  -- }
  -- MyCombat(Skill)
 
-- end

-- function BuffAllMage(useintensification, intensificationfirst, useenergywell, useperception, usemagictarget, useenergyinflux, usefireward, usesavageblessing, usefangritual, useshadowprotection)
--   local Skill = {}
--   local i = 0
--   local pbuffs = BuffList("player")
-- 	Skill = {
-- 	  { name = "Custom: Fang Ritual", use = ((usefangritual == true ) and (not pbuffs["Fang Ritual"])) },
-- 	  { name = "Custom: Shadow Protection", use = ((useshadowprotection == true ) and (not pbuffs["Shadow Protection"])) },
-- 	  { name = "Custom: Intensification", use = ((useintensification == true ) and (not pbuffs["Intensification"]) and (intensificationfirst == true)) },
-- 	  { name = "Custom: Energy Well", use = ((useenergywell == true ) and (not pbuffs["Energy Well"])) },
-- 	  { name = "Custom: Perception", use = ((useperception == true ) and (not pbuffs["Perception"])) },
-- 	  { name = "Custom: Magic Target", use = ((usemagictarget == true ) and (not pbuffs["Magic Target"])) },
-- 	  { name = "Custom: Energy Influx", use = ((useenergyinflux == true ) and (not pbuffs["Energy Influx"])) },
-- 	  { name = "Custom: Fire Ward", use = ((usefireward == true ) and (not pbuffs["Fire Ward"])) },
-- 	  { name = "Custom: Savage Blessing", use = ((usesavageblessing == true ) and (not pbuffs["Savage Blessing"])) },
-- 	  { name = "Custom: Intensification", use = ((useintensification == true ) and (not pbuffs["Intensification"]) and (intensificationfirst == false)) }
-- 	}
  
--   MyCombat(Skill)
-- end

-- function ChargeUp()  
--   local Skill = {}
--   local i = 0
--   local enemy = UnitCanAttack("player", "target")
--   local pBuffs = BuffList("player")
--   local tBuffs= BuffList("target")

-- 	Skill = {
-- 	  { name = "Custom: Static Field", use = (enemy and (pBuffs["Static Field Charge"])) },
-- 	  { name = "Custom: Electric Compression", use = (enemy and (pBuffs["Charged"])) },
-- 	  { name = "Custom: Plasma Arrow", use = ((enemy) and (not tBuffs["Static Field"])) }
-- 	}
--   MyCombat(Skill,arg1)
-- end

-- function BreakSkill(uselightning, usesilence)
--  local friendly = (not UnitCanAttack("player","target"))
--  local Skill = {}
--  local i = 0
--  Skill = {
--	  { name = "Custom: Lightning", use = ((uselightning == true) and (not friendly)) },
--	  { name = "Custom: Silence", use = (( usesilence == true) and (not friendly)) }
--  }
--  MyCombat(Skill)
-- end