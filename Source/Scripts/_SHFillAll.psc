Scriptname _SHFillAll extends ActiveMagicEffect

Potion property _SHWaterBottleMead auto
Potion property _SHWaterBottleWine auto
Potion property _SHSujammaWaterBottle auto

Potion property _SHSaltBottleMead auto
Potion property _SHSaltBottleWine auto
Potion property _SHSaltBottleSujamma auto

MiscObject property _SHEmptyMeadMisc auto
MiscObject property _SHEmptyWineMisc auto
MiscObject property _SHEmptySujammaMisc auto

Sound property _SHDrink auto

_SunHelmMain property _SHMain auto

Actor Player

Event OnEffectStart(Actor akTarget, Actor akCaster)
    _SHMain.DrinkAndFill()
EndEvent