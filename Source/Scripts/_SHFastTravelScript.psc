Scriptname _SHFastTravelScript extends ReferenceAlias


Event OnPlayerFastTravelEnd(Float afTravelGameTimeHours)
	(GetOwningQuest() as _SHSystemBase).FastTravelled = true
endEvent