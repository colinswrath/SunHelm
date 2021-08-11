Scriptname _SHConfig extends activemagiceffect
{This script will manage the config messagebox}

;-------------------------------------------------

;Properties
Message Property _SHMenuOptions Auto
Actor Player
_SunHelmMain property _SHMain auto

;events


;When the spell is fired, it brings up the menu
Event OnEffectStart(Actor akTarget, Actor akCaster)
    Player = akTarget
    ConfigMenu()
EndEvent

;functions

;Displays main messagebox menu. If edited make sure to change exit to last button in CK.
Function ConfigMenu(int in = -1)
	
	in = _SHMenuOptions.Show() ;Starts the config messagebox
	
	If in == 0	;Start SunHelm
		_SHMain.StartMod()
	ElseIf in == 1 ;Stop SunHelm
		_SHMain.StopMod()
	ElseIf in == 2	;Exit
		return
	EndIf
	
EndFunction
