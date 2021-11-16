Scriptname _SunHelmMain extends Quest
;This script attaches to the main SH quest
;Also handles need startups

_SH_MCMScript property _SHMcm auto
_SHPlayerScript property _SHPlayer auto

Quest property _SHStart auto
Quest property _SHDialogueQuest auto

;Properties
Actor property Player auto

Activator property _SH_Survival_NodeController auto

;Globals
GlobalVariable Property _SHEnabled Auto
GlobalVariable Property _SHDisableFT auto
GlobalVariable Property _SHTutsEnabled auto
GlobalVariable property _SHFirstTimeEnabled auto
GlobalVariable property _SHCannibalism auto
GlobalVariable property _SHRawDamage auto
GlobalVariable property _SHCarryWeight auto
GlobalVariable Property _SHHungerShouldBeDisabled auto
GlobalVariable Property _SHThirstShouldBeDisabled auto
GlobalVariable Property _SHFatigueShouldBeDisabled auto
GlobalVariable Property _SHColdShouldBeDisabled auto
GlobalVariable Property _SHFirstPersonMessages auto
GlobalVariable property _SHIsLichGlobal auto
GlobalVariable Property _SHAnimationsEnabled auto
GlobalVariable Property _SHForceDisableCold auto
GlobalVariable property _SHRefillAnims auto
GlobalVariable Property _SHIsSexMale auto
GlobalVariable Property _SHContinuance1Line auto
GlobalVariable Property _SHDetailedContinuance auto
GlobalVariable Property _SHVampireNeedsOption Auto
GlobalVariable Property _SHNumDrinks Auto
GlobalVariable Property _SHIsVampireGlobal auto

GlobalVariable Property _SHIsInWater auto

GlobalVariable Property _SHIsVR auto

WorldSpace Property Tamriel Auto
WorldSpace Property DLC2SolstheimWorld Auto
WorldSpace Property BSHeartland auto
WorldSpace Property Wyrmstooth auto

;Spells
Spell Property _SHConfigSpell Auto
Spell Property _SHPlayerSpell auto
Spell property _SHContinuanceSpell auto
Spell property _SHFillAllSpell auto
Spell property _SHDrunkSpell auto
Spell property _SHSkoomaSpell auto
Spell property _SHFoodPoisoningSpell auto

Ingredient Property SaltPile Auto

;Scripts
_SHHungerSystem Property Hunger Auto
_SHThirstSystem Property Thirst Auto
_SHFatigueSystem Property Fatigue Auto
_SHCompatabilityScript Property ModComp auto
_SHColdSystem Property Cold auto

;Messages
Message Property _SHSleepStartMessage Auto

Message Property _SHStandWater auto
Message Property _SHStandWaterFirst auto

;Leveled
LeveledItem property LItemFoodInnCommon auto
LeveledItem property LItemBarrelFoodSame75 auto
LeveledItem property DLC2LootBanditRandom auto
LeveledItem property LootBanditRandom auto
LeveledItem property LootBanditRandomWizard auto

LeveledItem property _SHLLWaterSkin15 auto      ;Lowered to 5%
LeveledItem property _SHLLWater15 auto          ;Lowered to 5%
LeveledItem property _SHLLWater25 auto

;potions
Potion property _SHWaterBottleMead auto
Potion property _SHWaterBottleWine auto
Potion property _SHWaterskin_1 auto
Potion property _SHWaterskin_2 auto
Potion property _SHWaterskin_3 auto
Potion property _SHWaterskinSalt auto
Potion property _SHSujammaWaterBottle auto
Potion property _SHSaltBottleMead auto
Potion property _SHSaltBottleWine auto
Potion property _SHSaltBottleSujamma auto

MiscObject property _SHEmptyMeadMisc auto
MiscObject property _SHEmptyWineMisc auto
MiscObject property _SHEmptySujammaMisc auto

bool property SkyrimVR auto
bool startup = false

