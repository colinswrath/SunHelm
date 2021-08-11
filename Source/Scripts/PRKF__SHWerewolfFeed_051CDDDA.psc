;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 20
Scriptname PRKF__SHWerewolfFeed_051CDDDA Extends Perk Hidden

;BEGIN FRAGMENT Fragment_12
Function Fragment_12(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
if(_SHWerewolfFeedOptions.GetValue() == 1)
    if(_SHMain.Hunger.IsRunning())
        _SHMain.Hunger.DecreaseHungerLevel(150)
    endif 

    if(_SHMain.Thirst.IsRunning())
        _SHMain.Thirst.DecreaseThirstLevel(30)
    endif
ElseIf (_SHWerewolfFeedOptions.GetValue() == 2)
    if(_SHMain.Hunger.IsRunning())
        _SHMain.Hunger.DecreaseHungerLevel(150)
    endif
ElseIf (_SHWerewolfFeedOptions.GetValue() == 3)
    if(_SHMain.Thirst.IsRunning())
        _SHMain.Thirst.DecreaseThirstLevel(30)
    endif
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SunHelmMain property _SHMain auto
GlobalVariable Property _SHWerewolfFeedOptions Auto

