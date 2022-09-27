Scriptname _SHDiseaseProgressionScript extends ActiveMagicEffect

Spell property CurrentDiseaseSpell auto
Spell property NextDiseaseSpell auto
int property hoursToNextStage auto
bool property firstDisease auto

Message property ContractionMessage auto

bool FoodPoison = false

Actor SickActor 

event OnEffectStart(Actor akTarget, Actor akCaster)
    if(hoursToNextStage && hoursToNextStage > 0)
        RegisterForSingleUpdateGameTime(hoursToNextStage as float)
    endif
    SickActor = akTarget

    if(firstDisease)
        if(ContractionMessage)
            ContractionMessage.Show()
        endif
        game.IncrementStat("Diseases Contracted", 1)        ;Not sure if this is necessary
    endif
endevent

event OnEffectFinish(Actor akTarget, Actor akCaster)
    akTarget.RemoveSpell(CurrentDiseaseSpell)
endevent

event OnUpdateGameTime()
    if(SickActor && SickActor.GetActorValue("DiseaseResist") < 100)     ;If disease resist is 100%, check back again later
        self.Dispel()

        if NextDiseaseSpell && SickActor && !FoodPoison
            SickActor.DoCombatSpellApply(NextDiseaseSpell, Game.GetPlayer())
        endif
    Else
        RegisterForSingleUpdateGameTime(hoursToNextStage as float)
    endif
endevent