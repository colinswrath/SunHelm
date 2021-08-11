Scriptname _SH_MCMScript extends SKI_ConfigBase

_SunHelmMain property _SHMain auto
_SHWidgetScript property _SHWidget auto

GlobalVariable Property _SHMessagesEnabled auto
GlobalVariable Property _SHNeedsDeath auto
GlobalVariable Property _SHDisableFT auto
GlobalVariable Property _SHEnabled Auto
GlobalVariable property _SHCannibalism auto
GlobalVariable property _SHDrunkSkoomaFX auto
GlobalVariable property _SHColdFX auto
GlobalVariable Property _SHHungerTutEnabled auto
GlobalVariable Property _SHThirstTutEnabled auto
GlobalVariable Property _SHFatigueTutEnabled auto
GlobalVariable Property _SHHungerShouldBeDisabled auto
GlobalVariable Property _SHThirstShouldBeDisabled auto
GlobalVariable Property _SHFatigueShouldBeDisabled auto
GlobalVariable Property _SHColdShouldBeDisabled auto
GlobalVariable property _SHRateGoal auto
GlobalVariable Property _SHToggleSounds auto
GlobalVariable Property _SHAnimationsEnabled auto
GlobalVariable Property _SHGiveBottles auto
GlobalVariable Property _SHFirstPersonMessages auto
GlobalVariable Property _SHForceDisableCold auto
GlobalVariable Property _SHColdWidgetX Auto
GlobalVariable Property _SHColdWidgetY Auto
GlobalVariable property _SHHideColdWidget auto
GlobalVariable property _SHRawDamage auto
GlobalVariable property _SHCarryWeight auto
GlobalVariable property _SHCampfireSkillTreeInstalled auto
GlobalVariable property _SHWaterskinEquip auto
GlobalVariable property _SHRefillAnims auto
GlobalVariable Property _SHDetailedContinuance auto
GlobalVariable Property _SHContinuance1Line auto
GlobalVariable Property _SHSeasonsEnabled auto
GlobalVariable property _SHPauseNeedsCombat auto
GlobalVariable property _SHPauseNeedsDialogue auto
GlobalVariable property _SH_PerkRank_Hydrated auto
GlobalVariable property _SH_PerkRank_Slumber auto
GlobalVariable property _SH_PerkRank_ThermalIntensity auto
GlobalVariable property _SH_PerkRank_Connoisseur auto
GlobalVariable property _SH_PerkRank_Reservoir auto
GlobalVariable property _SH_PerkRank_Repose auto
GlobalVariable property _SH_PerkRank_AmbientWarmth auto
GlobalVariable property _SH_PerkRank_Conviviality auto
GlobalVariable property _SH_PerkRank_Unyielding auto
GlobalVariable property _SHHungerRate auto
GlobalVariable property _SHThirstRate auto
GlobalVariable property _SHFatigueRate auto
GlobalVariable property _SHWaterskinLocation auto   
GlobalVariable property _SHPauseNeedsOblivion auto   
GlobalVariable property _SHWerewolfPauseNeeds auto   
GlobalVariable property _SHWerewolfFatigue auto  
GlobalVariable Property _SHWidgetXOffset Auto
GlobalVariable Property _SHWidgetYOffset Auto 
GlobalVariable Property _SHToggleWidgets Auto 
GlobalVariable Property _SHFillHotKey Auto 
GlobalVariable Property _SHContHotKey Auto 
GlobalVariable Property _SHWidgetHotKey Auto 
GlobalVariable Property _SHTutorials Auto
GlobalVariable Property _SHWidgetOrientation Auto
GlobalVariable Property _SHWidgetPreset Auto
GlobalVariable Property _SHWidgetDisplayType Auto
GlobalVariable Property _SHNumDrinks Auto
GlobalVariable Property _SHWerewolfFeedOptions Auto
GlobalVariable Property _SHVampireNeedsOption Auto
GlobalVariable Property _SHInnKeeperDialogue Auto
GlobalVariable Property _SHEatDrinkHotkey Auto

Actor property PlayerRef auto

int MOD_TOGGLE_INDEX

int DEFAULT_ANIMATIONS
int DEFAULT_REFILLANIMATIONS
int DEFAULT_CANNIBAL
int DEFAULT_RAW
int DEFAULT_CARRYWEIGHT
int DEFAULT_BOTTLES
int DEFAULT_WATERSKINS
int DEFAULT_TUTORIALS
int DEFAULT_COLDFX
int DEFAULT_MESSAGES
int DEFAULT_SOUNDS
int DEFAULT_FIRSTPERSON
int DEFAULT_COLDWIDGET
int DEFAULT_DETAILED
int DEFAULT_DETAILED1LINE
int DEFAULT_DEATH
int DEFAULT_PAUSECOMBAT
int DEFAULT_COLDRATE
int DEFAULT_HUNGERRATE
int DEFAULT_THIRSTRATE
int DEFAULT_FATIGUERATE
int DEFAULT_PAUSEDIALOGUE
int DEFAULT_COLDWIDGETX
int DEFAULT_COLDWIDGETY
int DEFAULT_WIDGETOFFSETX
int DEFAULT_WIDGETOFFSETY
int DEFAULT_WIDGETPRESET
int DEFAULT_ALCOHOL

int restoreFlag

string Property ConfigDir
	string Function Get()
		return JContainers.userDirectory() + "SunHelm/"
	EndFunction
EndProperty

string Property DefaultFile
	string Function Get()
		return "Data/SunHelm.json"
	EndFunction
EndProperty

string Property Ext = ".json"  AutoReadOnly
string CurrentFile = ""
string[] BrowseFileEntries

int WidgetXNoOffset = 1175
int WidgetYNoOffset = 721

;--------------------------
;Strings
;-------------------------
String[] ModToggleArray
String[] OrientationArray
String[] WidgetDisplayArray
String[] WidgetPresetArray
String[] WerewolfFillArray
String[] VampireOptionArray
String[] WaterskinArray

int Function GetVersion()
    return 1
endfunction

;On the MCM load
Event OnConfigInit()
    Pages = new string[6]
    Pages[0] = "$GeneralSettings"
    Pages[1] = "$DisplaySettings"
    Pages[2] = "$Needs"
    Pages[3] = "$Cold"
    Pages[4] = "$SkillTree"
    Pages[5] = "$Profiles"

    ModToggleArray = new String[2]
    ModToggleArray[0] = "$Disabled"
    ModToggleArray[1] = "$Enabled"

    OrientationArray = new String[2]
    OrientationArray[0] = "$Vertical"
    OrientationArray[1] = "$Horizontal"

    WidgetDisplayArray = new String[3]
    WidgetDisplayArray[0] = "$Alpha"
    WidgetDisplayArray[1] = "$Color"
    WidgetDisplayArray[2] = "$AlphaColor"

    WidgetPresetArray = new String[4]
    WidgetPresetArray[0] = "$Top_Left"
    WidgetPresetArray[1] = "$Top_Right"
    WidgetPresetArray[2] = "$Bottom_Left"
    WidgetPresetArray[3] = "$Bottom_Right"

    WerewolfFillArray = new String[3]
    WerewolfFillArray[0] = "$Hunger_Thirst"
    WerewolfFillArray[1] = "$Hunger"
    WerewolfFillArray[2] = "$Thirst"

    VampireOptionArray = new String[4]
    VampireOptionArray[0] = "$Immortal"
    VampireOptionArray[1] = "$Thirst"
    VampireOptionArray[2] = "$Fatigue_Thirst"
    VampireOptionArray[3] = "$Mortal"

    WaterskinArray = new String[3]
    WaterskinArray[0] = "$Back"
    WaterskinArray[1] = "$Right"
    WaterskinArray[2] = "$Left"
EndEvent

;Is triggered on MCM menu update
Event OnVersionUpdate(int a_version)
    if (a_version > 1)
        Debug.Trace(self + "$UpdatingToVersion" + a_version)
		OnConfigInit()
    endif
EndEvent