Sound property _SHDrink auto
Sound property _SHFillWaterM auto

;bools
Bool Property InWater
	Bool Function Get()
        if _SHIsInWater.GetValue() == 1.0
            return true
        else
            return false
        endif
		;Return PO3_SKSEFunctions.IsActorInWater(Player)
	EndFunction
EndProperty

bool property SKSEInstalled = false auto
bool property BeastWerewolf auto
bool property HumanWerewolf auto
bool property VampireThirst = true auto
bool property CampfireInstalled = false auto
bool property introMessageShown = false auto
bool property MCMCannibal = false auto
bool property HasFoodPoison = false auto

bool property LLItemsAdded = false auto hidden
;Misc
int property SKSEVersion auto
MiscObject property _SHMeadEmptyMisc auto
MiscObject property _SHWineEmptyMisc auto
MiscObject property _SHWaterskinEmpty auto

Perk property _SHCannibalPerks auto
Perk property _SHMiscActivations auto

;Widget Properties
Float property WidgetAlphaLevel = 100.00 auto
int property _SHDrinksConsumed auto

Idle Property idlepickup_ground Auto
Idle Property IdleStop_Loose Auto

Keyword property IsBeastRace auto
Keyword property _SH_LightFoodKeyword auto
Keyword property _SH_MediumFoodKeyword auto
Keyword property _SH_HeavyFoodKeyword auto
Keyword property _SH_SoupKeyword auto
Keyword property _SH_MeadBottleKeyword auto
Keyword property _SH_WineBottleKeyword auto
Keyword property _SH_SujammaBottleKeyword auto

Keyword property _SH_MeadWATERBottleKeyword auto
Keyword property _SH_WineWATERBottleKeyword auto
Keyword property _SH_SujammaWATERBottleKeyword auto

Keyword property _SH_DrinkKeyword auto
Keyword property _SH_AlcoholDrinkKeyword auto
Keyword property _SHSaltWaterKeyword auto

Keyword property VendorItemFoodRaw auto

Race property WoodElfRace auto

float property ModVersion auto

bool initUpdate = false
;Oblivion variables

bool property isInOblivion auto
FormList property _SHOblivionWorlds auto
FormList property _SHOblivionLctns auto
FormList property _SHOblivionCells auto
bool property wasInOblivion = false auto
bool lockSurvival = false
bool progress25 = false
bool progress50 = false
bool progress75 = false

;----Strings------

string property NoSKSE = "SKSE NOT INSTALLED. SUNHELM MAY NOT FUNCTION PROPERLY" auto
string property NoSkyUI = "SkyUI not installed. A limited config spell can be used to start the mod, but settings wont be available." auto
;Events

;Oninit fires when the quest is first initialized
;Adds the spell and then is started with the config
Event Oninit()
    
    RegisterForSleep()
    RegisterForSingleUpdate(5)  
EndEvent

;When a stop sleep event is caught, start the mod up
Event OnSleepStop(bool abInterrupted)

    If (_SHEnabled.GetValue() == 0)
        int option = _SHSleepStartMessage.Show()
        introMessageShown = true
        If (option == 0)
            StartMod()
        EndIf
        SendModEvent("_SH_WidgetUi") 
        SendModEvent("_SH_WidgetColdUi")  
    EndIf
    UnregisterForSleep()
EndEvent
;Functions

;Stop updating when mod is enabled
Event OnUpdate()

    if(!initUpdate)
        CheckForUpdate()
        initUpdate = true
    endif

    ;Dont enable during intro
    if !Game.IsFightingControlsEnabled() || Player.IsInInterior()
		RegisterForSingleUpdate(5)
		return
    endif
    
    if(_SHStart.GetStage() == 0)
        _SHStart.SetStage(10)
    endif

endEvent

