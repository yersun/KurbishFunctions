function PrintKurbishSignature()

	DEFAULT_CHAT_FRAME:AddMessage("-------------------------------------------------------");

	DEFAULT_CHAT_FRAME:AddMessage("PrintKurbishSignatureMage()");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("PrintKurbishSignatureDruid()");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("PrintKurbishSignatureRogue()");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("PrintKurbishSignatureTank()");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("PrintKurbishSignaturePriest()");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("PrintKurbishSignatureLookAround()");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("PrintKurbishSignatureDiyce()");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("PrintKurbishSignatureTest()");

    DEFAULT_CHAT_FRAME:AddMessage("-------------------------------------------------------");
	
end

function PrintKurbishSignatureMage()
    DEFAULT_CHAT_FRAME:AddMessage("------------------ KURBISH FUNCTIONS MAGE------------------");

	DEFAULT_CHAT_FRAME:AddMessage(" ");	
		
	DEFAULT_CHAT_FRAME:AddMessage("BossAttackMageRogueLite(wampirehealth, useFireball, usecursedfang, fangtimeout, fangenergypct, electricbolttimeout, usesavagepower, useflame, usemeteor, useplazma, usefangritual, useshadow, useinflux, useenergywell, useelemental, warntbufflist, finalskill)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("BossAttackHeavy(warn)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("FullAttack(usefangritual, useshadow, useenergywell, useinflux, useelemental, useIntensification, usecatalyst, useplazma, electricbolttimeout, useflame, usesavagepower)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("BossAttackMageDruidLite(Recoverhealth, earthhealth, useFireball, usemagma, electricbolttimeout, usesavagepower, useflame, usemeteor, useplazma, usePerception, usemagictarget, useinflux, useenergywell, useelemental, warntbufflist, finalskill, donthealpvp)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("BossAttackMageWardenLite(usebladefirst, usesurge, useblade, useFireball, electricbolttimeout, usesavagepower, useflame, usemeteor, useplazma, usescepter, usebriar, useinflux, useenergywell, useelemental, usebriar, usemarking, warntbufflist, finalskill)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("MageStun(useDischarge, usephoenix, usepurgatory, rapidpurgatory, Dischargemessage)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
    DEFAULT_CHAT_FRAME:AddMessage("BuffAllMage(useIntensification, Intensificationfirst, useenergywell, usePerception, usemagictarget, useenergyinflux, usefireward, usesavageblessing, usefangritual, useshadowprotection, usebriar, usescepter, usemarking)");

	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("CastDemoralized(dontcasttdebuff)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
    DEFAULT_CHAT_FRAME:AddMessage("ChargeUp(chargeonly)");

	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
    DEFAULT_CHAT_FRAME:AddMessage("BreakSkill(usehumanrules, useLightning, usesilence, usesilencefirst, warntbufflist, castifwarning, Lightningmessage)");

	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
    DEFAULT_CHAT_FRAME:AddMessage("ProtectSelf(usedistract, earthProtectionPercent, RecoverPercent, crystalCandySlot, crystalCandyPercent, phirusSlot, phirusPercent, glovedebuflist, gloveslot)");

    DEFAULT_CHAT_FRAME:AddMessage("-------------------------------------------------------");
	
end

function PrintKurbishSignatureRogue()
	DEFAULT_CHAT_FRAME:AddMessage("------------------ KURBISH FUNCTIONS ROGUE ------------------");
	
	DEFAULT_CHAT_FRAME:AddMessage("BossAttackRogueDruid(attackslot, Recoverhealth, usehysteric, useinformer, useshadow, uselowblow,  usewound)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("BossAttackRoguePriest(attackslot, regeneratehealth, urgentPercent, useinformer, useshadow, uselowblow,  usewound)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("BuffAllRogueDruid(usehysteric, useinformer, useassasin, usekillin)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("LookAroundAndAttackRogue(attackslot, turnaround, Recoverpct, manapct, manaslot, manabuffname)");
	
	DEFAULT_CHAT_FRAME:AddMessage("-------------------------------------------------------");

end

function PrintKurbishSignatureTank()

	DEFAULT_CHAT_FRAME:AddMessage("------------------ KURBISH FUNCTIONS TANK ------------------");

	DEFAULT_CHAT_FRAME:AddMessage("BossAttackTank(doattack, attackslot, usehatred, usewhirl, useholyseal, usearmor, hphiruspct, hphirusslot, mphiruspct, mphirusslot, pctmanacritic, disarmamentcount, useatonement,  useholystrike, usepunishment, usethreaten)");

	DEFAULT_CHAT_FRAME:AddMessage("-------------------------------------------------------");
	
end

function PrintKurbishSignatureDruid()

	DEFAULT_CHAT_FRAME:AddMessage("------------------ KURBISH FUNCTIONS DRUID ------------------");

	DEFAULT_CHAT_FRAME:AddMessage("NatureAttackDruidScout(cameliahealth1, cameliahealth2, cameliahealth3, blossominghealth, earthhealth, Recoverhealth, rockhealth, forceRecoverfriendlyhealth, userockslide, usebriar, usevampirearrow, useFireball, useearthpulse, useeartharrow)");

	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
    DEFAULT_CHAT_FRAME:AddMessage("NatureAttackDruidRogue(useweakening, usewithering , blossominghealth, earthhealth, Recoverhealth, rockhealth, userockslide, usewrath, usebriar, usecorrosive, usewidow, useearthpulse, useeartharrow, donthealpvp)");

	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("NatureAttackDruidMage(useweakening, usewithering , blossominghealth, earthhealth, Recoverhealth, rockhealth, userockslide, useFireball, usewrath, usebriar, useearthpulse, useeartharrow, donthealpvp)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
    DEFAULT_CHAT_FRAME:AddMessage("NatureBossDruidMage(useweakening, usewithering , selfblossominghealth, blossominghealth, earthhealth, Recoverhealth, forceRecoverifbuffed, restorehealth, rockhealth, sendsystemmessage, doattack)");
		
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("DruidSelfHeal(useblossoming, Recoverhealth, forceRecoverifbuffed, restorehealth, rockhealth, crystalCandySlot, crystalCandyPercent, phirusSlot, phirusPercent, earthhealth, glovedebuflist, gloveslot, sendsystemmessage)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("BreakSkillDruidMage(usehumanrules, useLightning, usesilence, usebinding, usesilencefirst, warntbufflist, castifwarning, Lightningmessage)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("SetTank()");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("DruidPartyHeal2(targetableSkillSlot, criticalhealthpct, blossominghealth, earthhealth, Recoverhealth, restorehealth, keeptankRecovered, keepselfRecovered, doattack)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
    DEFAULT_CHAT_FRAME:AddMessage("DruidMageTimedHeal(targetableSkillSlot, useSpring, blossominghealth)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
    DEFAULT_CHAT_FRAME:AddMessage("BuffAllDruid(useconcentration, useblessing, usemagicturmoil, usesavage, usefireward)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("BreakSkillDruidScout(usebinding, usethroat)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("BreakSkillDruidRogue(usebinding, useblind)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("LookAroundAndAttackDruid(attackslot, attackfirst, turnaround, blossomingpct, Recoverpct, manapct, manaslot, manabuffname)");

	DEFAULT_CHAT_FRAME:AddMessage("-------------------------------------------------------");
	
end

function PrintKurbishSignaturePriest()

	DEFAULT_CHAT_FRAME:AddMessage("------------------ KURBISH FUNCTIONS PRIEST ------------------");

	DEFAULT_CHAT_FRAME:AddMessage("ProtectSelfPriest(holyauropercent, wavehealth, regeneratePercent, urgentPercent, crystalCandySlot, crystalCandyPercent, phirusSlot, phirusPercent, glovedebuflist, gloveslot)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("PriestGroupHeal(useLastPrayer)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("BossAttackPriestKnight(holyauropercent, regeneratePercent, urgentPercent, useMagicBarrier, useBlessedWater, useGrace, useEnchancedArmor, useBoneChill, useRisingTide, donthealpvp)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("BuffAllPriest(useMagicBarrier, useBlessedWater, useGrace, useEnchancedArmor, useDivine, useWave)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("PriestTimedHeal(targetableSkillSlot, urgenthealth, regenhealth)");
	
	DEFAULT_CHAT_FRAME:AddMessage("-------------------------------------------------------");

end


function PrintKurbishSignatureLookAround()

	DEFAULT_CHAT_FRAME:AddMessage("------------------ KURBISH FUNCTIONS LOOK AROUND ------------------");

	DEFAULT_CHAT_FRAME:AddMessage("LookAroundAndTarget(lookaroundenabled)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("ToggleLookAround()");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("LookAroundAndAttack(attackslot, turnaround, Recoverpct, Recoverspell, Recoverbuffname, forceRecoverpct, manapct, manaslot, manabuffname)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("LookAroundAndAttackWithPotion(attackslot, turnaround, potionpct, potionslot, potionbuffname)");

	DEFAULT_CHAT_FRAME:AddMessage("-------------------------------------------------------");
	
end


function PrintKurbishSignatureDiyce()

    DEFAULT_CHAT_FRAME:AddMessage("DirectDPSMage(useIntensification, useboltfirst, electricbolttimeout, usemagma, useFireball, useearthpulse, uselighting, useflame, usemeteor, useplasma, earthhealth, Recoverhealth)");

	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("DirectDPSMageRogue(useIntensification, useboltfirst, wampirehealth, electricbolttimeout, usecursedfangs, forcecursedfangs, useFireball,  uselighting, useflame, usemeteor, useplasma, phirusPercent, phirusSlot)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");

    DEFAULT_CHAT_FRAME:AddMessage("BossAttackMage(shieldon, usefangritual, useshadowprotection, useIntensification, useenergywell, usePerception, usemagictarget, useenergyinflux, dointerrupt, interrupt_list, useweakness , wampirehealth, electricbolttimeout, usecursedfangs, forcecursedfangs, usemagma, useFireball, usemystic, useplasma, useflame, usemeteor, earthhealth, Recoverhealth, phirusPercent, phirusSlot)");

	DEFAULT_CHAT_FRAME:AddMessage(" ");

end

function PrintKurbishSignatureTest()

	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("SayMessage(message)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
    DEFAULT_CHAT_FRAME:AddMessage("ToggleDebug()");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");

    DEFAULT_CHAT_FRAME:AddMessage("PrintDebuffs(who)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");

    DEFAULT_CHAT_FRAME:AddMessage("PrintBuffs(who)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("PrintPlayerStatus(who)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	
	DEFAULT_CHAT_FRAME:AddMessage("PrintPartyInfo(criticalhealth)");
	
	DEFAULT_CHAT_FRAME:AddMessage(" ");

end