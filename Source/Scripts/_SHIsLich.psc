Scriptname _SHIsLich extends ActiveMagicEffect  

GlobalVariable property _SHLichCurrentOption auto
_SunHelmMain property _SHMain auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
    _SHMain.LichChangeNeeds(_SHLichCurrentOption.GetValue() as int)
endevent


Event OnEffectFinish(Actor akTarget, Actor akCaster)
    _SHMain.LichChangeNeeds(1)
EndEvent