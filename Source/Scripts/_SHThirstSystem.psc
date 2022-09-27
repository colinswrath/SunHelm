Scriptname _SHThirstSystem extends _SHSystemBase

;Properties

int Property _SHThirstStage0 auto
int Property _SHThirstStage1 auto
int Property _SHThirstStage2 auto
int Property _SHThirstStage3 auto
int Property _SHThirstStage4 auto
int Property _SHThirstStage5 auto

int Property CurrentThirstStage auto hidden

Potion property _SHWaterBottleMead auto

Spell Property _SHThirstSpell1 Auto
Spell Property _SHThirstSpell2 Auto
Spell Property _SHThirstSpell3 Auto
Spell Property _SHThirstSpell4 Auto
Spell Property _SHThirstSpell5 Auto
Spell Property _SHThirstSpell6 Auto

Message property _SHThirstMessage0 auto
Message property _SHThirstMessage1 auto
Message property _SHThirstMessage2 auto
Message property _SHThirstMessage3 auto
Message property _SHThirstMessage4 auto
Message property _SHThirstMessage5 auto
Message property _SHThirstTut auto

Message property _SHThirstMessage0First auto
Message property _SHThirstMessage1First auto
Message property _SHThirstMessage2First auto
Message property _SHThirstMessage3First auto
Message property _SHThirstMessage4First auto
Message property _SHThirstMessage5First auto

Sound property _SHThirstSoundsF auto
Sound property _SHThirstSoundsM auto

GlobalVariable Property _SHThirstTutEnabled auto
GlobalVariable property _SHFirstTimeEnabled auto
GlobalVariable property _SHWaterskinAdded auto
GlobalVariable Property _SHIsVampireGlobal auto

bool ShowNewStageMessage
bool Increasing
bool startUp
bool wasQuenched = false

;Functions

;Calls parent method to start the system
Function StartSystem()
    If (!IsRunning())
        _SHThirstTimeStamp.SetValue(Utility.GetCurrentGameTime())
        parent.StartSystem()
        ;add water to player
        Player = game.GetPlayer()
        If (_SHWaterskinAdded.GetValue() == 0)
            Player.AddItem(_SHMain._SHWaterskin_3, 1)
            _SHWaterskinAdded.SetValue(1.0)
        EndIf
        CurrentThirstStage = -1
        startUp = true
        GetNewSystemStage()
        ApplySystemEffects()
        startUp = false
    EndIf
EndFunction

;Stops the system.
Function StopSystem()
    parent.StopSystem()
EndFunction

Function UpdateNeed()
    IncrementThirstLevel()
    GetNewSystemStage()
    ApplySystemEffects()
    _SHThirstTimeStamp.SetValue(Utility.GetCurrentGameTime())
    _SHMain.ResetDrinkCount()
    SendModEvent("_SH_UpdateWidget")
EndFunction

Function GetNewSystemStage()
    int NewStage
    float currentLevel = _SHCurrentThirstLevel.GetValue()

    If (currentLevel < _SHThirstStage1)
        NewStage = 0
        if(!wasQuenched)
            wasQuenched = true
            SendModEvent("_SH_IncreaseSurvivalSkill")
        endif
    ElseIf (currentLevel < _SHThirstStage2)
        NewStage = 1
        wasQuenched = false   
    ElseIf (currentLevel < _SHThirstStage3)
        NewStage = 2
        wasQuenched = false
        if(_SHThirstTutEnabled.GetValue() == 1 && _SHTutorials.GetValue() == 1 && Increasing)
            _SHThirstTutEnabled.SetValue(0)
            _SHThirstTut.Show()
        EndIf
    ElseIf (currentLevel < _SHThirstStage4)
        NewStage = 3
        wasQuenched = false
    ElseIf (currentLevel < _SHThirstStage5)
        NewStage = 4
        wasQuenched = false
    ElseIf (currentLevel >= _SHThirstStage5)
        NewStage = 5
        wasQuenched = false
    EndIf

    If (NewStage != CurrentThirstStage)
        ShowNewStageMessage = true
    Else
        ShowNewStageMessage = false
    EndIf

    CurrentThirstStage = NewStage
EndFunction

Function ApplySystemEffects()
    
    if(ShowNewStageMessage)
        RemoveSystemEffects()       ;Remove effects before applying new ones

        ;Decide which spell set to add
        If (CurrentThirstStage == 0)
            DisplayNotifications(_SHThirstMessage0First, _SHThirstMessage0)
            Player.AddSpell(_SHThirstSpell1, false)
        ElseIf (CurrentThirstStage == 1)
            If (_SHMessagesEnabled.GetValue() == 1 && (!Increasing || startup))
                DisplayNotifications(_SHThirstMessage1First, _SHThirstMessage1)
            EndIf
            Player.AddSpell(_SHThirstSpell2, false)
        ElseIf (CurrentThirstStage == 2)
            DisplayNotifications(_SHThirstMessage2First, _SHThirstMessage2)
            Player.AddSpell(_SHThirstSpell3, false)
        ElseIf (CurrentThirstStage == 3)
            DisplayNotifications(_SHThirstMessage3First, _SHThirstMessage3)
            Player.AddSpell(_SHThirstSpell4, false)
        ElseIf (CurrentThirstStage == 4)
            DisplayNotifications(_SHThirstMessage4First, _SHThirstMessage4)
            Player.AddSpell(_SHThirstSpell5, false)
        ElseIf (CurrentThirstStage == 5)
            DisplayNotifications(_SHThirstMessage5First, _SHThirstMessage5)
            Player.AddSpell(_SHThirstSpell6, false)
        EndIf

        if(CurrentThirstStage > 1 && Increasing == true)
            ApplyFx(_SHThirstSoundsM,_SHThirstSoundsF)
        EndIf
    endif