Function CheckForUpdate()
    
    CheckGameInfo()
    
    ;If a mod version is set
    if(ModVersion)
        ;Check for update
        if(ModVersion < 3.06)
            Debug.Notification("SunHelm is currently updating. Please do not open the MCM.")

            if(ModVersion < 3.00)
                Debug.Notification("INCOMPATIBLE VERSION DETECTED: YOU ARE ON A 3.0.0 INCOMPATIBLE SAVE. YOU NEED A NEW GAME FOR 3.0.0+.")
            endif       
            
            int alreadyEnabled = _SHEnabled.GetValue() as int
            ;Refresh the mod
            
            if(alreadyEnabled == 1)
                StopMod()
                StartMod()
            endif
            
            ;Update the activation perk
            if(ModVersion == 3.02)
                _SHPlayer.UpdateActivationPerk()
            endif

            ModComp.CleanLists()
            
            Debug.Notification("SunHelm is updated to: 3.0.6")
        endif
    endif
    ModVersion = 3.06
    
    ModComp.CheckMods()
EndFunction

Function CheckGameInfo()

    Player = game.GetPlayer()

    if(!Game.GetFormFromFile(0x00000802, "SkyUI_SE.esp"))
        Player.AddSpell(_SHConfigSpell, False)
        Debug.Notification(NoSkyUI)
    Else
        SKSEVersion = SKSE.GetVersion() 
        if(SKSEVersion > 0)
            SKSEInstalled = true
        Else
            Debug.Notification(NoSKSE)
        EndIf
    EndIf
    
    If Player.GetActorBase().GetSex() == 0
        _SHIsSexMale.SetValue(1.0)
    Else
        _SHIsSexMale.SetValue(0.0)
    EndIf

EndFunction

Function StartMod()
    If (_SHEnabled.GetValue() == 0 && !startup)
        Utility.Wait(5)
        _SHEnabled.SetValue(1.0)
        startup = true
        Player = Game.GetPlayer()
        Player.AddSpell(_SHPlayerSpell, false)
        _SHDialogueQuest.Start()
        
        if(Debug.GetVersionNumber() < "1.5.97.0")
            _SHIsVR.SetValue(1.0)
        endif
        AddDrinksAndOthersToList()
        ModStartCannibalism()
        ModStartPowersPerks()
        ModStartPlayerUpdates()
        HandleModStartDiseases()
        
        if(!introMessageShown)    
            introMessageShown = true
        endif
        
        ModStartSystems()
        
        _SHStart.SetStage(20)
        startup = false
    EndIf
    _SHFirstTimeEnabled.SetValue(0)
EndFunction

;Stops the mod ie. removes effects etc.
Function StopMod()
    If (_SHEnabled.GetValue() == 1)
        RemoveDrinksFromList()
        _SHEnabled.SetValue(0)
        _SHPlayer.stopUpdating = true
        _SHDialogueQuest.Stop()
        HandleModStopDiseases()
        RemovePowersAndEffects()
        StopSystems()
        Player.RemovePerk(_SHCannibalPerks)
        Player.RemovePerk(_SHMiscActivations)
        Game.EnableFastTravel(true)
    Else
        Debug.Notification("SunHelm already disabled...")
    EndIf
EndFunction

Function ModStartPowersPerks()
    AddPowers()
    Player.AddPerk(_SHCannibalPerks)   
    Player.AddPerk(_SHMiscActivations)
EndFunction

Function ModStartPlayerUpdates()
    ;Start player updates
    _SHPlayer.stopUpdating = false
    wasInOblivion = false
    _SHPlayer.Update()
EndFunction

Function ModStartSystems()
    if(_SHIsVampireGlobal.GetValue() == 0)
        StartSystems()
    else
        VampireChangeNeeds(_SHVampireNeedsOption.GetValue() as int)
    endif
EndFunction

Function ModStartCannibalism()
    ;Auto enable cannibalism
    if(Game.GetPlayer().GetRace() == WoodElfRace)
        _SHCannibalism.SetValue(1)
    Elseif(MCMCannibal)
        ;enable cannibal if it was before
        _SHCannibalism.SetValue(1)
    endif
