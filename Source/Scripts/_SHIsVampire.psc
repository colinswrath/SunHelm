Scriptname _SHIsVampire extends ActiveMagicEffect

_SunHelmMain property _SHMain auto
_SHThirstSystem property Thirst auto
GlobalVariable Property _SHVampireNeedsOption Auto
GlobalVariable Property _SHIsVampireGlobal auto

FormList property _SHVampireBlood auto
Keyword Property Vampire auto
Keyword Property _SHBloodDrink auto

Potion property DLC1BloodPotion auto

Actor property PlayerRef auto

bool property LordFeedEffect auto


Event OnEffectStart(Actor akTarget, Actor akCaster)   
    
    _SHIsVampireGlobal.SetValue(1.0)
    if(LordFeedEffect)
        RegisterForAnimationEvent(PlayerRef, "KillMoveEnd")        
    else
        _SHMain.VampireChangeNeeds(_SHVampireNeedsOption.GetValue() as int)    
    endif
    
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
    VampireFeedNeeds()
EndEvent

Function VampireFeedNeeds()
    if(Thirst.IsRunning())
        Thirst.DecreaseThirstLevel(200)
    endif
EndFunction

Event OnVampireFeed(Actor akTarget)
    VampireFeedNeeds()
EndEvent

;To detect blood potions
Event OnObjectEquipped(form akBaseObject, ObjectReference akReference)
    if(akBaseObject as potion)
        if(akBaseObject == DLC1BloodPotion || _SHVampireBlood.HasForm(akBaseObject) || akBaseObject.HasKeyword(_SHBloodDrink))
            VampireFeedNeeds()
        endif
    endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    if(LordFeedEffect)
        UnregisterForAnimationEvent(PlayerRef, "KillMoveEnd")
    endif
    
    if(!PlayerRef.HasKeyword(Vampire) && !LordFeedEffect)
        _SHIsVampireGlobal.SetValue(0.0)
        _SHMain.VampireChangeNeeds(4)
    endif
EndEvent