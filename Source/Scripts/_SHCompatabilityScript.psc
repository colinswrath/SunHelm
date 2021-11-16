Scriptname _SHCompatabilityScript extends Quest

;Yes I know the name is mispelled. Its disgusting and im sorry.

FormList Property _SHFoodLightList Auto
FormList Property _SHFoodMediumList Auto
FormList Property _SHFoodHeavyList Auto
FormList Property _SHSoupList auto
FormList Property _SHFoodIgnoreList Auto
FormList Property _SHRawList auto
FormList Property _SHLichRaceList auto

_SunHelmMain property _SHMain auto

FormList Property _SHMeadBottleList Auto
FormList Property _SHWineBottleList Auto
FormList Property _SHSujammaBottleList Auto
FormList Property _SHDrinkList auto
FormList Property _SHDrinkNoBottle auto
FormList Property _SHAlcoholList auto
FormList Property _SHVampireBlood auto
FormList Property _SHCampfireBackPacks auto
FormList Property _SHActivateList auto
FormList property _SHHotBeverageList auto

FormList CampfireWaterskins
FormList property _SHWaterskins auto


FormList Property _SHHeatSourcesAll Auto
FormList Property _SHHeatSourcesSmall Auto
FormList Property _SHHeatSourcesNormal Auto
FormList Property _SHHeatSourcesLarge Auto

FormList property _SHColdCloudyWeather auto

bool doAClean = true

bool HunterbornInstalled
bool CookingInSkyrimInstalled
bool CuttingRoomFloorInstalled
bool CACOInstalled
bool NordicCookingInstalled
bool MealTimeInstalled
bool property FrostfallInstalled auto
bool LOTDInstalled
bool property BrumaInstalled auto
bool USSEPInstalled
bool CampfireInstalled
bool CampsiteInstalled
bool property WyrmstoothInstalled auto
bool UndeathInstalled
bool PathInstalled
bool property ObsidianInstalled auto
bool WarmDrinksInstalled

Function CleanLists()

	;REVERT LISTS FIRST
	_SHFoodLightList.Revert()
	_SHFoodMediumList.Revert()
	_SHFoodHeavyList.Revert()
	_SHSoupList.Revert()
	_SHFoodIgnoreList.Revert()
	_SHRawList.Revert()
	_SHDrinkList.Revert()
	_SHMeadBottleList.Revert()
	_SHWineBottleList.Revert()
	_SHSujammaBottleList.Revert()
	_SHDrinkList.Revert()
	_SHAlcoholList.Revert()
	_SHHeatSourcesAll.Revert()
	_SHHeatSourcesSmall.Revert()
	_SHHeatSourcesNormal.Revert()
	_SHLichRaceList.Revert()
	_SHColdCloudyWeather.Revert()
	_SHHotBeverageList.Revert()

	HunterbornInstalled = false
	CookingInSkyrimInstalled = false
	CuttingRoomFloorInstalled = false
	CACOInstalled = false
	NordicCookingInstalled = false
	MealTimeInstalled = false
	FrostfallInstalled = false
	LOTDInstalled = false
	BrumaInstalled = false
	USSEPInstalled = false
	CampfireInstalled = false
	CampsiteInstalled = false
	UndeathInstalled = false
	PathInstalled = false
	ObsidianInstalled = false
	WarmDrinksInstalled = false

	doAClean = false

EndFunction

Function ResetLists()

	CleanLists()
	CheckMods()

endFunction


Function CheckMods()

	If (doAClean)
		CleanLists()
	EndIf

	;If false then hunterborn is not installed
	if(Hunterborn())
		HunterbornInstalled = true
	else
		;If this is true that means we uninstalled hunterborn and we need to clean the lists next time
		if(HunterbornInstalled)
			doAClean = true
			HunterbornInstalled = false
		endif
    endif

	if(CookingInSkyrim())
		CookingInSkyrimInstalled = true
	else
		if(CookingInSkyrimInstalled)
			doAClean = true
			CookingInSkyrimInstalled = false
		endif
	endif

	If (CuttingRoomFloor())
		CuttingRoomFloorInstalled = true
	Else
		if(CuttingRoomFloorInstalled)
			doAClean = true
			CuttingRoomFloorInstalled = false
		endif
	EndIf

	if(NordicCooking())
		NordicCookingInstalled = true
	else
		If (NordicCookingInstalled)
			doAClean = true
			CuttingRoomFloorInstalled = false
		EndIf
	endif

	If (Frostfall())
		FrostfallInstalled = true
	else
		If (FrostfallInstalled)
			doAClean = true
			FrostfallInstalled = false
		EndIf
	EndIf

	if(CACO())
		CACOInstalled = true	
	else
		if(CACOInstalled)
			doAClean = true
			CACOInstalled = false
		endif
	Endif

	if(Mealtime())
		MealTimeInstalled = true
	Else
		if(MealTimeInstalled)
			doAClean = true
			MealTimeInstalled = false
		endif
	endif

	if(LOTD())
		LOTDInstalled = true
	Else
		if(LOTDInstalled)
			doAClean = true
			LOTDInstalled = false
		endif
	endif

	if(Bruma())
		BrumaInstalled = true
	else
		if(BrumaInstalled)
			doAClean = true
			BrumaInstalled = false
		endif
	endif

	if(USSEP())
		USSEPInstalled = true
	else
		if(USSEPInstalled)
			doAClean = true
			USSEPInstalled = false
		endif
	endif

	if(Campfire())
		CampfireInstalled = true
	Else
		if(CampfireInstalled)
			doAClean = true
			CampfireInstalled = false
		endif
	endif

	if(Campsite())
		CampsiteInstalled = true
	else
		if(CampsiteInstalled)
			doAClean = true
			CampsiteInstalled = false
		endif
	endif

	if(Undeath())
		UndeathInstalled = true
	else
		if(UndeathInstalled)
			UndeathInstalled = false
		endif
	endif

	if(Transcendence())
		PathInstalled = true
	else
		if(PathInstalled)
			PathInstalled = false
		endif
	endif

	if(Obsidian())
		ObsidianInstalled = true
	else
		if(ObsidianInstalled)
			ObsidianInstalled = false
			doAClean = true
		endif
	endif

	if(WarmDrinks())
		WarmDrinksInstalled = true
	else
		if(WarmDrinksInstalled)
			WarmDrinksInstalled = false
			doAClean = true
		endif
	endif

EndFunction

bool function WarmDrinks()
	if(Game.GetModByName("Warm Drinks.esp") != 255)

		if(!WarmDrinksInstalled)
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x0000FB0A, "Warm Drinks.esp")) ;LeoBlueMountainTea
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x0000FB0A, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00019D0E, "Warm Drinks.esp")) ;LeoRedMountainTea
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00019D0E, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00019D11, "Warm Drinks.esp")) ;LeoPurpleMountainTea
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00019D11, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x0001EE13, "Warm Drinks.esp")) ;LeoElvenCoffee
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x0001EE13, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00023F16, "Warm Drinks.esp")) ;LeoDarkElvenCoffee
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00023F16, "Warm Drinks.esp")) 
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00029018, "Warm Drinks.esp")) ;LeoNordicCoffee
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00029018, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00029019, "Warm Drinks.esp")) ;LeoNordicBlueMountainTea
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00029019, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x0002901D, "Warm Drinks.esp")) ;LeoNordicPurpleMountainTea
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x0002901D, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00029021, "Warm Drinks.esp")) ;SummerRedMountainTea
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00029021, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00029023, "Warm Drinks.esp")) ;SummerPurpleMountainTea
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00029023, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00029025, "Warm Drinks.esp")) ;SweetenedBlue
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00029025, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00029027, "Warm Drinks.esp")) ;SweetenedRed
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00029027, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x0002902B, "Warm Drinks.esp")) ;SweetSugarTea
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x0002902B, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x0002902D, "Warm Drinks.esp")) ;CalmingBlue
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x0002902D, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x0002902F, "Warm Drinks.esp")) ;WayOfTheVoice
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x0002902F, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00029031, "Warm Drinks.esp")) ;Ash
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00029031, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00029033, "Warm Drinks.esp")) ;
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00029033, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00029035, "Warm Drinks.esp")) ;
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00029035, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00029037, "Warm Drinks.esp")) ;
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00029037, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00029039, "Warm Drinks.esp")) ;
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00029039, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x0002903B, "Warm Drinks.esp")) ;
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x0002903B, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x0002903D, "Warm Drinks.esp")) ;
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x0002903D, "Warm Drinks.esp"))
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x0006AD90, "Warm Drinks.esp")) ;
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x0006AD90, "Warm Drinks.esp"))

		endif
		return true
	Endif
	return false
EndFunction

bool function Obsidian()
	if(Game.GetModByName("Obsidian Weathers.esp") != 255)
		if(!ObsidianInstalled)
			_SHColdCloudyWeather.AddForm(Game.GetFormFromFile(0x0010E1E3, "Skyrim.esm") as Weather)
			_SHColdCloudyWeather.AddForm(Game.GetFormFromFile(0x0010A235, "Skyrim.esm") as Weather)
			_SHColdCloudyWeather.AddForm(Game.GetFormFromFile(0x0010E1E5, "Skyrim.esm") as Weather)
			_SHColdCloudyWeather.AddForm(Game.GetFormFromFile(0x0010E1E8, "Skyrim.esm") as Weather)
			_SHColdCloudyWeather.AddForm(Game.GetFormFromFile(0x0010E1EF, "Skyrim.esm") as Weather)
			_SHColdCloudyWeather.AddForm(Game.GetFormFromFile(0x0010A233, "Skyrim.esm") as Weather)
			_SHColdCloudyWeather.AddForm(Game.GetFormFromFile(0x0010A232, "Skyrim.esm") as Weather)
			_SHColdCloudyWeather.AddForm(Game.GetFormFromFile(0x00104AB4, "Skyrim.esm") as Weather)
			_SHColdCloudyWeather.AddForm(Game.GetFormFromFile(0x00010E0B, "Dawngaurd.esm") as Weather)
			_SHColdCloudyWeather.AddForm(Game.GetFormFromFile(0x00010E0E, "Dawngaurd.esm") as Weather)
		endif
		return true
	endif
	return false
endFunction


bool function Transcendence()

	; Check for lich races from Path of Transcendence
	if (Game.GetModByName("The Path of Transcendence.esp") != 255)
		if(!PathInstalled)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x00038357, "The Path of Transcendence.esp") as Race)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x000e0e47, "The Path of Transcendence.esp") as Race)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x0022bd61, "The Path of Transcendence.esp") as Race)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x00240166, "The Path of Transcendence.esp") as Race)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x00240167, "The Path of Transcendence.esp") as Race)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x0024a378, "The Path of Transcendence.esp") as Race)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x0024a379, "The Path of Transcendence.esp") as Race)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x0024f47d, "The Path of Transcendence.esp") as Race)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x0024f47e, "The Path of Transcendence.esp") as Race)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x0024f482, "The Path of Transcendence.esp") as Race)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x0024f486, "The Path of Transcendence.esp") as Race)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x0024f487, "The Path of Transcendence.esp") as Race)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x0037fd2b, "The Path of Transcendence.esp") as Race)
		endif
		return true
	endIf
	return false
endfunction

bool function Undeath()
	if (Game.GetModByName("Undeath.esp") != 255)
		if(!UndeathInstalled)
			_SHLichRaceList.AddForm(Game.GetFormFromFile(0x0001772a, "Undeath.esp") as Race)
		endif
		return true
	endIf
	return false
endfunction

;bool function Wyrmstooth()
;	if(game.GetModByName("Wyrmstooth.esp"))
;		if(!WyrmstoothInstalled)
;			_SHMain.Wyrmstooth = game.GetFormFromFile(0x00000d62, "Wyrmstooth.esp") as Worldspace
;		endif
;		return true
;	endif
;	return false
;EndFunction

bool function Campsite()
	if game.GetModByName("Campsite.esp") != 255
		if(!CampsiteInstalled)
			_SHHeatSourcesNormal.AddForm((game.GetFormFromFile(22786, "Campsite.esp") as activator) as form)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(22786, "Campsite.esp") as activator) as form)
		endif
		return true
	endIf
	return false
endfunction

