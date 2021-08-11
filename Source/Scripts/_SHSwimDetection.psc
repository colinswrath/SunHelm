Scriptname _SHSwimDetection extends ActiveMagicEffect

_SHHeatDetection property Heat auto

Event OnEffectStart(Actor akTarget, Actor akCaster) 
    Heat.RegisterForSingleUpdate(0.1)
EndEvent

Event OnEffectStop(Actor akTarget, Actor akCaster) 
    Heat.RegisterForSingleUpdate(0.1)
EndEvent

