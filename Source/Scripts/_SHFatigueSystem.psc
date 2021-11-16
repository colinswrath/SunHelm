Scriptname _SHFatigueSystem extends _SHSystemBase

;Properties

int Property _SHFatigueStage0 auto
int Property _SHFatigueStage1 auto
int Property _SHFatigueStage2 auto
int Property _SHFatigueStage3 auto
int Property _SHFatigueStage4 auto
int Property _SHFatigueStage5 auto

keyword property LocTypePlayerHouse auto

int Property CurrentFatigueStage auto hidden
int Property OldFatigueStage auto hidden

float Property SleepStartTime auto hidden
float Property SleepStopTime auto hidden

Spell property _SHFatigueSpell1 auto
Spell property _SHFatigueSpell2 auto
Spell property _SHFatigueSpell3 auto
Spell property _SHFatigueSpell4 auto
Spell property _SHFatigueSpell5 auto
Spell property _SHFatigueSpell6 auto

spell property WellRested auto
spell property Rested auto

Message property _SHFatigue0 auto
Message property _SHFatigue1 auto
Message property _SHFatigue2 auto
Message property _SHFatigue3 auto
Message property _SHFatigue4 auto
Message property _SHFatigue5 auto
Message property _SHFatigueTut auto

Message property _SHFatigue0First auto
Message property _SHFatigue1First auto
Message property _SHFatigue2First auto
Message property _SHFatigue3First auto
Message property _SHFatigue4First auto
Message property _SHFatigue5First auto

Message Property _SHBedroll auto
Message Property _SHBedrollFirst auto

Sound property _SHFatigueSoundsF auto
Sound property _SHFatigueSoundsM auto

quest property PlayerSleepQuest auto
quest property RelationshipMarriageFIN auto
quest property BYOHRelationshipAdoption auto
referencealias property LoveInterest auto
spell property MarriageRested auto
locationalias property CurrentHomeLocation auto
message property BYOHAdoptionRestedMessageMale auto
message property BYOHAdoptionRestedMessageFemale auto
spell property BYOHAdoptionSleepAbilityMale auto
spell property BYOHAdoptionSleepAbilityFemale auto
message property MarriageRestedMessage auto

GlobalVariable Property _SHFatigueTutEnabled auto
GlobalVariable Property _SHFatigueSleepRestoreAmount auto
GlobalVariable Property _SHBedrollSleep auto

bool ShowNewStageMessage
bool Increasing
bool startup
bool wasWellRested = false

;Events

;Detect when the player starts sleeping
Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
    DetectSleepStart(afSleepStartTime)
EndEvent

;Detect when the player stops sleeping
Event OnSleepStop(bool abInterrupted)
    DetectSleepStop()   
EndEvent
;Functions

Function DetectSleepStart(float afSleepStartTime)
    SleepStartTime = afSleepStartTime
    _SHWasSleeping = true
    HungerWasSleeping = true
    ThirstWasSleeping = true
EndFunction

Function DetectSleepStop()
    SleepStopTime = Utility.GetCurrentGameTime()  

    float decrease = GetSleepDecreaseAmount()
    ;If sleeping in a bedroll
    if(_SHBedrollSleep.GetValue() == 1.0)
        decrease = decrease * 0.75 
        if(_SHFirstPersonMessages.GetValue() == 1.0)
            _SHBedrollFirst.Show()
        else
            _SHBedroll.Show()
        endif
        _SHBedrollSleep.SetValue(0)
    endif
    DecreaseFatigueLevel(decrease)
EndFunction

;Start up the Fatigue system
Function StartSystem()
    If (!IsRunning())     
        _SHFatigueTimeStamp.SetValue(Utility.GetCurrentGameTime())
        parent.StartSystem()
        CurrentFatigueStage = -1
        StopVanillaSleep()
        startup = true
        RegisterForSleep()
        GetNewSystemStage()
        ApplySystemEffects()
        startup = false
    EndIf
EndFunction

Function StopVanillaSleep()
    PlayerSleepQuest.UnregisterForSleep()
    Player.RemoveSpell(Rested)
    Player.RemoveSpell(WellRested)
    Player.RemoveSpell(BYOHAdoptionSleepAbilityMale)
    Player.RemoveSpell(BYOHAdoptionSleepAbilityFemale)
EndFunction

