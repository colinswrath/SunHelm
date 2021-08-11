;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname PRKF__SHMiscActivations_052EE749 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
_SHMain.CarriageTravelled = True
if(_SHMain.Cold.IsRunning())
    _SHMain.Cold.carriageTravel = true
endif
Utility.Wait(13)
_SHMain.CarriageTravelled = false
if(_SHMain.Cold.IsRunning())
    _SHMain.Cold.carriageTravel = false
endif
if(_SHFirstPersonMessages.GetValue() == 1)
    _SHCarriageTravelFirst.Show()
Else
    _SHCarriageTravel.Show()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
_SHBedrollSleep.SetValue(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
    Actor Player = Game.GetPlayer()

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

    if(meadCount > 0 || wineCount > 0 || sujammaCount > 0 || skinCount > 0)
        _SHWellFill.Play(Player)
    endif

    if(skinCount > 0)
        Player.AddItem(_SHMain._SHWaterskin_3, skinCount)
    endif

    if(meadCount > 0)
        Player.AddItem(_SHWaterBottleMead, meadCount)
    endif

    if(wineCount > 0)
        Player.AddItem(_SHWaterBottleWine, wineCount)
    endif

    if(sujammaCount > 0)
        Player.AddItem(_SHSujammaWaterBottle, sujammaCount)
    endif

    _SHDrink.Play(Player)
    if(!_SHMain.Vampire || _SHVampireNeedsOption.GetValue() == 3)
        if(_SHMain.Thirst.IsRunning())
            _SHMain.Thirst.DecreaseThirstLevel(40)
        endif
    endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
_SunHelmMain property _SHMain auto
Potion property _SHWaterBottleMead auto
Potion property _SHWaterBottleWine auto
Potion property _SHSujammaWaterBottle auto

Potion property _SHSaltBottleMead auto
Potion property _SHSaltBottleWine auto
Potion property _SHSaltBottleSujamma auto
Potion property _SHWaterskin_1 auto
Potion property _SHWaterskin_2 auto
Potion property _SHWaterskin_3 auto
MiscObject property _SHWaterskinEmpty auto

MiscObject property _SHEmptyMeadMisc auto
MiscObject property _SHEmptyWineMisc auto
MiscObject property _SHEmptySujammaMisc auto
GlobalVariable Property _SHFirstPersonMessages auto
GlobalVariable Property _SHBedrollSleep auto
GlobalVariable Property _SHVampireNeedsOption Auto

Message Property _SHCarriageTravel auto
Message Property _SHCarriageTravelFirst auto

Sound property _SHDrink auto
Sound property _SHWellFill auto
