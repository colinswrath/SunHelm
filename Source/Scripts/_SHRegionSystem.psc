Scriptname _SHRegionSystem extends Quest

;The region system does not extend the base system. This is because it doesnt update on a regular interval, nor does it need the functionality implemented in the base system. It is instead updated via a magicEffect/spell (aka the RegionScript.psc)

GlobalVariable property _SHRateGoal auto
GlobalVariable property _SHColdActive auto
GlobalVariable property _SHColdFX auto
GlobalVariable Property _SHUITempLevel Auto   
GlobalVariable Property _SHForceDisableCold auto
GlobalVariable Property _SHCurrentRegionInt auto
GlobalVariable Property _SHSeasonsEnabled auto

;DEFAULT VALUES.
GlobalVariable Property _SHFreezingTemp auto    ;250
GlobalVariable Property _SHCoolTemp auto        ;125
GlobalVariable Property _SHReachTemp auto        ;100
GlobalVariable Property _SHComfTemp auto        ;35
GlobalVariable Property _SHMarshTemp auto       ;150
GlobalVariable Property _SHVolcanicTemp auto    ;25
GlobalVariable Property _SHThroatFreezeTemp auto      ;450

GlobalVariable Property _SHWarmTemp auto        ;0

GlobalVariable Property GameMonth auto      ;Default values at month 5

GlobalVariable Property _SHInInteriorType auto     ;0=WarmInterior, 1=ColdInterior
GlobalVariable Property _SHRegionTemperature auto   ;^

Weather property DLC02VolcanicAshStorm01 auto

FormList property _SHColdInteriors auto
FormList Property _SHInteriorWorldSpaces Auto
FormList property _SHColdCloudyWeather auto
FormList property _SHBlizzardWeathers auto

_SHCompatabilityScript property Compat auto
_SunHelmMain property _SHMain auto

bool property freezingRegion = false auto
bool property comfRegion = false auto
bool property coolRegion = false auto  
bool property pineRegion = false auto
bool property highHrothgarRegion = false auto
bool property marshRegion = false auto
bool property volcanicRegion = false auto
bool property throatRegion = false auto
bool property reachRegion = false auto

Float[] property SeasonMult auto

Spell property _SHRegionSpell auto

Actor property PlayerRef auto

;REGION CODES
;VOLCANIC = 0
;MARSH = 1
;Throat = 2
;PINE = 3
;COMF = 4
;FREEZING = 5
;REACH = 6
;COOL = 7
;WARM INTERIOR = 8
;COLD INTERIOR = 9

int property CurrentRegion
    int Function Get()
        _SHInInteriorType.SetValue(-1.0)
        if PlayerRef.IsInInterior() || _SHInteriorWorldSpaces.HasForm(PlayerRef.GetWorldSpace() as form)
            if(_SHColdInteriors.HasForm(PlayerRef.GetCurrentLocation() as form) || _SHColdInteriors.HasForm(PlayerRef.GetParentCell() as form))
                _SHInInteriorType.SetValue(1.0)
                return 9
            else
                _SHInInteriorType.SetValue(0)
                return 8
            endif
        ElseIf(volcanicRegion)
            return 0
        ElseIf(marshRegion)
            return 1
        ElseIf(throatRegion)
            return 2
        ElseIf (pineRegion)     ;Pine Freezing region
            return 3
        elseif(comfRegion)    ;Riverwood
            return 4
        elseif(freezingRegion || highHrothgarRegion)
            return 5
        ElseIf (reachRegion)
            return 6
        elseif(coolRegion)
            return 7
        else
            return MakeUnknownRegionGuess()
        endif
    EndFunction
EndProperty

int Property CurrentMonth
    int Function Get()
        if(_SHSeasonsEnabled.GetValue() == 1)
            return GameMonth.GetValue() as int
        else
            return 5    ;Default cold levels at month 5
        endif
    EndFunction
EndProperty

Function StartSystem()
    PlayerRef.AddSpell(_SHRegionSpell, false)
EndFunction

Function StopSystem()
    PlayerRef.RemoveSpell(_SHRegionSpell)
EndFunction

Function UpdateCurrentRegionTemp()
    
    _SHRegionTemperature.SetValue(CalculateRegionTemp() as float)
EndFunction

int Function CalculateRegionTemp()

    int region = CurrentRegion
    _SHCurrentRegionInt.SetValue(region)      ;Get Current region

    ;Repeats are redundancy. In case I want to seperate temps out further later.
    if(region == 0) ;Volcanic
        return (_SHVolcanicTemp.GetValue() * SeasonMult[CurrentMonth]) as int
    elseif(region == 1) ;Marsh
        return (_SHMarshTemp.GetValue() * SeasonMult[CurrentMonth]) as int
    ElseIf (region == 2) ;Throat temp uses comf region
        return (_SHComfTemp.GetValue() * SeasonMult[CurrentMonth]) as int
    ElseIf (region == 3)    ;Pine
        return (_SHFreezingTemp.GetValue() * SeasonMult[CurrentMonth]) as int
    ElseIf (region == 4)    ;Comfortable
        return (_SHComfTemp.GetValue() * SeasonMult[CurrentMonth]) as int
    ElseIf (region == 5)    ;Freezing
        return (_SHFreezingTemp.GetValue() * SeasonMult[CurrentMonth]) as int
    ElseIf (region == 6)    ;Reach
        return (_SHReachTemp.GetValue() * SeasonMult[CurrentMonth]) as int
    ElseIf (region == 7)    ;Cool
        return (_SHCoolTemp.GetValue() * SeasonMult[CurrentMonth]) as int
    ElseIf (region == 8)    ;Warm Interior
        return _SHWarmTemp.GetValue() as int
    ElseIf (region == 9)   ;Cold interior
        return (_SHFreezingTemp.GetValue() * SeasonMult[CurrentMonth]) as int
    endif

EndFunction

;SunHelm will try to infer as to the current regions cold level. If there can be a blizzard here, it infers it as a freezing region. Otherwise, its cool if it can snow, and comfortable if it cannot. (Assuming weathers are tagged correctly)
int Function MakeUnknownRegionGuess()
    Weather snow = Weather.FindWeather(3)
    
    if(snow)
        int weatherClass = snow.GetClassification()
        If snow != DLC02VolcanicAshStorm01   ;Snowy
            if(_SHBlizzardWeathers.HasForm(snow))
                return _SHFreezingTemp.GetValue() as int
            else     
                if(Compat.BrumaInstalled && (PlayerRef.GetWorldSpace() == _SHMain.BSHeartland))
                    Return 5
                endif
                return 6
            endif 
        endIf
    else
        return 4
    endif
EndFunction





