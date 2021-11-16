Scriptname _SHEatDetection extends ReferenceAlias

Actor Player
Form consumed

Keyword Property VendorItemFood Auto
Keyword Property _SHSaltWaterKeyword Auto

FormList Property _SHFoodLightList Auto
FormList Property _SHFoodMediumList Auto
FormList Property _SHFoodHeavyList Auto
FormList Property _SHSoupList auto
FormList Property _SHFoodIgnoreList Auto
FormList Property _SHRawList auto
FormList Property _SHDrinkList auto
FormList Property _SHMeadBottleList auto
FormList Property _SHAlcoholList auto
FormList Property _SHDrinkNoBottle auto

Keyword property _SH_LightFoodKeyword auto
Keyword property _SH_MediumFoodKeyword auto
Keyword property _SH_HeavyFoodKeyword auto
Keyword property _SH_SoupKeyword auto
Keyword property _SH_MeadBottleKeyword auto
Keyword property _SH_WineBottleKeyword auto
Keyword property _SH_SujammaBottleKeyword auto
Keyword property _SH_DrinkKeyword auto
Keyword property IsBeastRace auto

Idle Property IdleStop_Loose Auto

Keyword property _SH_MeadWATERBottleKeyword auto
Keyword property _SH_WineWATERBottleKeyword auto
Keyword property _SH_SujammaWATERBottleKeyword auto
Keyword property VendorItemFoodRaw auto


GlobalVariable property _SHDiseasesEnabled auto
GlobalVariable Property _SHAnimationsEnabled auto
GlobalVariable property _SHRawDamage auto
GlobalVariable property _SHColdActive auto
GlobalVariable Property _SHVampireNeedsOption Auto
GlobalVariable Property _SHIsVampireGlobal Auto

spell property _SHSoupWarmthSpell auto
Spell property _SHFoodPoisoningSpell auto

Message Property _SHUnknownFood Auto

bool property ImmuneFoodPoisoning
    bool Function Get()
        if(Player.HasKeyword(IsBeastRace) || Player.GetRace() == _SHMain.WoodElfRace || _SHMain.Vampire || _SHMain.HumanWerewolf)
            return true
        else
            return false
        endif
    EndFunction
EndProperty

bool property CheckIgnoreCategorization
    bool Function Get()
        if(IsConsumedRawItem || _SHDrinkList.HasForm(consumed) || _SHDrinkNoBottle.HasForm(consumed) || consumed.HasKeyword(_SH_MeadWATERBottleKeyword) || consumed.HasKeyword(_SH_SujammaWATERBottleKeyword) || consumed.HasKeyword(_SH_WineWATERBottleKeyword) || consumed.HasKeyword(_SH_DrinkKeyword) || _SHDrinkNoBottle.HasForm(consumed) || _SHAlcoholList.HasForm(consumed))
            return true
        else
            return false
        endif
    EndFunction
EndProperty

bool property IsConsumedRawItem
    bool Function Get()
        if(consumed.HasKeyword(VendorItemFoodRaw) || _SHRawList.HasForm(consumed))
            return true
        else
            return false
        endif
    EndFunction
EndProperty

import Utility

;(Refactor to use keywords instead of formlists) Use a formlist for unknown food
_SunHelmMain property _SHMain auto
_SHHungerSystem property _HungerSystem auto
_SHThirstSystem property _ThirstSystem auto

;Events

;Event fires when object is Equipped
Event OnObjectEquipped(form akBaseObject, ObjectReference akReference)
    If (akBaseObject as Potion && (akBaseObject as Potion).IsFood())
        Player = Game.GetPlayer()   ;TODO MAKE A PROPERTY DONT WASTE THIS TIME
        consumed = akBaseObject
        FoodCheck()
    EndIf
EndEvent

