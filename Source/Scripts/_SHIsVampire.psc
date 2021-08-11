Scriptname _SHIsVampire extends ActiveMagicEffect

_SunHelmMain property _SHMain auto
GlobalVariable Property _SHVampireNeedsOption Auto

int currentOption
bool property VampireBeast auto

FormList property _SHVampireBlood auto
Keyword Property Vampire auto
Keyword Property _SHBloodDrink auto

Potion property DLC1BloodPotion auto

_SHThirstSystem property Thirst auto

Actor Player

Function VampireFeedNeeds()

    if(Thirst.IsRunning())
        Thirst.DecreaseThirstLevel(200)
    endif

EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)   
    Player = akTarget

    if(VampireBeast)
        RegisterForAnimationEvent(akTarget, "KillMoveEnd")        
    EndIf
    
    currentOption = _SHVampireNeedsOption.GetValue() as int
    _SHMain.Vampire = true
    _SHMain.VampireChangeNeeds(currentOption)    
    
EndEvent

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

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
    VampireFeedNeeds()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    if(!VampireBeast && !Player.HasKeyword(Vampire))
        _SHMain.Vampire = false
        _SHMain.VampireChangeNeeds(4)
    endif

EndEvent