;When a page is opened or reset
Event OnPageReset(string page)

    If(page == "")
        LoadCustomContent("SunHelmLogo.dds")
        return
    Else
        UnloadCustomContent()
    EndIf

    if(_SHEnabled.GetValue() == 0)
        If(page == "$GeneralSettings")
            SetCursorFillMode(TOP_TO_BOTTOM)
            
            if Game.IsFightingControlsEnabled()
                AddMenuOptionST("ENABLE","$SunHelmSurvival", ModToggleArray[MOD_TOGGLE_INDEX])
            else
                AddMenuOption("$SunHelmSurvival", ModToggleArray[MOD_TOGGLE_INDEX], OPTION_FLAG_DISABLED)
                AddHeaderOption("$SHBoundHands",OPTION_FLAG_DISABLED)
            endif
            AddEmptyOption()
        Else
            AddHeaderOption("$EnableToView",OPTION_FLAG_DISABLED)
        Endif
    Else

        If(page == "$GeneralSettings")
            SetCursorFillMode(TOP_TO_BOTTOM)
            
            if Game.IsFightingControlsEnabled()
                AddMenuOptionST("ENABLE","$SunHelmSurvival", ModToggleArray[_SHEnabled.GetValue() as int])
            else
                AddMenuOption("$SunHelmSurvival", ModToggleArray[_SHEnabled.GetValue() as int], OPTION_FLAG_DISABLED)
                AddHeaderOption("$SHBoundHands",OPTION_FLAG_DISABLED)
            endif
            AddEmptyOption()
  
            AddHeaderOption("$AnimOptions")
            AddToggleOptionST("ANIMATIONS","$PlayEatDrinkAnims", _SHAnimationsEnabled.GetValue())
            AddToggleOptionST("REFILLANIMATIONS","$PlayRefillAnims", _SHRefillAnims.GetValue())
            AddEmptyOption()
            AddHeaderOption("$GameplayOptions")

            AddToggleOptionST("FASTTRAVEL","$ToggleFT", _SHDisableFT.GetValue())
            AddToggleOptionST("CANNIBAL","$ToggleCannibal",_SHCannibalism.GetValue())
            AddToggleOptionST("RAW","$ToggleRaw",_SHRawDamage.GetValue())
            AddToggleOptionST("CARRYWEIGHT","$ToggleCW", _SHCarryWeight.GetValue())
            AddToggleOptionST("INNKEEPER","$InnKeeperDialogue", _SHInnKeeperDialogue.GetValue())
            SetCursorPosition(1)
            AddTextOptionST("RESETFORM","$ResetFormLists","")
            AddToggleOptionST("BOTTLES","$ToggleBottle", _SHGiveBottles.GetValue())
            AddHeaderOption("$WaterskinOptions")
            AddToggleOptionST("WATERSKIN","$WaterskinEquip", _SHWaterskinEquip.GetValue())
            AddMenuOptionST("SKINLOCATION","$WaterskinLocation", WaterskinArray[_SHWaterskinLocation.GetValue() as int])
            ;Hotkeys
            AddHeaderOption("$Hotkeys")
            AddKeyMapOptionST("FILLHOTKEY","$DrinkAndFillHk", _SHFillHotKey.GetValue() as int, OPTION_FLAG_WITH_UNMAP)
            AddTextOptionST("REMOVEPOWERS","$TogglePowers","")

        ElseIf(page == "$DisplaySettings")
            SetCursorFillMode(TOP_TO_BOTTOM)

            AddHeaderOption("$DisplayOptions")
            AddToggleOptionST("TUTORIALS","$EnableTut",_SHTutorials.GetValue())
            AddEmptyOption()
            AddHeaderOption("$Notifications")
            AddToggleOptionST("MESSAGES","$DispMsgNotifs",_SHMessagesEnabled.GetValue())
            AddToggleOptionST("SOUNDS","$SoundNotifs",_SHToggleSounds.GetValue())
            AddToggleOptionST("FIRSTPERSON","$ToggleFirst", _SHFirstPersonMessages.GetValue())
            AddEmptyOption()
            AddHeaderOption("$ContinuanceOptions")
            AddKeyMapOptionST("CONTINHOTKEY","$ContinuanceHk", _SHContHotKey.GetValue() as int, OPTION_FLAG_WITH_UNMAP)
            AddToggleOptionST("DETAILEDCONT","$DetailedCont", _SHDetailedContinuance.GetValue())
            AddToggleOptionST("DETAILED1LINE","$DetailOneLine", _SHContinuance1Line.GetValue())
            SetCursorPosition(1)
            AddHeaderOption("$WidgetOptions")
            AddToggleOptionST("TOGGLEWIDGET","$ToggleWidget", _SHToggleWidgets.GetValue())
            AddMenuOptionST("ORIENTATION","$WidgetOrient",OrientationArray[_SHWidgetOrientation.GetValueInt()])
            AddMenuOptionST("WIDGETDISTYPE","$WidgDisType",WidgetDisplayArray[_SHWidgetDisplayType.GetValue() as int])
            AddKeyMapOptionST("HIDEWIDHOTKEY","$WidgetHk", _SHWidgetHotKey.GetValue() as int, OPTION_FLAG_WITH_UNMAP)
            AddEmptyOption()
            AddHeaderOption("$WidgetLocation")
            AddMenuOptionST("WIDGETPRESET","$PresetLoc",WidgetPresetArray[_SHWidgetPreset.GetValueInt()])
            AddSliderOptionST("WIDGETX","$WidgXOff", _SHWidgetXOffset.GetValue() as int)
            AddSliderOptionST("WIDGETY","$WidgYOff", _SHWidgetYOffset.GetValue() as int)
            AddEmptyOption()
            

        ElseIf (page == "$Needs")
            SetCursorFillMode(TOP_TO_BOTTOM)

            AddHeaderOption("$NeedsOptions")
            AddToggleOptionST("DEATH","$DmgHungThirst", _SHNeedsDeath.GetValue())
            AddToggleOptionST("PAUSEOBLIVION","$PauseOblivion", _SHPauseNeedsOblivion.GetValue())
            AddToggleOptionST("PAUSECOMBAT","$PauseCombat", _SHPauseNeedsCombat.GetValue())
            AddToggleOptionST("PAUSEDIALOGUE","$PauseDialogue", _SHPauseNeedsDialogue.GetValue())
            
            AddHeaderOption("$Hunger")
            AddToggleOptionST("TOGGLEHUNGER","$ToggleHunger", !(_SHHungerShouldBeDisabled.GetValue() as bool))
            AddSliderOptionST("HUNGERRATE","$HungerRate", _SHHungerRate.GetValue())
            AddHeaderOption("$Thirst")
            AddToggleOptionST("TOGGLETHIRST","$ToggleThirst", !(_SHThirstShouldBeDisabled.GetValue() as bool))
            AddSliderOptionST("THIRSTRATE","$ThirstRate", _SHThirstRate.GetValue())
            AddHeaderOption("$Fatigue")
            AddToggleOptionST("TOGGLEFATIGUE","$ToggleFatigue", !(_SHFatigueShouldBeDisabled.GetValue() as bool))
            AddSliderOptionST("FATIGUERATE","$FatigueRate", _SHFatigueRate.GetValue())
            SetCursorPosition(1)
            AddHeaderOption("$AlcoholSkoomaOptions")
            AddToggleOptionST("DRUNKFX","$DrunkSkoomaFx", _SHDrunkSkoomaFX.GetValue())
            AddSliderOptionST("ALCOHOL","$AlcoholNumber", _SHNumDrinks.GetValue())
            AddHeaderOption("$WerewolfOptions")
            AddMenuOptionST("WEREFEED","$WereFills", WerewolfFillArray[_SHWerewolfFeedOptions.GetValue() as int])
            AddToggleOptionST("WEREFATIGUE","$WerewolfFatigue", _SHWerewolfFatigue.GetValue())
            AddToggleOptionST("WEREPAUSENEEDS","$WerewolfPause", _SHWerewolfPauseNeeds.GetValue())
            AddEmptyOption()
            AddHeaderOption("$VampireOptions")
            AddMenuOptionST("VAMPIRENEEDS","$VampireNeeds", VampireOptionArray[_SHVampireNeedsOption.GetValue() as int])
        
        ElseIf(page == "$SkillTree")
            SetCursorFillMode(TOP_TO_BOTTOM)
            
            if(_SHCampfireSkillTreeInstalled.GetValue() == 1.0)
                AddHeaderOption("$SurvRespec")
                AddTextOptionST("RESPECSKILL","$RespecSkillPoints", "")
                restoreFlag = OPTION_FLAG_DISABLED
                AddToggleOptionST("RESTORE","$RestSkillProg", false)
                AddSliderOptionST("RESTORESLIDER","$PointsToRestore", 0, "{0}", restoreFlag)
            else
                AddHeaderOption("$EnableCampfireSkillToView",OPTION_FLAG_DISABLED)
            endif

        ElseIf(page == "$Cold")
            SetCursorFillMode(TOP_TO_BOTTOM)
            
            if(_SHForceDisableCold.GetValue() == 0)
                AddHeaderOption("$Cold")
                AddToggleOptionST("TOGGLECOLD","$ToggleCold", !(_SHColdShouldBeDisabled.GetValue() as bool))
                AddSliderOptionST("COLDRATE","$ColdRate", _SHRateGoal.GetValue())
                AddToggleOptionST("COLDWIDGET","$ToggleColdWidget", !_SHHideColdWidget.GetValue())
                AddToggleOptionST("COLDFX","$ColdEffects", _SHColdFX.GetValue())
                AddToggleOptionST("SEASONS", "$Seasons", _SHSeasonsEnabled.GetValue())
                AddEmptyOption()
                AddHeaderOption("$WidgetOptions")
                AddSliderOptionST("COLDWIDGETX","$ColdWidXOff", _SHColdWidgetX.GetValue())
                AddSliderOptionST("COLDWIDGETY","$ColdWidYOff", _SHColdWidgetY.GetValue())
            endif

        ElseIf(page == "$Profiles")
            SetCursorFillMode(TOP_TO_BOTTOM)
		    if JContainers.isInstalled()
                AddHeaderOption("$Profiles")
                AddInputOptionST("NewFile", "$New", "")

                PopulateBrowseFileEntries()
                int iBrowseFlag = OPTION_FLAG_DISABLED
                if BrowseFileEntries.Length > 0
                    iBrowseFlag = OPTION_FLAG_NONE
                endif

                AddMenuOptionST("Browse", "$Browse", CurrentFile, a_flags = iBrowseFlag)

                int iFileFlag = OPTION_FLAG_DISABLED
                if CurrentFile != ""
                    iFileFlag = OPTION_FLAG_NONE
                endif

                AddTextOptionST("Load", "$Load", "", a_flags = iFileFlag)
                AddTextOptionST("Save", "$Save", "", a_flags = iFileFlag)
                AddTextOptionST("Delete", "$Delete", "", a_flags = iFileFlag)
            else
                AddTextOption("$RequireJContainers", "")    ;TODO ADD TRANSLATION FILE
            endif
        EndIf
    EndIf
