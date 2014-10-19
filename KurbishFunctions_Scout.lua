function BossAttackScoutMainDps()
	local mainclass, secondclass = UnitClass("player")
	if (secondclass == "Rogue") then
		BossAttackScoutRogue(true, false, false, false, true, true, false, true, true);
	elseif(secondclass == "Druid") then
		BossAttackScoutRogue(attackslot, .5, false, true, true, true,  true)
	else
		SendSystemMsg("Side class undefined??");
	end
end

function BossAttackScoutRogue(usefrost, usesnipe, usesapping, useweak, usevampire, usecombo, usedeadly, usewindarroow, useshot)
local phealth = PctH("player");
local pfocus = PctM("player"); -- this is focus(greenbar)
local penergy = PctS("player");
local secselapsed = os.time() - g_lastcasttime
local friendly = (not UnitCanAttack("player","target"))
local pbuffs = BuffList("player");
local tbuffs = BuffList("target");
-- local tbuffs = BuffList("target");
local combatstate = GetPlayerCombatState();
	if(usefrost and (not pbuffs["Frost Arrow"])) then
		CastSpellByName("Frost Arrow");
	elseif (usesnipe  and CD("Snipe")) then
		CastSpellByName("Snipe");
	elseif (usesapping  and CD("Sapping Arrow") and not tbuffs["Sapping Arrow"] and (penergy >= .30)) then
		CastSpellByName("Sapping Arrow");
	elseif (useweak and CD("Weak Spot") and (pfocus >= .20)) then
		CastSpellByName("Weak Spot");
	elseif (usevampire and CD("Vampire Arrows") and not tbuffs["Vampire Arrows"] and (pfocus >= .20)) then
	CastSpellByName("Vampire Arrows");
	elseif (usecombo and CD("Combo Shot")) then
		CastSpellByName("Combo Shot");
	elseif (usedeadly and CD("Deadly Poison Bite") and tbuffs["Vampire Arrows"] and (penergy >= .20)) then
		CastSpellByName("Deadly Poison Bite");
	elseif (usewindarroow and CD("Wind Arrows") and (pfocus >= .20)) then
		CastSpellByName("Wind Arrows");
	elseif (useshot) then
		CastSpellByName("Shot");
	else
		UseAction(attackslot);
	end
end

function BuffAllScoutMain(buffplus)
	local mainclass, secondclass = UnitClass("player")
	if(secondclass == "Druid") then
		BuffAllScoutDruid();
	elseif (secondclass == "Rogue") then
		BuffAllScoutRogue(true);
	else
		SendSystemMsg("Side class undefined??");
	end
end

function BreakSkillScout(usethroat, useneck, usejoint)
local pfocus = PctM("player"); -- this is focus(greenbar)
local penergy = PctS("player");

	if(usethroat and CD("Throat Attack") and (pfocus >= .15)) then
		CastSpellByName("Throat Attack");
	elseif (useneck  and CD("Neck Strike") and (pfocus >= .30)) then
		CastSpellByName("Neck Strike");
	elseif (usejoint  and CD("Joint Blow") and (pfocus >= .15)) then
		CastSpellByName("Joint Blow");
	end
end

function BuffAllScoutRogue(usefrost)
  local pbuffs = BuffList("player")
  if ((usefrost == true ) and (not pbuffs["Frost Arrow"] or pbuffs["Frost Arrow"].time < 600)) then
	CastSpellByName("Savage Blessing");
  end
end

function BuffAllScoutDruid()
  local pbuffs = BuffList("player")
end