Scriptname _SHPlayerScript extends ReferenceAlias  

_SunHelmMain property _SHMain auto
PRKF__SHMiscActivations_052EE749 property _SHActivations auto
FormList property _SHAlcoholList auto
FormList property _SHSkoomaList auto
FormList property _ShBlackBooks auto
FormList Property _SHCampfireBackPacks auto

bool property stopUpdating = false auto

Keyword property _SH_AlcoholDrinkKeyword auto
Spell property _SHSkoomaSpell auto
GlobalVariable Property _SHIsRidingDragon auto
GlobalVariable property _SHEnabled auto
GlobalVariable property _SHDisableFT auto
GlobalVariable property _SHIsLichGlobal auto
GlobalVariable property _SHIsInDialogue auto
GlobalVariable property _SHForceDisableCold auto
GlobalVariable property _SHWaterskinEquip auto
GlobalVariable Property _SHIsVR auto
GlobalVariable Property _SHVampireNeedsOption Auto
GlobalVariable Property _SHHungerShouldBeDisabled auto
GlobalVariable Property _SHThirstShouldBeDisabled auto
GlobalVariable Property _SHFatigueShouldBeDisabled auto
GlobalVariable Property _SHColdShouldBeDisabled auto
GlobalVariable Property _SHInnKeeperDialogue auto
GlobalVariable Property _SHModShouldBeEnabled Auto
GlobalVariable Property _SHBedrollSleep auto

Spell property _SHBeverageWarmthSpell auto

GlobalVariable property _SHColdActive auto
Keyword property _SHHotBeverage auto
FormList property _SHHotBeverageList auto

FormList property _SHLichRaceList auto

float wasEquipped = 0.0

bool lastLichVal = false

Actor property Player auto
Form consumed

;_SHMain.CarriageTravelled = True
;if(_SHMain.Cold.IsRunning())
;    _SHMain.Cold.carriageTravel = true
;endif
;Utility.Wait(13)
;_SHMain.CarriageTravelled = false
;if(_SHMain.Cold.IsRunning())
;    _SHMain.Cold.carriageTravel = false
;endif
;if(_SHFirstPersonMessages.GetValue() == 1)
;    _SHCarriageTravelFirst.Show()
;Else
;    _SHCarriageTravel.Show()
;endif

Event OnPlayerLoadGame()
    ;Checking for update
    RegisterForMenu("MapMenu")
    RegisterForMenu("Dialogue Menu")
    _SHMain.CheckForUpdate()
    
    if(_SHForceDisableCold.GetValue() == 1.0)
        if(_SHMain.Cold.IsRunning())
            _SHMain.Cold.StopSystem()
        endif
    endif

    if(_SHEnabled.GetValue() == 1.0)
        CheckNeedsDisabled()
    endif 

EndEvent

;Called if updating from 3.02. Updates the perk properties
Function UpdateActivationPerk()

    _SHActivations._SHWaterskin_1 = _SHMain._SHWaterskin_1
    _SHActivations._SHWaterskin_2 = _SHMain._SHWaterskin_2
    _SHActivations._SHWaterskin_3 = _SHMain._SHWaterskin_3
    _SHActivations._SHVampireNeedsOption = _SHMain._SHVampireNeedsOption
    _SHActivations._SHWaterskinEmpty = _SHMain._SHWaterskinEmpty

EndFunction

;Event to detect alcohol and skooma
Event OnObjectEquipped(form akBaseObject, ObjectReference akReference)  
    if(_SHEnabled.GetValue() == 1.0)
        Potion foodEaten = (akBaseObject as Potion) 
        if(foodEaten && foodEaten.IsFood())
            consumed = akBaseObject
            HotBeverageCheck()            
            if(AlcoholCheck())
                _SHMain.AlcoholDrink()
            ElseIf (SkoomaCheck())
                _SHSkoomaSpell.Cast(Player,Player)
            endif
        endif
    elseif(akBaseObject as Armor)
        Armor item = akBaseObject as Armor
        _SHCampfireBackPacks = game.GetFormFromFile(0x0002C274, "Campfire.esm") as FormList

        if(_SHCampfireBackPacks && _SHCampfireBackPacks.HasForm(akBaseObject))          
            wasEquipped = _SHWaterskinEquip.GetValue()
            _SHWaterskinEquip.SetValue(0.0)
        elseif(_SHIsVR.GetValue() == 1.0 && _SHMain.Cold.IsRunning() && (item.IsBoots() || item.IsClothing() || item.IsCuirass() || item.IsGauntlets() || item.IsHelmet() || item.GetSlotMask() == 0x00010000))
            if(UI.IsMenuOpen("InventoryMenu"))
                RegisterForMenu("InventoryMenu")
            else
                _SHMain.Cold.VRCalcArmorWarmth(true)
            endif
        endif
    endif
