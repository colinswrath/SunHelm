Scriptname _SHWerewolfScript extends activemagiceffect 

Bool property HumanWerewolf auto
Bool property BeastWerewolf auto
bool NeedsWerePaused = false

GlobalVariable property _SHWerewolfPauseNeeds auto   
GlobalVariable property _SHWerewolfFatigue auto

Perk property WerewolfFeedPerk auto

_SunHelmMain property _SHMain auto

Actor Player

Event OnEffectStart(Actor akTarget, Actor akCaster)
    Player = akTarget

    if(HumanWerewolf)
        _SHMain.HumanWerewolf = true

    ElseIf (BeastWerewolf)

        ;Pause werewolf needs
        if(_SHWerewolfPauseNeeds.GetValue() == 1.0)
            _SHMain.PauseNeeds()
            NeedsWerePaused = true
        EndIf

        ;Add perk and set bools
        Player.AddPerk(WerewolfFeedPerk)
        _SHMain.BeastWerewolf = true
        _SHMain.HumanWerewolf = false
    EndIf

EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if(HumanWerewolf)
        _SHMain.HumanWerewolf = false

    ElseIf (BeastWerewolf)

        ;Unpause werewolf needs
        if(NeedsWerePaused)
            _SHMain.ResumeNeeds()
            NeedsWerePaused = false
        EndIf
      
        ;If set, increase fatigue
        if(_SHWerewolfFatigue.GetValue() == 1.0)
            _SHMain.Fatigue.IncreaseFatigueLevel(100)
        EndIf
        
        ;Set bools and remove perk
        Player.RemovePerk(WerewolfFeedPerk)
        _SHMain.BeastWerewolf = false
        _SHMain.HumanWerewolf = true     
    EndIf

EndEvent