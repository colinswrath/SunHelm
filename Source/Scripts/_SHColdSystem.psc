Scriptname _SHColdSystem extends _SHSystemBase

globalvariable property TimeScale auto

Keyword property LocTypeInn auto
keyword property MagicFlameCloak auto

int Property CurrentColdStage = -1 auto
int Property CurrentColdLevelLimit auto
;int property AmbientTempLevel = 0 auto  hidden
int property OldAmbientTempLevel = -1 auto hidden

_SHColdWidgetScript property ColdWidget auto
_SHRegionSystem property RegionSys auto
_SHWeatherSystem property WeatherSys auto

Spell property _SHColdSpell0 auto
Spell property _SHColdSpell1 auto
Spell property _SHColdSpell2 auto
Spell property _SHColdSpell3 auto
Spell property _SHColdSpell4 auto
Spell property _SHColdSpell5 auto

Spell property _SHSwimDetectionSpell auto
Spell property _SHFrostResistWarmthSpell auto

int Property _SHColdStage0 auto ;0
int Property _SHColdStage1 auto ;25
int Property _SHColdStage2 auto ;150
int Property _SHColdStage3 auto ;250
int Property _SHColdStage4 auto ;450
int Property _SHColdStage5 auto ;700

_SHHeatDetection property Heat auto

Message property _SHColdStageMessage0 auto
Message property _SHColdStageMessage1 auto
Message property _SHColdStageMessage2 auto
Message property _SHColdStageMessage3 auto
Message property _SHColdStageMessage4 auto
Message property _SHColdStageMessage5 auto

Message property _SHColdStageMessage0First auto
Message property _SHColdStageMessage1First auto
Message property _SHColdStageMessage2First auto
Message property _SHColdStageMessage3First auto
Message property _SHColdStageMessage4First auto
Message property _SHColdStageMessage5First auto

Message property _SHEnvMessage0 auto
Message property _SHEnvMessage1 auto
Message property _SHEnvMessage2 auto
Message property _SHEnvMessage3 auto
Message property _SHEnvMessage4 auto
Message property _SHEnvMessage5 auto

Message property _SHWarmerMessage auto
Message property _SHWarmerMessageFirst auto
Message property _SHColdTut auto

Message property _SHComfInteriorMessage auto

GlobalVariable property _SHRateGoal auto
GlobalVariable property _SHColdActive auto
GlobalVariable property _SHColdFX auto
GlobalVariable Property _SHUITempLevel Auto    ;;
GlobalVariable Property _SHForceDisableCold auto
GlobalVariable Property _SHIsNearHeatSource auto
GlobalVariable Property _SHIsInFreezingWater auto
GlobalVariable Property _SHColdLevelCap auto

;TODO NOT YET MADE
GlobalVariable Property _SHFreezingNightPen auto     ;100
GlobalVariable Property _SHCoolNightPen auto        ;50
GlobalVariable Property _SHWarmNightPen auto        ;25

GlobalVariable Property _SHAmbientTemperature auto
GlobalVariable Property _SHRegionTemperature auto   
GlobalVariable Property _SHWeatherTemperature auto   
GlobalVariable Property _SHInInteriorType auto     ;0=WarmInterior, 1=ColdInterior, -1= not in interior

GlobalVariable property _SHFrigidThreshold auto     ;The temperature at which your coldlimit will become max instead of ambient temp default = 700.00

GlobalVariable Property _SHIsVR auto

Sound property _SHMaleFreezing auto
Sound property _SHMaleFrigid auto
Sound property _SHFemaleFreezing auto
Sound property _SHFemaleFrigid auto

Keyword property Survival_ArmorCold auto
Keyword property Survival_ArmorWarm auto

ImageSpaceModifier property _SHColdISM1 auto
ImageSpaceModifier property _SHColdISM2 auto
ImageSpaceModifier property _SHColdISM3 auto

;Minimum values required to reach respective cold levels
int property MinValFrostBitten = 600 auto hidden

bool ShowNewStageMessage = false
bool comfInteriorMessageShown = false

