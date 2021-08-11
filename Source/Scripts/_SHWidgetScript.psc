Scriptname _SHWidgetScript extends SKI_WidgetBase

;Properties 

string orientation 
bool isEnabled = false
bool hideWidget = false

_SunHelmMain property _SHMain auto

GlobalVariable property _SHCurrentHungerLevel auto
GlobalVariable property _SHCurrentThirstLevel auto
GlobalVariable property _SHCurrentFatigueLevel auto
GlobalVariable Property _SHToggleWidgets Auto 
GlobalVariable Property _SHWidgetOrientation Auto
GlobalVariable Property _SHWidgetPreset Auto
GlobalVariable Property _SHWidgetDisplayType Auto
GlobalVariable Property _SHWidgetXOffset Auto
GlobalVariable Property _SHWidgetYOffset Auto 


;Functions

String Function GetWidgetSource()
	Return "SunHelm/SunHelmIcons.swf"
	;Return "SunHelm/statusicons.swf"
EndFunction

; @overrides SKI_WidgetBase
String Function GetWidgetType()
	
    Return "SHWidgetScript"
endFunction

Bool Property Enabled
	Bool Function Get()
		Return isEnabled
	EndFunction

	Function Set(bool a_val)
		isEnabled = a_val
		If (Ready)
			UI.InvokeBool(HUD_MENU, WidgetRoot + ".setEnabled", isEnabled) 
		EndIf
		
	EndFunction
EndProperty

int Property WidgetX
	int Function Get()
		if(_SHWidgetOrientation.GetValue() == 1)
			if(_SHWidgetPreset.GetValue() == 0)
				return 200
			ElseIf(_SHWidgetPreset.GetValue() == 1)
				return 1125
			ElseIf(_SHWidgetPreset.GetValue() == 2)
				return 175
			ElseIf(_SHWidgetPreset.GetValue() == 3)
				return 1175
			endif
		else
			if(_SHWidgetPreset.GetValue() == 0 || _SHWidgetPreset.GetValue() == 2)
				return 20
			ElseIf(_SHWidgetPreset.GetValue() == 1 || _SHWidgetPreset.GetValue() == 3)
				return 1245
			endif
		endif
	EndFunction
EndProperty

int Property WidgetY
	int Function Get()
		if(_SHWidgetOrientation.GetValue() == 1)
			if(_SHWidgetPreset.GetValue() == 0 || _SHWidgetPreset.GetValue() == 1)
				return 45
			ElseIf(_SHWidgetPreset.GetValue() == 2 || _SHWidgetPreset.GetValue() == 3)
				return 721
			endif
		else
			if(_SHWidgetPreset.GetValue() == 0 || _SHWidgetPreset.GetValue() == 1)
				return 165
			ElseIf(_SHWidgetPreset.GetValue() == 2 || _SHWidgetPreset.GetValue() == 3)
				return 721
			endif
		endif
	EndFunction
EndProperty

Event OnWidgetReset()
	Parent.OnWidgetReset()

	;Determine widget hidden
	bool hide
	if(_SHMain._SHEnabled.GetValue() == 1 && _SHToggleWidgets.GetValue() == 1 && !hideWidget)
		hide = false
	Else
		hide = true
	EndIf

	UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionX", WidgetX + _SHWidgetXOffset.GetValue() as int + 20)
	UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionY", WidgetY + _SHWidgetYOffset.GetValue() as int)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setHAnchor", "right")
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setVAnchor", "bottom")
	
	UI.InvokeBool(HUD_MENU, WidgetRoot + ".setHide", hide)

	;Call init Numbers function
	int[] argsNum  = new int[1]
	argsNum[0] = Enabled as int

	UI.InvokeBool(HUD_MENU, WidgetRoot + ".initNumbers", argsNum)

	UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", true)

	;Init strings function
	string[] argString = new string[1]

	if(_SHWidgetOrientation.GetValue() == 0)
		orientation = "vertical"
	Else
		orientation = "horizontal"
	EndIf

	argString[0] = orientation
	UI.InvokeStringA(HUD_MENU, WidgetRoot + ".initStrings", argString)

	;Commit
	UI.Invoke(HUD_MENU, WidgetRoot + ".initCommit")

	;Alpha
	UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setAlpha", 100)

	UpdateWidget()