EndFunction

Function HandleModStartDiseases()
    Quest DiseaseQuest = Game.GetFormFromFile(0x0000FB5C,"SunHelmDiseases.esp") as Quest
    if(!DiseaseQuest.IsRunning())
        DiseaseQuest.Start()
    endif
EndFunction

Function HandleModStopDiseases()
    Quest DiseaseQuest = Game.GetFormFromFile(0x0000FB5C,"SunHelmDiseases.esp") as Quest
    if(DiseaseQuest)
        Spell _SHCureDiseaseSpell = Game.GetFormFromFile(0x0003835D,"SunHelmDiseases.esp") as Spell
        _SHCureDiseaseSpell.Cast(Player)
        DiseaseQuest.Stop()
    endif
EndFunction

Function RemovePowersAndEffects()
    Player.RemoveSpell(_SHContinuanceSpell)
    Player.RemoveSpell(_SHFillAllSpell)
    Player.RemoveSpell(_SHFoodPoisoningSpell)
    Player.RemoveSpell(_SHPlayerSpell)     
endFunction

Function AddPowers()
    Player.AddSpell(_SHContinuanceSpell, false)
    Player.AddSpell(_SHFillAllSpell, false)
endFunction

Function DrinkAndFill()
    if(InWater)
        ;Check bottles
        int meadCount = Player.GetItemCount(_SHEmptyMeadMisc)
        if(meadCount > 0)
            Player.RemoveItem(_SHEmptyMeadMisc,meadCount)
        endif

        int emptySkinCount = Player.GetItemCount(_SHWaterskinEmpty)
        int oneSkinCount = Player.GetItemCount(_SHWaterskin_1)
        int twoSkinCount = Player.GetItemCount(_SHWaterskin_2)

        int skinCount = emptySkinCount + oneSkinCount + twoSkinCount
        if(skinCount > 0)
            Player.RemoveItem(_SHWaterskinEmpty,emptySkinCount)
            Player.RemoveItem(_SHWaterskin_1,oneSkinCount)
            Player.RemoveItem(_SHWaterskin_2,twoSkinCount)
        endif

        int wineCount
        wineCount = Player.GetItemCount(_SHEmptyWineMisc)
        if(wineCount > 0)
            Player.RemoveItem(_SHEmptyWineMisc,wineCount)
        endif

        int sujammaCount
        sujammaCount = Player.GetItemCount(_SHEmptySujammaMisc)
        if(sujammaCount > 0)
            Player.RemoveItem(_SHEmptySujammaMisc,sujammaCount)
        endif

        if(wineCount > 0 || meadCount > 0 || sujammaCount > 0 || skinCount > 0)
            SendModEvent("_SH_IncreaseSurvivalSkill")
            if(_SHRefillAnims.GetValue() == 1.0)
                PlayFillAnimation()
            endif
        else
                ;Dont play fill sounds
            PlayFillAnimation(false)
        endif

        ;Fresh Water
        if(!IsInSaltwater())
            if(meadCount > 0)
                Player.AddItem(_SHWaterBottleMead, meadCount)
            endif

            if(wineCount > 0)
                Player.AddItem(_SHWaterBottleWine, wineCount)
            endif

            if(sujammaCount > 0)
                Player.AddItem(_SHSujammaWaterBottle, sujammaCount)
            endif

            if(skinCount > 0)
                Player.AddItem(_SHWaterskin_3, skinCount)
            endif

            if(Thirst.IsRunning())
                _SHDrink.Play(Player)
                Thirst.DecreaseThirstLevel(40)
            endif

        ;SaltWater
        else
            
            if(meadCount > 0)
                Player.AddItem(_SHSaltBottleMead, meadCount)
            endif

            if(wineCount > 0)
                Player.AddItem(_SHSaltBottleWine, wineCount)
            endif

            if(sujammaCount > 0)
                Player.AddItem(_SHSaltBottleSujamma, sujammaCount)
            endif

            if(skinCount > 0)
                Player.AddItem(_SHWaterskinSalt, skinCount)
            endif          
        endif
    Else
        if(_SHFirstPersonMessages.GetValue() == 1)
            _SHStandWaterFirst.Show()
        else
            _SHStandWater.Show()
        endif
    endif