Function ApplySpouseAdoptionBonuses()

    location currentLocation = Player.GetCurrentLocation()
	if RelationshipMarriageFIN.IsRunning() && RelationshipMarriageFIN.GetStage() >= 10 && currentLocation == LoveInterest.GetActorRef().GetCurrentLocation()
        Player.RemoveSpell(MarriageRested)
        MarriageRestedMessage.Show()
		Player.AddSpell(MarriageRested, false)
    endIf

    if BYOHRelationshipAdoption.IsRunning() && Player.GetCurrentLocation() == CurrentHomeLocation.GetLocation()
        Player.RemoveSpell(BYOHAdoptionSleepAbilityMale)
        Player.RemoveSpell(BYOHAdoptionSleepAbilityFemale)
		if Player.GetActorBase().GetSex() == 0
			BYOHAdoptionRestedMessageMale.Show()
			Player.AddSpell(BYOHAdoptionSleepAbilityMale, false)
		else
			BYOHAdoptionRestedMessageFemale.Show()
			Player.AddSpell(BYOHAdoptionSleepAbilityFemale, false)
		endIf
	endIf
    
EndFunction

;Stop the fatigue system
Function StopSystem()
    PlayerSleepQuest.RegisterForSleep()
    parent.StopSystem()
EndFunction

;Updates the need values
Function UpdateNeed()
    if(!_SHWasSleeping)
        IncrementFatigueLevel()
        GetNewSystemStage()
        ApplySystemEffects()
    Else
        _SHWasSleeping = false  ;Reset sleep variable
    EndIf
    _SHFatigueTimeStamp.SetValue(Utility.GetCurrentGameTime())
    SendModEvent("_SH_UpdateWidget")
EndFunction

;Apply the correct spell to the player based on the stage
Function ApplySystemEffects()
    Player = game.GetPlayer()
    
    if(ShowNewStageMessage)
        RemoveSystemEffects()       ;Remove effects before applying new ones

        ;Decide which spell set to add
        If (CurrentFatigueStage == 0)
            DisplayNotifications(_SHFatigue0First, _SHFatigue0)
            Player.AddSpell(_SHFatigueSpell1, false)
        ElseIf (CurrentFatigueStage == 1)
            if(_SHMessagesEnabled.GetValue() == 1 && (!Increasing || startup))
                DisplayNotifications(_SHFatigue1First, _SHFatigue1)
            endif
            Player.AddSpell(_SHFatigueSpell2, false)
        ElseIf (CurrentFatigueStage == 2)
            DisplayNotifications(_SHFatigue2First, _SHFatigue2)
            Player.AddSpell(_SHFatigueSpell3, false)
        ElseIf (CurrentFatigueStage == 3)
            DisplayNotifications(_SHFatigue3First, _SHFatigue3)
            Player.AddSpell(_SHFatigueSpell4, false)
        ElseIf (CurrentFatigueStage == 4)
            DisplayNotifications(_SHFatigue4First, _SHFatigue4)
            Player.AddSpell(_SHFatigueSpell5, false)
        ElseIf (CurrentFatigueStage == 5)
            DisplayNotifications(_SHFatigue5First, _SHFatigue5)
            Player.AddSpell(_SHFatigueSpell6, false)
        EndIf

        if(CurrentFatigueStage > 1 && Increasing == true)
            ApplyFx(_SHFatigueSoundsM, _SHFatigueSoundsF)
        EndIf
    endif
EndFunction

;Remove the system effects
Function RemoveSystemEffects()
    ;Remove the spells from the player
    Player.RemoveSpell(_SHFatigueSpell1)
    Player.RemoveSpell(_SHFatigueSpell2)
    Player.RemoveSpell(_SHFatigueSpell3)
    Player.RemoveSpell(_SHFatigueSpell4)
    Player.RemoveSpell(_SHFatigueSpell5)
    Player.RemoveSpell(_SHFatigueSpell6)
EndFunction

;Return appropriate system stage level
Function GetNewSystemStage()
    
    int NewStage
    float currentLevel = _SHCurrentFatigueLevel.GetValue()

    If (currentLevel < _SHFatigueStage1)
        NewStage = 0
        if(!wasWellRested)
            wasWellRested = true
            SendModEvent("_SH_IncreaseSurvivalSkill")
            ApplySpouseAdoptionBonuses()
        endif
    ElseIf (currentLevel < _SHFatigueStage2)
        NewStage = 1
        wasWellRested = false
    ElseIf (currentLevel < _SHFatigueStage3)
        NewStage = 2
        wasWellRested = false
        if(_SHFatigueTutEnabled.GetValue() == 1 && _SHTutorials.GetValue() == 1 && Increasing)
            _SHFatigueTutEnabled.SetValue(0)
            _SHFatigueTut.Show()
        EndIf
    ElseIf (currentLevel < _SHFatigueStage4)
        NewStage = 3
        wasWellRested = false
    ElseIf (currentLevel < _SHFatigueStage5)
        NewStage = 4
        wasWellRested = false
    ElseIf (currentLevel >= _SHFatigueStage5)
        NewStage = 5
        wasWellRested = false
    EndIf

    If (NewStage != CurrentFatigueStage)
        ShowNewStageMessage = true
    Else
        ShowNewStageMessage = false
    EndIf

    CurrentFatigueStage = NewStage