bool function Campfire()
	
	if game.GetModByName("Campfire.esm") != 255

		if(!CampfireInstalled)
			_SHHeatSourcesNormal.AddForm(game.GetFormFromFile(0x00040013, "Campfire.esm") as activator)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(0x00040013, "Campfire.esm") as activator) as form)	;Crackling Deadwood 

			_SHHeatSourcesNormal.AddForm((game.GetFormFromFile(0x000328B9, "Campfire.esm") as activator) as form)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(0x000328B9, "Campfire.esm") as activator) as form)		;Crackling Firewood

			_SHHeatSourcesNormal.AddForm((game.GetFormFromFile(0x000328A8, "Campfire.esm") as activator) as form)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(0x000328A8, "Campfire.esm") as activator) as form)		;Flickering Books

			_SHHeatSourcesNormal.AddForm((game.GetFormFromFile(0x000328A6, "Campfire.esm") as activator) as form)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(0x000328A6, "Campfire.esm") as activator) as form)		;Flickering Branches

			_SHHeatSourcesNormal.AddForm((game.GetFormFromFile(0x0005C8D8, "Campfire.esm") as activator) as form)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(0x0005C8D8, "Campfire.esm") as activator) as form)		;Flickering Kindling

			_SHHeatSourcesNormal.AddForm((game.GetFormFromFile(0x00033E67, "Campfire.esm") as activator) as form)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(0x00033E67, "Campfire.esm") as activator) as form)			;Roaring Deadwood

			_SHHeatSourcesNormal.AddForm((game.GetFormFromFile(0x00033E69, "Campfire.esm") as activator) as form)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(0x00033E69, "Campfire.esm") as activator) as form)		;Roaring Firewood

			_SHHeatSourcesNormal.AddForm((game.GetFormFromFile(0x0006ABB2, "Campfire.esm") as activator) as form)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(0x0006ABB2, "Campfire.esm") as activator) as form)		;Roaring World Firewood
			
			_SHHeatSourcesNormal.AddForm((game.GetFormFromFile(0x0005C8D6, "Campfire.esm") as activator) as form)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(0x0005C8D6, "Campfire.esm") as activator) as form)		;Fragile kindling

			_SHHeatSourcesNormal.AddForm((game.GetFormFromFile(0x00032334, "Campfire.esm") as activator) as form)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(0x00032334, "Campfire.esm") as activator) as form)		;Fragile Books Lit

			_SHHeatSourcesNormal.AddForm((game.GetFormFromFile(0x00032333, "Campfire.esm") as activator) as form)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(0x00032333, "Campfire.esm") as activator) as form)		;Fragile Branches Lit

			_SHHeatSourcesNormal.AddForm((game.GetFormFromFile(0x0005C8D6, "Campfire.esm") as activator) as form)
			_SHHeatSourcesAll.AddForm((game.GetFormFromFile(0x0005C8D6, "Campfire.esm") as activator) as form)		;Fragile 

			CampfireWaterskins = Game.GetFormFromFile(0x0005711E, "Campfire.esm") as FormList

			int index = _SHWaterskins.GetSize()
			while index
				index -=1 
				CampfireWaterskins.AddForm(_SHWaterskins.GetAt(index) as form)
			endwhile

		endif
		return true
	endif
	return false
endFunction

bool function USSEP()

	form meatPie = Game.GetFormFromFile(0x00000801, "Unofficial Skyrim Special Edition Patch.esp")

	if(meatPie)
		if(!USSEPInstalled)
			_SHFoodHeavyList.AddForm(meatPie)
		endif
		return true
	endif

	return false
endfunction

bool Function Bruma()

	form grapeJam = Game.GetFormFromFile(0x000b6c59,"BSHeartland.esm")
	if(grapeJam)
		if(!BrumaInstalled)
			_SHMain.BSHeartland = Game.GetFormFromFile(0x000A764B, "BSHeartland.esm") as WorldSpace
			;Light Food
			_SHFoodLightList.AddForm(grapeJam) ;Grape Jam
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000b6c5a,"BSHeartland.esm")) ;Cheese Curds
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000cc27e,"BSHeartland.esm")) ;Sliced Olroy Cheese
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000cc27f,"BSHeartland.esm")) ;Olroy Cheese Wedge
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000d2f3d,"BSHeartland.esm")) ;Sweetcake
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0005f06e,"BSHeartland.esm")) ;Cheese Wedge
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000b6c53,"BSHeartland.esm")) ;Lollipop
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000b6c54,"BSHeartland.esm")) ;Candy Bunnies
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000b6c58,"BSHeartland.esm")) ;Apple Jam
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0005f06c,"BSHeartland.esm")) ;Sliced Cheese
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01601421,"Update.esm")) ;Red Cabbage
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01601FB8,"Update.esm")) ;Parsnip
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01601FCA,"Update.esm")) ;Grapes
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01602078,"Update.esm")) ;Pear
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01602079,"Update.esm")) ;Peach
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x016020AC,"Update.esm")) ;Lettuce
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01602564,"Update.esm")) ;Scrib Cabbage
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0160280B,"Update.esm")) ;Orange
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0160280E,"Update.esm")) ;Boiled Egg
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0160280F,"Update.esm")) ;Flapjack
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01602812,"Update.esm")) ;Radish
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01602839,"Update.esm")) ;Strawberry
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0160283A,"Update.esm")) ;Banana
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0160283C,"Update.esm")) ;Corn
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01602943,"Update.esm")) ;Cabbage roll

			;Medium Food
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000b6c5b,"BSHeartland.esm")) ;Colovian Bread Wreath
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000cc280,"BSHeartland.esm")) ;Cooked Rat Meat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0005f070,"BSHeartland.esm")) ;Corn Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00062712,"BSHeartland.esm")) ;Turkey Breast
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00062713,"BSHeartland.esm")) ;Shepherd's Pie
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00071a0f,"BSHeartland.esm")) ;Rice Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00071a10,"BSHeartland.esm")) ;Rice Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00071a14,"BSHeartland.esm")) ;Garlic Carrots
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000721c7,"BSHeartland.esm")) ;Roast Turkey
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000721ca,"BSHeartland.esm")) ;Jugged Rabbit
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000b6c55,"BSHeartland.esm")) ;Beef Skewer
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000b6c56,"BSHeartland.esm")) ;Baked Apple
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00001d7f,"BSHeartland.esm")) ;Applewatch Pie
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0005f064,"BSHeartland.esm")) ;Venison Pasty
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0005f066,"BSHeartland.esm")) ;Corn Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0005f06a,"BSHeartland.esm")) ;Beef Pasty
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x01601FC8,"Update.esm")) ;Pumpkin
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x01602941,"Update.esm")) ;Carrot cake
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x01602942,"Update.esm")) ;Carrot Cake slice
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x01602945,"Update.esm")) ;Eyebread

			;Heavy Food
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x000cc27d,"BSHeartland.esm")) ;Olroy Cheese Wheel
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x0005f06d,"BSHeartland.esm")) ;Cheese Wheel
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x000721c8,"BSHeartland.esm")) ;Trout Steak
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x000721c9,"BSHeartland.esm")) ;Slaughterfish Pie
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x01601911,"Update.esm")) ;Watermelon
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x016020AF,"Update.esm")) ;Cooked Boar
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x016028B8,"Update.esm")) ;Mutton Roast
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x016028C6,"Update.esm")) ;Roast lamb

			;Soup Food
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0005f071,"BSHeartland.esm")) ;Mudcrab Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000721c6,"BSHeartland.esm")) ;Imperial City Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000b6c52,"BSHeartland.esm")) ;Colovian Beef Stew
			;Raw Food
			_SHRawList.AddForm(Game.GetFormFromFile(0x00049320,"BSHeartland.esm")) ;Trout Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x016020AD,"Update.esm")) ;Raw rat
			_SHRawList.AddForm(Game.GetFormFromFile(0x016020AE,"Update.esm")) ;Boar meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x016028B7,"Update.esm")) ;Mutton
			_SHRawList.AddForm(Game.GetFormFromFile(0x016028D8,"Update.esm")) ;Lamb

			;Alcohol
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005f06f,"BSHeartland.esm")) ;Greenwood Mead
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x0005f06f,"BSHeartland.esm")) ;Greenwood Mead
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005f072,"BSHeartland.esm")) ;Flin
			_SHSujammaBottleList.AddForm(Game.GetFormFromFile(0x0005f072,"BSHeartland.esm")) ;Flin
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005f073,"BSHeartland.esm")) ;Ale
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x0005f073,"BSHeartland.esm")) ;Ale
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00062715,"BSHeartland.esm")) ;Shadowbanish Wine
			_SHWineBottleList.AddForm(Game.GetFormFromFile(0x00062715,"BSHeartland.esm")) ;Shadowbanish Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00062716,"BSHeartland.esm")) ;Colovian Battlecry
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x00062716,"BSHeartland.esm")) ;Colovian Battlecry
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x000858ef,"BSHeartland.esm")) ;Brandy
			_SHWineBottleList.AddForm(Game.GetFormFromFile(0x000858ef,"BSHeartland.esm")) ;Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005f065,"BSHeartland.esm")) ;Cheap Wine
			_SHWineBottleList.AddForm(Game.GetFormFromFile(0x0005f065,"BSHeartland.esm")) ;Cheap Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005f067,"BSHeartland.esm")) ;Cheap Wine
			_SHWineBottleList.AddForm(Game.GetFormFromFile(0x0005f067,"BSHeartland.esm")) ;Cheap Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005f068,"BSHeartland.esm")) ;Mead
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x0005f068,"BSHeartland.esm")) ;Mead
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005f069,"BSHeartland.esm")) ;Beer
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x0005f069,"BSHeartland.esm")) ;Beer
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005f06b,"BSHeartland.esm")) ;Applewatch Cider
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x0005f06b,"BSHeartland.esm")) ;Applewatch Cider
			;Vampire Blood
			;Ignore List
			_SHFoodIgnoreList.AddForm(Game.GetFormFromFile(0x000d6c67,"BSHeartland.esm")) ;Welkynd Stone

			;Light
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00601421,"BSAssets.esm"))	;Red Cabbage
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00601FB8,"BSAssets.esm"))	;Parsnip
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00601FCA,"BSAssets.esm"))	;Grapes
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00602078,"BSAssets.esm"))	;Pear
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00602079,"BSAssets.esm"))	;Peach
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x006020AC,"BSAssets.esm"))	;Lettuce
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00602564,"BSAssets.esm"))	;Srib Cabbage
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0060280B,"BSAssets.esm"))	;Orange
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0060280E,"BSAssets.esm"))	;Boiled Egg
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0060280F,"BSAssets.esm"))	;Flapjack
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00602812,"BSAssets.esm"))	;Radish
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00602839,"BSAssets.esm"))	;Strawberry
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0060283A,"BSAssets.esm"))	;Banana
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0060283C,"BSAssets.esm"))	;Corn
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00602943,"BSAssets.esm"))	;Cabbage Roll
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00602945,"BSAssets.esm"))	;Eyebread
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00602942,"BSAssets.esm"))	;Carrot Cake
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0000B9D1,"BS_DLC_patch.esm"))	;Cooked Corn

			;Medium
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00602941,"BSAssets.esm"))	;Carrot Cake
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00601911,"BSAssets.esm"))	;Watermelon

			;Heavy
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x006020AF,"BSAssets.esm"))	;Cooked Boar Meat
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x006028B8,"BSAssets.esm"))	;Cooked Mutton
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x006028C6,"BSAssets.esm"))	;Mutton Roast
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x006028D8,"BSAssets.esm"))	;Lamb

			;Raw
			_SHRawList.AddForm(Game.GetFormFromFile(0x006028B7,"BSAssets.esm"))	;Mutton

		endif
		return true
	endif
	return false

endfunction

bool Function LOTD()

	form CinnaspiceCookie = Game.GetFormFromFile(0x002E0517,"LegacyoftheDragonborn.esm")
	if CinnaspiceCookie
		if (!LOTDInstalled)
			_SHFoodLightList.AddForm(CinnaspiceCookie)
			_SHActivateList.AddForm(Game.GetFormFromFile(0x00304426,"LegacyoftheDragonborn.esm"))
		endif
		return true
	endif

	return false
endFunction

bool Function Frostfall()

	form strBrew1 = Game.GetFormFromFile(0x0001CEBD,"Frostfall.esp")
	if strBrew1
		If (!FrostfallInstalled)
			
			;Mead
			_SHAlcoholList.AddForm(strBrew1)	;Strong brew1
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0001CEBF,"Frostfall.esp")) ;Strong brew 2
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0001CEC1,"Frostfall.esp")) ;Strong brew 3
			_SHFoodIgnoreList.AddForm(Game.GetFormFromFile(0x00062FEC,"Frostfall.esp"))	;Frostbite ingestible
			_SHFoodIgnoreList.AddForm(Game.GetFormFromFile(0x00066B5F,"Frostfall.esp")) ;Frostbite ingestible
			_SHFoodIgnoreList.AddForm(Game.GetFormFromFile(0x00068121,"Frostfall.esp")) ;Frostbite ingestible
			_SHFoodIgnoreList.AddForm(Game.GetFormFromFile(0x00068123,"Frostfall.esp")) ;Frostbite ingestible
			_SHFoodIgnoreList.AddForm(Game.GetFormFromFile(0x00068125,"Frostfall.esp")) ;Frostbite ingestible
		EndIf
		return true
	endif
	
	return false
