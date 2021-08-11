Scriptname _SHDragonConditionalScript extends ActiveMagicEffect

GlobalVariable Property _SHIsRidingDragon auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	_SHIsRidingDragon.SetValue(1.0) 
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	_SHIsRidingDragon.SetValue(0.0) 
endEvent