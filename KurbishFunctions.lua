local KurbishFunctions = {} -- the AddOn namespace, all your functions should be placed inside here instead of as globals.
_G.KurbishFunctions = KurbishFunctions -- expose it to the global scope

-- Test git
g_lastaction = ""  -- Define g_lastaction globally
g_lastcast = ""  -- Define g_lastcast globally
g_lastcasttarget = ""
g_lastcasttime = 0;
g_lastElectricBolt = { LastCast = 0 , TargetGUID = -999999999 }
g_lastPlasmaArrow = { LastCast = 0 , TargetGUID = -999999999 }
g_lastBriarEntwinement = { LastCast = 0 , TargetGUID = -999999999 }
g_lastWeakeningSeed = { LastCast = 0 , TargetGUID = -999999999 }
g_lastWitheringSeed = { LastCast = 0 , TargetGUID = -999999999 }
g_lastBlossoming = { LastCast = 0 , TargetName = "" }
g_lastRecover = { LastCast = 0, TargetName = "" }
g_debugEnabled = false
g_currentlyCasting = false
g_turnlookaround = true
g_tank = ""
g_blossomingTable = { };
g_RecoverTable = { };
g_ignorecastson = {"Elektrik Topu"};
g_ignorecastby = {"Çiçek Açan Hayat","Elektrik Akımı","Sarılı Dikenli Çalı","Cursed Fangs","Alev Efekti", "Tabiat Ana'nın Gazabı", "Heyelan"};
g_priestbuffactive = false;
g_holyskillslot = 8;
g_bossAttackMageMainWarnBuffs = {'Kutsal Hale','Serenstum','Yumuşak Ormanşarkısı Pastası'};
g_useGloveDebuffList = {'Yıldırım', 'Gölge Hapsi', 'Stunned','Uyuşturucu Hançer Etkisi'};
g_mageBreakSkillAvoidBuffs = {'Kutsal Hale','Yumuşak Ormanşarkısı Pastası','Acıyı Önemsememe','Shield of Truth','Serenstum', 'Kaya Koruması'};