endfunction

bool Function Mealtime()

	form redMtnFudge = Game.GetFormFromFile(0x00023aa0,"mealtimeyum.esp")
	
		if (redMtnFudge)
			if(!MealTimeInstalled)
				;Light Food"
				_SHFoodLightList.AddForm(redMtnFudge) ;Red Mountain Flower Fudge"
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00026974,"mealtimeyum.esp")) ;Mountain Flower Malts
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00026972,"mealtimeyum.esp")) ;Flower Malt Bowl
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00029867,"mealtimeyum.esp")) ;Jazbay Meadowcream Scone
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00029842,"mealtimeyum.esp")) ;Ice Cream
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00029845,"mealtimeyum.esp")) ;Snowberry Ice Cream
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002984c,"mealtimeyum.esp")) ;Chocolate Ice Cream
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002984f,"mealtimeyum.esp")) ;Sovngarde Ice Cream
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002c735,"mealtimeyum.esp")) ;Jazbay Meadowcream Scones
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002c738,"mealtimeyum.esp")) ;Fudge Brownie
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002c73a,"mealtimeyum.esp")) ;Fudge Brownies
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002c73f,"mealtimeyum.esp")) ;Sabre Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002c742,"mealtimeyum.esp")) ;Sabre Cakes
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002c748,"mealtimeyum.esp")) ;Custard Baked Apple
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002f628,"mealtimeyum.esp")) ;Stros M'Kai Rum Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002f61a,"mealtimeyum.esp")) ;Stros M'Kai Rum Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002f621,"mealtimeyum.esp")) ;Frost Mirriam Pastry
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002f624,"mealtimeyum.esp")) ;Frost Mirriam Pastry Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0003254a,"mealtimeyum.esp")) ;Sugared Yellow Mountain Flowers
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0003251d,"mealtimeyum.esp")) ;Chocolate Mole Sauce
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0003251f,"mealtimeyum.esp")) ;Frost Mirriam Dip
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00032521,"mealtimeyum.esp")) ;Spicy Dragon's Tongue Sauce
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00032532,"mealtimeyum.esp")) ;Wedding Cookies
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00032534,"mealtimeyum.esp")) ;Wedding Cookie
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00032539,"mealtimeyum.esp")) ;Sugared Red Mountain Flowers
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0003253c,"mealtimeyum.esp")) ;Sugared Red Mountain Flowers
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00032540,"mealtimeyum.esp")) ;Sugared Purple Mountain Flowers
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00032542,"mealtimeyum.esp")) ;Sugared Purple Mountain Flowers
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00032544,"mealtimeyum.esp")) ;Sugared Blue Mountain Flowers
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00032546,"mealtimeyum.esp")) ;Sugared Blue Mountain Flowers
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00032548,"mealtimeyum.esp")) ;Sugared Yellow Mountain Flowers
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00051871,"mealtimeyum.esp")) ;Marshmallow Stick
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00065c92,"mealtimeyum.esp")) ;Rainbow Mountain Flower Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00065c90,"mealtimeyum.esp")) ;Rainbow Mountain Flower Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0006adaf,"mealtimeyum.esp")) ;Icy Custard
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0006ad9f,"mealtimeyum.esp")) ;Dragons Tongue Honey Baklava
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0006ada1,"mealtimeyum.esp")) ;Dragons Tongue Honey Baklava
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0006feb6,"mealtimeyum.esp")) ;Wheat Flakes Bowl
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0006feb9,"mealtimeyum.esp")) ;Dragon's Tongue Hummus
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0006fee3,"mealtimeyum.esp")) ;Buttery Pound Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0006fee8,"mealtimeyum.esp")) ;Buttery Pound Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0006feec,"mealtimeyum.esp")) ;Honey Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0006feef,"mealtimeyum.esp")) ;Honey Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0006fef7,"mealtimeyum.esp")) ;Cream Puffs
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0006fef9,"mealtimeyum.esp")) ;Cream Puff
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0006fefc,"mealtimeyum.esp")) ;Baked Winterhold Flambe
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0007a110,"mealtimeyum.esp")) ;Carrot Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0007a109,"mealtimeyum.esp")) ;Salmon and Juniper Mousse
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0007a10b,"mealtimeyum.esp")) ;Salmon and Juniper Mousse
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0007a10e,"mealtimeyum.esp")) ;Carrot Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0007f219,"mealtimeyum.esp")) ;Celebration Sweetroll Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0007f217,"mealtimeyum.esp")) ;Celebration Sweetroll
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0008942a,"mealtimeyum.esp")) ;Candy Floss
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0009874a,"mealtimeyum.esp")) ;Yellow Mountain Flower Cookie
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00098732,"mealtimeyum.esp")) ;Buttermilk Biscuit
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00098734,"mealtimeyum.esp")) ;Honey Buttermilk Biscuit
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00098736,"mealtimeyum.esp")) ;Snowberry Buttermilk Biscuit
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00098738,"mealtimeyum.esp")) ;Applebutter Buttermilk Biscuit
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0009873a,"mealtimeyum.esp")) ;Buttermilk Egg Biscuit
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0009873e,"mealtimeyum.esp")) ;Apple Butter
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00098740,"mealtimeyum.esp")) ;Honey Sugar Crystals
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00098742,"mealtimeyum.esp")) ;Nordic Cocoa Powder
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000a2956,"mealtimeyum.esp")) ;Wedding Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0000659a,"mealtimeyum.esp")) ;Snowberry Sauce Dish
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0000659e,"mealtimeyum.esp")) ;Red Mountain Flower Cookie
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000065a4,"mealtimeyum.esp")) ;Snowberry Sauce
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000065ba,"mealtimeyum.esp")) ;Pate
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000065be,"mealtimeyum.esp")) ;Jazbay Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000065c0,"mealtimeyum.esp")) ;Jazbay Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0000948f,"mealtimeyum.esp")) ;Bread Roll Basket
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00009491,"mealtimeyum.esp")) ;Bread Roll
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000094b6,"mealtimeyum.esp")) ;Potato Salad
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000094b3,"mealtimeyum.esp")) ;Potato Salad Bowl
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00015019,"mealtimeyum.esp")) ;Tomato Egg Fritata Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00014ffc,"mealtimeyum.esp")) ;Honey Pudding
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00015000,"mealtimeyum.esp")) ;Honey Pudding Bowl
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00015003,"mealtimeyum.esp")) ;Butterscotch Spice Pie
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00015006,"mealtimeyum.esp")) ;Butterscotch Spice Pie Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001500a,"mealtimeyum.esp")) ;Bread Pudding
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001500d,"mealtimeyum.esp")) ;Bread Pudding
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00015010,"mealtimeyum.esp")) ;Jazbay Leaf Pasteles
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00015012,"mealtimeyum.esp")) ;Jazbay Leaf Pastel
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00015017,"mealtimeyum.esp")) ;Tomato Egg Fritata
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00017efe,"mealtimeyum.esp")) ;Fruit Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00017ee4,"mealtimeyum.esp")) ;Juniper Spiced Slaughterfish
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00017ee8,"mealtimeyum.esp")) ;Riverwood Tree Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00017eed,"mealtimeyum.esp")) ;Riverwood Tree Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00017ef1,"mealtimeyum.esp")) ;Pancake Puff
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00017ef3,"mealtimeyum.esp")) ;Pancake Puff Plate
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00017ef5,"mealtimeyum.esp")) ;Ash Yam Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00017ef8,"mealtimeyum.esp")) ;Ash Yam Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00017efa,"mealtimeyum.esp")) ;Fruit Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001adef,"mealtimeyum.esp")) ;Potato Pancake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001adcb,"mealtimeyum.esp")) ;Buttercream Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001add0,"mealtimeyum.esp")) ;Dragonborn Wedding Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001add5,"mealtimeyum.esp")) ;Wedding Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001add9,"mealtimeyum.esp")) ;Buttercream Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001adde,"mealtimeyum.esp")) ;Decorated Buttercream Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001ade2,"mealtimeyum.esp")) ;Decorated Buttercream Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001dcbb,"mealtimeyum.esp")) ;Snowberry Delight Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001dcbe,"mealtimeyum.esp")) ;Snowberry Delight
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001dcc2,"mealtimeyum.esp")) ;Azura's Star Cookie
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001dcc5,"mealtimeyum.esp")) ;Azura's Star Cookie Plate
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00023aa2,"mealtimeyum.esp")) ;Red Mountain Flower Fudge Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00023a71,"mealtimeyum.esp")) ;Moon Sugared Fruit Bowl
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00023a74,"mealtimeyum.esp")) ;Moon Sugared Fruits
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00023a78,"mealtimeyum.esp")) ;Red Velvet Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00023a7c,"mealtimeyum.esp")) ;Red Velvet Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00023a80,"mealtimeyum.esp")) ;Log Cake
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00023a82,"mealtimeyum.esp")) ;Log Cake Slice
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00023a86,"mealtimeyum.esp")) ;Bread Twigs
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00023a88,"mealtimeyum.esp")) ;Bread Twigs
				_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00023a8a,"mealtimeyum.esp")) ;Bread Twigs
				
				Utility.Wait(1)
				;Medium Food
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00029852,"mealtimeyum.esp")) ;Creme Brulee
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00029855,"mealtimeyum.esp")) ;Sunlight Souffle
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0002985a,"mealtimeyum.esp")) ;Elves Ear Pasta
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0002985d,"mealtimeyum.esp")) ;Elves Ear Pasta Plate
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0002985f,"mealtimeyum.esp")) ;Emperor Parasol Ravioli
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00029862,"mealtimeyum.esp")) ;Emperor Parasol Ravioli Dish
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00029864,"mealtimeyum.esp")) ;Golden Caviar
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0002c74b,"mealtimeyum.esp")) ;Custard Baked Apples
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000324f4,"mealtimeyum.esp")) ;Dragon's Tongue Beans
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000324f6,"mealtimeyum.esp")) ;Dragon's Tongue Fudge
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000324f8,"mealtimeyum.esp")) ;Dragon's Tongue Fudge Slice
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000324fb,"mealtimeyum.esp")) ;Sugarglass Dragon
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000324ff,"mealtimeyum.esp")) ;Butter Dragon
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00032502,"mealtimeyum.esp")) ;Apple Eider Salad
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00032505,"mealtimeyum.esp")) ;Apple Spice Cake
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00032507,"mealtimeyum.esp")) ;Apple Spice Cake Slice
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003250b,"mealtimeyum.esp")) ;Breton Hors d'Oeuvre
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003250e,"mealtimeyum.esp")) ;Breton Hors d'Oeuvres
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00032514,"mealtimeyum.esp")) ;Mudcrab Cake
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00032516,"mealtimeyum.esp")) ;Mudcrab Cakes
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00032519,"mealtimeyum.esp")) ;Tomato Frost Mirriam Marinara
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003251b,"mealtimeyum.esp")) ;Elves Ear Eider Pesto
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003252c,"mealtimeyum.esp")) ;Wilderness Poutine
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00035419,"mealtimeyum.esp")) ;Sausage Potato Coddle
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000382f2,"mealtimeyum.esp")) ;Horker Bacon Slices
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000382ec,"mealtimeyum.esp")) ;Horker Bacon
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003d41a,"mealtimeyum.esp")) ;Snowberry Jam Sandwich
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003d3f7,"mealtimeyum.esp")) ;Horker Bacon Sandwich
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003d3fd,"mealtimeyum.esp")) ;Frost Mirriam Tea Sandwich
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003d402,"mealtimeyum.esp")) ;Frost Mirriam Tea Sandwiches
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003d406,"mealtimeyum.esp")) ;Egg Salad Sandwich
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003d40c,"mealtimeyum.esp")) ;Egg Salad
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003d410,"mealtimeyum.esp")) ;Lavender Cake
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003d414,"mealtimeyum.esp")) ;Lavender Cake Slice
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0003d418,"mealtimeyum.esp")) ;Egg Salad Bowl
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0004252e,"mealtimeyum.esp")) ;Cyrodilic Pasta
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00042527,"mealtimeyum.esp")) ;Pesto Pasta
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00042529,"mealtimeyum.esp")) ;Pesto Pasta
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0004252c,"mealtimeyum.esp")) ;Cyrodilic Pasta
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00047632,"mealtimeyum.esp")) ;Jazbay Pie
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0004c737,"mealtimeyum.esp")) ;Honey Wheat Waffles
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0004c739,"mealtimeyum.esp")) ;Honey Wheat Waffle
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00051873,"mealtimeyum.esp")) ;Toasted Marshmallow Stick
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0005186d,"mealtimeyum.esp")) ;Chocolate Cream Pie
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00056979,"mealtimeyum.esp")) ;Chocolate Lava Cake
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00060b8c,"mealtimeyum.esp")) ;Dark Chocolate Snowberry Mousse Cake
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00060b82,"mealtimeyum.esp")) ;Alto Wine Mousse Cake
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00060b86,"mealtimeyum.esp")) ;Chocolate Mousse Cake
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00060b89,"mealtimeyum.esp")) ;Butterscotch Mousse Cake
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006ada6,"mealtimeyum.esp")) ;Spicy Chicken Satay Plate
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006ada8,"mealtimeyum.esp")) ;Spicy Chicken Satay
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006adac,"mealtimeyum.esp")) ;Spicy Chicken Mole
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006ff03,"mealtimeyum.esp")) ;Baked Winterhold Flambe
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006feb3,"mealtimeyum.esp")) ;Breton Meatballs
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006febb,"mealtimeyum.esp")) ;Naan Bread
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006febd,"mealtimeyum.esp")) ;Naan Bread Pile
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006fec1,"mealtimeyum.esp")) ;Goat Cheese Dip Bread Bowl
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006fec4,"mealtimeyum.esp")) ;Beef Stew Bread Bowl
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006fec7,"mealtimeyum.esp")) ;Elves Ear Chicken Fricassee
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006feca,"mealtimeyum.esp")) ;Creamed Honey
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006fecd,"mealtimeyum.esp")) ;Stuffed Baked Potato
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006fed1,"mealtimeyum.esp")) ;Spiced Apple Cobbler
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006fed4,"mealtimeyum.esp")) ;Spiced Apple Cobbler Slice
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006fed8,"mealtimeyum.esp")) ;Grapes and Ashyam Falafel
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006feda,"mealtimeyum.esp")) ;Grapes and Ashyam Falafel Plate
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0006fef3,"mealtimeyum.esp")) ;Elsweyr Delight
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0009873c,"mealtimeyum.esp")) ;Buttermilk Biscuits and Gravy
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000a2954,"mealtimeyum.esp")) ;Vegetable Plate
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000a2952,"mealtimeyum.esp")) ;Vegetable Plate
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00006596,"mealtimeyum.esp")) ;Green Casserole Dish
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00006598,"mealtimeyum.esp")) ;Mashed Potato Dish
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000065a6,"mealtimeyum.esp")) ;Mashed Potatoes
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000065a8,"mealtimeyum.esp")) ;Green Casserole
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000065ae,"mealtimeyum.esp")) ;Cheese Casserole Dish
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000065b0,"mealtimeyum.esp")) ;Cheese Casserole
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000065b2,"mealtimeyum.esp")) ;Flower Cookie Platter
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000065b8,"mealtimeyum.esp")) ;Roast Boar Platter
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000065bc,"mealtimeyum.esp")) ;Roast Boar Slice
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000065c2,"mealtimeyum.esp")) ;Bread Stuffing Dish
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000065c4,"mealtimeyum.esp")) ;Bread Stuffing
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0000f24f,"mealtimeyum.esp")) ;Roast Chicken Platter
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0001212e,"mealtimeyum.esp")) ;Plate of Boars in a Blanket
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0001211b,"mealtimeyum.esp")) ;Daedra'd Egg Plate
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0001211d,"mealtimeyum.esp")) ;Daedra'd Egg
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00012120,"mealtimeyum.esp")) ;Boar in a Blanket
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0001212a,"mealtimeyum.esp")) ;Roast Chicken Leg
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0001ade6,"mealtimeyum.esp")) ;Cream Porridge
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0001ade9,"mealtimeyum.esp")) ;Cream Porridge Bowl
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0001adeb,"mealtimeyum.esp")) ;Potato Pancakes
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000036c9,"mealtimeyum.esp")) ;Jellied Fish
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0001dcc8,"mealtimeyum.esp")) ;Corned Beef Plate
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0001dccb,"mealtimeyum.esp")) ;Corned Beef Slice
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00020ba0,"mealtimeyum.esp")) ;Eslweyr Rarebit
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00020b9a,"mealtimeyum.esp")) ;Candied Ash Yams
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00020b9c,"mealtimeyum.esp")) ;Candied Ash Yam Plate
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00023a96,"mealtimeyum.esp")) ;Yellow Chicken Curry
				_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00023a99,"mealtimeyum.esp")) ;Yellow Chicken Curry Bowl
				;Heavy Food
				_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x0003252f,"mealtimeyum.esp")) ;Vegetable Plate
				_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x0003541e,"mealtimeyum.esp")) ;Sausage Potato Coddle Plate
				_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x0006ad9b,"mealtimeyum.esp")) ;Chicken Pot Pie
				_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x000065aa,"mealtimeyum.esp")) ;Chili Con Carne Pot
				_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x000065ac,"mealtimeyum.esp")) ;Chili Con Carne
				_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00023a91,"mealtimeyum.esp")) ;Gourmet's Potage le Magnifique
				_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00023a94,"mealtimeyum.esp")) ;Gourmet's Potage le Magnifique Bowl
				;Soup Food
				_SHSoupList.AddForm(Game.GetFormFromFile(0x00023a9b,"mealtimeyum.esp")) ;Frothy Snowberry Soup
				_SHSoupList.AddForm(Game.GetFormFromFile(0x00023a9e,"mealtimeyum.esp")) ;Frothy Snowberry Soup Bowl
				_SHSoupList.AddForm(Game.GetFormFromFile(0x0006fedd,"mealtimeyum.esp")) ;Spicy Chicken Gumbo
				_SHSoupList.AddForm(Game.GetFormFromFile(0x0006fedf,"mealtimeyum.esp")) ;Spicy Chicken Gumbo Bowl
				_SHSoupList.AddForm(Game.GetFormFromFile(0x0001dcce,"mealtimeyum.esp")) ;Eslweyr Fondue Bowl
				;Raw Food
				;Alcohol
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0004c740,"mealtimeyum.esp")) ;Black-Briar Mead Goblet

				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00051844,"mealtimeyum.esp")) ;Mead with Juniper Berry
				_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x00051844,"mealtimeyum.esp")) ;Mead with Juniper Berry
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00051846,"mealtimeyum.esp")) ;Dragon's Breath Mead Goblet
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00051848,"mealtimeyum.esp")) ;Black-Briar Reserve Goblet
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005184a,"mealtimeyum.esp")) ;Honningbrew Mead Goblet
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005184c,"mealtimeyum.esp")) ;Nord Mead Goblet
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00051853,"mealtimeyum.esp")) ;Ashfire Mead Goblet
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00051856,"mealtimeyum.esp")) ;Stros M'Kai Rum Goblet
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00051858,"mealtimeyum.esp")) ;Spiced Wine Goblet
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005185a,"mealtimeyum.esp")) ;Alto Wine Goblet
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005185c,"mealtimeyum.esp")) ;Wine Goblet
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005185e,"mealtimeyum.esp")) ;Brandy Goblet
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00051865,"mealtimeyum.esp")) ;Ale Goblet
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00051867,"mealtimeyum.esp")) ;Argonian Ale Goblet
				_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0005ba7e,"mealtimeyum.esp")) ;Firebrand Wine Goblet
				;Water
				_SHDrinkList.AddForm(Game.GetFormFromFile(0x000036cb,"mealtimeyum.esp")) ;Egg Nog
				_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x000036cb,"mealtimeyum.esp"))
				_SHDrinkList.AddForm(Game.GetFormFromFile(0x0000659c,"mealtimeyum.esp")) ;Mulled Cider
				_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x0000659c,"mealtimeyum.esp"))
				_SHDrinkList.AddForm(Game.GetFormFromFile(0x000065b4,"mealtimeyum.esp")) ;Nordic Hot Cocoa
				_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x000065b4,"mealtimeyum.esp"))
				_SHDrinkList.AddForm(Game.GetFormFromFile(0x00023a6d,"mealtimeyum.esp")) ;Warm Honeyed Milk
				_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00023a6d,"mealtimeyum.esp"))
			endif
			return true
		endif
		return false
