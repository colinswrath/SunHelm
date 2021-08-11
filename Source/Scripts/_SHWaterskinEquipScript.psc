Scriptname _SHWaterskinEquipScript extends ActiveMagicEffect

;NOTICE----DEPRICATED AND NO LONGER USED. WATERSKIN EQUIP WAS REMOVED FROM THE MOD

_SunHelmMain property _SHMain auto
Armor Property _SHWaterskinLeft Auto
Armor Property _SHWaterskinRight Auto
Armor Property _SHWaterskinBack Auto
GlobalVariable property _SHWaterskinLocation auto   
Actor Player

Event OnEffectStart(Actor akTarget, Actor akCaster)
    Player = akTarget
    EquipSkin()
    RegisterForModEvent("_SHUpdateSkin", "OnUpdateSkin")
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    UnequipSkin()
    UnregisterForModEvent("_SHUpdateSkin")
EndEvent

Function EquipSkin()
    int skinPlace = _SHWaterskinLocation.GetValue() as int

    if(skinPlace == 0)
        Player.AddItem(_SHWaterskinBack, 1, true)
		Player.EquipItem(_SHWaterskinBack, false, true)
    ElseIf (skinPlace == 1)
        Player.AddItem(_SHWaterskinRight, 1, true)
		Player.EquipItem(_SHWaterskinRight, false, true)
    ElseIf (skinPlace == 2)
        Player.AddItem(_SHWaterskinLeft, 1, true)
		Player.EquipItem(_SHWaterskinLeft, false, true)
    endif
endFunction

Function UnequipSkin()
    Player.RemoveItem(_SHWaterskinBack, Player.GetItemCount(_SHWaterskinBack) as Int, true)
	Player.RemoveItem(_SHWaterskinRight, Player.GetItemCount(_SHWaterskinRight) as Int, true)
	Player.RemoveItem(_SHWaterskinLeft, Player.GetItemCount(_SHWaterskinLeft) as Int, true)
EndFunction

Event OnUpdateSkin(string eventName, string strArg, float numArg, Form sender)
    UnequipSkin()
    EquipSkin()
endevent

