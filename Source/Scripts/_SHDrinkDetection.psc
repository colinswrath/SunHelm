Scriptname _SHDrinkDetection extends ReferenceAlias

Actor Player
Form consumed

Keyword Property VendorItemFood Auto

FormList Property _SHMeadBottleList Auto
FormList Property _SHWineBottleList Auto
FormList Property _SHSujammaBottleList Auto
FormList Property _SHDrinkList auto
FormList Property _SHAlcoholList auto
FormList Property _SHDrinkNoBottle auto

GlobalVariable Property _SHAnimationsEnabled auto
GlobalVariable Property _SHGiveBottles auto
GlobalVariable Property _SHVampireNeedsOption Auto
GlobalVariable Property _SHIsVampireGlobal auto

Potion property _SHWaterBottleMead auto
Potion property _SHWaterBottleWine auto
Potion property _SHSaltBottleMead auto
Potion property _SHSaltBottleWine auto
Potion property _SHSujammaWaterBottle auto
Potion property _SHSaltBottleSujamma auto

MiscObject property _SHEmptyMeadMisc auto
MiscObject property _SHEmptyWineMisc auto
MiscObject property _SHEmptySujammaMisc auto
MiscObject property _SHWaterskin_Empty auto
Potion property _SHWaterskinSalt auto

Message Property _SHUnknownFood Auto

_SHThirstSystem property _ThirstSystem auto
_SunHelmMain property _SHMain auto

Idle Property IdleStop_Loose Auto

Potion property _SHWaterskin_1 auto
Potion property _SHWaterskin_2 auto
Potion property _SHWaterskin_3 auto

FormList property _SHWaterskins auto

Keyword property _SH_DrinkKeyword auto
Keyword property _SH_MeadBottleKeyword auto
Keyword property _SH_WineBottleKeyword auto
Keyword property _SH_WineWATERBottleKeyword auto
Keyword property _SH_SujammaWATERBottleKeyword auto
Keyword property _SHSaltWaterKeyword auto
Keyword property _SH_MeadWATERBottleKeyword auto
Keyword property _SH_SujammaBottleKeyword auto

import Utility


Event OnObjectEquipped(form akBaseObject, ObjectReference akReference)
    if(akBaseObject as Potion && (akBaseObject as Potion).IsFood())
        Player = Game.GetPlayer()
        consumed = akBaseObject
        DrinkCheck()
    endif
EndEvent

;TODO - Tidy and redo this. Consolodate items into a count
Function DrinkCheck()

    int thirstVal = 80
    bool playAnim = false

    if(_SHAlcoholList.HasForm(consumed))
        DecreaseThirst(thirstVal/2)
        playAnim = true
    endif

    if (consumed == _SHSaltBottleMead)
        IncreaseThirst(20.00)
        ReturnBottle(0)
        playAnim = true

    ElseIf (consumed == _SHSaltBottleWine)
        IncreaseThirst(20.00)
        ReturnBottle(1)
        playAnim = true

    ElseIf (consumed == _SHSaltBottleSujamma)
        IncreaseThirst(20.0)
        ReturnBottle(2)
        playAnim = true

    ElseIf(consumed == _SHWaterskin_3)
        
        Player.AddItem(_SHWaterskin_2,1,true)
        DecreaseThirst(thirstVal)
        playAnim = true

    ElseIf (consumed == _SHWaterskin_2)
        
        Player.AddItem(_SHWaterskin_1,1,true)
        DecreaseThirst(thirstVal)
        playAnim = true

    ElseIf(consumed == _SHWaterskin_1)
        
        Player.AddItem(_SHWaterskin_Empty,1,true)
        DecreaseThirst(thirstVal)
        playAnim = true

    ElseIf (consumed == _SHWaterskinSalt)
        IncreaseThirst(20.0)
        Player.AddItem(_SHWaterskin_Empty,1)
        playAnim = true

    ElseIf (consumed.HasKeyword(_SH_MeadWATERBottleKeyword) || _SHDrinkList.HasForm(consumed))

        DecreaseThirst(thirstVal)
        playAnim = true
        ReturnBottle(0)

    ElseIf (consumed.HasKeyword(_SH_SujammaWATERBottleKeyword))

        DecreaseThirst(thirstVal)
        playAnim = true
        ReturnBottle(2)

    ElseIf (consumed.HasKeyword(_SH_WineWATERBottleKeyword))

        DecreaseThirst(thirstVal)
        playAnim = true
        ReturnBottle(1)

    ElseIf (_SHDrinkNoBottle.HasForm(consumed) || consumed.HasKeyword(_SH_DrinkKeyword))
        DecreaseThirst(thirstVal)
        playAnim = true

    ElseIf (consumed.HasKeyword(_SHSaltWaterKeyword))
        IncreaseThirst(20.00)
        playAnim = true

    Elseif(consumed.HasKeyword(_SH_MeadBottleKeyword) || _SHMeadBottleList.HasForm(consumed))
        playAnim = true
        ReturnBottle(0)
    ElseIf (consumed.HasKeyword(_SH_WineBottleKeyword) || _SHWineBottleList.HasForm(consumed))
        playAnim = true
        ReturnBottle(1)
    ElseIf (consumed.HasKeyword(_SH_SujammaBottleKeyword) || _SHSujammaBottleList.HasForm(consumed))
        playAnim = true
        ReturnBottle(2)
    endif

    if(_SHAnimationsEnabled.GetValue() && playAnim)
        PlayDrinkAnimation()
    endif
endFunction

Function ReturnBottle(int type)
    if(_SHGiveBottles.GetValue() == 1.0)
        if(type == 0)
            Player.AddItem(_SHEmptyMeadMisc,1)
        elseif(type == 1)
            Player.AddItem(_SHEmptyWineMisc,1)
        elseif(type == 2)
            Player.AddItem(_SHEmptySujammaMisc,1)
        endif
    endif
endFunction

;---------------------------ANIMATION----------------------------
Function PlayDrinkAnimation()
    If Player.GetAnimationVariableInt("i1stPerson") as Int == 1
        If Player.GetSitState() == 0
            ;Debug.SendAnimationEvent(Player, "idleDrinkingStandingStart")
            ;Utility.Wait(7.5)
            ;Player.PlayIdle(IdleStop_Loose)
            ;Utility.Wait(1.0)
        Else
            Game.ForceThirdPerson()
            Utility.Wait(1.0)
            Debug.SendAnimationEvent(Player, "ChairDrinkingStart")
            Utility.Wait(1.0)
            Game.ForceFirstPerson()
        EndIf
    Else
        If Player.GetSitState() == 0
            Debug.SendAnimationEvent(Player, "idleDrinkingStandingStart")
            Utility.Wait(7.5)
            Player.PlayIdle(IdleStop_Loose)
        Else
            Debug.SendAnimationEvent(Player, "ChairDrinkingStart")
        EndIf
    endif
EndFunction
;------------------------------------------------------------------
Function DecreaseThirst(float amount)  
    if((_SHIsVampireGlobal.GetValue() == 0  || _SHVampireNeedsOption.GetValue() == 3) && _ThirstSystem.IsRunning())
        _ThirstSystem.DecreaseThirstLevel(amount)
    endif
EndFunction

Function IncreaseThirst(float amount)  
    if((_SHIsVampireGlobal.GetValue() == 0 || _SHVampireNeedsOption.GetValue() == 3) && _ThirstSystem.IsRunning())
        _ThirstSystem.IncreaseThirstLevel(amount)
    endif
EndFunction



