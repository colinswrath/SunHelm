Scriptname _SHOblivionScript extends ActiveMagicEffect

_SunHelmMain Property _SHMain Auto
bool wasPaused = false

GlobalVariable property _SHFirstPersonMessages auto
GlobalVariable property _SHPauseNeedsOblivion auto   

Message Property _SHOblivionBack auto
Message Property _SHOblivionBackFirst auto
Message property _SHOblivionMessage auto
Message property _SHOblivionMessageFirst auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if(_SHPauseNeedsOblivion.GetValue() == 1)
        wasPaused = true
        CheckPlayerIsInOblivion(true)
    endif

endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if(wasPaused)
        wasPaused = false
        ;Reenable needs
        CheckPlayerIsInOblivion(false)
    endif

endEvent

Function CheckPlayerIsInOblivion(bool InOblivion)

    if(!InOblivion)
        _SHMain.isInOblivion = false
    endif

    if(_SHPauseNeedsOblivion.GetValue() == 1)

        if(InOblivion)
            _SHMain.isInOblivion = true
            if(_SHFirstPersonMessages.GetValue() == 1)
                _SHOblivionMessageFirst.Show()
            else
                _SHOblivionMessage.Show()
            endif
        else
            if(_SHFirstPersonMessages.GetValue() == 1)
                _SHOblivionBackFirst.Show()
            else
                _SHOblivionBack.Show()
            endif
        endif
    endif
EndFunction