endfunction

;Return is true for installed, false for not
bool Function Hunterborn()

	Form oxheart = Game.GetFormFromFile(0x00012C6B, "Hunterborn.esp")
	If oxheart
        If !HunterbornInstalled          
			
			;Drink list items
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0000B504, "Hunterborn.esp"))  ;Strange brew
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x0000B504, "Hunterborn.esp"))  ;Strange brew

			;Light items
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00014226, "Hunterborn.esp"))	;edible flower
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00014228, "Hunterborn.esp"))	;edible insect
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001422A, "Hunterborn.esp"))	;edible mushroom
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x002A1197, "Hunterborn.esp"))	;edible mushroom2
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x002A1199, "Hunterborn.esp"))	;edible mushroom3
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000F2794, "Hunterborn.esp")) 	;sausagedrat			
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001422C, "Hunterborn.esp"))	;edible root			
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001422E, "Hunterborn.esp"))	;edible berry
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000314CC, "Hunterborn.esp"))	;chaurus chops
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0009C5C9, "Hunterborn.esp"))	;petcarrot					
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000C4E31, "Hunterborn.esp"))	;edibleberry
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000ED676, "Hunterborn.esp"))	;morthalmudders
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000ED678, "Hunterborn.esp"))	;oceanskiss
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00014796, "Hunterborn.esp"))		;Raw skeever
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00014798, "Hunterborn.esp"))		;Raw fox
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001479A, "Hunterborn.esp"))		;Raw goat
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001479C, "Hunterborn.esp"))		;Raw wolf
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000147A2, "Hunterborn.esp"))		;Raw rabbit
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00014D22, "Hunterborn.esp"))		;raw mudcrab
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00014D24, "Hunterborn.esp"))		;raw slaughterfish
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00012C6C, "Hunterborn.esp"))		;horse heart
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00027783, "Hunterborn.esp"))		;raw chaurus
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00029846, "Hunterborn.esp"))		;raw spider
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0011AFC8, "Hunterborn.esp"))		;petchickenarctic
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0009C5CF, "Hunterborn.esp"))		;
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0009C5D7, "Hunterborn.esp"))		;
			
			;Medium items
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E47, "Hunterborn.esp"))	;dragon stuffed rabbit
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E49, "Hunterborn.esp"))	;hot honey horker
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E4B, "Hunterborn.esp"))	;mari mammoth elsweyr
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E4D, "Hunterborn.esp"))	;boiled mudcrab
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E4F, "Hunterborn.esp"))	;mudcrab egg
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E51, "Hunterborn.esp"))	;skewered skeever
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E53, "Hunterborn.esp"))	;velvet slaughter
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E55, "Hunterborn.esp"))	;sweet wolf
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E1F, "Hunterborn.esp"))	;seared fox
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E21, "Hunterborn.esp"))	;seared rabbit
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0022776B, "Hunterborn.esp"))	;seared mammoth
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E1B, "Hunterborn.esp"))	;venison jerky			
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E1D, "Hunterborn.esp"))	;horse jerky
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E2F, "Hunterborn.esp"))	;fox herb cutlet
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E3F, "Hunterborn.esp"))	;minced mari bear			
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E43, "Hunterborn.esp"))	;elf ear elk
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000F278D, "Hunterborn.esp"))	;skeeverscramble
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000F278F, "Hunterborn.esp"))	;bearbeer
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000314C4, "Hunterborn.esp"))	;spider fry
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000314C5, "Hunterborn.esp"))	;boiled spider paste
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00055772, "Hunterborn.esp"))	;watermelon
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000314CD, "Hunterborn.esp"))	;troll jerky	
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000F2787, "Hunterborn.esp"))	;mammothballs
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000F2783, "Hunterborn.esp"))	;mashedtroll
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000ED670, "Hunterborn.esp"))	;goatloin
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000ED672, "Hunterborn.esp"))	;spotteddog
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000E8564, "Hunterborn.esp"))	;salmonbake						
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000ED674, "Hunterborn.esp"))	;fishcrabsauce			
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000ED67E, "Hunterborn.esp"))	;deviledchaurus
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x002A1194, "Hunterborn.esp"))	;boiled mushrooms
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00014795, "Hunterborn.esp"))		;Raw bear
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0001479E, "Hunterborn.esp"))		;Raw mammoth
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000147A0, "Hunterborn.esp"))		;Raw sabre
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00014D21, "Hunterborn.esp"))		;venison elk
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00029847, "Hunterborn.esp"))		;raw troll
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00029849, "Hunterborn.esp"))		;raw dragon

			;Heavy items
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E31, "Hunterborn.esp"))	;mullwine braised mammoth
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E33, "Hunterborn.esp"))	;sabre pot roast
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E35, "Hunterborn.esp"))	;elk steak
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E37, "Hunterborn.esp"))	;goat haunch
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E39, "Hunterborn.esp"))	;wolf haunch
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E23, "Hunterborn.esp"))	;mutt chop
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E25, "Hunterborn.esp"))	;ale braised saber
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E27, "Hunterborn.esp"))	;wolf chop snowberry
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E29, "Hunterborn.esp"))	;mead braised bear
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E2B, "Hunterborn.esp"))	;venison tenderloin

			Utility.Wait(0.5)

			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E2D, "Hunterborn.esp"))	;breaded elk
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E3B, "Hunterborn.esp"))	;smoked elf roast
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00017E3D, "Hunterborn.esp"))	;honey mammoth roast
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00029DBA, "Hunterborn.esp"))	;charred troll
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00029DBC, "Hunterborn.esp"))	;dragon steak
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x000314D7, "Hunterborn.esp"))	;wyrm and chips
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00029854, "Hunterborn.esp"))	;chaurus pie
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x000ED680, "Hunterborn.esp"))	;fattyfinfry
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x000ED67A, "Hunterborn.esp"))	;farmersbreak
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00078EAD, "Hunterborn.esp"))	;roastboar

			;Raw items
			_SHRawList.AddForm(Game.GetFormFromFile(0x00014795, "Hunterborn.esp"))		;Raw bear
			_SHRawList.AddForm(Game.GetFormFromFile(0x00014796, "Hunterborn.esp"))		;Raw skeever
			_SHRawList.AddForm(Game.GetFormFromFile(0x00014798, "Hunterborn.esp"))		;Raw fox
			_SHRawList.AddForm(Game.GetFormFromFile(0x0001479A, "Hunterborn.esp"))		;Raw goat
			_SHRawList.AddForm(Game.GetFormFromFile(0x0001479C, "Hunterborn.esp"))		;Raw wolf
			_SHRawList.AddForm(Game.GetFormFromFile(0x0001479E, "Hunterborn.esp"))		;Raw mammoth
			_SHRawList.AddForm(Game.GetFormFromFile(0x000147A0, "Hunterborn.esp"))		;Raw sabre
			_SHRawList.AddForm(Game.GetFormFromFile(0x000147A2, "Hunterborn.esp"))		;Raw rabbit
			_SHRawList.AddForm(Game.GetFormFromFile(0x00014D21, "Hunterborn.esp"))		;venison elk
			_SHRawList.AddForm(Game.GetFormFromFile(0x00014D22, "Hunterborn.esp"))		;raw mudcrab
			_SHRawList.AddForm(Game.GetFormFromFile(0x00014D24, "Hunterborn.esp"))		;raw slaughterfish
			_SHRawList.AddForm(Game.GetFormFromFile(0x00012C6C, "Hunterborn.esp"))		;horse heart
			_SHRawList.AddForm(Game.GetFormFromFile(0x00027783, "Hunterborn.esp"))		;raw chaurus
			_SHRawList.AddForm(Game.GetFormFromFile(0x00029846, "Hunterborn.esp"))		;raw spider
			_SHRawList.AddForm(Game.GetFormFromFile(0x00029847, "Hunterborn.esp"))		;raw troll
			_SHRawList.AddForm(Game.GetFormFromFile(0x00029849, "Hunterborn.esp"))		;raw dragon
			_SHRawList.AddForm(Game.GetFormFromFile(0x0011AFC8, "Hunterborn.esp"))		;petchickenarctic
			_SHRawList.AddForm(Game.GetFormFromFile(0x0009C5CF, "Hunterborn.esp"))		;
			_SHRawList.AddForm(Game.GetFormFromFile(0x0009C5D7, "Hunterborn.esp"))		;
			_SHRawList.AddForm(oxheart)	

			;Soups
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00017E08, "Hunterborn.esp"))		;bear carrot stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00017E09, "Hunterborn.esp"))		;hunters stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00017E0B, "Hunterborn.esp"))		;fox apple stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00017E0D, "Hunterborn.esp"))		;spiced diced goat
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00017E0F, "Hunterborn.esp"))		;rabbit mushroom stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00017E11, "Hunterborn.esp"))		;mammoth tomato stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00017E13, "Hunterborn.esp"))		;mudcrab chowder
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00017E15, "Hunterborn.esp"))		;salty sabred stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00017E17, "Hunterborn.esp"))		;skeevender stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00017E19, "Hunterborn.esp"))		;wolf cabbage stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000ED667, "Hunterborn.esp"))		;highkingsstew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000ED66A, "Hunterborn.esp"))		;rarebit
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000ED66C, "Hunterborn.esp"))		;beggarbroth
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000ED66E, "Hunterborn.esp"))		;spidersurprise
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00029DB9, "Hunterborn.esp"))		;spider soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00017E41, "Hunterborn.esp"))		;root bear
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00017E45, "Hunterborn.esp"))		;goat and potatoes
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000314C9, "Hunterborn.esp"))		;poisoners soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000314D1, "Hunterborn.esp"))		;dragon heart stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000314D4, "Hunterborn.esp"))		;dragon blood pudding
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00031A49, "Hunterborn.esp"))		;carrot pot dragon
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00078EA9, "Hunterborn.esp"))		;boarpotatostew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00078EAB, "Hunterborn.esp"))		;boarleakstew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000ED67C, "Hunterborn.esp"))		;woolcoat
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0007DFB3, "Hunterborn.esp"))		;watermelongazpacho
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000F2791, "Hunterborn.esp"))		;reachmensoup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000F2789, "Hunterborn.esp"))		;foxhole

			Utility.Wait(0.5)

			_SHSoupList.AddForm(Game.GetFormFromFile(0x000F278B, "Hunterborn.esp"))		;predatorsprice
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000F2785, "Hunterborn.esp"))		;flamingdragon
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0028CD04, "Hunterborn.esp"))		;Soupvege
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0028CD16, "Hunterborn.esp"))		;Soup Mixed
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0028CD16, "Hunterborn.esp"))		;Soup Mixed
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0028CD1A, "Hunterborn.esp"))		;Soup seasoned
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0028CD1C, "Hunterborn.esp"))		;Soup mixed meat
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0028CD1E, "Hunterborn.esp"))		;Soup mixed seasoned
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0028CD20, "Hunterborn.esp"))		;Soup mixed meat seasoned
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0028CD22, "Hunterborn.esp"))		;Soup meat seasoned
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C053, "Hunterborn.esp"))		;Stew vege
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C055, "Hunterborn.esp"))		;Stew mixed
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C057, "Hunterborn.esp"))		;Stew meat
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C059, "Hunterborn.esp"))		;Stew Seasoned
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C05B, "Hunterborn.esp"))		;Stew mixed meat
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C05D, "Hunterborn.esp"))		;Stew mixed seasoned
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C05F, "Hunterborn.esp"))		;Stew mixed meat seasoned
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C061, "Hunterborn.esp"))		;Stew meat seasoned
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C063, "Hunterborn.esp"))		;Stew meat vege
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C067, "Hunterborn.esp"))		;Stew meat vege
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C065, "Hunterborn.esp"))		;Stew meat vege seasoned	
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C069, "Hunterborn.esp"))		;Stew meat vege seasoned
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C06B, "Hunterborn.esp"))		;Stew Meat Mushroom
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C06D, "Hunterborn.esp"))		;Soup meat seasoned mushroom
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C06F, "Hunterborn.esp"))		;Soup meat vege mushroom
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C071, "Hunterborn.esp"))		;Soup meat vege seasoned mushroom
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C073, "Hunterborn.esp"))		;Soup mixed mushroom
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C075, "Hunterborn.esp"))		;Soup mixed meat mushroom
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C077, "Hunterborn.esp"))		;Soup mixed meat seasoned mushroom
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C079, "Hunterborn.esp"))		;Soup mixed seaseoned mushroom
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C07B, "Hunterborn.esp"))		;Soup vege mushroom
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C07D, "Hunterborn.esp"))		;Soup seasoned mushroom
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C07F, "Hunterborn.esp"))		;Stew Meat Mush
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C081, "Hunterborn.esp"))		;Stew meat seasoned mush
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C083, "Hunterborn.esp"))		;
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C085, "Hunterborn.esp"))		;
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C087, "Hunterborn.esp"))		;
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C089, "Hunterborn.esp"))		;
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C08B, "Hunterborn.esp"))		;
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C08D, "Hunterborn.esp"))		;
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C08F, "Hunterborn.esp"))		;
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0029C091, "Hunterborn.esp"))		;
		
			;Drink list
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x0003FD68, "Hunterborn.esp"))	;ten dragon tea
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x0003FD68, "Hunterborn.esp"))
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x000402D7, "Hunterborn.esp"))	;juniper tea
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x000402D7, "Hunterborn.esp"))
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x000402DA, "Hunterborn.esp"))	;lavender tea
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x000402DA, "Hunterborn.esp"))
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x000402DC, "Hunterborn.esp"))	;mt flower tea
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x000402DC, "Hunterborn.esp"))
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x000402DE, "Hunterborn.esp"))	;moon dance tea
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x000402DE, "Hunterborn.esp"))
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x000402E0, "Hunterborn.esp"))	;nirn spring tea
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x000402E0, "Hunterborn.esp"))
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x000402E2, "Hunterborn.esp"))	;snowberry tea
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x000402E2, "Hunterborn.esp"))
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x000402E4, "Hunterborn.esp"))	;wheat boon tea
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x000402E4, "Hunterborn.esp"))
			
			Utility.Wait(0.5)
		EndIf
		return True
	Else
		return False
	EndIf