;Widget Variables
Int temperatureLevelNearHeat = 1
Int temperatureLevelFreezingArea = 4
Int temperatureLevelNeutral = 0
Int lastTemperatureLevel = 0
Int temperatureLevelColdArea = 3
Int temperatureLevelWarmArea = 2

bool property startup = false auto
bool newAmbientTemp = false
bool property waitForColdSleepCheck = false auto
bool property carriageTravel = false auto

bool property flameCloak = false auto
bool wasWarm = false

Float property WarmthRatingBonus
    float Function Get()
        Float warmthRating
        if(_SHIsVR.GetValue() == 1.0)
            warmthRating = VRCalcArmorWarmth()
        else
            warmthRating = Player.GetWarmthRating()
        endif
        if(flameCloak)
            warmthRating += 15
        endif
        if(warmthRating > 230)
            warmthRating = 230
        endif
        Float bonusPercent = 0.80 * warmthRating / 230
        return bonusPercent
    EndFunction
EndProperty

Float Property ColdPerUpdate
    float Function Get()
        float coldPerSecond
        ;5400 -> 4800
        float secondsGoal = (4800)/ TimeScale.GetValue()
        coldPerSecond = _SHAmbientTemperature.GetValue() / secondsGoal
        return (coldPerSecond * 14.994) * _SHRateGoal.GetValue()
    endfunction
EndProperty

Function StartSystem()
    If (!IsRunning())
        _SHColdActive.SetValue(1.0)
        parent.StartSystem()
        SendModEvent("_SH_WidgetColdUi")
        startup = true
        RegisterForSleep()
        StartSubSystems()
        _SHColdLastTimeStamp.SetValue(Utility.GetCurrentGameTime())
        StartUpdates()
        startup = false
    endif
EndFunction

Function StopSystem()
    _SHColdActive.SetValue(0.0)
    SendModEvent("_SH_WidgetColdUi")
    StopSubSystems()
    ImagespaceModifier.RemoveCrossFade(1.0)
    parent.StopSystem()
EndFunction

Function StartSubSystems()
    Player.AddSpell(_SHSwimDetectionSpell, false)
    Player.AddSpell(_SHFrostResistWarmthSpell, false)
    Heat.StartSystem()
    RegionSys.StartSystem()
    WeatherSys.StartSystem()
EndFunction

Function StopSubSystems()
    Heat.StopSystem()
    RegionSys.StopSystem()
    WeatherSys.StopSystem()
    Player.RemoveSpell(_SHSwimDetectionSpell)
    Player.RemoveSpell(_SHFrostResistWarmthSpell)
EndFunction

Function StartUpdates()
    SetColdStage()
    ApplyColdEffects()
    UpdateNeed()    
EndFunction

Function UpdateNeed()
    _SHColdCurrentTimeStamp.SetValue(Utility.GetCurrentGameTime())

    if(_SHIsNearHeatSource.GetValue() == 0.0 && _SHIsInFreezingWater.GetValue() == 0.0)
        SetCurrentColdTemp()
        if(_SHInInteriorType.GetValue() == 0.0)
            SetTemperatureUI(1.0,1.0)
        else
            flameCloak = Player.HasMagicEffectWithKeyword(MagicFlameCloak)
            SetColdLevelLimit()
            ShowEnvironmentMessage()
            UpdateCurrentColdLevel(WarmthRatingBonus)       
        endif
    endif

    _SHColdLastTimeStamp.SetValue(_SHColdCurrentTimeStamp.GetValue())
EndFunction

;The cold level limit is the goal at which your cold level is trying to reach. Typically this is the same as ambient temp, but not always
Function SetColdLevelLimit()
    CurrentColdLevelLimit = 0

    if(_SHAmbientTemperature.GetValue() >= MinValFrostBitten)
        CurrentColdLevelLimit = _SHColdLevelCap.GetValue() as int
    else
        CurrentColdLevelLimit = _SHAmbientTemperature.GetValue() as int
    endif
EndFunction