endFunction

Function AlcoholDrink()

    _SHDrinksConsumed = _SHDrinksConsumed + 1
    Player = Game.GetPlayer()

    if(_SHDrinksConsumed >= _SHNumDrinks.GetValue())
        _SHDrinksConsumed = 0   ;Reset drink count
        _SHDrunkSpell.Cast(Player,Player)
    endif
EndFunction

Function ResetDrinkCount()

    _SHDrinksConsumed = 0

EndFunction

;TODO Split off the percentage based calculations to each individual script
Function ContinuancePower()

    float firstPerson = _SHFirstPersonMessages.GetValue()
    
    string hungerString = ""
    string hungerValString = ""
    string thirstString = ""
    string thirstValString = ""
    string fatigueString = ""
    string fatigueValString = ""
    string coldString = ""
    string coldValString = ""
    
    if(Hunger.IsRunning())
        hungerValString = "Hunger: " + Hunger.GetHungerPercent() + "%"

        int CurrentHungerStage = Hunger.CurrentHungerStage
        ;hungerString = "Hunger: "
        hungerString = ""
        If (CurrentHungerStage == 0)
            hungerString += "Well Fed, "
        ElseIf (CurrentHungerStage == 1)
            hungerString += "Satisfied, "
        ElseIf (CurrentHungerStage == 2)
            hungerString += "Peckish, "
        ElseIf (CurrentHungerStage == 3)
            hungerString += "Hungry, "
        ElseIf (CurrentHungerStage == 4)
            hungerString += "Ravenous, "
        ElseIf (CurrentHungerStage == 5)
            hungerString += "Starving, "
        EndIf
    endif
    
    if(Fatigue.IsRunning())
        fatigueValString = "Exhaustion: " + Fatigue.GetFatiguePercent() + "%"

        int CurrentFatigueStage = Fatigue.CurrentFatigueStage
        ;fatigueString = "Exhaustion: "
        fatigueString = ""
        
        If (CurrentFatigueStage == 0)
            fatigueString += "Well Rested, "
        ElseIf (CurrentFatigueStage == 1)
            fatigueString += "Rested, "     
        ElseIf (CurrentFatigueStage == 2)
            fatigueString += "Slightly Tired, "    
        ElseIf (CurrentFatigueStage == 3)
            fatigueString += "Tired, "     
        ElseIf (CurrentFatigueStage == 4)
            fatigueString += "Weary, "      
        ElseIf (CurrentFatigueStage == 5)
            fatigueString += "Exhausted, "
        EndIf
    endif
    
    if(Thirst.IsRunning())
        thirstValString = "Thirst: " + Thirst.GetThirstPercent() + "%"

        int CurrentThirstStage = Thirst.CurrentThirstStage
        
        ;thirstString = "Thirst: "
        thirstString = ""
        
        If (CurrentThirstStage == 0)
            thirstString += "Quenched, " 
        ElseIf (CurrentThirstStage == 1)
            thirstString += "Sated, "       
        ElseIf (CurrentThirstStage == 2)
            thirstString += "Thirsty, "    
        ElseIf (CurrentThirstStage == 3)
            thirstString += "Parched, "    
        ElseIf (CurrentThirstStage == 4)
            thirstString += "Dehydrated, "    
        ElseIf (CurrentThirstStage == 5)
            thirstString += "Severely Dehydrated, "    
        EndIf
    endif

    if(Cold.IsRunning())
        coldValString = "Cold: " + ((Cold._SHCurrentColdLevel.GetValue() / 900)*100) as int  + "%"

        int CurrentColdStage = Cold.CurrentColdStage
        ;coldString = "Cold: "
        coldString = ""
        
        If (CurrentColdStage == 0)
            coldString += "Warm" 
        ElseIf (CurrentColdStage == 1)
            coldString += "Comfortable"       
        ElseIf (CurrentColdStage == 2)
            coldString += "Chilly"    
        ElseIf (CurrentColdStage == 3)
            coldString += "Cold"    
        ElseIf (CurrentColdStage == 4)
            coldString += "Freezing"    
        ElseIf (CurrentColdStage == 5)
            coldString += "Frigid"    
        EndIf
    endif

    if(_SHDetailedContinuance.GetValue() == 1.0)
        if(_SHContinuance1Line.GetValue() == 1.0)
            Debug.Notification(hungerValString + " " + hungerString + fatigueValString + " " + fatigueString + thirstValString + " " + thirstString + coldValString + " " + coldString)
        Else
            Debug.Notification(hungerValString + ": " +  hungerString)
            Debug.Notification(fatigueValString + ": " + fatigueString)
            Debug.Notification(thirstValString +": " + thirstString)
            Debug.Notification(coldValString + ": " + coldString)
        endif
    Else
        if(_SHContinuance1Line.GetValue() == 1.0)
            Debug.Notification(hungerValString + ", " + fatigueValString + ", " + thirstValString + ", " + coldValString)
        Else
            Debug.Notification(hungerValString)
            Debug.Notification(fatigueValString)
            Debug.Notification(thirstValString)
            Debug.Notification(coldValString)
        endif
    endif
    
    if(_SHIsVR.GetValue() == 1)
        Debug.Notification("Warmth Rating: " + Cold.VRCalcArmorWarmth())
    endif

