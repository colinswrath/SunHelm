Scriptname _SHWeatherSystem extends Quest

Actor property PlayerRef auto

FormList property _SHColdCloudyWeather auto
FormList property _SHBlizzardWeathers auto
Weather property DLC02VolcanicAshStorm01 auto
Weather property CurrentWeather auto

GlobalVariable Property _SHCurrentRegionInt Auto

GlobalVariable Property _SHWeatherTemperature auto   ; intialize at 0

;TODO make these globals
int property SnowWeatherPen = 250 auto hidden
int property BlizzardWeatherPen = 650 auto hidden
int property CloudySnowPen = 100 auto hidden
int property RainWeatherPen = 50 auto hidden
int property ClearWeatherPen = 0 auto hidden

Function StartSystem()
    if(!IsRunning())
        Start()
        PO3_Events_Form.RegisterForWeatherChange(self)
        CurrentWeather = Weather.GetCurrentWeather()
        _SHWeatherTemperature.SetValue(CalculateWeatherTemp(CurrentWeather))
    endif
EndFunction

Function StopSystem()
    if(IsRunning())
        PO3_Events_Form.UnregisterForWeatherChange(self)
        Stop()
    endif
EndFunction

Event OnWeatherChange(Weather akOldWeather, Weather akNewWeather)
    CurrentWeather = akNewWeather
    _SHWeatherTemperature.SetValue(CalculateWeatherTemp(CurrentWeather))
EndEvent

int Function CalculateWeatherTemp(Weather calcWeather)
    ;Only take weather into account if you are outside
    int weatherTemp = ClearWeatherPen
    if (!PlayerRef.IsInInterior())
        if(_SHColdCloudyWeather.HasForm(calcWeather) && (_SHCurrentRegionInt.GetValue() != 5 || _SHCurrentRegionInt.GetValue() != 9))
            weatherTemp = CloudySnowPen
        else
            Int weatherClass = -1   ;None
            weatherClass = calcWeather.GetClassification()
            
            If weatherClass == 2    ;Rainy
                weatherTemp = RainWeatherPen
            ElseIf (weatherClass == 3 && (calcWeather != DLC02VolcanicAshStorm01))   ;Snowy
                if(_SHBlizzardWeathers.HasForm(calcWeather))
                    weatherTemp = BlizzardWeatherPen
                else
                    weatherTemp = SnowWeatherPen
                endif 
            endIf
        endif
    endif
    
    return weatherTemp
EndFunction

Weather Function GetRealCurrentWeather()
    if Weather.GetCurrentWeatherTransition() >= 0.500000
        CurrentWeather = Weather.GetCurrentWeather()
    else
        CurrentWeather = Weather.GetOutgoingWeather()
    endIf

    return CurrentWeather
EndFunction
