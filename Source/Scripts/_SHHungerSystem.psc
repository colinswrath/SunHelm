Scriptname _SHHungerSystem extends _SHSystemBase

;Properties

;Hunger spells/Stages/Messages
int Property _SHHungerStage0 auto
int Property _SHHungerStage1 auto
int Property _SHHungerStage2 auto
int Property _SHHungerStage3 auto
int Property _SHHungerStage4 auto
int Property _SHHungerStage5 auto

int Property CurrentHungerStage auto hidden

Spell property _SHHungerSpell1 auto
Spell property _SHHungerSpell2 auto
Spell property _SHHungerSpell3 auto
Spell property _SHHungerSpell4 auto
Spell property _SHHungerSpell5 auto
Spell property _SHHungerSpell6 auto

Message property _SHHunger0 auto
Message property _SHHunger1 auto
Message property _SHHunger2 auto
Message property _SHHunger3 auto
Message property _SHHunger4 auto
Message property _SHHunger5 auto
Message property _SHHungerTut auto

Message property _SHHunger0First auto
Message property _SHHunger1First auto
Message property _SHHunger2First auto
Message property _SHHunger3First auto
Message property _SHHunger4First auto
Message property _SHHunger5First auto

Sound property _SHHungerSounds auto

GlobalVariable Property _SHHungerTutEnabled auto
bool ShowNewStageMessage
bool Increasing
bool startup
bool wasWellFed = false
;Events

;Functions

;Calls parent method to start the system
Function StartSystem()
    If (!IsRunning())
        _SHHungerTimeStamp.SetValue(Utility.GetCurrentGameTime())
        parent.StartSystem()
        CurrentHungerStage = -1
        startUp = true
        Player = game.GetPlayer()
        GetNewSystemStage()
        ApplySystemEffects()
        startup = false
    EndIf
EndFunction

;Stops the system.
Function StopSystem()
    parent.StopSystem()
EndFunction

;Updates the need values
Function UpdateNeed()
    IncrementHungerLevel()
    GetNewSystemStage()
    ApplySystemEffects()
    _SHHungerTimeStamp.SetValue(Utility.GetCurrentGameTime())
    SendModEvent("_SH_UpdateWidget")
EndFunction

;Apply the correct spell to the player based on the stage
Function ApplySystemEffects()

    if(ShowNewStageMessage)
        RemoveSystemEffects()       ;Remove effects before applying new ones

        ;Decide which spell set to add
        If (CurrentHungerStage == 0)
            DisplayNotifications(_SHHunger0First, _SHHunger0)
            Player.AddSpell(_SHHungerSpell1, false)
        ElseIf (CurrentHungerStage == 1)
            If (_SHMessagesEnabled.GetValue() == 1 && (!Increasing || startup))
                DisplayNotifications(_SHHunger1First, _SHHunger1)
            EndIf
            Player.AddSpell(_SHHungerSpell2, false)
        ElseIf (CurrentHungerStage == 2)
            DisplayNotifications(_SHHunger2First, _SHHunger2)
            Player.AddSpell(_SHHungerSpell3, false)
        ElseIf (CurrentHungerStage == 3)
            DisplayNotifications(_SHHunger3First, _SHHunger3)
            Player.AddSpell(_SHHungerSpell4, false)
        ElseIf (CurrentHungerStage == 4)
            DisplayNotifications(_SHHunger4First, _SHHunger4)
            Player.AddSpell(_SHHungerSpell5, false)
        ElseIf (CurrentHungerStage == 5)
            DisplayNotifications(_SHHunger5First, _SHHunger5)
            Player.AddSpell(_SHHungerSpell6, false)
        EndIf

        if(CurrentHungerStage > 1 && Increasing == true)
            ApplyFxGeneric()
        EndIf
    endif
EndFunction

;Remove the system effects
Function RemoveSystemEffects()

    ;Remove the spells from the player
    Player.RemoveSpell(_SHHungerSpell1)
    Player.RemoveSpell(_SHHungerSpell2)
    Player.RemoveSpell(_SHHungerSpell3)
    Player.RemoveSpell(_SHHungerSpell4)
    Player.RemoveSpell(_SHHungerSpell5)
    Player.RemoveSpell(_SHHungerSpell6)

EndFunction

Function ApplyFxGeneric()

    If (_SHToggleSounds.GetValue() == 1.0)
        _SHHungerSounds.Play(Player)
    EndIf
EndFunction


