Scriptname _SHRegionScript extends ActiveMagicEffect

String property regionName auto
_SHColdSystem property Cold auto
_SHRegionSystem property RegionSys auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	if(Cold.IsRunning())

		if(regionName == "COMF_REGION")
			RegionSys.comfRegion = true
		ElseIf (regionName == "REACH_REGION")
			RegionSys.reachRegion = true
		elseif(regionName == "COOL_REGION")		;Tundra
			RegionSys.coolRegion = true
		elseif(regionName == "FREEZING_REGION")
			RegionSys.freezingRegion = true
		ElseIf (regionName == "PINE_REGION")
			RegionSys.pineRegion = true
		ElseIf (regionName == "HIGH_HROTHGAR_REGION")
			RegionSys.highHrothgarRegion = true
		ElseIf (regionName == "MARSH_REGION")
			RegionSys.marshRegion = true
		ElseIf (regionName == "VOLCANIC_REGION")
			RegionSys.volcanicRegion = true
		ElseIf (regionName == "THROAT_REGION")
			RegionSys.throatRegion = true
		endif
	endif
	
	RegionSys.UpdateCurrentRegionTemp()

endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	
	if(regionName == "COMF_REGION")
		RegionSys.comfRegion = false
	ElseIf (regionName == "REACH_REGION")
		RegionSys.reachRegion = false
	elseif(regionName == "COOL_REGION")		;Tundra
		RegionSys.coolRegion = false
	elseif(regionName == "FREEZING_REGION")
		RegionSys.freezingRegion = false
	ElseIf (regionName == "PINE_REGION")
		RegionSys.pineRegion = false
	ElseIf (regionName == "HIGH_HROTHGAR_REGION")
		RegionSys.highHrothgarRegion = false
	ElseIf (regionName == "MARSH_REGION")
		RegionSys.marshRegion = false
	ElseIf (regionName == "VOLCANIC_REGION")
		RegionSys.volcanicRegion = false
	ElseIf (regionName == "THROAT_REGION")
		RegionSys.throatRegion = false
	endif

	RegionSys.UpdateCurrentRegionTemp()

endevent