;Called to inc cold level every update
Function UpdateCurrentColdLevel(float warmthResistancePerc)
    warmthResistancePerc = 1.00 - warmthResistancePerc
    float timePassed = ((_SHColdCurrentTimeStamp.GetValue()*24) - (_SHColdLastTimeStamp.GetValue() * 24))
    int updatesMade = (timePassed / _SHUpdateInterval.GetValue()) as int
    
    if(updatesMade < 1)
        updatesMade = 1
    endif
    float oldColdLevel = _SHCurrentColdLevel.GetValue()
    if(oldColdLevel > CurrentColdLevelLimit as float)
        float baseHeat = 20.0
        if(_SH_PerkRank_AmbientWarmth.GetValue() == 1.0)
            baseHeat+=(baseHeat*0.25)
        endif 
        float decValue = 20 * updatesMade
        DecreaseColdLevel(decValue)
    elseif (oldColdLevel == CurrentColdLevelLimit as float)
        SetColdStage()
        ApplyColdEffects()
    else
        float amountBeforeResist = ColdPerUpdate * updatesMade as float
        float totalUpdate = amountBeforeResist * warmthResistancePerc
        IncreaseColdLevel(totalUpdate)
    endif
    SetTemperatureUI(oldColdLevel, _SHCurrentColdLevel.GetValue())

EndFunction

Function DecreaseColdLevel(float amount)
    _SHCurrentColdLevel.SetValue( _SHCurrentColdLevel.GetValue() - amount)
    float coldLimit = CurrentColdLevelLimit as float

    if(_SHIsNearHeatSource.GetValue() == 1.0)
        coldLimit = GetCurrentWarmthLimit()
    endif
    
    if(_SHCurrentColdLevel.GetValue() < coldLimit)
        _SHCurrentColdLevel.SetValue(coldLimit)
    Elseif(_SHCurrentColdLevel.GetValue() < 0.0)
        _SHCurrentColdLevel.SetValue(0.0)
    endif

    SetColdStage()
    ApplyColdEffects()
EndFunction

Function IncreaseColdLevel(float amount)
    _SHCurrentColdLevel.SetValue( _SHCurrentColdLevel.GetValue() + amount)

    If (carriageTravel)
        if(_SHCurrentColdLevel.GetValue() > _SHColdStage3 as float)
            _SHCurrentColdLevel.SetValue(_SHColdStage3 as float)    
        endif
    elseif(_SHCurrentColdLevel.GetValue() > CurrentColdLevelLimit as float)
        _SHCurrentColdLevel.SetValue(CurrentColdLevelLimit as float)    
    endif

    ;Redundency. Cold level limit should not be over 900. But just in case, this keeps you from getting colder
    if(_SHCurrentColdLevel.GetValue() > _SHColdLevelCap.GetValue() as int)
        _SHCurrentColdLevel.SetValue(_SHColdLevelCap.GetValue())
    endif

    SetColdStage()
    ApplyColdEffects()
EndFunction

;Uses the temps calculated from the region and weather systems to determine a total temperature
Function SetCurrentColdTemp()
    int tempTotal = 0
    tempTotal += _SHRegionTemperature.GetValue() as int
    tempTotal += _SHWeatherTemperature.GetValue() as int
    tempTotal += CalculateNightPenalty()

    if(tempTotal > _SHColdLevelCap.GetValue() as int) ;900 cap
        tempTotal = _SHColdLevelCap.GetValue() as int
    endif
    
    _SHAmbientTemperature.SetValue(tempTotal)
    newAmbientTemp = OldAmbientTempLevel != _SHAmbientTemperature.GetValue() as int
    OldAmbientTempLevel = _SHAmbientTemperature.GetValue() as int
EndFunction

int Function CalculateNightPenalty()
    int pen = 0
    if(!Player.IsInInterior());_SHInInteriorType.GetValue() == -1.0)    ;If we are outdoors (-1 code for outdoors)       
        float time = GetCurrentHourOfDay()
      
        if(time > 19.0 || time < 7.0)
            If(_SHRegionTemperature.GetValue() >= 250.0)
                return _SHFreezingNightPen.GetValue() as int
            ElseIf (_SHRegionTemperature.GetValue() >= 100)
                return _SHCoolNightPen.GetValue() as int
            Else
                return _SHWarmNightPen.GetValue() as int
            endif
        endif
    endif
    return pen    
EndFunction

