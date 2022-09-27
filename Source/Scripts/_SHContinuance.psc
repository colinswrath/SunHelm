Scriptname _SHContinuance extends ActiveMagicEffect

_SunHelmMain property _SHMain auto
_SHHungerSystem property Hunger auto
_SHThirstSystem property Thirst auto
_SHColdSystem property Cold auto
_SHFatigueSystem property Fatigue auto

Event OnEffectStart(Actor akTarget, Actor akCaster)  
    _SHMain.ContinuancePower()
EndEvent