EndEvent

Function SetDefaultValues()
    
    DEFAULT_ANIMATIONS = _SHAnimationsEnabled.GetValue() as int
    DEFAULT_REFILLANIMATIONS = _SHRefillAnims.GetValue() as int
    DEFAULT_CANNIBAL = _SHCannibalism.GetValue() as int
    DEFAULT_RAW = _SHRawDamage.GetValue() as int
    DEFAULT_CARRYWEIGHT = _SHCarryWeight.GetValue() as int
    DEFAULT_BOTTLES = _SHGiveBottles.GetValue() as int
    DEFAULT_WATERSKINS = _SHWaterskinEquip.GetValue() as int
    DEFAULT_TUTORIALS = _SHTutorials.GetValue() as int
    DEFAULT_COLDFX = _SHColdFX.GetValue() as int
    DEFAULT_MESSAGES = _SHMessagesEnabled.GetValue() as int
    DEFAULT_SOUNDS = _SHToggleSounds.GetValue() as int
    DEFAULT_FIRSTPERSON = _SHFirstPersonMessages.GetValue() as int
    DEFAULT_COLDWIDGET = _SHHideColdWidget.GetValue() as int
    DEFAULT_DETAILED = _SHDetailedContinuance.GetValue() as int
    DEFAULT_DETAILED1LINE = _SHContinuance1Line.GetValue() as int
    DEFAULT_DEATH = _SHNeedsDeath.GetValue() as int
    DEFAULT_PAUSECOMBAT = _SHPauseNeedsCombat.GetValue() as int
    DEFAULT_COLDRATE = _SHRateGoal.GetValue() as int
    DEFAULT_HUNGERRATE = _SHHungerRate.GetValue() as int
    DEFAULT_THIRSTRATE = _SHThirstRate.GetValue() as int
    DEFAULT_FATIGUERATE = _SHFatigueRate.GetValue() as int
    DEFAULT_PAUSEDIALOGUE = _SHPauseNeedsDialogue.GetValue() as int
    DEFAULT_COLDWIDGETX = _SHColdWidgetX.GetValue() as int
    DEFAULT_COLDWIDGETY = _SHColdWidgetY.GetValue() as int
    DEFAULT_WIDGETOFFSETX = _SHWidgetXOffset.GetValue() as int
    DEFAULT_WIDGETOFFSETY = _SHWidgetYOffset.GetValue() as int
    DEFAULT_WIDGETPRESET = _SHWidgetPreset.GetValue() as int
    DEFAULT_ALCOHOL = _SHNumDrinks.GetValue() as int

EndFunction

;TOGGLE STATES