endevent


Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
    ;if (akBaseObject as Armor && _SHCampfireBackPacks.HasForm(akBaseObject) && )
    ;    _SHWaterskinEquip.SetValue(wasEquipped)
    if(_SHIsVR.GetValue() == 1.0 && _SHMain.Cold.IsRunning())
        armor item = akBaseObject as armor
        if(item.IsBoots() || item.IsClothing() || item.IsCuirass() || item.IsGauntlets() || item.IsHelmet() || item.GetSlotMask() == 0x00010000)
            if(UI.IsMenuOpen("InventoryMenu"))
                RegisterForMenu("InventoryMenu")
            else
                _SHMain.Cold.VRCalcArmorWarmth(true)
            endif
        endif
    endIf
endEvent

Event OnUpdate()
    Update()
endevent

Event OnMenuOpen(String menuName)
    if(_SHEnabled.GetValue() == 1.0)
        if(menuName == "MapMenu")
            CheckFT()
        elseif(menuName == "Dialogue Menu")
            _SHIsInDialogue.SetValue(1.0)
        endif
    endif
endevent

Event OnMenuClose(String menuName)
    if(_SHEnabled.GetValue() == 1.0)
        if(menuName == "MapMenu")
            Game.EnableFastTravel(true)
        elseif(menuName == "Dialogue Menu")
            _SHIsInDialogue.SetValue(0.0)
        elseif(menuName == "InventoryMenu" && _SHIsVR.GetValue() == 1.0)
            _SHMain.Cold.VRCalcArmorWarmth(true)
            UnregisterForMenu("InventoryMenu")
        endif
    endif
endevent

Function CheckNeedsDisabled()

    If(_SHHungerShouldBeDisabled.GetValue() == 1.0)
        _SHMain.StopHunger()
    Else
        _SHMain.StartHunger()
    EndIf

    If(_SHThirstShouldBeDisabled.GetValue() == 1.0)
        _SHMain.StopThirst()
    Else
        _SHMain.StartThirst()
    EndIf

    If(_SHFatigueShouldBeDisabled.GetValue() == 1.0)
        _SHMain.StopFatigue()
    Else
        _SHMain.StartFatigue()
    EndIf

    If(_SHColdShouldBeDisabled.GetValue() == 1.0)
        _SHMain.StopCold()
    Else
        _SHMain.StartCold()
    EndIf

EndFunction

Function Update()
    if(_SHEnabled.GetValue() == 1.0)
        _SHIsLichGlobal.SetValue(CheckLich() as int)
        RegisterForMenu("MapMenu")
        RegisterForMenu("Dialogue Menu")

        CheckNeedsDisabled()
    endif
    if(!stopUpdating)
        RegisterForSingleUpdate(5 as float)
    endif
endFunction

function CheckFT()

    ;Only check if we dont have frostfall
    if(!_SHMain.ModComp.FrostfallInstalled && _SHEnabled.GetValue() == 1.0)
        if (_SHIsRidingDragon.GetValue() == 1.0 )
            if !Game.IsFastTravelControlsEnabled()
                Game.EnableFastTravel(true)
            endIf
            return 
        ElseIf (_SHDisableFT.GetValue() == 1.0); && Game.IsFastTravelControlsEnabled())
            Game.EnableFastTravel(false)  
        endIf
    endif
endFunction

;Check if alcohol
;The Alcohol and hot beverage checks are here because they need to still be checked even when thirst is inactive
bool Function AlcoholCheck()

    if(consumed.HasKeyword(_SH_AlcoholDrinkKeyword) || _SHAlcoholList.HasForm(consumed))
        return true
    Else
        return false
    endif

EndFunction

Function HotBeverageCheck()
    If (consumed.HasKeyword(_SHHotBeverage) || _SHHotBeverageList.HasForm(consumed))  
        if(_SHColdActive.GetValue() == 1.0)
            _SHBeverageWarmthSpell.Cast(Player,Player)
        endif
    endif

EndFunction

bool Function CheckLich()
    if(_SHLichRaceList.HasForm(Player.GetRace() as form))
        return true
    else
        return false
    endif
EndFunction

bool Function SkoomaCheck()
    ;If skooma restore fatigue
    if(_SHSkoomaList.HasForm(consumed))
        if(_SHMain.Fatigue.IsRunning())
            _SHMain.Fatigue.DecreaseFatigueLevel(15.00)
        endif
        return true
    else
        return false
    endif

EndFunction