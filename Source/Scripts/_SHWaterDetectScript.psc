Scriptname _SHWaterDetectScript extends ActiveMagicEffect

GlobalVariable Property _SHIsInWater auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    _SHIsInWater.SetValue(1.0)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    _SHIsInWater.SetValue(0.0)
EndEvent