function KurbishFunctions_OnEvent(this, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	-- local isself = UnitName("target") == UnitName("player");
	-- if(event == "COMBATMETER_DAMAGE") then
		-- if(_source == UnitName("player")) then
		-- 	PrintDebugMessage("Eventi -> " .. event .. " , " .. _skill .. " , " .. _damage .. " , " .. _type)
		-- end
		-- Msg("Skill : ".._skill.." || Type : ".._type);
	if(event == "CHAT_MSG_COMBAT") then
			local playername = UnitName("player");
				local skillused, skillwhom = string.match(arg1, playername..", (.*) ile (.*)'nin Hayat")
				-- local skillused, skillwhom = string.match(arg1, "(%w+) cast by "..playername)
				-- Case #1 = Player casts xxx on yyy.
				if(nil ~= skillused) then
					-- Msg(arg1);
					 if (IsIgnoredSkill(g_ignorecastby, skillused)) then skillused = ""; end
				elseif (nil == skillused) then
					skillwhom, skillused  = string.match(arg1, playername.." (.*) üzerinde (.*) kullanır");
					if(nil ~= skillused) then 
						if(IsIgnoredSkill(g_ignorecastson, skillused)) then skillused = ""; end
					end
				end
				
				if(nil ~= skillused and skillused ~= "") then
					-- Msg('('..skillused..')'.."-"..skillwhom);
					PrintDebugMessage('('..skillused..')');
				end	
				
			
			if(string.find(arg1, playername.."(.*) üzerinde Sarılı Dikenli Çalı kullanır")) then
				g_lastBriarEntwinement.LastCast = os.time();
				g_lastBriarEntwinement.TargetGUID = UnitGUID("target");
				PrintDebugMessage("TABLO KAYIT : Sarılı Dikenli Çalı : " ..g_lastBriarEntwinement.TargetGUID.." @ "..g_lastBriarEntwinement.LastCast )
			elseif((nil ~= skillused) and string.match(skillused, "Çiçek Açan Hayat")) then
				g_lastBlossoming.LastCast = os.time();
				g_lastBlossoming.TargetName = skillwhom;
				g_blossomingTable[skillwhom] = os.time();
				PrintDebugMessage("TABLO KAYIT : Çiçek Açan Hayat : " ..g_lastBlossoming.TargetName.." @ "..g_lastBlossoming.LastCast )
			elseif((nil ~= skillused) and (skillused == "İyileştirme") and (nil ~= skillwhom)) then
				g_RecoverTable[skillwhom] = os.time();
				PrintDebugMessage("TABLO KAYIT : İyileştirme : " ..skillwhom.." @ "..os.time() )
				
			end
	elseif (event == "CASTING_START") then
		g_lastcast = arg1
		g_lastcasttime = os.time()
		g_currentlyCasting = true
		g_lastcasttarget = UnitGUID("target")

		PrintDebugMessage("Event -> " .. event .. " , " .. g_lastcast .. " , " .. arg2)
	elseif (event == "CASTING_FAILED") then
		g_currentlyCasting = false
		if(g_lastcast == "Elektrik Topu") then 
			g_lastElectricBolt.LastCast = 0
		end
		g_lastcasttime = os.time() -- override here again now that the casting trial finished without success
		-- PrintDebugMessage(AddMessage("Event -> " .. event .. " , " .. arg1 .. " , " .. arg2)
	elseif (event == "CASTING_STOP") then
	    g_lastcasttime = os.time() -- override here again now that the casting has completed successfully
		g_lastcasttarget = UnitGUID("target")
		if(g_lastcast == "Elektrik Topu") then 
			g_lastElectricBolt.LastCast = os.time()
			g_lastElectricBolt.TargetGUID = UnitGUID("target")
		elseif (g_lastcast == "Plazma Oku") then
			g_lastPlasmaArrow.LastCast = os.time()
			g_lastPlasmaArrow.TargetGUID = UnitGUID("target")
		elseif(g_lastcast == "İyileştirme") then	
			g_lastRecover.LastCast = os.time()
			g_lastRecover.TargetName = UnitName("target")
		end;
	    g_currentlyCasting = false
	elseif((event == "CHAT_MSG_PARTY") and g_priestbuffactive) then
		local mainclass, sideclass = UnitClass("player");
		if(mainclass == "Şövalye" and sideclass == "Rahip" and nil ~= arg1 and nil ~= arg4) then
			local said = string.lower(arg1);
			if(said == "buff" or said == "buf") then
				BuffHolyProtection(g_holyskillslot,arg4);
			end
		end
	end
	
end

function KurbishFunctions_OnLoad(this)
	-- this:RegisterEvent("COMBATMETER_DAMAGE");
	this:RegisterEvent("CASTING_START");
	this:RegisterEvent("CASTING_FAILED");
	this:RegisterEvent("CASTING_STOP");
	this:RegisterEvent("CHAT_MSG_COMBAT");
	this:RegisterEvent("CHAT_MSG_PARTY");
end


function BuffCount(who, skillname)
    local cnt = 1

    local name, icon, count, ID = UnitBuff( who, cnt );

    while name ~= nil do
	if(name == skillname) then
           return count
	end
        cnt = cnt + 1
        name, icon, count, ID = UnitBuff( who, cnt );
    end
    return 0
end

function DebuffCount(who, buffname)
    local cnt = 1

    local name, icon, count, ID = UnitDebuff( who, cnt );

    while name ~= nil do
	if(name == buffname) then
           return count
	end
        cnt = cnt + 1
        name, icon, count, ID = UnitDebuff( who, cnt );
    end
    return 0
end

function DebuffTimeLeft(who, debuffname)
    local int = 1
	local debuffleft = 0

    local name, icon, count, ID = UnitDebuff( who, int );

    while name ~= nil do
		if(name == debuffname) then
			debuffleft = UnitDebuffLeftTime(who,int);
			break;
		end
		
		int = int + 1
        name, icon, count, ID = UnitDebuff( who, int );
    end
    return debuffleft;
end

function BuffTimeLeft(who, buffname)
    local int = 1
	local buffleft = 0

    local name, icon, count, ID = UnitBuff( who, int );

    while name ~= nil do
		if(name == buffname) then
			buffleft = UnitBuffLeftTime(who,int);
			break;
		end
		
		int = int + 1
        name, icon, count, ID = UnitBuff( who, int );
    end
    return buffleft;
end

function HasDebuffFromList(who, debufflist)
    local hasdebuff = false
	local cnt = 1
    local name, texture, count, debuffID, params = UnitDebuff(who,cnt)
	local debuffs = DebuffList(who)
    while name ~= nil do
		if (string.find(debuffs,name)) then
			hasdebuff = true
			break
		end
	    cnt = cnt + 1
        name, texture, count, debuffID, params = UnitDebuff(who,cnt)
    end
	
	return hasdebuff
end

function DebuffList(tgt)
    local cnt = 1
    local buffstr = "/"

    local buff = UnitDebuff(tgt,cnt)

    while buff ~= nil do
        buffstr = buffstr..buff.."/"
        cnt = cnt + 1
        buff = UnitDebuff(tgt,cnt)
    end

    return string.gsub(buffstr, "(%()(.)(%))", "%2")
end

function HasBuffsFromList(actualBuffs, lookForBuffs)
	local hasbuff = false
	if((nil ~= actualBuffs) and (nil ~= lookForBuffs)) then
		local cnt = 1
		local buff = lookForBuffs[cnt]

		while buff ~= nil do
			PrintDebugMessage(buff);
			if(actualBuffs[buff]) then 
				hasbuff = true;
				break;
			end
			cnt = cnt + 1
			buff = lookForBuffs[cnt]
		end
	end
	return hasbuff
end

function ActualBuffList(tgt)
   local list = {}
   local buffcmd = UnitBuff
   local infocmd = UnitBuffLeftTime
   
   -- There is a max of 100 buffs/debuffs per unit apparently
   for i = 1,100 do
       local buff, _, stackSize, ID = buffcmd(tgt, i)
       local timeRemaining = infocmd(tgt,i)
       if buff then
           -- Ad to list by name
           list[buff:gsub("(%()(.)(%))", "%2")] = { stack = stackSize, time = timeRemaining, id = ID }
           -- We also list by ID in case two different buffs/debuffs have the same name.
           list[ID] = {stack = stackSize, time = timeRemaining, name = buff:gsub("(%()(.)(%))", "%2") }
       else
           break
       end
   end

   return list
end

function ActualDebuffList(tgt)
   local list = {}
   local buffcmd = UnitDebuff
   local infocmd = UnitDebuffLeftTime
   
   -- There is a max of 100 buffs/debuffs per unit apparently
   for i = 1,100 do
       local buff, _, stackSize, ID = buffcmd(tgt, i)
       local timeRemaining = infocmd(tgt,i)
       if buff then
           -- Ad to list by name
           list[buff:gsub("(%()(.)(%))", "%2")] = { stack = stackSize, time = timeRemaining, id = ID }
           -- We also list by ID in case two different buffs/debuffs have the same name.
           list[ID] = {stack = stackSize, time = timeRemaining, name = buff:gsub("(%()(.)(%))", "%2") }
       else
           break
       end
   end

   return list
end

-- pass nill for 'lookaroundenabled' to use default global
function LookAroundAndTarget(lookaroundenabled)
	if(nil ~= lookaroundenabled) then g_turnlookaround = lookaroundenabled; end
	TurnLeftStop();  
	TargetNearestEnemy(); 
	local tgt=UnitClass("target"); 
	if (g_turnlookaround and ((nil == tgt) or (tgt == ""))) then 
		TurnLeftStart(); 
	elseif (not (UnitName("target") == UnitName("player"))) then  
		TurnLeftStop();  
	end;
	
end

function ToggleLookAround()
	g_turnlookaround = not g_turnlookaround;
	local text = "LookAroundEnabled = "
	if(g_turnlookaround) then
		text = text.."true";
	else
		TurnLeftStop();
		text = text.."false"
	end
	DEFAULT_CHAT_FRAME:AddMessage(text);
end

function LookAroundAndAttack(attackslot, turnaround, recoverpct, recoverspell, recoverbuffname, forcerecoverpct, manapct, manaslot, manabuffname)
	local phealth = PctH("player")
	local penergy = PctS("player")
	local pmana = PctM("player")
	local pbuffs = BuffList("player")

	-- First check if we currently have a target
	local tgt=UnitClass("target"); 
	local friendly = (not UnitCanAttack("player","target"))
	local isdead = UnitIsDeadOrGhost("target")

	if((forcerecoverpct > 0) and (phealth < forcerecoverpct)) then
		CastSpellByName(recoverspell);
	elseif((manaslot > 0) and ((pmana < manapct) or (penergy < manapct)) and (not pbuffs[manabuffname])) then
		UseAction(manaslot);
	elseif((recoverpct > 0) and (phealth < recoverpct) and (not pbuffs[recoverbuffname])) then
		CastSpellByName(recoverspell);
	elseif((nil == tgt) or friendly) then
		if(turnaround) then TurnLeftStart(); end
		TargetNearestEnemy();
	elseif ((nil ~= tgt) and isdead) then
		if(turnaround) then TurnLeftStop(); end
		UseAction(attackslot);
	else
		if(turnaround) then TurnLeftStop(); end
		UseAction(attackslot);
	end
end

function LookAroundAndAttackWithPotion(attackslot, turnaround, potionpct, potionslot, potionbuffname)
	local phealth = PctH("player")
	local penergy = PctS("player")
	local pbuffs = BuffList("player");

	-- First check if we currently have a target
	local tgt=UnitClass("target"); 
	local friendly = (not UnitCanAttack("player","target"))
	local isdead = UnitIsDeadOrGhost("target")

	if((potionpct > 0) and (phealth < potionpct) and (not pbuffs[potionbuffname])) then
		UseAction(potionslot);
	elseif((nil == tgt) or friendly) then
		if(turnaround) then TurnLeftStart(); end
		TargetNearestEnemy();
	elseif ((nil ~= tgt) and isdead) then
		if(turnaround) then TurnLeftStop(); end
		UseAction(attackslot);
	else
		if(turnaround) then TurnLeftStop(); end
		UseAction(attackslot);
	end
end

function findpattern(text, pattern, start)
  return string.sub(text, string.find(text, pattern, start))
end

function IsIgnoredSkill(g_ignoretable, skillused)
	local cnt = 1;
	local isignored = false;
	local tablename = g_ignoretable[cnt];
	while tablename ~= nil do
	    -- PrintDebugMessage(tablename.."<->"..skillused);
		if(string.find(skillused,tablename,1,true)) then
			isignored = true;
			PrintDebugMessage("SKILL IGNORED -> "..skillused);
			break;
		end
		cnt = cnt + 1
		tablename = g_ignoretable[cnt];
	end
	return isignored;
end

-- function CDLeft(skillname)
--    local firstskill = GetSkillDetail(2,1)
--    if (g_skill[firstskill] == nil) or (g_skill[firstskill].page ~= 2) then
--        ReadSkills()
--    end
--    
--    local tt,cd = 999,999;
--    if g_skill[skillname] ~= nil then
--        tt,cd = GetSkillCooldown(g_skill[skillname].page,g_skill[skillname].slot)
--    elseif skillname == nil then
--        return tt,cd;
--    else
--        Msg("Skill not available: "..skillname)        --Comment this line out if you do not wish to recieve this error message.
--        return tt,cd;
--    end
--    return tt,cd;
-- end

function GetPartyIdByUnitName(unitname)
	local partyid = nil;
	if(unitname == UnitName("player")) then partyid = 0; return partyid; end
	for i=1,GetNumPartyMembers()-1 do
		if(UnitName("party"..i) == unitname) then
			partyid = i;
			break;
        end
	end
end

function CheckAndSetTank()
	-- local threatBar = getglobal("vcThreatMeter_Bar" .. j)
	local threatName = getglobal("vcThreatMeter_Bar" .. j .. "TextLeft")
	if(nil ~= threatName) then
		Msg("ThreadName is : "..threatName);
		local partyid = GetPartyIdByUnitName(threatName);
		if(nil ~= partyid and partyid > 0) then 
			TargetUnit("party"..partyid); 
			SetTank();
		end
	end
end

function GetPotUsable(slotno)
	local icon_path, name, count, locked, wore, continued  = GetActionInfo(slotno);
	local usable = false;
	if(nil ~= icon_path) then
		local cooldown, remaining  = GetActionCooldown(slotno); 
		usable = (count > 0) and GetActionUsable(slotno) and (remaining == 0);
	end
	return usable;
end

function BuffHolyProtection(holskillslot, playername)
	if(GetNumRaidMembers() > 0) then
	   for num=1,35 do
		   TargetUnit("raid"..num)
		   local unitName = UnitName("target");
		   if nil ~= unitName and unitName == playername then
				Msg("Isim tuttu!");
				if (GetActionUsable(holskillslot) and (UnitHealth("raid"..num) > 0) and CD("Kutsal Koruma") and UnitIsUnit("target","raid"..num)) then 
					Msg("Skili atiyorum!");
					CastSpellByName("Kutsal Koruma");
					Msg("Skili attim!");
					break;
				else
					Msg("Hata!");
					-- SendChatMessage("Agro buffi atamadim, yakınlaşıp tekrar 'buff' dermisin? *OTO MESAJ*", "WHISPER", "Common", playername);
				end
			end
	   end
   end
end