EndFunction

;----------------------LEVELED LISTS FUNCTIONS--------------
function AddDrinksAndOthersToList()

    if(LLItemsAdded == false)
        LItemFoodInnCommon.AddForm(_SHWaterBottleMead, 1, 1)
        LItemFoodInnCommon.AddForm(_SHWaterBottleMead, 1, 1)
        LItemFoodInnCommon.AddForm(_SHWaterBottleMead, 1, 2)
        LItemFoodInnCommon.AddForm(_SHWaterBottleMead, 1, 3)

        LItemFoodInnCommon.AddForm(_SHWaterBottleWine, 1, 1)
        LItemFoodInnCommon.AddForm(_SHWaterBottleWine, 1, 1)
        LItemFoodInnCommon.AddForm(_SHWaterBottleWine, 1, 2)
        LItemFoodInnCommon.AddForm(_SHWaterBottleWine, 1, 3)

        LItemBarrelFoodSame75.AddForm(_SHMeadEmptyMisc, 1, 1)
        LItemBarrelFoodSame75.AddForm(_SHWineEmptyMisc, 1, 1)

        LootBanditRandom.AddForm(_SHLLWater15, 1 , 1)
        LootBanditRandom.AddForm(_SHLLWaterSkin15, 1, 1)
        LootBanditRandomWizard.AddForm(_SHLLWater15, 1 , 1)
        LootBanditRandomWizard.AddForm(_SHLLWaterSkin15, 1, 1)
        DLC2LootBanditRandom.AddForm(_SHLLWater15, 1 , 1)
        DLC2LootBanditRandom.AddForm(_SHLLWaterSkin15, 1, 1)

        LLItemsAdded = true
    EndIf
EndFunction

;Not sure if this should be used
function RemoveDrinksFromList()
    LItemFoodInnCommon.Revert()
    LItemBarrelFoodSame75.Revert()

    LootBanditRandom.Revert()
    LootBanditRandomWizard.Revert()
    DLC2LootBanditRandom.Revert()
EndFunction
;------------------------------END LL FUNCTIONS-------------

