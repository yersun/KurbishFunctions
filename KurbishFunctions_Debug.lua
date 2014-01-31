function PrintDebugMessage(message)
  if (g_debugEnabled) then
    DEFAULT_CHAT_FRAME:AddMessage(message)
  end
end

function PrintTestMessage(message)
    DEFAULT_CHAT_FRAME:AddMessage(message)
end

function ToggleDebug()
	if(g_debugEnabled == true) then
		g_debugEnabled = false
	else
		g_debugEnabled = true
	end
	  local entext = "true"
	if(not g_debugEnabled) then entext = "false" end
	DEFAULT_CHAT_FRAME:AddMessage("------------------------------------------------")
	DEFAULT_CHAT_FRAME:AddMessage("Kurbish Functions DebugMode Enabled = " .. entext)
	DEFAULT_CHAT_FRAME:AddMessage("------------------------------------------------")
end

function SayMessage(message)
	SendChatMessage(message, "SAY" );
end

-- -------------------------
-- TEST FUNCTIONS START HERE
-- ------------------------- 

function Test()
    DEFAULT_CHAT_FRAME:AddMessage("--->  Kurbish Test Pufffttt!... <---");
end

function TestElectricBolt(electricbolttimeout)
  local Skill = {}
  local i = 0
  local friendly = (not UnitCanAttack("player","target"))
  local tbuffs= BuffList("target")  
  local electricBoltCastable = ElectricBoltCastableOnTarget(electricbolttimeout)
  secselapsed = os.time() - g_lastElectricBolt.LastCast

  if((electricBoltCastable == true) and (tbuffs["Electric Flow"])) then
    DEFAULT_CHAT_FRAME:AddMessage("Electric Bolt Timeout expired but Electric Flow Debuff detected on target!" .. secselapsed )
  end
	Skill = {
		{ name = "Custom: Electric Bolt", use = ((not friendly) and (electricBoltCastable)) }
	}
  MyCombat(Skill)
end

function PrintDebuffs(who)
    local cnt = 1
	local prm;
	local cont;

    local name, texture, count, debuffID, params = UnitDebuff(who,cnt)

    while name ~= nil do
	
	if (nil == params) then prm = "" else prm = params end
	if (nil == count) then cont = "" else cont = count end
	DEFAULT_CHAT_FRAME:AddMessage("Name:"..name.." , Params:".. prm .. " , Count:" .. cont);
        cnt = cnt + 1
        name, texture, count, debuffID, params = UnitDebuff(who,cnt)
    end
end


function PrintBuffs(who)
    local cnt = 1

    local buff = UnitBuff(who,cnt)

    DEFAULT_CHAT_FRAME:AddMessage("-----------------------------------------")

    while buff ~= nil do
	DEFAULT_CHAT_FRAME:AddMessage(buff);
        cnt = cnt + 1
        buff = UnitBuff(who,cnt)
    end

  local cameliacount = BuffCount(who, "Camellia Flower")
  local naturepower = BuffCount(who, "Nature's Power")

  DEFAULT_CHAT_FRAME:AddMessage("Camelia Count = " .. cameliacount)
  DEFAULT_CHAT_FRAME:AddMessage("Nature's Power = " .. naturepower)

  DEFAULT_CHAT_FRAME:AddMessage("-----------------------------------------")
end

function PrintPlayerStatus(who)

  DEFAULT_CHAT_FRAME:AddMessage("UnitMaxHealth : "..UnitMaxHealth(who));
  DEFAULT_CHAT_FRAME:AddMessage("UnitMaxSkill : "..UnitMaxSkill(who));
  DEFAULT_CHAT_FRAME:AddMessage("UnitMaxMana : "..UnitMaxMana(who));

end

function PrintPotUsable(slotno)
	local icon_path, name, count, locked, wore, continued  = GetActionInfo(slotno); 
	local cooldown, remaining  = GetActionCooldown(slotno); 
	Msg("Cooldown : "..cooldown);
	Msg("Remaining : "..remaining);
	Msg("Icon : "..icon_path);
	Msg("Name : "..name);
	Msg("Count : "..count);
	Msg("Locked : "..tostring(locked));
	Msg("Wore : "..tostring(wore));
	Msg("Continued : "..tostring(continued));
	
end