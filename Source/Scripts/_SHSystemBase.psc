Scriptname _SHSystemBase extends Quest
;Base need script. Contains methods that each need system will inherit and use
;-----------------------------------------------------------------------------
;There are systems in the mod other than the needs, but typically this script drives only the core need's systems
 
;--Properties--
Actor property Player auto

GlobalVariable Property _SHUpdateInterval Auto
GlobalVariable property _SHHungerRate auto 
GlobalVariable Property _SHThirstRate Auto
GlobalVariable Property _SHFatigueRate Auto

GlobalVariable Property _SHCurrentHungerLevel Auto
GlobalVariable Property _SHCurrentThirstLevel Auto
GlobalVariable Property _SHCurrentFatigueLevel Auto
GlobalVariable Property _SHCurrentColdLevel Auto    ;;

bool Property _SHWasSleeping auto hidden
GlobalVariable Property _SHMessagesEnabled auto
GlobalVariable Property _SHNeedsDeath auto
GlobalVariable Property _SHHungerTimeStamp Auto
GlobalVariable Property _SHFatigueTimeStamp Auto
GlobalVariable Property _SHThirstTimeStamp Auto
GlobalVariable Property _SHColdLastTimeStamp Auto
GlobalVariable Property _SHColdCurrentTimeStamp Auto
GlobalVariable Property _SHHungerShouldBeDisabled auto
GlobalVariable Property _SHThirstShouldBeDisabled auto
GlobalVariable Property _SHFatigueShouldBeDisabled auto
GlobalVariable Property _SHColdShouldBeDisabled auto
GlobalVariable Property _SHIsSexMale auto
GlobalVariable Property _SHToggleSounds auto
GlobalVariable Property _SHFirstPersonMessages auto
GlobalVariable property _SHIsInDialogue auto
GlobalVariable property _SH_PerkRank_Hydrated auto
GlobalVariable property _SH_PerkRank_Slumber auto
GlobalVariable property _SH_PerkRank_ThermalIntensity auto
GlobalVariable property _SH_PerkRank_Connoisseur auto
GlobalVariable property _SH_PerkRank_Reservoir auto
GlobalVariable property _SH_PerkRank_Repose auto
GlobalVariable property _SH_PerkRank_AmbientWarmth auto
GlobalVariable property _SH_PerkRank_Conviviality auto
GlobalVariable property _SHPauseNeedsCombat auto
GlobalVariable property _SHPauseNeedsDialogue auto
GlobalVariable property _SHPauseNeedsOblivion auto   
GlobalVariable Property _SHTutorials Auto 

bool property PauseForCombat 
    bool Function Get()
        if(Player.IsInCombat() && _SHPauseNeedsCombat.GetValue() == 1)
            return true
        else
            return false
        endif
    EndFunction
EndProperty

bool property PauseForDialogue 
    bool Function Get()
        if(_SHIsInDialogue.GetValue() == 1.0 && _SHPauseNeedsDialogue.GetValue() == 1)
            return true
        else
            return false
        endif
    EndFunction
EndProperty

bool property PauseForOblivion
    bool Function Get()
        if(!_SHMain.isInOblivion || _SHPauseNeedsOblivion.GetValue() == 0.0)
            return false        ;Return false if we are not in oblivion or if we have oblivion pause turned off
        else
            return true
        endif
    EndFunction
EndProperty

_SunHelmMain property _SHMain auto

bool property HungerWasSleeping = false auto
bool property ThirstWasSleeping = false auto

bool InJail = false

;--Local Variables--

;Called on every fired update event
Event OnUpdateGameTime()
    if(!PauseForOblivion && !PauseForCombat && !PauseForDialogue)
        
        ;Jail check
        if(!InJail || !_SHMain.BeastWerewolf)
            UpdateNeed()   ;Update appropriate need
        endif
    Else
        SetTimeStamps()
    endif
    RegisterForSingleUpdateGameTime(_SHUpdateInterval.GetValue())    ;Register to update the time again
EndEvent

;Starts up a system
Function StartSystem() 
    Start()
    Utility.Wait(1) ;Give the quest time to start
    RegisterForSingleUpdateGameTime(_SHUpdateInterval.GetValue())
EndFunction

;Stops a system. Register for update is automatically unregistered on the quest's conclusion
Function StopSystem()
    if (IsRunning())
        RemoveSystemEffects()
        Stop()
    endif
EndFunction

Function PauseUpdates()
    UnregisterForUpdateGameTime()
EndFunction

Function ResumeUpdates()
    RegisterForSingleUpdateGameTime(_SHUpdateInterval.GetValue())    ;Register to update the time again
EndFunction

Event OnStoryJail(ObjectReference akGuard, Form akCrimeGroup, Location akLocation, int aiCrimeGold)
    InJail = true;
EndEvent

;Fires event when the player gets out of jail
Event OnStoryServedTime(Location akLocation, Form akCrimeGroup, int aiCrimeGold, int aiDaysJail)
    SetTimeStamps()    
    SetValuesOnStoryServed(akLocation)

    InJail = false
EndEvent

Event OnStoryEscapeJail(Location akLocation, Form akCrimeGroup)
    SetTimeStamps()    

    InJail = false
EndEvent

;Utility
;Checks to see if a float is between value 1 and 2.
bool Function IsBetween(float checkVal, int valOne, int valTwo)
    If (checkVal >= valOne && checkVal < valTwo)
        return true
    EndIf
    return false
EndFunction

;Rounds a float to the nearest int
int Function Round(float number)
    If (number - (number as int)) < 0.5     ;casting a float as an int functions the same way as a math.Floor function
		Return (number as int)
	EndIf
	Return (Math.Ceiling(number) as int)
EndFunction

Function DisplayNotifications(Message first, Message third) 

    If (_SHMessagesEnabled.GetValue() == 1)
        if(_SHFirstPersonMessages.GetValue() == 1.0)              
            first.Show()
        Else
            third.Show()
        endif
    EndIf

EndFunction

Function ApplyFx(Sound male, Sound female)

    If(_SHToggleSounds.GetValue())
        If (_SHIsSexMale.GetValue() == 1.0)
            male.Play(Player)
            return
        Else
            female.Play(Player)
            return
        EndIf
    EndIf
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          Overwrites            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Will be overwritten by children
Function UpdateNeed()
    Debug.Notification("Error: UpdateNeed not overwritten! Please report on modpage!")
EndFunction

Function RemoveSystemEffects()
    Debug.Notification("Error: RemoveSystemEffects not overwritten! Please report on modpage!")
EndFunction

Function SetValuesOnStoryServed(Location akLocation)
    Debug.Notification("Error: SetValuesOnStoryServed not overwritten! Please report on modpage!")
EndFunction

Function SetTimeStamps()
    Debug.Notification("Error: SetTimeStamps not overwritten! Please report on modpage!")
endfunction