Function PlayFillAnimation(bool playFillSound = true)
    If (_SHRefillAnims.GetValue() == 1.0)
        If Utility.IsInMenuMode()
            Game.DisablePlayerControls(False, False, False, False, False, True)
            Utility.Wait(0.01)
            Game.EnablePlayerControls(False, False, False, False, False, True)
            Utility.Wait(0.25)
        EndIf

        If Player.IsWeaponDrawn()
            If SKSEVersion > 0.0
                Player.SheatheWeapon()
                Utility.Wait(2)
            endif
        endif

        If Player.GetAnimationVariableInt("i1stPerson") as Int == 1
            Game.ForceThirdPerson()
            Utility.Wait(1.0)
            Player.PlayIdle(idlepickup_ground)
            Utility.Wait(1.0)

            if(playFillSound)
                _SHFillWaterM.Play(Player)
            endif

            Utility.Wait(1.0)

            Player.PlayIdle(IdleStop_Loose)
            Utility.Wait(1.0)
            Game.ForceFirstPerson()
        else
            Utility.Wait(1.0)
            Player.PlayIdle(idlepickup_ground)
            Utility.Wait(1.0)

            if(playFillSound)
                _SHFillWaterM.Play(Player)
            endif

            Utility.Wait(1.0)
            Player.PlayIdle(IdleStop_Loose)
            Utility.Wait(1.0)
        endif
    EndIf
EndFunction
;------------------------------END--------------------------------

bool Function IsInSaltwater()

	if Player.GetWorldSpace() == Tamriel

		if Player.GetPositionY() > 104000.0
			Return True
		elseif Player.GetPositionY() > 86500.0 && Player.GetPositionX() < -10800.0
			Return True
		elseif Player.GetPositionY() > 50250.0 && Player.GetPositionX() > 109250.0
			Return True
		else
			Return False
		endif
		
	elseif DLC2SolstheimWorld != None && Player.GetWorldSpace() == DLC2SolstheimWorld
		if Player.GetPositionX() < 31070.0
			Return True
		elseif Player.GetPositionY() < 24385.0
			Return True
		elseif Player.GetPositionY() > 79100.0
			Return True
		elseif Player.GetPositionX() > 76350.0
			Return True	
		else
			Return False
		endif
		
	else
		Return False
	endif
endFunction

Function VampireChangeNeeds(int option)
    if(_SHIsVampireGlobal.GetValue() == 1.0 && _SHEnabled.GetValue() == 1)
        if(option == 0)
            _SHColdShouldBeDisabled.SetValue(1.0)
            _SHThirstShouldBeDisabled.SetValue(1.0)
            _SHFatigueShouldBeDisabled.SetValue(1.0)
            _SHHungerShouldBeDisabled.SetValue(1.0)
        elseif(option == 1)
            _SHColdShouldBeDisabled.SetValue(1.0)
            _SHThirstShouldBeDisabled.SetValue(0.0)
            _SHFatigueShouldBeDisabled.SetValue(1.0)
            _SHHungerShouldBeDisabled.SetValue(1.0)
        Elseif(option == 2)
            _SHColdShouldBeDisabled.SetValue(1.0)
            _SHThirstShouldBeDisabled.SetValue(0.0)
            _SHFatigueShouldBeDisabled.SetValue(0.0)
            _SHHungerShouldBeDisabled.SetValue(1.0)
        ElseIf (option == 3)
            _SHColdShouldBeDisabled.SetValue(0.0)
            _SHThirstShouldBeDisabled.SetValue(0.0)
            _SHFatigueShouldBeDisabled.SetValue(0.0)
            _SHHungerShouldBeDisabled.SetValue(0.0)
        endif
    else
        if(option == 4)
            _SHColdShouldBeDisabled.SetValue(0.0)
            _SHThirstShouldBeDisabled.SetValue(0.0)
            _SHFatigueShouldBeDisabled.SetValue(0.0)
            _SHHungerShouldBeDisabled.SetValue(0.0)
        endif
    endif
EndFunction