;Apply current stage effects according to the 
Function ApplyColdEffects()
    
    if(ShowNewStageMessage)
        RemoveSystemEffects()

        bool male = _SHIsSexMale.GetValue()

        float sounds = _SHToggleSounds.GetValue()
        if(CurrentColdStage == 0)
            DisplayNotificationsImod(_SHColdStageMessage0First,_SHColdStageMessage0, none)
            Player.AddSpell(_SHColdSpell0, false)
        ElseIf (CurrentColdStage == 1)
            DisplayNotificationsImod(_SHColdStageMessage1First,_SHColdStageMessage1, none)
            Player.AddSpell(_SHColdSpell1, false)
        ElseIf (CurrentColdStage == 2)
            DisplayNotificationsImod(_SHColdStageMessage2First,_SHColdStageMessage2, none)
            Player.AddSpell(_SHColdSpell2, false)
        ElseIf (CurrentColdStage == 3)
            DisplayNotificationsImod(_SHColdStageMessage3First,_SHColdStageMessage3, _SHColdISM1)
            Player.AddSpell(_SHColdSpell3, false)
        ElseIf (CurrentColdStage == 4)
            DisplayNotificationsImod(_SHColdStageMessage4First,_SHColdStageMessage4, _SHColdISM2)
            Player.AddSpell(_SHColdSpell4, false)
            If(sounds == 1.0)
                If (male == 1.0)
                    _SHMaleFreezing.Play(Player)
                Else
                    _SHFemaleFreezing.Play(Player)
                EndIf
            EndIf
        ElseIf (CurrentColdStage == 5)
            DisplayNotificationsImod(_SHColdStageMessage5First,_SHColdStageMessage5, _SHColdISM3)
            Player.AddSpell(_SHColdSpell5, false)
            If(sounds == 1.0)
                If (male == 1.0)
                    _SHMaleFrigid.Play(Player)
                Else
                    _SHFemaleFrigid.Play(Player)
                EndIf
            EndIf
        endif
    endif
    CheckColdDamage()
EndFunction

Function DisplayNotificationsImod(Message first, Message third, ImageSpaceModifier imod)

    If (_SHMessagesEnabled.GetValue() == 1)
        if(_SHFirstPersonMessages.GetValue() == 1.0)              
            first.Show()
        Else
            third.Show()
        endif
    EndIf

    if(_SHIsInFreezingWater.GetValue() == 0.0 && _SHColdFX.GetValue() == 1.0)
        if(imod)
            imod.ApplyCrossFade(1.0)
        else
            ImageSpaceModifier.RemoveCrossFade(1.0)
        endif
    endif
endfunction

Function SetValuesOnStoryServed(Location akLocation)
    _SHCurrentColdLevel.SetValue(25)
EndFunction

Function ShowEnvironmentMessage()
    if(newAmbientTemp)
        If (CurrentColdLevelLimit < _SHColdStage1)       
            _SHEnvMessage0.Show()
        ElseIf (CurrentColdLevelLimit < _SHColdStage2)        
            _SHEnvMessage1.Show()
        ElseIf (CurrentColdLevelLimit < _SHColdStage3)       
            _SHEnvMessage2.Show()
        ElseIf (CurrentColdLevelLimit < _SHColdStage4)       
            _SHEnvMessage3.Show()
        ElseIf (CurrentColdLevelLimit < _SHColdStage5)      
            _SHEnvMessage4.Show()
        ElseIf (CurrentColdLevelLimit >= _SHFrigidThreshold.GetValue() as int)      
            _SHEnvMessage5.Show()
        EndIf
    endif
EndFunction