EndFunction

;Remove the system effects
Function RemoveSystemEffects()
    
    ;Remove the spells from the player
    Player.RemoveSpell(_SHThirstSpell1)
    Player.RemoveSpell(_SHThirstSpell2)
    Player.RemoveSpell(_SHThirstSpell3)
    Player.RemoveSpell(_SHThirstSpell4)
    Player.RemoveSpell(_SHThirstSpell5)
    Player.RemoveSpell(_SHThirstSpell6)

EndFunction

Function IncrementThirstLevel()
    Increasing = true

    ;Calculates how much time has passed since the last update
    int HoursPassed = Round((Utility.GetCurrentGameTime() - _SHThirstTimeStamp.GetValue()) * 24)  
    
    ;Damage when Thirsty
    If (_SHNeedsDeath.GetValue() == 1)
        if(CurrentThirstStage == 5)
           Game.GetPlayer().DamageActorValue("Health", (Utility.RandomInt(1,75))* HoursPassed)
        EndIf
    EndIf

    ;float incValue = (HoursPassed * (_SHThirstRate.GetValue() + Utility.RandomFloat(-1.0,1.0)))
    float incValue = HoursPassed * _SHThirstRate.GetValue()
    incValue = incValue + (Utility.RandomFloat(-1.0,1.0) * (incValue * 0.10))

    ;Slower vampire rate
    if(_SHIsVampireGlobal.GetValue() == 1.0)
        incValue = incValue / 4
    ElseIf (FastTravelled)
        FastTravelled = false
        incValue = incValue / 2
    ElseIf(ThirstWasSleeping)
        ThirstWasSleeping = false
        incValue = incValue*0.75
    Endif

	;Calculates the hunger/Thirst that has been accumulated 10% variability
    _SHCurrentThirstLevel.SetValue(_SHCurrentThirstLevel.GetValue() + incValue)

    ;We dont want to go greater than the greatest possible
    if(_SHCurrentThirstLevel.GetValue() > _SHThirstStage5)
        _SHCurrentThirstLevel.SetValue(_SHThirstStage5)
    EndIf
EndFunction

Function DecreaseThirstLevel(float decAmount)

    float perkMod = 0.0

    if(_SH_PerkRank_Hydrated.GetValue() == 1.0)
        perkMod = 0.1
    elseif(_SH_PerkRank_Hydrated.GetValue() == 2.0)
        perkMod = 0.15
    endif

    decAmount += (decAmount*perkMod)

    _SHCurrentThirstLevel.SetValue(_SHCurrentThirstLevel.GetValue() - decAmount)    ;Decrement the level
    ;Ensure thirst level doesn't go below value
    If (_SHCurrentThirstLevel.GetValue() < 0.0)
        _SHCurrentThirstLevel.SetValue(0.0)
    EndIf

    Increasing = false
    GetNewSystemStage()
    ApplySystemEffects()
    Increasing = true
    SendModEvent("_SH_UpdateWidget")

EndFunction

;Increase level by set amount
Function IncreaseThirstLevel(float incAmount)
    _SHCurrentThirstLevel.SetValue(_SHCurrentThirstLevel.GetValue() + incAmount) 

    ;Ensure thirst level doesn't go above value
    If (_SHCurrentThirstLevel.GetValue() > _SHThirstStage5)
        _SHCurrentThirstLevel.SetValue(_SHThirstStage5)
    EndIf
    
    RemoveSystemEffects()   ;Remove again just to make sure
    GetNewSystemStage()
    ApplySystemEffects()

    SendModEvent("_SH_UpdateWidget")

EndFunction

Function SetValuesOnStoryServed(Location akLocation)
    If (akLocation == "CidhnaMine01" || akLocation == "CidhnaMine02")   ;Figure out which one this is
        _SHCurrentThirstLevel.SetValue(125)
    Else
        _SHCurrentThirstLevel.SetValue(85)
    EndIf
EndFunction

int Function GetThirstPercent()
    return ((_SHCurrentThirstLevel.GetValue() / _SHThirstStage5) * 100) as int
endFunction

;Parent calls
Function PauseUpdates()
    parent.PauseUpdates()
EndFunction

Function ResumeUpdates()
    _SHThirstTimeStamp.SetValue(Utility.GetCurrentGameTime())
    parent.ResumeUpdates()
EndFunction

Function SetTimeStamps()
    _SHThirstTimeStamp.SetValue(Utility.GetCurrentGameTime())
endfunction