Function LichChangeNeeds(int option)
    if(_SHIsLichGlobal.GetValue() == 1 && _SHEnabled.GetValue() == 1)
        ;Immortal
        if(option == 0)
            _SHColdShouldBeDisabled.SetValue(1.0)
            _SHThirstShouldBeDisabled.SetValue(1.0)
            _SHFatigueShouldBeDisabled.SetValue(1.0)
            _SHHungerShouldBeDisabled.SetValue(1.0)
        ;Mortal
        Else
            _SHColdShouldBeDisabled.SetValue(0.0)
            _SHThirstShouldBeDisabled.SetValue(0.0)
            _SHFatigueShouldBeDisabled.SetValue(0.0)
            _SHHungerShouldBeDisabled.SetValue(0.0)
        endif
    endif
EndFunction

;Starts the needs
Function StartSystems()
    StartCold()
    StartHunger()
    StartThirst()
    StartFatigue()
    SendModEvent("_SH_WidgetUi") 
    SendModEvent("_SH_WidgetColdUi")  
EndFunction

;Stops the needs
Function StopSystems()
    StopCold()
    StopThirst()
    StopFatigue()
    StopHunger()
EndFunction

;Pause needs where they are
Function PauseNeeds()
    StopCold()
    
    if(Thirst.IsRunning())
        Thirst.PauseUpdates()
    endif

    if(Hunger.IsRunning())
        Hunger.PauseUpdates()
    endif
    
    if(Fatigue.IsRunning())
        Fatigue.PauseUpdates()
    endif

    ;Update the timestamps so next update doesnt progress needs.
    UpdateAllTimeStamps()
EndFunction

;Start needs back up after pausing
Function ResumeNeeds()

    StartCold()
    if(_SHThirstShouldBeDisabled.GetValue() == 0.0)
        Thirst.ResumeUpdates()
    endif

    if(_SHHungerShouldBeDisabled.GetValue() == 0.0)
        Hunger.ResumeUpdates()
    endif

    if(_SHFatigueShouldBeDisabled.GetValue() == 0.0)
        Fatigue.ResumeUpdates()
    endif
EndFunction

;Updates all time stamps to current time when called
Function UpdateAllTimeStamps()
    Hunger._SHHungerTimeStamp.SetValue(Utility.GetCurrentGameTime())
    Fatigue._SHFatigueTimeStamp.SetValue(Utility.GetCurrentGameTime())
    Thirst._SHThirstTimeStamp.SetValue(Utility.GetCurrentGameTime())
EndFunction

;Stop functions so that other scripts may access stop functions
Function StopThirst()
    if(Thirst.IsRunning())
        Thirst.StopSystem()
        SendModEvent("_SH_UpdateWidget")
    endif
EndFunction

Function StopHunger()
    if(Hunger.IsRunning())
        Hunger.StopSystem()
        SendModEvent("_SH_UpdateWidget")
    endif
EndFunction

Function StopFatigue()
    if(Fatigue.IsRunning())
        Fatigue.StopSystem()
        SendModEvent("_SH_UpdateWidget")
    endif
EndFunction

Function StopCold()
    if(Cold.IsRunning())
        Cold.StopSystem()
    endif
EndFunction

Function StartCold()  
    if(_SHColdShouldBeDisabled.GetValue() == 0.0 && _SHForceDisableCold.GetValue() == 0.0)
        Cold.StartSystem()
    endif
EndFunction

Function StartFatigue()
    if(_SHFatigueShouldBeDisabled.GetValue() == 0.0)
        Fatigue.StartSystem()
        SendModEvent("_SH_UpdateWidget")
    endif
EndFunction

Function StartHunger()
    if(_SHHungerShouldBeDisabled.GetValue() == 0.0)
        Hunger.StartSystem()
        SendModEvent("_SH_UpdateWidget")
    endif
EndFunction

Function StartThirst()
    if(_SHThirstShouldBeDisabled.GetValue() == 0.0)
        Thirst.StartSystem()
        SendModEvent("_SH_UpdateWidget")
    endif
EndFunction
