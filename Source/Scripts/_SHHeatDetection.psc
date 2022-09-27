Scriptname _SHHeatDetection extends ReferenceAlias

_SHColdSystem property Cold auto
FormList Property _SHHeatSourcesAll Auto
FormList Property _SHHeatSourcesSmall Auto
FormList Property _SHHeatSourcesNormal Auto
FormList Property _SHHeatSourcesLarge Auto

GlobalVariable property _SHNormalSourceRadius auto
GlobalVariable property _SHSmallSourceRadius auto
GlobalVariable Property _SHCurrentColdLevel Auto   
GlobalVariable property _SHLargeSourceRadius auto
GlobalVariable property _SHToggleSounds auto
GlobalVariable Property _SHIsSexMale auto
GlobalVariable Property _SHIsNearHeatSource auto
GlobalVariable Property _SHIsInFreezingWater auto
GlobalVariable property _SH_PerkRank_ThermalIntensity auto
GlobalVariable Property _SHFirstPersonMessages auto
GlobalVariable Property _SHCurrentRegionInt auto
GlobalVariable Property _SHColdLevelCap auto

GlobalVariable Property _SHFreezingTemp auto
GlobalVariable Property _SHRegionTemperature auto

Keyword property LocTypeInn auto

Message property _SHFreezingWaterMessage auto

ImageSpaceModifier property _SHColdISM2 auto

Sound property _SHMaleFrigid auto
Sound property _SHFemaleFrigid auto

Actor property PlayerRef auto

Message Property _SHNearHeatMessage auto
Message Property _SHNearHeatMessageFirst auto
bool warmthMessageShown = false
bool coldMessageShown = false

float property lastTime auto
int updatesMade

Event OnUpdate()
    Update()
endevent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
    Cold.UnregisterForUpdate()
EndEvent

Event OnSleepStop(bool abInterrupted)
    Update()
    Cold.waitForColdSleepCheck = false
    Cold.RegisterForSingleUpdate(0.1)
EndEvent

Function StartSystem()
    lastTime = Utility.GetCurrentGameTime()
    RegisterForSleep()
    Update()
endFunction

Function StopSystem()
    UnregisterForSleep()
    UnregisterForUpdate()
endfunction

Function Update()
    if(!PlayerRef.IsSwimming())

        coldMessageShown = false
        _SHIsInFreezingWater.SetValue(0.0)

        if(SearchForHeatSources())
            _SHIsNearHeatSource.SetValue(1.0)
            SetNumberOfUpdates()
            ApplyHeatSource()
        else
            warmthMessageShown = false
            _SHIsNearHeatSource.SetValue(0.0)
        endif
    else
        warmthMessageShown = false
        if(CheckForFreezingWater())
            SetNumberOfUpdates()
            ApplyFreezingWater()
        else
            _SHIsInFreezingWater.SetValue(0.0)
            coldMessageShown = false
        endif
    endif

    lastTime = Utility.GetCurrentGameTime()
    RegisterForSingleUpdate(3.0)
endFunction

Function SetNumberOfUpdates()
    float timePassed = ((Utility.GetCurrentGameTime() *24) - (lastTime * 24))
    updatesMade = (timePassed / 0.0166) as int
    if(updatesMade < 1)
        updatesMade = 1
    endif
endfunction

Function ApplyHeatSource()
    if(!warmthMessageShown)
        if(Cold._SHCurrentColdLevel.GetValue() > 25)
            if(_SHFirstPersonMessages.GetValue() == 1.0)
                _SHNearHeatMessageFirst.Show()
            else
                _SHNearHeatMessage.Show()
            endif
        endif
        warmthMessageShown = true 
    endif 

    float baseHeat = 15.0

    if(_SH_PerkRank_ThermalIntensity.GetValue() == 1.0)
        baseHeat+=(baseHeat*0.10)
    elseif(_SH_PerkRank_ThermalIntensity.GetValue() == 0.0)
        baseHeat+=(baseHeat*0.15)
    endif

    Cold.DecreaseColdLevel(baseHeat*updatesMade)
    Cold.SetTemperatureUI(0.0,0.0,1)    ;Set widget warm
endfunction

Function ApplyFreezingWater()
    _SHIsNearHeatSource.SetValue(0.0)
    _SHIsInFreezingWater.SetValue(1.0)

    if(!coldMessageShown)
        coldMessageShown = true
        Cold.CurrentColdLevelLimit = _SHColdLevelCap.GetValue() as int

        If(_SHToggleSounds.GetValue() == 1.0)
            If (_SHIsSexMale.GetValue() == 1.0)
                _SHMaleFrigid.Play(PlayerRef)
            Else
                _SHFemaleFrigid.Play(PlayerRef)
            EndIf
        EndIf
    endif
    ;Play FX, sounds, etc
    Cold.SetTemperatureUI(0.0,0.0,4)
    Cold.IncreaseColdLevel(20.0*updatesMade)
EndFunction

bool Function SearchForHeatSources()
    Location current_location = PlayerRef.GetCurrentLocation()
    if current_location && current_location.HasKeyword(LocTypeInn)
        return true
    endif

    if (!PlayerRef.IsRunning() && !PlayerRef.IsSprinting())
        objectreference heatSourceRef = game.FindClosestReferenceOfAnyTypeInListFromRef(_SHHeatSourcesAll, Game.GetPlayer() as objectreference, _SHLargeSourceRadius.GetValue())
        if (heatSourceRef && heatSourceRef.IsEnabled())
            float distance = PlayerRef.GetDistance(heatSourceRef)
            
            form heatSource = heatSourceRef.GetBaseObject()
            if(_SHHeatSourcesSmall.HasForm(heatSource) && distance <= _SHSmallSourceRadius.GetValue())
                return true
            elseif(_SHHeatSourcesNormal.HasForm(heatSource) && distance <= _SHNormalSourceRadius.GetValue())
                return true
            elseif(_SHHeatSourcesLarge.HasForm(heatSource))
                return true
            else
                return true
            endif
        endIf

    endif
    return false
EndFunction

bool Function CheckForFreezingWater()

    if(!PlayerRef.HasMagicEffectWithKeyword(Cold.MagicFlameCloak) && (_SHCurrentRegionInt.GetValue() == 5 || _SHCurrentRegionInt.GetValue() == 9))
        return true
    endif
    return false

EndFunction