;Set appropriate system stage level
Function GetNewSystemStage()

    int NewStage
    float currentLevel = _SHCurrentHungerLevel.GetValue()

    If (currentLevel < _SHHungerStage1)
        NewStage = 0
        if(!wasWellFed)
            wasWellFed = true
            SendModEvent("_SH_IncreaseSurvivalSkill")
        endif
    ElseIf (currentLevel < _SHHungerStage2)
        NewStage = 1
        wasWellFed = false
    ElseIf (currentLevel < _SHHungerStage3)
        NewStage = 2
        wasWellFed = false
        if(_SHHungerTutEnabled.GetValue() == 1 && _SHTutorials.GetValue() == 1 && Increasing)
            _SHHungerTutEnabled.SetValue(0)
            _SHHungerTut.Show()
        EndIf
    ElseIf (currentLevel < _SHHungerStage4)
        NewStage = 3
        wasWellFed = false
    ElseIf (currentLevel < _SHHungerStage5)
        NewStage = 4
        wasWellFed = false
    ElseIf (currentLevel >= _SHHungerStage5)
        NewStage = 5
        wasWellFed = false
    EndIf

    If (NewStage != CurrentHungerStage)
        ShowNewStageMessage = true
    Else
        ShowNewStageMessage = false
    EndIf

    CurrentHungerStage = NewStage

EndFunction

Function IncrementHungerLevel()
    Increasing = true
    ;Calculates how much time has passed since the last update
    int HoursPassed = Round((Utility.GetCurrentGameTime() - _SHHungerTimeStamp.GetValue()) * 24)  
    ;Damage when hungry
    If (_SHNeedsDeath.GetValue() == 1)
        if(CurrentHungerStage == 5)
           Player.DamageActorValue("Health", (Utility.RandomInt(1,75))*HoursPassed)
        EndIf
    EndIf

	;Calculates the hunger/Thirst that has been accumulated +/-10% variability
    float incValue = HoursPassed * _SHHungerRate.GetValue()
    incValue = incValue + (Utility.RandomFloat(-1.0,1.0) * (incValue * 0.10))

    If (_SHMain.CarriageTravelled)
        incValue = incValue / 2
    ElseIf(HungerWasSleeping)
        HungerWasSleeping = false
        incValue = incValue*0.75
    EndIf
    
    _SHCurrentHungerLevel.SetValue(_SHCurrentHungerLevel.GetValue() + incValue)

    ;We dont want to go greater than the greatest possible value
    if(_SHCurrentHungerLevel.GetValue() > _SHHungerStage5)
        _SHCurrentHungerLevel.SetValue(_SHHungerStage5)
    EndIf
EndFunction

;Decreases the hunger level by provided amount
Function DecreaseHungerLevel(float decAmount)

    float perkMod = 0.0
    if(_SH_PerkRank_Connoisseur.GetValue() == 1.0)
        perkMod = 0.10
    elseif(_SH_PerkRank_Connoisseur.GetValue() == 2.0)
        perkMod = 0.15
    endif

    decAmount += (decAmount*perkMod)

    Increasing = false
    _SHCurrentHungerLevel.SetValue(_SHCurrentHungerLevel.GetValue() - decAmount)    ;Decrement the level
    ;Ensure hunger level doesn't go below value
    If (_SHCurrentHungerLevel.GetValue() < 0)
        _SHCurrentHungerLevel.SetValue(0)
    EndIf

    GetNewSystemStage()
    ApplySystemEffects()
    Increasing = true

    SendModEvent("_SH_UpdateWidget")
EndFunction

Function SetValuesOnStoryServed(Location akLocation)
    If (akLocation == "CidhnaMine01" || akLocation == "CidhnaMine02")   ;Figure out which one this is
        _SHCurrentHungerLevel.SetValue(245)
    Else
        _SHCurrentHungerLevel.SetValue(165)
    endif
EndFunction

int Function GetHungerPercent()
    return ((_SHCurrentHungerLevel.GetValue() / _SHHungerStage5) * 100) as int
endFunction

;Parent calls
Function PauseUpdates()
    parent.PauseUpdates()
EndFunction

Function ResumeUpdates()
    _SHHungerTimeStamp.SetValue(Utility.GetCurrentGameTime())
    parent.ResumeUpdates()
EndFunction

Function SetTimeStamps()
    _SHHungerTimeStamp.SetValue(Utility.GetCurrentGameTime())
endfunction