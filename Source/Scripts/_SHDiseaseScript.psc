Scriptname _SHDiseaseScript extends ActiveMagicEffect

Spell property CurrentDiseaseSpell auto
Spell property NextDiseaseSpell auto
int property hoursToNextStage auto
bool property firstDisease auto

GlobalVariable Property _SHFirstPersonMessages auto
Spell property _SHFoodPoisoningSpell auto

bool FoodPoison = false

_SunHelmMain property _SHMain auto

event OnEffectStart(Actor akTarget, Actor akCaster)
    
    if(CurrentDiseaseSpell == _SHFoodPoisoningSpell)
        _SHMain.HasFoodPoison = true
        FoodPoison = true
    endif

    if(hoursToNextStage && hoursToNextStage > 0)
        RegisterForSingleUpdateGameTime(hoursToNextStage as float)
    endif

    if(firstDisease)
        game.IncrementStat("Diseases Contracted", 1)
    endif
endevent

event OnEffectFinish(Actor akTarget, Actor akCaster)
    if(CurrentDiseaseSpell == _SHFoodPoisoningSpell)
        _SHMain.HasFoodPoison = false
    endif

    akTarget.RemoveSpell(CurrentDiseaseSpell)

endevent

event OnUpdateGameTime()
    Actor target = self.GetTargetActor()
    self.Dispel()

    if NextDiseaseSpell && target && !FoodPoison
        target.DoCombatSpellApply(NextDiseaseSpell, Game.GetPlayer())
    endif
endevent