endfunction


bool Function CookingInSkyrim()

	form trout = Game.GetFormFromFile(0x000F1EE, "Cooking_In_Skyrim.esp")
	if trout
		if !CookingInSkyrimInstalled

			;raw
			_SHRawList.AddForm(trout)	;raw trout
			_SHRawList.AddForm(Game.GetFormFromFile(0x00061015, "Cooking_In_Skyrim.esp"))	;Raw slaughterfish

			;light
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001AD19, "Cooking_In_Skyrim.esp"))		;Pear
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0001DBE3, "Cooking_In_Skyrim.esp"))		;Lemon
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00020AAD, "Cooking_In_Skyrim.esp"))		;Onion
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00020AB3, "Cooking_In_Skyrim.esp"))		;Turnip
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0002397F, "Cooking_In_Skyrim.esp"))		;Fig
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00023983, "Cooking_In_Skyrim.esp"))		;Pepper
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00023985, "Cooking_In_Skyrim.esp"))		;Radiccio
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x000E22F1, "Cooking_In_Skyrim.esp"))		;Cheese Dumpling
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0016AE3A, "Cooking_In_Skyrim.esp"))		;Blackberry

			;medium
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00017E4F, "Cooking_In_Skyrim.esp"))		;Grilled trout
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00078665, "Cooking_In_Skyrim.esp"))		;Eggs with tomatoes
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0007866B, "Cooking_In_Skyrim.esp"))		;Garlic potatoes
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00078670, "Cooking_In_Skyrim.esp"))		;Potato Casserole
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0007B540, "Cooking_In_Skyrim.esp"))		;Cabbage Salad
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000841B6, "Cooking_In_Skyrim.esp"))		;Salmon Apple Salad
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0008708A, "Cooking_In_Skyrim.esp"))		;Chicken Salad
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00087093, "Cooking_In_Skyrim.esp"))		;Garlic clams
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00087096, "Cooking_In_Skyrim.esp"))		;Baked vegetable eggs
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000870A5, "Cooking_In_Skyrim.esp"))		;Ash Yam Salad
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000870A8, "Cooking_In_Skyrim.esp"))		;Fig radicchio salad
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000870AB, "Cooking_In_Skyrim.esp"))		;radicchio salad
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000870AE, "Cooking_In_Skyrim.esp"))		;Roasted turnips
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000E22F4, "Cooking_In_Skyrim.esp"))		;Fig Pie
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000E22F7, "Cooking_In_Skyrim.esp"))		;Gourd Pie
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000E22FA, "Cooking_In_Skyrim.esp"))		;Meat Pie
			

			;heavy
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x0007E41D, "Cooking_In_Skyrim.esp"))	;Braised Venison

			;Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00075796, "Cooking_In_Skyrim.esp"))	;Chicken soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0007B53C, "Cooking_In_Skyrim.esp"))	;Rabbit stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0007B544, "Cooking_In_Skyrim.esp"))	;Salmon Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0007B549, "Cooking_In_Skyrim.esp"))	;Carrot Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0007B54D, "Cooking_In_Skyrim.esp"))	;Pheasant Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0007E418, "Cooking_In_Skyrim.esp"))	;Goat Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000812EB, "Cooking_In_Skyrim.esp"))	;Potato Mushroom Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000841B8, "Cooking_In_Skyrim.esp"))	;Creamy Mushroom Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000841BC, "Cooking_In_Skyrim.esp"))	;Mudcrab soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000841BE, "Cooking_In_Skyrim.esp"))	;Valenwood Fondue
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000728CB, "Cooking_In_Skyrim.esp"))	;Apple and pear compote
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0008708D, "Cooking_In_Skyrim.esp"))	;Fish Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00087090, "Cooking_In_Skyrim.esp"))	;Cheese Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00087099, "Cooking_In_Skyrim.esp"))	;Ash Hopper Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0008709C, "Cooking_In_Skyrim.esp"))	;Ash Yam Boar Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0008709F, "Cooking_In_Skyrim.esp"))	;Creamy Fish Chowder
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000870A2, "Cooking_In_Skyrim.esp"))	;Trout Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000DD1E5, "Cooking_In_Skyrim.esp"))	;Ash Yam Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000DD1EA, "Cooking_In_Skyrim.esp"))	;Solstheim Fondue
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0016AE3A, "Cooking_In_Skyrim.esp"))	;Ashlands Fondue
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000812E9, "Cooking_In_Skyrim.esp"))	;Borscht	

			Utility.Wait(0.5)

		endif
		return True
	else
		return false
	endif

