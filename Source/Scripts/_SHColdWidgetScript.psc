Scriptname _SHColdWidgetScript extends SKI_WidgetBase

GlobalVariable Property _SHUITempLevel Auto
GlobalVariable Property _SHColdWidgetX Auto
GlobalVariable Property _SHColdWidgetY Auto
GlobalVariable property _SHHideColdWidget auto

string orientation 
bool isEnabled = false
_SunHelmMain property _SHMain auto
bool hideWidget = false

String Function GetWidgetSource()
	Return "SunHelm/SunHelmColdIcons.swf"
EndFunction

; @overrides SKI_WidgetBase
String Function GetWidgetType()

    Return "SHColdWidgetScript"
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

Event OnWidgetReset()
	Parent.OnWidgetReset()
	lastTemp = 0.0
	;Determine widget hidden
	bool hide = false
	if(_SHMain.Cold._SHColdActive.GetValue() == 1 && _SHHideColdWidget.GetValue() == 0)
		hide = false
	Else
		hide = true
	EndIf
	UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionX", 860 + _SHColdWidgetX.GetValue())
	UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionY", 50 + _SHColdWidgetY.GetValue())
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setHAnchor", "right")
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setVAnchor", "bottom")

	UI.InvokeBool(HUD_MENU, WidgetRoot + ".setHide", hide)

	;Call init Numbers function
	int[] argsNum  = new int[1]
	argsNum[0] = Enabled as int

	UI.InvokeBool(HUD_MENU, WidgetRoot + ".initNumbers", argsNum)

	UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", true)


	;Commit
	UI.Invoke(HUD_MENU, WidgetRoot + ".initCommit")

	;Default location

EndEvent

float lastTemp = 0.0
Function UpdateWidget()
	if(Ready)
		int tempLevel = _SHUITempLevel.GetValue() as int

		if(lastTemp != tempLevel)
			int[] args = new int[1]
			args[0] = tempLevel
	
			UI.InvokeIntA(HUD_MENU, WidgetRoot + ".setStatus", args)
			lastTemp = tempLevel
		endif
	EndIf
EndFunction

Event OnGameReload()
	Parent.OnGameReload()
	RegisterForModEvent("_SH_UpdateColdWidget", "OnUpdateWidget")
	RegisterForModEvent("_SH_WidgetColdUi", "OnUIConfig")
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