STATE ANIMATIONS
    Event OnSelectST()
        _SHAnimationsEnabled.SetValue((!_SHAnimationsEnabled.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHAnimationsEnabled.GetValue())
    EndEvent

    Event OnDefaultST()
		_SHAnimationsEnabled.SetValue(DEFAULT_ANIMATIONS)
        SetToggleOptionValueST(_SHAnimationsEnabled.GetValue())
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleAnimsDesc")
    EndEvent
ENDSTATE

STATE REFILLANIMATIONS
    Event OnSelectST()
        _SHRefillAnims.SetValue((!_SHRefillAnims.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHRefillAnims.GetValue())
    EndEvent

    Event OnDefaultST()
		_SHRefillAnims.SetValue(DEFAULT_REFILLANIMATIONS)
        SetToggleOptionValueST(_SHRefillAnims.GetValue())
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleRefillDesc")
    EndEvent
ENDSTATE

STATE CANNIBAL
    Event OnSelectST()
        _SHCannibalism.SetValue((!_SHCannibalism.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHCannibalism.GetValue())
        _SHMain.MCMCannibal = _SHCannibalism.GetValue() as bool
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHCannibalDesc")
    EndEvent
ENDSTATE

STATE RAW
    Event OnSelectST()
        _SHRawDamage.SetValue((!_SHRawDamage.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHRawDamage.GetValue())
    EndEvent

    Event OnDefaultST()
		_SHRawDamage.SetValue(DEFAULT_RAW)
        SetToggleOptionValueST(_SHRawDamage.GetValue())
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleRawDesc")
    EndEvent
ENDSTATE

STATE CARRYWEIGHT
    Event OnSelectST()
        _SHCarryWeight.SetValue((!_SHCarryWeight.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHCarryWeight.GetValue())
    EndEvent

    Event OnDefaultST()
		_SHCarryWeight.SetValue(DEFAULT_CARRYWEIGHT)
        SetToggleOptionValueST(_SHCarryWeight.GetValue())
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleCWPenDesc")
    EndEvent
ENDSTATE

STATE BOTTLES
    Event OnSelectST()
        _SHGiveBottles.SetValue((!_SHGiveBottles.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHGiveBottles.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$ToggleBottleInfo")
    EndEvent

    Event OnDefaultST()
		_SHGiveBottles.SetValue(DEFAULT_BOTTLES)
        SetToggleOptionValueST(_SHGiveBottles.GetValue())
	EndEvent
ENDSTATE

STATE WATERSKIN
    Event OnSelectST()
        _SHWaterskinEquip.SetValue((!_SHWaterskinEquip.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHWaterskinEquip.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHWaterskinInfo")
    EndEvent
ENDSTATE

STATE TUTORIALS
    Event OnSelectST()
        _SHTutorials.SetValue((!_SHTutorials.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHTutorials.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleTutsDesc")
    EndEvent
ENDSTATE

STATE COLDFX
    Event OnSelectST()
        _SHColdFX.SetValue( (!_SHColdFX.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHColdFX.GetValue())

        if(_SHColdFX.GetValue() == 0)
            ImagespaceModifier.RemoveCrossFade(1.0)
        endif
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleColdFXDesc")
    EndEvent
ENDSTATE

STATE MESSAGES
    Event OnSelectST()
        _SHMessagesEnabled.SetValue((!_SHMessagesEnabled.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHMessagesEnabled.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleMsgDesc")
    EndEvent
ENDSTATE

STATE SOUNDS
    Event OnSelectST()
        _SHToggleSounds.SetValue( (!_SHToggleSounds.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHToggleSounds.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleSoundsDesc")
    EndEvent
ENDSTATE

STATE FIRSTPERSON
    Event OnSelectST()
        _SHFirstPersonMessages.SetValue((!_SHFirstPersonMessages.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHFirstPersonMessages.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$ToggleFirstInfo")
    EndEvent
ENDSTATE

STATE FASTTRAVEL
    Event OnSelectST()
        _SHDisableFT.SetValue((!_SHDisableFT.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHDisableFT.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleFTDesc")
    EndEvent
ENDSTATE

STATE COLDWIDGET
    Event OnSelectST()
        _SHHideColdWidget.SetValue( (!_SHHideColdWidget.GetValue() as bool) as float)
        SetToggleOptionValueST(!_SHHideColdWidget.GetValue())
    EndEvent

    Event OnDefaultST()
		_SHHideColdWidget.SetValue(DEFAULT_COLDWIDGET)
        SetToggleOptionValueST(!_SHHideColdWidget.GetValue())
	EndEvent

    Event OnHighlightST()  

    EndEvent
ENDSTATE

STATE PAUSEOBLIVION
    Event OnSelectST()
        _SHPauseNeedsOblivion.SetValue( (!_SHPauseNeedsOblivion.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHPauseNeedsOblivion.GetValue()) 
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHOblivionDesc")
    EndEvent
ENDSTATE

STATE DEATH
    Event OnSelectST()
        _SHNeedsDeath.SetValue( (!_SHNeedsDeath.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHNeedsDeath.GetValue()) 
    EndEvent

    Event OnDefaultST()
		_SHNeedsDeath.SetValue(DEFAULT_DEATH)
        SetToggleOptionValueST(_SHNeedsDeath.GetValue())
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleDamageDesc")       
    EndEvent
ENDSTATE

STATE DETAILED1LINE
    Event OnSelectST()
        _SHContinuance1Line.SetValue( (!_SHContinuance1Line.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHContinuance1Line.GetValue())
    EndEvent

    Event OnDefaultST()
		_SHContinuance1Line.SetValue(DEFAULT_DETAILED1LINE)
        SetToggleOptionValueST(_SHContinuance1Line.GetValue())
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$DetailOneLine")
    EndEvent
ENDSTATE

STATE DETAILEDCONT
    Event OnSelectST()
        _SHDetailedContinuance.SetValue( (!_SHDetailedContinuance.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHDetailedContinuance.GetValue())
    EndEvent

    Event OnDefaultST()
		_SHDetailedContinuance.SetValue(DEFAULT_DETAILED)
        SetToggleOptionValueST(_SHDetailedContinuance.GetValue())
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$DetailedContHelp")
    EndEvent
ENDSTATE

STATE PAUSECOMBAT
    Event OnSelectST()
        _SHPauseNeedsCombat.SetValue( (!_SHPauseNeedsCombat.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHPauseNeedsCombat.GetValue())
    EndEvent

    Event OnDefaultST()
		_SHPauseNeedsCombat.SetValue(DEFAULT_PAUSECOMBAT)
        SetToggleOptionValueST(_SHPauseNeedsCombat.GetValue())
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$PauseCombatDesc")
    EndEvent
ENDSTATE

STATE PAUSEDIALOGUE
    Event OnSelectST()
        _SHPauseNeedsDialogue.SetValue( (!_SHPauseNeedsDialogue.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHPauseNeedsDialogue.GetValue())
    EndEvent

    Event OnDefaultST()
        _SHPauseNeedsDialogue.SetValue(DEFAULT_PAUSEDIALOGUE)
        SetToggleOptionValueST(_SHPauseNeedsDialogue.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$PauseDialogueDesc")
    EndEvent
ENDSTATE

STATE DRUNKFX
    Event OnSelectST()
        _SHDrunkSkoomaFX.SetValue( (!_SHDrunkSkoomaFX.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHDrunkSkoomaFX.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHVisualEffects")
    EndEvent
ENDSTATE

STATE WEREPAUSENEEDS
    Event OnSelectST()
        _SHWerewolfPauseNeeds.SetValue( (!_SHWerewolfPauseNeeds.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHWerewolfPauseNeeds.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHWerePauseDesc")
    EndEvent
ENDSTATE

STATE WEREFATIGUE
    Event OnSelectST()
        _SHWerewolfFatigue.SetValue( (!_SHWerewolfFatigue.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHWerewolfFatigue.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHWereFatigueDesc")
    EndEvent
ENDSTATE

STATE TOGGLEWIDGET
    Event OnSelectST()
        _SHToggleWidgets.SetValue( (!_SHToggleWidgets.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHToggleWidgets.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleWidgDesc")
    EndEvent
ENDSTATE

STATE TOGGLEHUNGER
    Event OnSelectST()
        _SHHungerShouldBeDisabled.SetValue( (!_SHHungerShouldBeDisabled.GetValue() as bool) as float)
        SetToggleOptionValueST(!_SHHungerShouldBeDisabled.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleHungerDesc")
    EndEvent
ENDSTATE

STATE TOGGLETHIRST
    Event OnSelectST()
        _SHThirstShouldBeDisabled.SetValue( (!_SHThirstShouldBeDisabled.GetValue() as bool) as float)
        SetToggleOptionValueST(!_SHThirstShouldBeDisabled.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleThirstDesc")
    EndEvent
ENDSTATE

STATE TOGGLEFATIGUE
    Event OnSelectST()
        _SHFatigueShouldBeDisabled.SetValue( (!_SHFatigueShouldBeDisabled.GetValue() as bool) as float)
        SetToggleOptionValueST(!_SHFatigueShouldBeDisabled.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleFatigueDesc")
    EndEvent
ENDSTATE

STATE TOGGLECOLD
    Event OnSelectST()
        _SHColdShouldBeDisabled.SetValue( (!_SHColdShouldBeDisabled.GetValue() as bool) as float)
        SetToggleOptionValueST(!_SHColdShouldBeDisabled.GetValue())
    EndEvent

    Event OnHighlightST()  

    EndEvent
ENDSTATE

STATE SEASONS
    Event OnSelectST()
        _SHSeasonsEnabled.SetValue( (!_SHSeasonsEnabled.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHSeasonsEnabled.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHSeasonsDesc")
    EndEvent
ENDSTATE

STATE INNKEEPER
    Event OnSelectST()
        _SHInnKeeperDialogue.SetValue( (!_SHInnKeeperDialogue.GetValue() as bool) as float)
        SetToggleOptionValueST(_SHInnKeeperDialogue.GetValue())
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHInnkeepDesc")
    EndEvent
ENDSTATE

;SLIDER STATES

STATE HUNGERRATE
    Event OnSliderOpenST()
        SetSliderDialogStartValue(_SHHungerRate.GetValue())
		SetSliderDialogDefaultValue(DEFAULT_HUNGERRATE)
		SetSliderDialogRange(0, 20)
        SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(float value)
        _SHHungerRate.SetValue(value as int)
		SetSliderOptionValueST(value as int)
	EndEvent

	Event OnDefaultST()
		_SHHungerRate.SetValue(DEFAULT_HUNGERRATE)
		SetSliderOptionValueST(DEFAULT_HUNGERRATE as int)
	EndEvent
    
    Event OnHighlightST()  
        SetInfoText("$SHHungerRateDesc")
    EndEvent
ENDSTATE

STATE THIRSTRATE
    Event OnSliderOpenST()
        SetSliderDialogStartValue(_SHThirstRate.GetValue())
		SetSliderDialogDefaultValue(DEFAULT_THIRSTRATE)
		SetSliderDialogRange(0, 20)
        SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(float value)
        _SHThirstRate.SetValue(value as int)
		SetSliderOptionValueST(value as int)
	EndEvent

	Event OnDefaultST()
		_SHThirstRate.SetValue(DEFAULT_THIRSTRATE)
		SetSliderOptionValueST(DEFAULT_THIRSTRATE as int)
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHThirstRateDesc")
    EndEvent
ENDSTATE

STATE FATIGUERATE
    Event OnSliderOpenST()
        SetSliderDialogStartValue(_SHFatigueRate.GetValue())
		SetSliderDialogDefaultValue(DEFAULT_FATIGUERATE)
		SetSliderDialogRange(0, 20)
        SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(float value)
        _SHFatigueRate.SetValue(value as int)
		SetSliderOptionValueST(value as int)
	EndEvent

	Event OnDefaultST()
		_SHFatigueRate.SetValue(DEFAULT_FATIGUERATE)
		SetSliderOptionValueST(DEFAULT_FATIGUERATE as int)
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHFatigueRateDesc")
    EndEvent
ENDSTATE

STATE COLDRATE
    Event OnSliderOpenST()
        SetSliderDialogStartValue(_SHRateGoal.GetValue())
		SetSliderDialogDefaultValue(DEFAULT_COLDRATE)
		SetSliderDialogRange(0, 3.0)
        SetSliderDialogInterval(0.1)
	EndEvent

	Event OnSliderAcceptST(float value)
        _SHRateGoal.SetValue(value)
		SetSliderOptionValueST(value)
	EndEvent

	Event OnDefaultST()
		_SHRateGoal.SetValue(DEFAULT_COLDRATE)
		SetSliderOptionValueST(DEFAULT_COLDRATE as int)
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHColdRateInfo")
    EndEvent
ENDSTATE

STATE COLDWIDGETX
    Event OnSliderOpenST()
        SetSliderDialogStartValue(_SHColdWidgetX.GetValue())
		SetSliderDialogDefaultValue(DEFAULT_COLDWIDGETX)
		SetSliderDialogRange(-1500.0, 1500.0)
        SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(float value)
        _SHColdWidgetX.SetValue(value as int)
		SetSliderOptionValueST(value as int)
	EndEvent

	Event OnDefaultST()
		_SHColdWidgetX.SetValue(DEFAULT_COLDWIDGETX)
		SetSliderOptionValueST(DEFAULT_COLDWIDGETX as int)
	EndEvent

    Event OnHighlightST()  

    EndEvent
ENDSTATE

STATE COLDWIDGETY
    Event OnSliderOpenST()
        SetSliderDialogStartValue(_SHColdWidgetY.GetValue())
		SetSliderDialogDefaultValue(DEFAULT_COLDWIDGETY)
		SetSliderDialogRange(-1500.0, 1500.0)
        SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(float value)
        _SHColdWidgetY.SetValue(value as int)
		SetSliderOptionValueST(value as int)
	EndEvent

	Event OnDefaultST()
		_SHColdWidgetY.SetValue(DEFAULT_COLDWIDGETY)
		SetSliderOptionValueST(DEFAULT_COLDWIDGETY as int)
	EndEvent

    Event OnHighlightST()  

    EndEvent
ENDSTATE

STATE WIDGETX
    Event OnSliderOpenST()
        SetSliderDialogStartValue(_SHWidgetXOffset.GetValue())
		SetSliderDialogDefaultValue(DEFAULT_WIDGETOFFSETX)
		SetSliderDialogRange(-500.0, 500.0)
        SetSliderDialogInterval(1.0)
    EndEvent

    Event OnSliderAcceptST(float value)
        _SHWidgetXOffset.SetValue(value as int)
		SetSliderOptionValueST(value as int)
	EndEvent

    Event OnDefaultST()
		_SHWidgetXOffset.SetValue(DEFAULT_WIDGETOFFSETX)
		SetSliderOptionValueST(DEFAULT_WIDGETOFFSETX as int)
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHWidgXOptionDesc")
    EndEvent
ENDSTATE

STATE WIDGETY
    Event OnSliderOpenST()
        SetSliderDialogStartValue(_SHWidgetYOffset.GetValue())
		SetSliderDialogDefaultValue(DEFAULT_WIDGETOFFSETY)
		SetSliderDialogRange(-740.0, 740.0)
        SetSliderDialogInterval(1.0)
    EndEvent

    Event OnSliderAcceptST(float value)
        _SHWidgetYOffset.SetValue(value as int)
		SetSliderOptionValueST(value as int)
	EndEvent

    Event OnDefaultST()
		_SHWidgetYOffset.SetValue(DEFAULT_WIDGETOFFSETY)
		SetSliderOptionValueST(DEFAULT_WIDGETOFFSETY as int)
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHWidgYOptionDesc")
    EndEvent
ENDSTATE

STATE ALCOHOL
    Event OnSliderOpenST()
        SetSliderDialogStartValue(_SHNumDrinks.GetValue())
		SetSliderDialogDefaultValue(DEFAULT_ALCOHOL)
		SetSliderDialogRange(0,10)
        SetSliderDialogInterval(1.0)
    EndEvent

    Event OnSliderAcceptST(float value)
        _SHNumDrinks.SetValue(value as int)
		SetSliderOptionValueST(value as int)
	EndEvent

    Event OnDefaultST()
		_SHNumDrinks.SetValue(DEFAULT_ALCOHOL)
		SetSliderOptionValueST(DEFAULT_ALCOHOL as int)
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHAlcoholNumDesc")
    EndEvent
ENDSTATE

STATE RESTORESLIDER

    Event OnSliderOpenST()        
        SetSliderDialogStartValue(0.0)
        SetSliderDialogDefaultValue(0.0)

        GlobalVariable _SHPointsTotal = Game.GetFormFromFile(0x00000803, "SunHelmCampfireSkill.esp") as GlobalVariable
        if(_SHPointsTotal)
            SetSliderDialogRange(0, _SHPointsTotal.GetValue())
        else
            SetSliderDialogRange(0, 0)
        endif
        
        SetSliderDialogInterval(1.0)
    EndEvent

    Event OnSliderAcceptST(float value)
        GlobalVariable _SHPerkPoints = Game.GetFormFromFile(0x00000801, "SunHelmCampfireSkill.esp") as GlobalVariable

        if(_SHPerkPoints)

            GlobalVariable _SHPerkPointsEarned = Game.GetFormFromFile(0x00000802, "SunHelmCampfireSkill.esp") as GlobalVariable
            GlobalVariable _SHPerkPointsProgress = Game.GetFormFromFile(0x00000800, "SunHelmCampfireSkill.esp") as GlobalVariable

            _SHPerkPointsProgress.SetValue(0.0)
            _SHPerkPoints.SetValue(value)
            _SHPerkPointsEarned.SetValue(value)
            ClearSurvivalPerks()
            ShowMessage("$SkillPtsRestored", false)
            restoreFlag = OPTION_FLAG_DISABLED
            ;SetToggleOptionValue(SurvivalRestore, false)
        endif
	EndEvent

    Event OnDefaultST()
		
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHSurvRestoreDesc")
    EndEvent
ENDSTATE

;MENU STATES

STATE ENABLE
    Event OnMenuOpenST()
		SetMenuDialogOptions(ModToggleArray)
        SetMenuDialogStartIndex(MOD_TOGGLE_INDEX)
        SetMenuDialogDefaultIndex(1)
	EndEvent

	Event OnMenuAcceptST(int index)
		MOD_TOGGLE_INDEX = index
        SetMenuOptionValueST(ModToggleArray[MOD_TOGGLE_INDEX])

        if(index == 0)
            ShowMessage("$ModStopping")
        else
            ShowMessage("$ModStarting")
        endif	
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHToggleModDesc")
    EndEvent
ENDSTATE

STATE SKINLOCATION
    Event OnMenuOpenST()
		SetMenuDialogOptions(WaterskinArray)
        SetMenuDialogStartIndex(_SHWaterskinLocation.GetValue() as int)
        SetMenuDialogDefaultIndex(0)
	EndEvent

	Event OnMenuAcceptST(int index)
		_SHWaterskinLocation.SetValue(index)
        SetMenuOptionValueST(WaterSkinArray[_SHWaterskinLocation.GetValue() as int])
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$WaterskinLocationInfo")
    EndEvent
ENDSTATE

STATE ORIENTATION
    Event OnMenuOpenST()
		SetMenuDialogOptions(OrientationArray)
        SetMenuDialogStartIndex(_SHWidgetOrientation.GetValue() as int)
        SetMenuDialogDefaultIndex(1)
	EndEvent

	Event OnMenuAcceptST(int index)
		_SHWidgetOrientation.SetValue(index)
        SetMenuOptionValueST(OrientationArray[_SHWidgetOrientation.GetValue() as int])
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHWidgetOrientDesc")
    EndEvent
ENDSTATE

STATE WIDGETPRESET
    Event OnMenuOpenST()
		SetMenuDialogOptions(WidgetPresetArray)
        SetMenuDialogStartIndex(_SHWidgetPreset.GetValue() as int)
        SetMenuDialogDefaultIndex(3)
	EndEvent

	Event OnMenuAcceptST(int index)
		_SHWidgetPreset.SetValue(index)
        SetMenuOptionValueST(WidgetPresetArray[_SHWidgetPreset.GetValue() as int])

        _SHWidgetXOffset.SetValue(0.0)
        _SHWidgetYOffset.SetValue(0.0)
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHPresetDesc")
    EndEvent
ENDSTATE

STATE WIDGETDISTYPE
    Event OnMenuOpenST()
		SetMenuDialogOptions(WidgetDisplayArray)
        SetMenuDialogStartIndex(_SHWidgetDisplayType.GetValue() as int)
        SetMenuDialogDefaultIndex(3)
	EndEvent

	Event OnMenuAcceptST(int index)
		_SHWidgetDisplayType.SetValue(index)
        SetMenuOptionValueST(WidgetDisplayArray[_SHWidgetDisplayType.GetValue() as int])
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHDisplayTypeDesc")
    EndEvent
ENDSTATE

STATE WEREFEED
    Event OnMenuOpenST()
		SetMenuDialogOptions(WerewolfFillArray)
        SetMenuDialogStartIndex(_SHWerewolfFeedOptions.GetValue() as int)
        SetMenuDialogDefaultIndex(3)
	EndEvent

	Event OnMenuAcceptST(int index)
		_SHWerewolfFeedOptions.SetValue(index)
        SetMenuOptionValueST(WerewolfFillArray[_SHWerewolfFeedOptions.GetValue() as int])
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHWerewolfFillDesc")
    EndEvent
ENDSTATE

STATE VAMPIRENEEDS
    Event OnMenuOpenST()
		SetMenuDialogOptions(VampireOptionArray)
        SetMenuDialogStartIndex(_SHVampireNeedsOption.GetValue() as int)
        SetMenuDialogDefaultIndex(3)
	EndEvent

	Event OnMenuAcceptST(int index)
		_SHVampireNeedsOption.SetValue(index)
        SetMenuOptionValueST(VampireOptionArray[_SHVampireNeedsOption.GetValue() as int])
	EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHVampireOptDesc")
    EndEvent
ENDSTATE

;TEXT STATES

STATE RESETFORM
    Event OnSelectST()
        if(ShowMessage("$AreYouSureReset"))
            _SHMain.ModComp.ResetLists()
            ShowMessage("$ListsReset")
        endif
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHResetDesc")
    EndEvent
ENDSTATE

STATE RESPECSKILL
    Event OnSelectST()
        if(ShowMessage("$AreYouSureRefund")) 
            RefundSkillPoints()
            ShowMessage("$SkillPtsRestored", false)
        endif
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHSurvRespecDesc")
    EndEvent
ENDSTATE

;TODO FINISH
STATE RESTORE
    Event OnSelectST()
        if ShowMessage("$OptionIntended")
            ShowMessage("$SelectTotalNumber")

            SetToggleOptionValueST(true , true)
            restoreFlag = OPTION_FLAG_NONE
        endif
    EndEvent

    Event OnHighlightST()  

    EndEvent
ENDSTATE

STATE REMOVEPOWERS
    Event OnSelectST()
        if(PlayerRef.HasSpell(_SHMain._SHContinuanceSpell))
            PlayerRef.RemoveSpell(_SHMain._SHContinuanceSpell)
            ShowMessage("$PowersRemoved")
        Else
            PlayerRef.AddSpell(_SHMain._SHContinuanceSpell, false)
            ShowMessage("$PowersAdded")
        endif

        if(PlayerRef.HasSpell(_SHMain._SHFillAllSpell))
            PlayerRef.RemoveSpell(_SHMain._SHFillAllSpell)
        Else
            PlayerRef.AddSpell(_SHMain._SHFillAllSpell, false)
        endif
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$TogglePowersInfo")
    EndEvent
ENDSTATE

;KEYMAPS
STATE FILLHOTKEY
    Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
        UnregisterForKey(_SHFillHotKey.GetValueInt())
		_SHFillHotKey.SetValue(keyCode)
        SetKeyMapOptionValueST(_SHFillHotKey.GetValueInt(), OPTION_FLAG_WITH_UNMAP)
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$DrinkAndFillHkInfo")
    EndEvent
ENDSTATE

STATE CONTINHOTKEY
    Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
        UnregisterForKey(_SHContHotKey.GetValueInt())
		_SHContHotKey.SetValue(keyCode)
        SetKeyMapOptionValueST(_SHContHotKey.GetValueInt(), OPTION_FLAG_WITH_UNMAP)
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$ContinuanceHkInfo")
    EndEvent
ENDSTATE

STATE HIDEWIDHOTKEY
    Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
        UnregisterForKey(_SHWidgetHotKey.GetValueInt())
		_SHWidgetHotKey.SetValue(keyCode)
        SetKeyMapOptionValueST(_SHWidgetHotKey.GetValueInt(), OPTION_FLAG_WITH_UNMAP)
    EndEvent

    Event OnHighlightST()  
        SetInfoText("$SHWidgetHKDesc")
    EndEvent
ENDSTATE
;OLD

Event OnKeyDown(Int KeyCode)

    int WidgetHotkey = _SHWidgetHotKey.GetValue() as int
    int ContHotkey = _SHContHotKey.GetValue() as int
    int FillHotkey = _SHFillHotKey.GetValue() as int

	UnregisterForKey(FillHotkey)
    UnregisterForKey(ContHotkey)
    UnregisterForKey(WidgetHotkey)
    
    If !UI.IsTextInputEnabled() && !Utility.IsInMenuMode()
        if(KeyCode == FillHotkey)
            _SHMain.DrinkAndFill()
        ElseIf (KeyCode == ContHotkey)
            _SHMain.ContinuancePower()
        ElseIf (KeyCode == WidgetHotkey)
            SendModEvent("_SHHideWidget")
        endif   
    endif

    if(FillHotkey > -1)
        RegisterForKey(FillHotkey)
    endif
    if(ContHotkey > -1)
        RegisterForKey(ContHotkey)
    endif
    if(WidgetHotkey > -1)
        RegisterForKey(WidgetHotkey)
    endif
endEvent

Function SaveSettings(string a_path)
	int jData = JMap.object()
	JMap.setInt(jData, "Animations", _SHAnimationsEnabled.GetValue() as int)
	JMap.setInt(jData, "RefillAnimations", _SHRefillAnims.GetValue() as int)
	JMap.setInt(jData, "DisableFastTravel", _SHDisableFT.GetValue() as int)
	JMap.setInt(jData, "Cannibalism", _SHCannibalism.GetValue() as int)
	JMap.setInt(jData, "RawDamage", _SHRawDamage.GetValue() as int)
	JMap.setInt(jData, "CarryWeight", _SHCarryWeight.GetValue() as int)
	JMap.setInt(jData, "EmptyBottles", _SHGiveBottles.GetValue() as int)
	JMap.setInt(jData, "EquipWaterskin", _SHWaterskinEquip.GetValue() as int)
	JMap.setInt(jData, "SkinLocation", _SHWaterskinLocation.GetValue() as int)
	JMap.setInt(jData, "Tutorials", _SHTutorials.GetValue() as int)
	JMap.setInt(jData, "ColdFx", _SHColdFX.GetValue() as int)
	JMap.setInt(jData, "Messages", _SHMessagesEnabled.GetValue() as int)
	JMap.setInt(jData, "Sounds", _SHToggleSounds.GetValue() as int)
	JMap.setInt(jData, "FirstPersonMessages", _SHFirstPersonMessages.GetValue() as int)
	JMap.setInt(jData, "FillHotkey", _SHFillHotKey.GetValue() as int)
	JMap.setInt(jData, "ContinuanceHotkey", _SHContHotKey.GetValue() as int)
	JMap.setInt(jData, "DetailedContinuance", _SHDetailedContinuance.GetValue() as int)
	JMap.setInt(jData, "Continuance1Line", _SHContinuance1Line.GetValue() as int)
	JMap.setInt(jData, "ToggleWidgets", _SHToggleWidgets.GetValue() as int)
	JMap.setInt(jData, "WidgetOrientation", _SHWidgetOrientation.GetValue() as int)
	JMap.setInt(jData, "WidgetType", _SHWidgetDisplayType.GetValue() as int)
	JMap.setInt(jData, "WidgetHotkey", _SHWidgetHotKey.GetValue() as int)
	JMap.setInt(jData, "WidgetPreset", _SHWidgetPreset.GetValue() as int)
	JMap.setInt(jData, "WidgetXOffset", _SHWidgetXOffset.GetValue() as int)
	JMap.setInt(jData, "WidgetYOffset", _SHWidgetYOffset.GetValue() as int)
	JMap.setInt(jData, "Death", _SHNeedsDeath.GetValue() as int)
	JMap.setInt(jData, "PauseOblivion", _SHPauseNeedsOblivion.GetValue() as int)
	JMap.setInt(jData, "PauseCombat", _SHPauseNeedsCombat.GetValue() as int)
	JMap.setInt(jData, "PauseDialogue", _SHPauseNeedsDialogue.GetValue() as int)
	JMap.setInt(jData, "ToggleHunger", (!_SHHungerShouldBeDisabled.GetValueInt() as bool) as int)
	JMap.setInt(jData, "HungerRate", _SHHungerRate.GetValue() as int)
	JMap.setInt(jData, "ToggleThirst", (!_SHThirstShouldBeDisabled.GetValueInt() as bool) as int)
	JMap.setInt(jData, "ThirstRate", _SHThirstRate.GetValue() as int)
	JMap.setInt(jData, "ToggleFatigue", (!_SHFatigueShouldBeDisabled.GetValueInt() as bool) as int)
	JMap.setInt(jData, "FatigueRate", _SHFatigueRate.GetValue() as int)
	JMap.setInt(jData, "DrunkFx", _SHDrunkSkoomaFX.GetValue() as int)
	JMap.setInt(jData, "NumberDrinks", _SHNumDrinks.GetValue() as int)
	JMap.setInt(jData, "WereFeedOption", _SHWerewolfFeedOptions.GetValue() as int)
	JMap.setInt(jData, "WereFatigue", _SHWerewolfFatigue.GetValue() as int)
	JMap.setInt(jData, "WerePauseNeeds", _SHWerewolfPauseNeeds.GetValue() as int)
	JMap.setInt(jData, "VampireNeeds", _SHVampireNeedsOption.GetValue() as int)
	JMap.setInt(jData, "Innkeeper", _SHInnKeeperDialogue.GetValue() as int)
	JValue.writeToFile(jData, ConfigDir + CurrentFile + Ext)
EndFunction

Function LoadSettings(string a_path)
    int jData = JValue.readFromFile(a_path)
	int animations = JMap.getInt(jData, "Animations")
    int refill = JMap.getInt(jData, "RefillAnimations")
    int fastTravel = JMap.getInt(jData, "DisableFastTravel")
    int cannibal = JMap.getInt(jData, "Cannibalism")
    int raw = JMap.getInt(jData, "RawDamage")
    int carryWeight = JMap.getInt(jData, "CarryWeight")
    int emptyBottles = JMap.getInt(jData, "EmptyBottles")
    int waterSkin = JMap.getInt(jData, "EquipWaterskin")
    int skinLocation = JMap.getInt(jData, "SkinLocation")
    int tutorials = JMap.getInt(jData, "Tutorials")
    int coldFx = JMap.getInt(jData, "ColdFx")
    int messages = JMap.getInt(jData, "Messages")
    int sounds = JMap.getInt(jData, "Sounds")
    int firstPerson = JMap.getInt(jData, "FirstPersonMessages")
    int fillHotkey = JMap.getInt(jData, "FillHotkey")
    int contHotkey = JMap.getInt(jData, "ContinuanceHotkey")
    int detailedCont = JMap.getInt(jData, "DetailedContinuance")
    int cont1Line = JMap.getInt(jData, "Continuance1Line")
    int toggleWidgets = JMap.getInt(jData, "ToggleWidgets")
    int widgetOrientation = JMap.getInt(jData, "WidgetOrientation")
    int widgetType = JMap.getInt(jData, "WidgetType")
    int widgetHotkey = JMap.getInt(jData, "WidgetHotkey")
    int widgetPreset = JMap.getInt(jData, "WidgetPreset")
    int xOffset = JMap.getInt(jData, "WidgetXOffset")
    int yOffset = JMap.getInt(jData, "WidgetYOffset")
    int death = JMap.getInt(jData, "Death")
    int oblivion = JMap.getInt(jData, "PauseOblivion")
    int combat = JMap.getInt(jData, "PauseCombat")
    int dialogue = JMap.getInt(jData, "PauseDialogue")
    int hunger = JMap.getInt(jData, "ToggleHunger")
    int hungerRate = JMap.getInt(jData, "HungerRate")
    int thirst = JMap.getInt(jData, "ToggleThirst")
    int thirstRate = JMap.getInt(jData, "ThirstRate")
    int fatigue = JMap.getInt(jData, "ToggleFatigue")
    int fatigueRate = JMap.getInt(jData, "FatigueRate")
    int drunk = JMap.getInt(jData, "DrunkFx")
    int numDrinks = JMap.getInt(jData, "NumberDrinks")
    int wereFeed = JMap.getInt(jData, "WereFeedOption")
    int wereFatigue = JMap.getInt(jData, "WereFatigue")
    int werePause = JMap.getInt(jData, "WerePauseNeeds")
    int vampireNeeds = JMap.getInt(jData, "VampireNeeds")
    int innKeeper = JMap.getInt(jData, "Innkeeper")

    if animations
		_SHAnimationsEnabled.SetValue(animations)
	endif
    if refill
        _SHRefillAnims.SetValue(refill)
    endif
    if fastTravel
        _SHDisableFT.SetValue(fastTravel)
    endif
    if cannibal
        _SHCannibalism.SetValue(cannibal)
    endif
    if raw
        _SHRawDamage.SetValue(raw)
    endif
    if carryWeight
        _SHCarryWeight.SetValue(carryWeight)
    endif
    if emptyBottles
        _SHGiveBottles.SetValue(emptyBottles)
    endif
    if waterSkin
        _SHWaterskinEquip.SetValue(waterSkin)
    endif
    if skinLocation
        _SHWaterskinLocation.SetValue(skinLocation)
    endif
    if fillHotkey
        _SHFillHotKey.SetValue(fillHotkey)
    endif
    if tutorials
        _SHTutorials.SetValue(tutorials)
    endif
    if coldFx
        _SHColdFX.SetValue(coldFx)
    endif
    if messages
        _SHMessagesEnabled.SetValue(messages)
    endif
    if sounds
        _SHToggleSounds.SetValue(sounds)
    endif
    if firstPerson
        _SHFirstPersonMessages.SetValue(firstPerson)
    endif
    if contHotkey
        _SHContHotKey.SetValue(contHotkey)
    endif
    if detailedCont
        _SHDetailedContinuance.SetValue(detailedCont)
    endif
    if cont1Line
        _SHDetailedContinuance.SetValue(cont1Line)
    endif
    if toggleWidgets
        _SHToggleWidgets.SetValue(toggleWidgets)
    endif
    if widgetOrientation
        _SHWidgetOrientation.SetValue(widgetOrientation)
    endif
    if widgetType
        _SHWidgetDisplayType.SetValue(widgetType)
    endif
    if widgetHotkey
        _SHWidgetHotKey.SetValue(widgetHotkey)
    endif
    if widgetPreset
        _SHWidgetPreset.SetValue(widgetPreset)
    endif
    if xOffset
        _SHWidgetXOffset.SetValue(xOffset)
    endif
    if yOffset
        _SHWidgetYOffset.SetValue(yOffset)
    endif
    if death
        _SHNeedsDeath.SetValue(death)
    endif
    if oblivion
        _SHPauseNeedsOblivion.SetValue(oblivion)
    endif
    if combat
        _SHPauseNeedsCombat.SetValue(combat) 
    endif
    if dialogue
        _SHPauseNeedsDialogue.SetValue(dialogue)     
    endif
    if hunger
        _SHHungerShouldBeDisabled.SetValue((!hunger as bool) as int)
    endif
    if hungerRate
        _SHHungerRate.SetValue(hungerRate)
    endif
    if thirst
        _SHThirstShouldBeDisabled.SetValue((!thirst as bool) as int)
    endif
    if thirstRate
        _SHThirstRate.SetValue(thirstRate)
    endif
    if fatigue
        _SHFatigueShouldBeDisabled.SetValue((!fatigue as bool) as int)
    endif
    if fatigueRate
        _SHFatigueRate.SetValue(fatigueRate)
    endif
    if drunk
        _SHDrunkSkoomaFX.SetValue(drunk)
    endif
    if numDrinks
        _SHNumDrinks.SetValue(numDrinks)
    endif
    if wereFeed
        _SHWerewolfFeedOptions.SetValue(wereFeed)
    endif
    if wereFatigue
        _SHWerewolfFatigue.SetValue(wereFatigue)
    endif
    if werePause
        _SHWerewolfPauseNeeds.SetValue(werePause)
    endif
    if vampireNeeds
        _SHVampireNeedsOption.SetValue(vampireNeeds)
    endif
    if innkeeper
        _SHInnKeeperDialogue.SetValue(innkeeper)
    endif

EndFunction

;CREDIT: PARAPETS
Function PopulateBrowseFileEntries()
	string[] contents = JContainers.contentsOfDirectoryAtPath(ConfigDir, extension = Ext)
	BrowseFileEntries = Utility.CreateStringArray(contents.Length)
	int index = 0
	while index < contents.Length
		string filePath = contents[index]
		int startIndex = StringUtil.GetLength(ConfigDir)
		int len = StringUtil.GetLength(filePath) - StringUtil.GetLength(Ext) - startIndex
		string fileName = StringUtil.Substring(filePath, startIndex, len)
		BrowseFileEntries[index] = fileName
		index += 1
	endwhile
EndFunction

;TODO ADD STRINGS TO TRANSLATION FILE
;CREDIT: PARAPETS
State NewFile
	Event OnInputAcceptST(string a_input)
		bool doSave = false
		if a_input != ""
			if JContainers.fileExistsAtPath(ConfigDir + a_input + Ext)
				doSave = ShowMessage("$OverwriteWarning")
			else
				doSave = true
			endif
		endif
		if doSave
			CurrentFile = a_input
			SaveSettings(ConfigDir + CurrentFile + Ext)
			GotoState("Browse")
			SetMenuOptionValueST(CurrentFile)
			PopulateBrowseFileEntries()
			if BrowseFileEntries.Length == 0
				SetOptionFlagsST(OPTION_FLAG_DISABLED)
			else
				SetOptionFlagsST(OPTION_FLAG_NONE)
			endif
			GotoState("Load")
			SetOptionFlagsST(OPTION_FLAG_NONE)
			GotoState("Save")
			SetOptionFlagsST(OPTION_FLAG_NONE)
			GotoState("Delete")
			SetOptionFlagsST(OPTION_FLAG_NONE)
		endif
	EndEvent
EndState

;CREDIT: PARAPETS
State Browse
	Event OnMenuOpenST()
		SetMenuDialogOptions(BrowseFileEntries)
	EndEvent

	Event OnMenuAcceptST(int a_index)
		string sFile = BrowseFileEntries[a_index]
		if sFile != ""
			CurrentFile = sFile
			SetMenuOptionValueST(sFile)
			GotoState("Load")
			SetOptionFlagsST(OPTION_FLAG_NONE)
			GotoState("Save")
			SetOptionFlagsST(OPTION_FLAG_NONE)
			GotoState("Delete")
			SetOptionFlagsST(OPTION_FLAG_NONE)
		endif
	EndEvent
EndState

;CREDIT: PARAPETS
State Load
	Event OnSelectST()
		if ShowMessage("$LoadWarning")
			LoadSettings(ConfigDir + CurrentFile + Ext)
		endif
	EndEvent
EndState

;CREDIT: PARAPETS
State Save
	Event OnSelectST()
		if CurrentFile != ""
			if ShowMessage("$OverwriteWarning")
				SaveSettings(ConfigDir + CurrentFile + Ext)
			endif
		endif
	EndEvent
EndState

;CREDIT: PARAPETS
State Delete
	Event OnSelectST()
		if ShowMessage("$DeleteWarning")
			JContainers.removeFileAtPath(ConfigDir + CurrentFile + Ext)
			CurrentFile = ""
			SetOptionFlagsST(OPTION_FLAG_DISABLED)
			GotoState("Browse")
			SetMenuOptionValueST("")
			PopulateBrowseFileEntries()
			if BrowseFileEntries.Length == 0
				SetOptionFlagsST(OPTION_FLAG_DISABLED)
			endif
			GotoState("Load")
			SetOptionFlagsST(OPTION_FLAG_NONE)
			GotoState("Save")
			SetOptionFlagsST(OPTION_FLAG_DISABLED)
		endif
	EndEvent
EndState

Function RefundSkillPoints()

	GlobalVariable _SHPerkPoints = Game.GetFormFromFile(0x00000801, "SunHelmCampfireSkill.esp") as GlobalVariable

    if(_SHPerkPoints)

        GlobalVariable _SHPerkPointsEarned = Game.GetFormFromFile(0x00000802, "SunHelmCampfireSkill.esp") as GlobalVariable
        GlobalVariable _SHPerkPointsProgress = Game.GetFormFromFile(0x00000800, "SunHelmCampfireSkill.esp") as GlobalVariable

        _SHPerkPoints.SetValue(_SHPerkPointsEarned.GetValue())
        _SHPerkPointsProgress.SetValue(0.0)
        ;ClearSurvivalPerks()
    endif

EndFunction

Function ClearSurvivalPerks()
    ;Clear perks
    _SH_PerkRank_Hydrated.SetValue(0.0)
    _SH_PerkRank_Slumber.SetValue(0.0) 
    _SH_PerkRank_ThermalIntensity.SetValue(0.0) 
    _SH_PerkRank_Connoisseur.SetValue(0.0) 
    _SH_PerkRank_Reservoir.SetValue(0.0) 
    _SH_PerkRank_Repose.SetValue(0.0) 
    _SH_PerkRank_AmbientWarmth.SetValue(0.0) 
    _SH_PerkRank_Conviviality.SetValue(0.0) 
    _SH_PerkRank_Unyielding.SetValue(0.0) 

EndFunction

Function CheckToggleMod()
    if(MOD_TOGGLE_INDEX == 0 && _SHEnabled.GetValue() == 1)
        _SHMain.StopMod()
    EndIf

    if(MOD_TOGGLE_INDEX == 1 && _SHEnabled.GetValue() == 0)
        _SHMain.StartMod()
    EndIf
EndFunction

Function ApplyModStatus()

    SendModEvent("_SHUpdateSkin")

    CheckToggleMod()

    int WidgetHotkey = _SHWidgetHotKey.GetValue() as int
    int ContHotkey = _SHContHotKey.GetValue() as int
    int FillHotkey = _SHFillHotKey.GetValue() as int

    UnregisterForKey(FillHotkey)
    UnregisterForKey(ContHotkey)
    UnregisterForKey(WidgetHotkey)

    if(FillHotkey > -1)
        RegisterForKey(FillHotkey)
    endif
    if(ContHotkey > -1)
        RegisterForKey(ContHotkey)
    endif
    if(WidgetHotkey > -1)
        RegisterForKey(WidgetHotkey)
    endif

    SendModEvent("_SH_WidgetUi") 
    SendModEvent("_SH_WidgetColdUi")
    
EndFunction

Event OnConfigClose()
    ApplyModStatus()
EndEvent