endfunction

bool Function CuttingRoomFloor()

	form frostMead = Game.GetFormFromFile(0x00037108, "Cutting Room Floor.esp")

	If (frostMead)
		If (!CuttingRoomFloorInstalled)
			
			_SHAlcoholList.AddForm(frostMead)
			_SHMeadBottleList.AddForm(frostMead)

		EndIf
		return true
	else
		return false
	EndIf

endfunction

bool Function CACO()


	form porkJerky = Game.GetFormFromFile(0x0099e786,"Complete Alchemy & Cooking Overhaul.esp")
	
	If (porkJerky)
		If (!CACOInstalled)
			;Light Food
			_SHFoodLightList.AddForm(porkJerky) ;Pork Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01CCA123,"Update.esm")) ;Dough
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01CCA129,"Update.esm")) ;Onion
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01CCA151,"Update.esm")) ;Blueberries
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01CCA152,"Update.esm")) ;Peas
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01CCA153,"Update.esm")) ;Scrib Cabbage
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01CCA154,"Update.esm")) ;Turnip
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01CCA129,"Update.esm")) ;Seasoning
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x01CCA120,"Update.esm")) ;Sugar
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00a10116,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acf2,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acf4,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acf6,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acf8,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0054e48a,"Complete Alchemy & Cooking Overhaul.esp")) ;Apple Pie Slice
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0054e497,"Complete Alchemy & Cooking Overhaul.esp")) ;Chaurus Dumpling
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005b8c29,"Complete Alchemy & Cooking Overhaul.esp")) ;Marinade
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x004cf8c1,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Carrots
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023c9,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023cb,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023cd,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023cf,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023d1,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023d3,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023d5,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023d7,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023d9,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023db,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023dd,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023df,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023e1,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023e3,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023e5,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023e7,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023e9,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023ea,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x005023ed,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Wheat Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00511764,"Complete Alchemy & Cooking Overhaul.esp")) ;Cabbage Half
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0051686d,"Complete Alchemy & Cooking Overhaul.esp")) ;Venison Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00516870,"Complete Alchemy & Cooking Overhaul.esp")) ;Mammoth Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00516872,"Complete Alchemy & Cooking Overhaul.esp")) ;Sabre Cat Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00516874,"Complete Alchemy & Cooking Overhaul.esp")) ;Bear Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00516876,"Complete Alchemy & Cooking Overhaul.esp")) ;Boar Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00516878,"Complete Alchemy & Cooking Overhaul.esp")) ;Chicken Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00516879,"Complete Alchemy & Cooking Overhaul.esp")) ;Goat Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0051687b,"Complete Alchemy & Cooking Overhaul.esp")) ;Hominid Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0051687d,"Complete Alchemy & Cooking Overhaul.esp")) ;Horker Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00516880,"Complete Alchemy & Cooking Overhaul.esp")) ;Horse Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00516881,"Complete Alchemy & Cooking Overhaul.esp")) ;Salmon Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00516883,"Complete Alchemy & Cooking Overhaul.esp")) ;Skeever Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00516886,"Complete Alchemy & Cooking Overhaul.esp")) ;Troll Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acd4,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acd6,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acd8,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acda,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acdc,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acde,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052ace0,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052ace2,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052ace4,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052ace6,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052ace8,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acea,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acec,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acee,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0052acf0,"Complete Alchemy & Cooking Overhaul.esp")) ;Sack of Barley Flour
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x002b18d4,"Complete Alchemy & Cooking Overhaul.esp")) ;Sweet Cheese Pudding
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00220106,"Complete Alchemy & Cooking Overhaul.esp")) ;Grilled Mora Tapinella
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0022011e,"Complete Alchemy & Cooking Overhaul.esp")) ;Grilled Scaly Pholiota
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00220120,"Complete Alchemy & Cooking Overhaul.esp")) ;Snowberry Jam
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00220122,"Complete Alchemy & Cooking Overhaul.esp")) ;Jazbay Jam
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00220146,"Complete Alchemy & Cooking Overhaul.esp")) ;Grilled Briar Heart
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x0022000b,"Complete Alchemy & Cooking Overhaul.esp")) ;Mushroom and Cheese Quiche
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00220027,"Complete Alchemy & Cooking Overhaul.esp")) ;Beef Jerky
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x002200a2,"Complete Alchemy & Cooking Overhaul.esp")) ;Hard Boiled Egg
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x002200a6,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Clam
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00200309,"Complete Alchemy & Cooking Overhaul.esp")) ;Snowberry Tart
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x001fb175,"Complete Alchemy & Cooking Overhaul.esp")) ;Rorikstead Cheese
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x001fb177,"Complete Alchemy & Cooking Overhaul.esp")) ;Ivarstead Cheese
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x001fb179,"Complete Alchemy & Cooking Overhaul.esp")) ;Haafingar Cheese
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x001fb17b,"Complete Alchemy & Cooking Overhaul.esp")) ;Rorikstead Cheese Wheel
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x001fb17d,"Complete Alchemy & Cooking Overhaul.esp")) ;Ivarstead Cheese Wheel
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x001fb17f,"Complete Alchemy & Cooking Overhaul.esp")) ;Haafingar Cheese Wheel
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x001fb183,"Complete Alchemy & Cooking Overhaul.esp")) ;Rorikstead Cheese Sliced
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x001fb185,"Complete Alchemy & Cooking Overhaul.esp")) ;Ivarstead Cheese Sliced
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x001fb187,"Complete Alchemy & Cooking Overhaul.esp")) ;Haafingar Cheese Sliced
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x004b1215,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Ash Hopper Leg Meat
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x004c0579,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Ash Hopper Meat
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00190b50,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Fox Meat
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00190b58,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Slaughterfish
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00190b5e,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Tern Breast
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00190b5f,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Hawk Breast
			_SHFoodLightList.AddForm(Game.GetFormFromFile(0x00190b63,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Chaurus Meat

			Utility.Wait(0.5)

			;Medium Food
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00725695,"Complete Alchemy & Cooking Overhaul.esp")) ;Buttered Mudcrab Claw
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x01CCA150,"Update.esm")) ;Pumpkin
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0099e776,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Mutton
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0099e784,"Complete Alchemy & Cooking Overhaul.esp")) ;Cured Pork
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0099e788,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Pork Sliced
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0099e78a,"Complete Alchemy & Cooking Overhaul.esp")) ;Bacon
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0099e78c,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Ham Slices
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0099e78e,"Complete Alchemy & Cooking Overhaul.esp")) ;Cured Ham Slices
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00534f23,"Complete Alchemy & Cooking Overhaul.esp")) ;Baked Yam
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0054425d,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Boar Sliced
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0054426c,"Complete Alchemy & Cooking Overhaul.esp")) ;Cured Boar Slices
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0054e4a3,"Complete Alchemy & Cooking Overhaul.esp")) ;Marinated Chicken Breast
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0054e4a6,"Complete Alchemy & Cooking Overhaul.esp")) ;Marinated Fox
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0054e4a8,"Complete Alchemy & Cooking Overhaul.esp")) ;Marinated Goat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0054e4aa,"Complete Alchemy & Cooking Overhaul.esp")) ;Marinated Flesh
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0054e4ae,"Complete Alchemy & Cooking Overhaul.esp")) ;Marinated Troll Meat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x005c7f6e,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Liver
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00497c91,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Hawk
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00497c94,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Tern
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0049cdc5,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Goat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x004a6fe8,"Complete Alchemy & Cooking Overhaul.esp")) ;Pan Fried Salmon
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x004a6ffd,"Complete Alchemy & Cooking Overhaul.esp")) ;Dried Salmon
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x004b631f,"Complete Alchemy & Cooking Overhaul.esp")) ;Honey Wheat Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x004b6322,"Complete Alchemy & Cooking Overhaul.esp")) ;Potato Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x004b6325,"Complete Alchemy & Cooking Overhaul.esp")) ;Wheat Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x004b6328,"Complete Alchemy & Cooking Overhaul.esp")) ;Dark Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x004c057d,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Ash Hopper Meat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x004c569b,"Complete Alchemy & Cooking Overhaul.esp")) ;Barley Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x004c569d,"Complete Alchemy & Cooking Overhaul.esp")) ;Barley Nut Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x004d9ae6,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Boar Slices
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0050c65d,"Complete Alchemy & Cooking Overhaul.esp")) ;Baked Potatoes
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00220108,"Complete Alchemy & Cooking Overhaul.esp")) ;Steamed Mudcrab Claw
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00220127,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Ash Hopper Leg Meat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0022013e,"Complete Alchemy & Cooking Overhaul.esp")) ;Grilled Clams
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00220142,"Complete Alchemy & Cooking Overhaul.esp")) ;Roast Beef
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00220143,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Venison
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00220009,"Complete Alchemy & Cooking Overhaul.esp")) ;Glenpoint Savory Pie
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0022000c,"Complete Alchemy & Cooking Overhaul.esp")) ;Gravlax
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00220026,"Complete Alchemy & Cooking Overhaul.esp")) ;Mashed Potatoes
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0022002b,"Complete Alchemy & Cooking Overhaul.esp")) ;Roasted Heart
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00220048,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Skeever Tail
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x002200cb,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Yam
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x002002ad,"Complete Alchemy & Cooking Overhaul.esp")) ;Boar Bacon
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x002002cd,"Complete Alchemy & Cooking Overhaul.esp")) ;Beef Sausage
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x002002d1,"Complete Alchemy & Cooking Overhaul.esp")) ;Chicken Sausage
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0020540e,"Complete Alchemy & Cooking Overhaul.esp")) ;Honey Wheat Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0020a518,"Complete Alchemy & Cooking Overhaul.esp")) ;Cured Meat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0020a519,"Complete Alchemy & Cooking Overhaul.esp")) ;Cured Meat Slices
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00220001,"Complete Alchemy & Cooking Overhaul.esp")) ;Beer Battered Slaughterfish
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00220004,"Complete Alchemy & Cooking Overhaul.esp")) ;Snowberry Pie
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00195c73,"Complete Alchemy & Cooking Overhaul.esp")) ;Roasted Flesh
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x001fb15e,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Fox Meat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x001fb199,"Complete Alchemy & Cooking Overhaul.esp")) ;Dark Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x001fb19d,"Complete Alchemy & Cooking Overhaul.esp")) ;Barley Nut Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x001fb19f,"Complete Alchemy & Cooking Overhaul.esp")) ;Barley Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x001fb1a1,"Complete Alchemy & Cooking Overhaul.esp")) ;Wheat Bread
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0048da5a,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Troll Meat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0048da62,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Meat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0048da65,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Bear Steak
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0048da6d,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Beef Steak
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00492b79,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Troll Steak
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00492b7a,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Venison Steak
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00492b7c,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Mammoth Snout Steak
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00492b83,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Hominid Meat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0049cdac,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Mammoth Steak
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0049cdb1,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Horse Steak
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0049cdbc,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Horker Loaf
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x0049cdc7,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Goat Meat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x004a1ed3,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Sabre Cat Steak
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00190b53,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Sabre Cat Meat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00190b54,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Bear Meat
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00190b56,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Mammoth Meat
			

			Utility.Wait(0.5)

			;Heavy Food
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00725696,"Complete Alchemy & Cooking Overhaul.esp")) ;Buttered Mudcrab Legs
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x0054e4a4,"Complete Alchemy & Cooking Overhaul.esp")) ;Marinated Bear Steak
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x0054e4ac,"Complete Alchemy & Cooking Overhaul.esp")) ;Marinated Sabre Cat Steak
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x005b8c2c,"Complete Alchemy & Cooking Overhaul.esp")) ;Marinated Beef Steak
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x0048da60,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Troll Meat
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x0049cdb5,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Horse Steak
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x004a6ff8,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Canine Rack
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x004c0572,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Chaurus Meat
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x002b18cd,"Complete Alchemy & Cooking Overhaul.esp")) ;Slow Cooked Pork
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00220008,"Complete Alchemy & Cooking Overhaul.esp")) ;Beef Stroganius
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00190b55,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Bear Steak
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00190b57,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Mammoth Steak
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00195c75,"Complete Alchemy & Cooking Overhaul.esp")) ;Cooked Sabre Cat Steak
			;Soup Food
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0099e778,"Complete Alchemy & Cooking Overhaul.esp")) ;Mutton Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0099e796,"Complete Alchemy & Cooking Overhaul.esp")) ;Pork and Vegetable Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x009a89ce,"Complete Alchemy & Cooking Overhaul.esp")) ;Pea Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x009fec40,"Complete Alchemy & Cooking Overhaul.esp")) ;Barley Porridge
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00a1011c,"Complete Alchemy & Cooking Overhaul.esp")) ;Chicken Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00a1011d,"Complete Alchemy & Cooking Overhaul.esp")) ;Vegetable Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00a1014a,"Complete Alchemy & Cooking Overhaul.esp")) ;Fire Hopper Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0052ad03,"Complete Alchemy & Cooking Overhaul.esp")) ;Human Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00534f1a,"Complete Alchemy & Cooking Overhaul.esp")) ;Bear Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00534f1d,"Complete Alchemy & Cooking Overhaul.esp")) ;Mammoth Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00534f20,"Complete Alchemy & Cooking Overhaul.esp")) ;Trollmeat Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x005c2e48,"Complete Alchemy & Cooking Overhaul.esp")) ;Saltrice Porridge
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18a4,"Complete Alchemy & Cooking Overhaul.esp")) ;Chicken and Vegetable Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18ca,"Complete Alchemy & Cooking Overhaul.esp")) ;Salmon and Potato Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18cb,"Complete Alchemy & Cooking Overhaul.esp")) ;Seafood Medley Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18cc,"Complete Alchemy & Cooking Overhaul.esp")) ;Pulled Pork Ragout
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18ce,"Complete Alchemy & Cooking Overhaul.esp")) ;Boar and Vegetable Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18cf,"Complete Alchemy & Cooking Overhaul.esp")) ;Sabre Cat Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18d0,"Complete Alchemy & Cooking Overhaul.esp")) ;Ham and Vegetable Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18d1,"Complete Alchemy & Cooking Overhaul.esp")) ;Squash and Bacon Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18d2,"Complete Alchemy & Cooking Overhaul.esp")) ;Meat Ball Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18d5,"Complete Alchemy & Cooking Overhaul.esp")) ;Beef and Mushroom Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18d6,"Complete Alchemy & Cooking Overhaul.esp")) ;Chicken Mushroom Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18d7,"Complete Alchemy & Cooking Overhaul.esp")) ;Slaughterfish Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18d8,"Complete Alchemy & Cooking Overhaul.esp")) ;Squash Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18d9,"Complete Alchemy & Cooking Overhaul.esp")) ;Beef and Vegetable Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18da,"Complete Alchemy & Cooking Overhaul.esp")) ;Beef and Egg Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18db,"Complete Alchemy & Cooking Overhaul.esp")) ;Creamy Leek Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18dc,"Complete Alchemy & Cooking Overhaul.esp")) ;Savory Chicken Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18dd,"Complete Alchemy & Cooking Overhaul.esp")) ;Salmon Cream Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18de,"Complete Alchemy & Cooking Overhaul.esp")) ;Savory Salmon Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18df,"Complete Alchemy & Cooking Overhaul.esp")) ;Beef and Egg Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002b18e0,"Complete Alchemy & Cooking Overhaul.esp")) ;Bacon Cheese Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00220118,"Complete Alchemy & Cooking Overhaul.esp")) ;Potage le Magnifique
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00220147,"Complete Alchemy & Cooking Overhaul.esp")) ;Reachman's Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00220073,"Complete Alchemy & Cooking Overhaul.esp")) ;Rabbit Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00220098,"Complete Alchemy & Cooking Overhaul.esp")) ;Bread Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00220099,"Complete Alchemy & Cooking Overhaul.esp")) ;Mushroom Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0022009a,"Complete Alchemy & Cooking Overhaul.esp")) ;Mammoth Fondue
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0022009b,"Complete Alchemy & Cooking Overhaul.esp")) ;Pheasant Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0022009e,"Complete Alchemy & Cooking Overhaul.esp")) ;Chicken Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x0022009f,"Complete Alchemy & Cooking Overhaul.esp")) ;Dogmeat Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002200a0,"Complete Alchemy & Cooking Overhaul.esp")) ;Equine Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002200a1,"Complete Alchemy & Cooking Overhaul.esp")) ;Rabbit Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002200a5,"Complete Alchemy & Cooking Overhaul.esp")) ;Goat Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002200c9,"Complete Alchemy & Cooking Overhaul.esp")) ;Ash Hopper Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002200ca,"Complete Alchemy & Cooking Overhaul.esp")) ;Yam Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002200da,"Complete Alchemy & Cooking Overhaul.esp")) ;Beef Cabbage Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x002200dd,"Complete Alchemy & Cooking Overhaul.esp")) ;Venison Vegetable Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00220000,"Complete Alchemy & Cooking Overhaul.esp")) ;Wayrest Bouillabaisse
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00220002,"Complete Alchemy & Cooking Overhaul.esp")) ;Jehannoise
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00220003,"Complete Alchemy & Cooking Overhaul.esp")) ;Haafingar Clam Chowder
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00220005,"Complete Alchemy & Cooking Overhaul.esp")) ;Coq Au Vin
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00220006,"Complete Alchemy & Cooking Overhaul.esp")) ;Soupe Au Pistou
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00190b5b,"Complete Alchemy & Cooking Overhaul.esp")) ;Woodsman Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00190b5d,"Complete Alchemy & Cooking Overhaul.esp")) ;Sabre Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x001fb15c,"Complete Alchemy & Cooking Overhaul.esp")) ;Hearty Horker Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x001fb16d,"Complete Alchemy & Cooking Overhaul.esp")) ;Squash and Onion Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x001fb173,"Complete Alchemy & Cooking Overhaul.esp")) ;Slaughterfish Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x001fb181,"Complete Alchemy & Cooking Overhaul.esp")) ;Wheat Porridge
			_SHSoupList.AddForm(Game.GetFormFromFile(0x01CCA126,"Update.esm")) ;light broth
			_SHSoupList.AddForm(Game.GetFormFromFile(0x01CCA127,"Update.esm")) ;brown broth
			_SHSoupList.AddForm(Game.GetFormFromFile(0x01CCA128,"Update.esm")) ;seafood broth

			Utility.Wait(0.5)

			;Raw Food
			_SHRawList.AddForm(Game.GetFormFromFile(0x0048da5a,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Troll Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x0048da62,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x0048da65,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Bear Steak
			_SHRawList.AddForm(Game.GetFormFromFile(0x0048da6d,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Beef Steak
			_SHRawList.AddForm(Game.GetFormFromFile(0x00492b79,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Troll Steak
			_SHRawList.AddForm(Game.GetFormFromFile(0x00492b7a,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Venison Steak
			_SHRawList.AddForm(Game.GetFormFromFile(0x00492b7c,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Mammoth Snout Steak
			_SHRawList.AddForm(Game.GetFormFromFile(0x00492b83,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Hominid Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x0049cda3,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Skeever Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x0049cdac,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Mammoth Steak
			_SHRawList.AddForm(Game.GetFormFromFile(0x0049cdb1,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Horse Steak
			_SHRawList.AddForm(Game.GetFormFromFile(0x0049cdbc,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Horker Loaf
			_SHRawList.AddForm(Game.GetFormFromFile(0x0049cdc7,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Goat Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x004a1ed3,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Sabre Cat Steak
			_SHRawList.AddForm(Game.GetFormFromFile(0x004b1215,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Ash Hopper Leg Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x004c0579,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Ash Hopper Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x00190b50,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Fox Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x00190b53,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Sabre Cat Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x00190b54,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Bear Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x00190b56,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Mammoth Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x00190b58,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Slaughterfish
			_SHRawList.AddForm(Game.GetFormFromFile(0x00190b5e,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Tern Breast
			_SHRawList.AddForm(Game.GetFormFromFile(0x00190b5f,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Hawk Breast
			_SHRawList.AddForm(Game.GetFormFromFile(0x00190b63,"Complete Alchemy & Cooking Overhaul.esp")) ;Raw Chaurus Meat
			_SHRawList.AddForm(Game.GetFormFromFile(0x01CCA147,"Update.esm")) ;Salmon
			_SHRawList.AddForm(Game.GetFormFromFile(0x01CCA148,"Update.esm")) ;Salmon
			_SHRawList.AddForm(Game.GetFormFromFile(0x01CCA130,"Update.esm")) ;Raw Human
			_SHRawList.AddForm(Game.GetFormFromFile(0x01CCA145,"Update.esm")) ;Raw Pork
			_SHRawList.AddForm(Game.GetFormFromFile(0x01CCA146,"Update.esm")) ;Raw Mutton

			Utility.Wait(0.5)
			;Alcohol
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00450dd6,"Complete Alchemy & Cooking Overhaul.esp")) ;Firebrand Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00450ddb,"Complete Alchemy & Cooking Overhaul.esp")) ;Jessica's Wine
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x00450ddb,"Complete Alchemy & Cooking Overhaul.esp")) ;Jessica's Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00450ddd,"Complete Alchemy & Cooking Overhaul.esp")) ;Jessica's Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00450ddf,"Complete Alchemy & Cooking Overhaul.esp")) ;Jessica's Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00450de4,"Complete Alchemy & Cooking Overhaul.esp")) ;Spiced Wine
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x00450de4,"Complete Alchemy & Cooking Overhaul.esp")) ;Spiced Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00450de6,"Complete Alchemy & Cooking Overhaul.esp")) ;Spiced Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00450de8,"Complete Alchemy & Cooking Overhaul.esp")) ;Spiced Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0045aff2,"Complete Alchemy & Cooking Overhaul.esp")) ;Argonian Bloodwine
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x0045aff2,"Complete Alchemy & Cooking Overhaul.esp")) ;Argonian Bloodwine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0045aff3,"Complete Alchemy & Cooking Overhaul.esp")) ;Argonian Bloodwine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0045aff6,"Complete Alchemy & Cooking Overhaul.esp")) ;Argonian Bloodwine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0045aff9,"Complete Alchemy & Cooking Overhaul.esp")) ;Surilie Brothers Wine
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x0045aff9,"Complete Alchemy & Cooking Overhaul.esp")) ;Surilie Brothers Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0045affc,"Complete Alchemy & Cooking Overhaul.esp")) ;Surilie Brothers Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0045affe,"Complete Alchemy & Cooking Overhaul.esp")) ;Surilie Brothers Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0045b00a,"Complete Alchemy & Cooking Overhaul.esp")) ;Emberbrand Wine
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x0045b00a,"Complete Alchemy & Cooking Overhaul.esp")) ;Emberbrand Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0045b00c,"Complete Alchemy & Cooking Overhaul.esp")) ;Emberbrand Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0045b00e,"Complete Alchemy & Cooking Overhaul.esp")) ;Emberbrand Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00460116,"Complete Alchemy & Cooking Overhaul.esp")) ;Flin
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00460117,"Complete Alchemy & Cooking Overhaul.esp")) ;Flin
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0046011a,"Complete Alchemy & Cooking Overhaul.esp")) ;Flin
			_SHSujammaBottleList.AddForm(Game.GetFormFromFile(0x0046011a,"Complete Alchemy & Cooking Overhaul.esp")) ;Flin
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00460124,"Complete Alchemy & Cooking Overhaul.esp")) ;Sujamma
			_SHSujammaBottleList.AddForm(Game.GetFormFromFile(0x00460124,"Complete Alchemy & Cooking Overhaul.esp")) ;Sujamma
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00460126,"Complete Alchemy & Cooking Overhaul.esp")) ;Sujamma
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00460128,"Complete Alchemy & Cooking Overhaul.esp")) ;Sujamma
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0046012a,"Complete Alchemy & Cooking Overhaul.esp")) ;Sadri's Sujamma
			_SHSujammaBottleList.AddForm(Game.GetFormFromFile(0x0046012a,"Complete Alchemy & Cooking Overhaul.esp")) ;Sadri's Sujamma
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0046012b,"Complete Alchemy & Cooking Overhaul.esp")) ;Sadri's Sujamma
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0046012e,"Complete Alchemy & Cooking Overhaul.esp")) ;Sadri's Sujamma
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0046013a,"Complete Alchemy & Cooking Overhaul.esp")) ;Shein
			_SHSujammaBottleList.AddForm(Game.GetFormFromFile(0x0046013a,"Complete Alchemy & Cooking Overhaul.esp")) ;Shein
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0046013c,"Complete Alchemy & Cooking Overhaul.esp")) ;Shein
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0046013e,"Complete Alchemy & Cooking Overhaul.esp")) ;Shein
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00460140,"Complete Alchemy & Cooking Overhaul.esp")) ;Mazte
			_SHSujammaBottleList.AddForm(Game.GetFormFromFile(0x00460140,"Complete Alchemy & Cooking Overhaul.esp")) ;Mazte
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00460142,"Complete Alchemy & Cooking Overhaul.esp")) ;Mazte
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00460144,"Complete Alchemy & Cooking Overhaul.esp")) ;Mazte
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bca1,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bca2,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bcb2,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bcb4,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bcb6,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bcb9,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bcbb,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bcbd,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bcbf,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bcc1,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy

			Utility.Wait(0.5)

			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bcc3,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bcc5,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bcc7,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bcc9,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x0044bccb,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x0044bccb,"Complete Alchemy & Cooking Overhaul.esp")) ;Colovian Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00450dd2,"Complete Alchemy & Cooking Overhaul.esp")) ;Firebrand Wine
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x00450dd2,"Complete Alchemy & Cooking Overhaul.esp")) ;Firebrand Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x00450dd4,"Complete Alchemy & Cooking Overhaul.esp")) ;Firebrand Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002ee52b,"Complete Alchemy & Cooking Overhaul.esp")) ;Village Red Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002ee52d,"Complete Alchemy & Cooking Overhaul.esp")) ;Village Red Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002ee52f,"Complete Alchemy & Cooking Overhaul.esp")) ;Village White Wine
			_SHWineBottleList.AddForm(Game.GetFormFromFile(0x002ee52f,"Complete Alchemy & Cooking Overhaul.esp")) ;Village White Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002ee531,"Complete Alchemy & Cooking Overhaul.esp")) ;Village White Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002ee533,"Complete Alchemy & Cooking Overhaul.esp")) ;Village White Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f8755,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x002f8755,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f8757,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f8758,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f875b,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f875d,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f875f,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f8761,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f8763,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f8765,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f8767,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f8769,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f876b,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f876d,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f876f,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002f8771,"Complete Alchemy & Cooking Overhaul.esp")) ;Cyrodilic Brandy
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002bbac6,"Complete Alchemy & Cooking Overhaul.esp")) ;Alto Noir Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002bbac7,"Complete Alchemy & Cooking Overhaul.esp")) ;Alto Noir Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002bbac9,"Complete Alchemy & Cooking Overhaul.esp")) ;Alto Noir Wine
			_SHWineBottleList.AddForm(Game.GetFormFromFile(0x002bbac9,"Complete Alchemy & Cooking Overhaul.esp")) ;Alto Noir Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002ee520,"Complete Alchemy & Cooking Overhaul.esp")) ;Alto Blanc Wine
			_SHWineBottleList.AddForm(Game.GetFormFromFile(0x002ee520,"Complete Alchemy & Cooking Overhaul.esp")) ;Alto Blanc Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002ee522,"Complete Alchemy & Cooking Overhaul.esp")) ;Alto Blanc Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002ee524,"Complete Alchemy & Cooking Overhaul.esp")) ;Alto Blanc Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002ee529,"Complete Alchemy & Cooking Overhaul.esp")) ;Village Red Wine
			_SHWineBottleList.AddForm(Game.GetFormFromFile(0x002ee529,"Complete Alchemy & Cooking Overhaul.esp")) ;Village Red Wine
			_SHAlcoholList.AddForm(Game.GetFormFromFile(0x002200f6,"Complete Alchemy & Cooking Overhaul.esp")) ;Alenog
			_SHMeadBottleList.AddForm(Game.GetFormFromFile(0x002200f6,"Complete Alchemy & Cooking Overhaul.esp")) ;Alenog

			Utility.Wait(0.5)


			;Water
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x005e65d3,"Complete Alchemy & Cooking Overhaul.esp")) ;Mugwort Tea
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x005e65d3,"Complete Alchemy & Cooking Overhaul.esp"))
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x005e65d6,"Complete Alchemy & Cooking Overhaul.esp")) ;Lavender Honey Tea
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x005e65d6,"Complete Alchemy & Cooking Overhaul.esp"))
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x006fce69,"Complete Alchemy & Cooking Overhaul.esp")) ;Carrot Juice
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x006fce6a,"Complete Alchemy & Cooking Overhaul.esp")) ;Tomato Juice
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x00701f71,"Complete Alchemy & Cooking Overhaul.esp")) ;Snowberry Juice
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x00701f72,"Complete Alchemy & Cooking Overhaul.esp")) ;Apple Juice
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x00701f74,"Complete Alchemy & Cooking Overhaul.esp")) ;Jazbay Grape Juice
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x01CCA111,"Update.esm")) ;Jug of Water
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x004e3d21,"Complete Alchemy & Cooking Overhaul.esp")) ;Jug of Water
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x004e3d23,"Complete Alchemy & Cooking Overhaul.esp")) ;Jug of Water
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x004e3d25,"Complete Alchemy & Cooking Overhaul.esp")) ;Jug of Water
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x004e3d27,"Complete Alchemy & Cooking Overhaul.esp")) ;Jug of Water
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x004e3d29,"Complete Alchemy & Cooking Overhaul.esp")) ;Jug of Water
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x01CCA122,"Update.esm")) ;CREAM
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x01CCA121,"Update.esm")) ;MILK
			
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x004e3d2b,"Complete Alchemy & Cooking Overhaul.esp")) ;Jug of Water
			_SHDrinkNoBottle.AddForm(Game.GetFormFromFile(0x004e3d2d,"Complete Alchemy & Cooking Overhaul.esp")) ;Jug of Water
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00220110,"Complete Alchemy & Cooking Overhaul.esp")) ;Canis Root Tea
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x00220110,"Complete Alchemy & Cooking Overhaul.esp"))
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x001fb171,"Complete Alchemy & Cooking Overhaul.esp")) ;Apple Cider
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x001fb171,"Complete Alchemy & Cooking Overhaul.esp"))

			;Vampire Blood
			_SHVampireBlood.AddForm(Game.GetFormFromFile(0x0055d7eb,"Complete Alchemy & Cooking Overhaul.esp")) ;Potion of Blood (Altmer)
			_SHVampireBlood.AddForm(Game.GetFormFromFile(0x0055d7ee,"Complete Alchemy & Cooking Overhaul.esp")) ;Potion of Blood (Argonian)
			_SHVampireBlood.AddForm(Game.GetFormFromFile(0x0055d7f2,"Complete Alchemy & Cooking Overhaul.esp")) ;Potion of Blood (Redguard)
			_SHVampireBlood.AddForm(Game.GetFormFromFile(0x0055d7f3,"Complete Alchemy & Cooking Overhaul.esp")) ;Potion of Blood (Bosmer)
			_SHVampireBlood.AddForm(Game.GetFormFromFile(0x0055d7f6,"Complete Alchemy & Cooking Overhaul.esp")) ;Potion of Blood (Breton)
			_SHVampireBlood.AddForm(Game.GetFormFromFile(0x0055d7f7,"Complete Alchemy & Cooking Overhaul.esp")) ;Potion of Blood (Orc)
			_SHVampireBlood.AddForm(Game.GetFormFromFile(0x0055d7f8,"Complete Alchemy & Cooking Overhaul.esp")) ;Potion of Blood (Nord)
			_SHVampireBlood.AddForm(Game.GetFormFromFile(0x0055d7f9,"Complete Alchemy & Cooking Overhaul.esp")) ;Potion of Blood (Dunmer)
			_SHVampireBlood.AddForm(Game.GetFormFromFile(0x0055d7fa,"Complete Alchemy & Cooking Overhaul.esp")) ;Potion of Blood (Khajiit)
			_SHVampireBlood.AddForm(Game.GetFormFromFile(0x0055d7fb,"Complete Alchemy & Cooking Overhaul.esp")) ;Potion of Blood (Imperial)

			;Ignore list
			_SHFoodIgnoreList.AddForm(Game.GetFormFromFile(0x01CCA124,"Update.esm"))	;Oil
			_SHFoodIgnoreList.AddForm(Game.GetFormFromFile(0x01CCA125,"Update.esm"))	;Vinigar
			

			Utility.Wait(0.5)


		EndIf
		return true
	else
		return false
	EndIf