;Updates the widget
Function SetTemperatureUI(float oldVal, float newVal, int forcedValue = 100)
    if(forcedValue == temperatureLevelNearHeat)
        if(_SHCurrentColdLevel.GetValue() <= GetCurrentWarmthLimit())
            _SHUITempLevel.SetValue(temperatureLevelNeutral)
        else
            _SHUITempLevel.SetValue(temperatureLevelNearHeat)
        endif
    elseif(forcedValue == temperatureLevelFreezingArea)
        _SHUITempLevel.SetValue(temperatureLevelFreezingArea)
    else
        if oldVal == newVal
            _SHUITempLevel.SetValue(temperatureLevelNeutral)
        elseIf oldVal > newVal
            _SHUITempLevel.SetValue(temperatureLevelWarmArea)
        elseIf oldVal < newVal
            if _SHAmbientTemperature.GetValue() >= _SHFrigidThreshold.GetValue()
                _SHUITempLevel.SetValue(temperatureLevelFreezingArea)
            elseif(_SHAmbientTemperature.GetValue() <= _SHColdStage1)
                _SHUITempLevel.SetValue(temperatureLevelNeutral)
            else
                _SHUITempLevel.SetValue(temperatureLevelColdArea)
            endIf
        endIf
    endif
    
    SendModEvent("_SH_UpdateColdWidget")
EndFunction

Function SetColdStage()
    int OldStage = CurrentColdStage
    int NewStage
    float currentLevel = _SHCurrentColdLevel.GetValue()

    If (currentLevel < _SHColdStage1)
        NewStage = 0
        if(!wasWarm)
            wasWarm = true
            SendModEvent("_SH_IncreaseSurvivalSkill")
        endif
    ElseIf (currentLevel < _SHColdStage2)
        NewStage = 1
        wasWarm = false
    ElseIf (currentLevel < _SHColdStage3)
        NewStage = 2
        wasWarm = false
    ElseIf (currentLevel < _SHColdStage4)
        NewStage = 3
        wasWarm = false
    ElseIf (currentLevel < _SHColdStage5)
        NewStage = 4
        wasWarm = false
    ElseIf (currentLevel >= _SHColdStage5)
        NewStage = 5
        wasWarm = false
    EndIf

    if(NewStage != OldStage)
        ShowNewStageMessage = true
    else
        ShowNewStageMessage = false
    endif

    CurrentColdStage = NewStage
EndFunction

;Remove the system effects
Function RemoveSystemEffects()
    ;Remove the spells from the player
    Player.RemoveSpell(_SHColdSpell0)
    Player.RemoveSpell(_SHColdSpell1)
    Player.RemoveSpell(_SHColdSpell2)
    Player.RemoveSpell(_SHColdSpell3)
    Player.RemoveSpell(_SHColdSpell4)
    Player.RemoveSpell(_SHColdSpell5)
EndFunction

Function SetTimeStamps()
    _SHColdLastTimeStamp.SetValue(Utility.GetCurrentGameTime())
    SetTemperatureUI(1.0,1.0)
endfunction

Function CheckColdDamage()
    if(_SHCurrentColdLevel.GetValue() >= _SHColdStage5 && _SHNeedsDeath.GetValue() == 1 && _SHIsNearHeatSource.GetValue() == 0.0)
        Player.DamageActorValue("Health", _SHCurrentColdLevel.GetValue() * 0.025)
    endif
EndFunction

;Placeholder for the ability to make certain regions only warm you so much, unless in shelter possibly
float Function GetCurrentWarmthLimit()
    float coldLimit = 0.0
    return coldLimit
endFunction

Function SetColdLevel(float amount)
    _SHCurrentColdLevel.SetValue(amount)

    SetColdStage()
    ApplyColdEffects()
EndFunction

;CREDIT: Frostbite for this function
Float function GetCurrentHourOfDay()
    {Identify the current 24 hour time of day}
    Float now = utility.GetCurrentGameTime()
    now -= math.Floor(now) as Float
    now *= 24.0000
    return now
endFunction

;--------------- THE BELOW CODE IS ONLY USED IF VR IS DETECTED--------------