;Checks for food, and decreases if it is
Function FoodCheck()

    bool playAnim = false
    if(_SHIsVampireGlobal.GetValue() == 0.0 || _SHVampireNeedsOption.GetValue() == 3)
        
        ;Werewolfs in human form, and wood elves can eat raw meat
        if(IsConsumedRawItem && _SHRawDamage.GetValue() == 1 && !ImmuneFoodPoisoning)              
            if(_SHDiseasesEnabled.GetValue() == 1)
                if(Utility.RandomInt(0,100) < 30)
                    Player.DoCombatSpellApply(_SHFoodPoisoningSpell,Player)
                endif
            else
                Player.DamageActorValue("Health", (Utility.RandomInt(0,25)))
            endif
            playAnim = true
        endif
            
        float foodPoisonModifier
        if(_SHMain.HasFoodPoison && _SHDiseasesEnabled.GetValue() == 1)
            foodPoisonModifier = 0.75
        Else
            foodPoisonModifier = 1.00
        endif
        
        If ((consumed.HasKeyword(_SH_LightFoodKeyword) || _SHFoodLightList.HasForm(consumed)))       
            DecreaseHunger((40) * foodPoisonModifier)
            playAnim = true
        ElseIf(consumed.HasKeyword(_SH_MediumFoodKeyword) || _SHFoodMediumList.HasForm(consumed))
            DecreaseHunger((75) * foodPoisonModifier)
            playAnim = true
        ElseIf (consumed.HasKeyword(_SH_HeavyFoodKeyword) || _SHFoodHeavyList.HasForm(consumed))
            DecreaseHunger((125) * foodPoisonModifier)
            playAnim = true
        ElseIf (consumed.HasKeyword(_SH_SoupKeyword) || _SHSoupList.HasForm(consumed))
            if(_SHColdActive.GetValue() == 1.0)
                _SHSoupWarmthSpell.Cast(Player,Player)
            endif
            DecreaseHunger(75)
            DecreaseThirst(20)
            playAnim = true
        ElseIf (_SHFoodIgnoreList.HasForm(consumed))
            return
        ElseIf(CheckIgnoreCategorization)
            _SHFoodIgnoreList.AddForm(consumed)
            return
        Else
            CheckUnknownConsumable()
        EndIf
        
        if(_SHAnimationsEnabled.GetValue() == 1 && playAnim)
            PlayEatAnimation()
        endif 
    endif
EndFunction

Function DecreaseHunger(float amount)
    if(_HungerSystem.IsRunning())
        _HungerSystem.DecreaseHungerLevel(amount)
    endif
endFunction

Function DecreaseThirst(float amount)
    if(_ThirstSystem.IsRunning())
        _ThirstSystem.DecreaseThirstLevel(amount)
    endif
endfunction

;Change to make main register for eating animation
Function PlayEatAnimation()

        If Player.GetAnimationVariableInt("i1stPerson") as Int == 1 || Player.IsRunning() || Player.IsSprinting()
            ;None
        else
            if(Player.GetSitState() == 0)
                Debug.SendAnimationEvent(Player, "idleEatingStandingStart")
                Utility.Wait(7.0)
                Player.PlayIdle(IdleStop_Loose)
            elseif(Player.GetSitState() == 3)
                Debug.SendAnimationEvent(Player, "ChairEatingStart")
            endif
        endif
    
EndFunction

Function CheckUnknownConsumable()
    int choice = _SHUnknownFood.Show()
            
    If (choice == 0)
        _SHFoodLightList.AddForm(consumed)
    ElseIf (choice == 1)
        _SHFoodMediumList.AddForm(consumed)
    ElseIf (choice == 2)
        _SHFoodHeavyList.AddForm(consumed)
    ElseIf (choice == 3)
        _SHSoupList.AddForm(consumed)
    ElseIf (choice == 4)
        _SHRawList.AddForm(consumed)
    ElseIf (choice == 5)
        _SHDrinkList.AddForm(consumed)
    ElseIf (choice == 6)
        _SHAlcoholList.AddForm(consumed)
        _SHMeadBottleList.AddForm(consumed)
    ElseIf(choice == 7)
        _SHDrinkNoBottle.AddForm(consumed)
    ElseIf(choice == 8)
        _SHFoodIgnoreList.AddForm(consumed)
    EndIf
endfunction