endfunction

bool Function NordicCooking()

	form jerky = Game.GetFormFromFile(0x00000D62,"NordicCooking.esp")

	if(jerky)
		if(!NordicCookingInstalled)

			;light
			_SHFoodLightList.AddForm(jerky)	;Jerky

			;Medium
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000038B0,"NordicCooking.esp"))		;Nordic Salmon Salad
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000038B9,"NordicCooking.esp"))		;Nordic Roasted Gourd
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x000038BC,"NordicCooking.esp"))		;Nordic Roasted Chicken
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00003E24,"NordicCooking.esp"))		;Nordic Smoked Salmon
			_SHFoodMediumList.AddForm(Game.GetFormFromFile(0x00005E91,"NordicCooking.esp"))		;Nordic Salad

			;heavy
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00000D65,"NordicCooking.esp"))		;Mammoth cheese steak
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x000038B3,"NordicCooking.esp"))		;Nordic Roasted Goat
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x000048EB,"NordicCooking.esp"))		;Nordic Cheese Hero
			_SHFoodHeavyList.AddForm(Game.GetFormFromFile(0x00005E8A,"NordicCooking.esp"))		;Nordic Veggie Hero

			;soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00000D63, "NordicCooking.esp"))	;Nordic beef stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000012EF, "NordicCooking.esp"))	;Nordic Horker Stew
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00001856, "NordicCooking.esp"))	;Nordic Hash
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00002322, "NordicCooking.esp"))	;Nordic Cheese Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x000038B6, "NordicCooking.esp"))	;Nordic Clam Chowder
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00004E51, "NordicCooking.esp"))	;Nordic Venison
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00005924, "NordicCooking.esp"))	;Nordic Chicken Soup
			_SHSoupList.AddForm(Game.GetFormFromFile(0x00005E8D, "NordicCooking.esp"))	;Nordic Veggie Stew

			;Mead drink
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00000D67,"NordicCooking.esp"))		;Nordic Red Apple Cider
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00000D69,"NordicCooking.esp"))		;Nordic Carrot Juice
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00003349,"NordicCooking.esp"))		;Nordic Green apple ale
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00009478,"NordicCooking.esp"))		;Nordic Red Apple Wine
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x00009479,"NordicCooking.esp"))		;Nordic Green Apple Wine

			_SHDrinkList.AddForm(Game.GetFormFromFile(0x000053BF,"NordicCooking.esp"))		;Nordic Tea
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x000053BF,"NordicCooking.esp"))
			_SHDrinkList.AddForm(Game.GetFormFromFile(0x000053B9,"NordicCooking.esp"))		;Nordic Coffee
			_SHHotBeverageList.AddForm(Game.GetFormFromFile(0x000053B9,"NordicCooking.esp"))

			Utility.Wait(0.5)

		endif
		return true
	else
		return false
	endif

endfunction