EndFunction

;Increases the fatigue level by provided amount
Function IncrementFatigueLevel()
    Increasing = true
    
    ;Calculates how much time has passed since the last update
	int HoursPassed = Round((Utility.GetCurrentGameTime() - _SHFatigueTimeStamp.GetValue()) * 24)    
    
    ;float incValue = _SHCurrentFatigueLevel.GetValue() + (HoursPassed * (_SHFatigueRate.GetValue()+ Utility.RandomFloat(-1.0,1.0)))
    
	;Calculates the exhaustion that has been accumulated at +/-10% variability
    float incValue = HoursPassed * _SHFatigueRate.GetValue()

    incValue = incValue + (Utility.RandomFloat(-1.0,1.0) * (incValue * 0.10))
    if(FastTravelled)
        FastTravelled = false
        incValue = incValue / 2
    endif

    _SHCurrentFatigueLevel.SetValue(_SHCurrentFatigueLevel.GetValue() + incValue)

    ;We dont want to go greater than the greatest possible
    if(_SHCurrentFatigueLevel.GetValue() > _SHFatigueStage5)
        _SHCurrentFatigueLevel.SetValue(_SHFatigueStage5)
    EndIf
EndFunction

Function IncreaseFatigueLevel(float amount)

    _SHCurrentFatigueLevel.SetValue(_SHCurrentFatigueLevel.GetValue() + amount)

    if(_SHCurrentFatigueLevel.GetValue() > _SHFatigueStage5)
        _SHCurrentFatigueLevel.SetValue(_SHFatigueStage5)
    EndIf

    GetNewSystemStage()
    ApplySystemEffects()
    SendModEvent("_SH_UpdateWidget")

endfunction

;Find out how much to decrease fatigue (testing needed)
float Function GetSleepDecreaseAmount()

    ;Failsafe for the event that this somehow gets called before OnSleepStop
    if(!SleepStopTime)
        SleepStopTime = Utility.GetCurrentGameTime()
    endif

    float hoursPassed = Round((SleepStopTime - SleepStartTime) * 24)
    return (hoursPassed * (_SHFatigueSleepRestoreAmount.GetValue()))
EndFunction

;Decreases the fatigue level by provided amount
Function DecreaseFatigueLevel(float decAmount)

    float perkMod = 0.0

    if(_SH_PerkRank_Slumber.GetValue() == 1.0)
        perkMod = 0.1
    elseif(_SH_PerkRank_Slumber.GetValue() == 2.0)
        perkMod = 0.15
    endif

    decAmount += (decAmount*perkMod)

    _SHCurrentFatigueLevel.SetValue(_SHCurrentFatigueLevel.GetValue() - decAmount)    ;Decrement the level
    ;Ensure hunger level doesn't go below value
    If (_SHCurrentFatigueLevel.GetValue() < 0.0)
        _SHCurrentFatigueLevel.SetValue(0.0)
    EndIf

    Increasing = false
    GetNewSystemStage()
    ApplySystemEffects()
    Increasing = true
    SendModEvent("_SH_UpdateWidget")
EndFunction

;Set the fatigue level to provided value
Function SetFatigueLevel(float amount)

    _SHCurrentFatigueLevel.SetValue(amount)    ;Decrement the level

    If (_SHCurrentFatigueLevel.GetValue() < 0)
        _SHCurrentFatigueLevel.SetValue(0)
    EndIf

    ;We dont want to go greater than the greatest possible
    if(_SHCurrentFatigueLevel.GetValue() > _SHFatigueStage5)
        _SHCurrentFatigueLevel.SetValue(_SHFatigueStage5)
    EndIf

    GetNewSystemStage()
    ApplySystemEffects()
    
    SendModEvent("_SH_UpdateWidget")
EndFunction

int Function GetFatiguePercent()
    return ((_SHCurrentFatigueLevel.GetValue()/ _SHFatigueStage5) * 100) as int
endFunction

;Parent calls
Function PauseUpdates()
    RemoveSystemEffects()
    parent.PauseUpdates()
EndFunction

Function ResumeUpdates()
    _SHFatigueTimeStamp.SetValue(Utility.GetCurrentGameTime())
    parent.ResumeUpdates()
EndFunction

Function SetValuesOnStoryServed(Location akLocation)
    If (akLocation == "CidhnaMine01" || akLocation == "CidhnaMine02")   ;Figure out which one this is
        _SHCurrentFatigueLevel.SetValue(375)
    Else
        _SHCurrentFatigueLevel.SetValue(205)
    EndIf
EndFunction

Function SetTimeStamps()
    _SHFatigueTimeStamp.SetValue(Utility.GetCurrentGameTime())
endfunction