EndEvent

Function UpdateWidget()
	if(Ready)

		;This is for color based
		int HungerLevel = SetLevel(_SHMain.Hunger.CurrentHungerStage)	;Verify this
		int ThirstLevel = SetLevel(_SHMain.Thirst.CurrentThirstStage)
		int FatigueLevel = SetLevel(_SHMain.Fatigue.CurrentFatigueStage)

		;Percent for alpha based (Use level to determine alpha percent)
		int HungerPercent = SetPercent(_SHMain.Hunger.CurrentHungerStage)
		int ThirstPercent = SetPercent(_SHMain.Thirst.CurrentThirstStage)
		int FatiguePercent = SetPercent(_SHMain.Fatigue.CurrentFatigueStage)

		int[] args = new Int[6]

		;Alpha Based (1st 3 parameters are alpha)
		if(_SHWidgetDisplayType.GetValue() == 0)
	
			args[0] = HungerPercent
			args[1] = ThirstPercent
			args[2] = FatiguePercent
			args[3] = 1
			args[4] = 1
			args[5] = 1

		;Color based (Alpha set to 100, change last three parameters)
		ElseIf(_SHWidgetDisplayType.GetValue() == 1)
			args[0] = 130
			args[1] = 130
			args[2] = 130
			args[3] = HungerLevel
			args[4] = ThirstLevel
			args[5] = FatigueLevel

		;Alpha and color based. Set both values
		Else
			args[0] = HungerPercent
			args[1] = ThirstPercent
			args[2] = FatiguePercent
			args[3] = HungerLevel
			args[4] = ThirstLevel
			args[5] = FatigueLevel
		EndIf
		
		;Turn off widgets based on which needs are enabled
		if(!_SHMain.Hunger.IsRunning())
			args[0] = 0
		endif

		If (!_SHMain.Thirst.IsRunning())
			args[1] = 0
		endif		
		
		If (!_SHMain.Fatigue.IsRunning())
			args[2] = 0
		endif

		UI.InvokeIntA(HUD_MENU, WidgetRoot + ".setStatus", args)
	EndIf
EndFunction

;Sets an int to correspond to desired widget
int Function SetLevel(int NeedStage)
	if(NeedStage < 1)
		return 0
	elseif(NeedStage < 2)
		return 1
	ElseIf (NeedStage < 4)
		return 2
	Else
		return 3
	EndIf
EndFunction

int Function SetPercent(int NeedStage)
	if(NeedStage <= 1)
		return 0
	ElseIf(NeedStage == 2)
		return 25
	ElseIf (NeedStage == 3)
		return 50
	ElseIf(NeedStage == 4)
		return 75
	Else
		return 130
	EndIf
EndFunction

Event OnGameReload()
	Parent.OnGameReload()
	RegisterForModEvent("_SH_UpdateWidget", "OnUpdateWidget")
    RegisterForModEvent("_SH_WidgetUi", "OnUIConfig")
    RegisterForModEvent("_SHHideWidget", "OnSetHideWidget")
EndEvent

Event OnUpdateWidget(string eventName, string strArg, float numArg, Form sender)
	UpdateWidget()
EndEvent

Event OnUIConfig(string eventName, string strArg, float numArg, Form sender)
	OnWidgetReset()
EndEvent

Event OnSetHideWidget(string eventName, string strArg, float numArg, Form sender)
	hideWidget = !hideWidget
	UI.InvokeBool(HUD_MENU, WidgetRoot + ".setHide", hideWidget)
	UI.Invoke(HUD_MENU, WidgetRoot + ".initCommit")
EndEvent




