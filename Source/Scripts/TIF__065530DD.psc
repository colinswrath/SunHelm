;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__065530DD Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
    Game.GetPlayer().RemoveItem(Gold001, 20)

    int thirstVal = 100

    float perkModifier = 0.0 ; Depricated

    ;if(!_SHMain.Vampire || _SHVampireNeedsOption.GetValue() == 3)
        if(_SHMain.Thirst.IsRunning())
            _SHMain.Thirst.DecreaseThirstLevel(thirstVal)
        endif
        if(_SHMain.Hunger.IsRunning())
            _SHMain.Hunger.DecreaseHungerLevel(165 + (165 * perkModifier))
        endif
    ;endif

    _SHFoodEat.Play(Game.GetPlayer())

    Actor Player = Game.GetPlayer()

    If Player.GetAnimationVariableInt("i1stPerson") as Int == 1
        if(Player.GetSitState() == 0)
            ;    Debug.SendAnimationEvent(Player, "idleEatingStandingStart")
            ;    Utility.Wait(7.0)
            ;    Player.PlayIdle(IdleStop_Loose)
        elseif(Player.GetSitState() == 3)
            Game.ForceThirdPerson()
            Utility.Wait(1.0)
            Debug.SendAnimationEvent(Player, "ChairEatingStart")
            Utility.Wait(1.0)
            Game.ForceFirstPerson()
        endif
    else
        if(Player.GetSitState() == 0)
            Debug.SendAnimationEvent(Player, "idleEatingStandingStart")
            Utility.Wait(7.0)
            Player.PlayIdle(IdleStop_Loose)
        elseif(Player.GetSitState() == 3)
            Debug.SendAnimationEvent(Player, "ChairEatingStart")
        endif
    endif
    
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
MiscObject property Gold001 auto
_SunHelmMain property _SHMain auto
Sound property _SHFoodEat auto
Idle Property IdleStop_Loose Auto
GlobalVariable Property _SHVampireNeedsOption Auto

