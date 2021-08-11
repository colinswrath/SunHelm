;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 107
Scriptname _SHPerk Extends Perk Hidden

;BEGIN FRAGMENT Fragment_106
Function Fragment_106(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
 
vanillaPerk.Fragment_0(akTargetRef,akActor)

(akTargetRef as Actor).PlayImpactEffect(BloodSprayImpactSetRed, "SkirtFBone01")
(akTargetRef as Actor).PlayImpactEffect(BloodSprayImpactSetRed, "SkirtFBone01")

if(_SHMain.Hunger.IsRunning())
    _SHMain.Hunger.DecreaseHungerLevel(100)
endif

if(_SHMain.Thirst.IsRunning())
    _SHMain.Thirst.DecreaseThirstLevel(10)
endif

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SunHelmMain property _SHMain auto
Sound property NPCCannibalKneelM auto
ImpactDataSet Property BloodSprayImpactSetRed Auto
Spell Property DA11CannibalismAbility Auto
Spell Property DA11CannibalismAbility02 Auto

PRKF_DA11Cannibalism_000EE5C3 property vanillaPerk auto