int Function VRCalcArmorWarmth(bool MessageRequest = false)

    int TotalWarmthRating = 0

    int HeadWarmthRating = GetArmorItemWarmth(Player.GetWornForm(0x00000002) as Armor, 1)       ; Head
	int BodyWarmthRating = GetArmorItemWarmth(Player.GetWornForm(0x00000004) as Armor, 2)       ; Body
	int HandsWarmthRating = GetArmorItemWarmth(Player.GetWornForm(0x00000008) as Armor, 3)       ; Hands
	int FeetWarmthRating = GetArmorItemWarmth(Player.GetWornForm(0x000000080) as Armor, 4)       ; Feet
	int CloakWarmthRating = GetArmorItemWarmth(Player.GetWornForm(0x00010000) as Armor, 5)      ; Cloak

    ;Torch
    if (Player.GetEquippedItemType(0) == 11)
        TotalWarmthRating += 50
    endIf

    MagicEffect Soup = game.GetFormFromFile(0x007A371E, "SunHelmSurvival.esp") as MagicEffect
    if(Soup && Player.HasMagicEffect(Soup))
        TotalWarmthRating += 50
    endif

    TotalWarmthRating += HeadWarmthRating + BodyWarmthRating + HandsWarmthRating + FeetWarmthRating + CloakWarmthRating
    if(MessageRequest)
        Debug.Notification("Warmth Rating: " + TotalWarmthRating)
        Debug.Notification("Head: " + HeadWarmthRating + " Body: " + BodyWarmthRating + " Hands: " + HandsWarmthRating + " Feet: " + FeetWarmthRating + " Cloak: " + CloakWarmthRating)
    endif
    return TotalWarmthRating
endFunction

int headCold = 8
int headNormal = 18
int headWarm = 29

int bodyCold = 17
int bodyNormal = 27
int bodyWarm = 54

int handsCold = 7
int handsNormal = 13
int handsWarm = 24

int feetCold = 7
int feetNormal = 13 
int feetWarm = 24

int cloakCold = 8
int cloakNormal = 18
int cloakWarm = 29

int Function GetArmorItemWarmth(Armor Item, int EquipLoc)

    int loc = EquipLoc
    int warmth = 0

    if (!Item || Item.HasKeywordString("FrostfallIgnore"))
		; Don't bother if nothing is in the armor slot
		return warmth
	endIf

    ;Head
    if(loc == 1)
        ;Cold
        if (Item.HasKeywordString("Survival_ArmorCold") || Item.HasKeywordString("FrostfallWarmthPoor"))
            return headCold
        ;Warm
        ElseIf (Item.HasKeywordString("Survival_ArmorWarm") || Item.HasKeywordString("FrostfallWarmthExcellent"))
            return headWarm
        ;Normal
        Else
            return headNormal
        endif
    ;Body    
    elseif(loc == 2)
        if (Item.HasKeywordString("Survival_ArmorCold") || Item.HasKeywordString("FrostfallWarmthPoor"))
            return bodyCold 
        ;Warm
        ElseIf (Item.HasKeywordString("Survival_ArmorWarm") || Item.HasKeywordString("FrostfallWarmthExcellent"))
            return bodyWarm
        ;Normal
        Else
            return bodyNormal
        endif
    ;Hands
    elseif(loc == 3)
        if (Item.HasKeywordString("Survival_ArmorCold") || Item.HasKeywordString("FrostfallWarmthPoor"))
            return handsCold   
        ;Warm
        ElseIf (Item.HasKeywordString("Survival_ArmorWarm") || Item.HasKeywordString("FrostfallWarmthExcellent"))
            return handsWarm
        ;Normal
        Else
            return handsNormal
        endif
    ;Feet
    ElseIf (loc == 4)
        if (Item.HasKeywordString("Survival_ArmorCold") || Item.HasKeywordString("FrostfallWarmthPoor"))
            return feetCold   
        ;Warm
        ElseIf (Item.HasKeywordString("Survival_ArmorWarm") || Item.HasKeywordString("FrostfallWarmthExcellent"))
            return feetWarm
        ;Normal
        Else
            return feetNormal
        endif
    ;Cloak
    ElseIf (loc == 5)
        if (Item.HasKeywordString("Survival_ArmorCold") || Item.HasKeywordString("FrostfallWarmthPoor"))
            return cloakCold            
        ;Warm
        ElseIf (Item.HasKeywordString("Survival_ArmorWarm") || Item.HasKeywordString("FrostfallWarmthExcellent") || Item.HasKeywordString("FrostfallCloakFur"))
            return cloakWarm
        ;Normal
        Else
            return cloakNormal
        endif 
    endif
EndFunction

