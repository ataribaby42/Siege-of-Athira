private _template = [
				["SUNNY", 0, 0, 0, 0, 0.1, 1], 
				["SUNNY_WINDY", 0, 0, 0, 0, 0.1, 5],
				["BROKEN", 0.3, 0, 0, 0, 0.1, 1], 
				["BROKEN_WINDY", 0.3, 0, 0, 0, 0.1, 5], 
				["OVERCAST", 0.7, 0, 0.02, 0, 0.1, 2], 
				["OVERCAST_WINDY", 0.7, 0, 0.02, 0, 0.1, 5],
				["LIGHT_RAIN", 0.8, 0.2, 0.03, 0, 0.1, 2], 
				["LIGHT_RAIN_WINDY", 0.8, 0.2, 0.03, 0, 0.1, 5], 
				["HEAVY_RAIN", 0.9, 0.7, 0.05, 0, 0.1, 2], 
				["HEAVY_RAIN-WINDY", 0.9, 0.7, 0.05, 0, 0.1, 5], 
				["THUNDERSTORM", 1, 1, 0.1, 1, 0.1, 6], 
				["LIGHTNINGS", 1, 0.2, 0.005, 1, 0.1, 3],
				["LIGHTNINGS_WINDY", 1, 0.2, 0.005, 1, 0.1, 5]
			];

private _weather = "soaWeather" call BIS_fnc_getParamValue;
if(_weather > 0) then
{
	if(_weather == 1) then {_template = [["SUNNY", 0, 0, 0, 0, 0.1, 1],["SUNNY_WINDY", 0, 0, 0, 0, 0.1, 5]];};
	if(_weather == 2) then {_template = [["BROKEN", 0.3, 0, 0, 0, 0.1, 1],["BROKEN_WINDY", 0.3, 0, 0, 0, 0.1, 5]];};
	if(_weather == 3) then {_template = [["OVERCAST", 0.7, 0, 0.02, 0, 0.1, 2],["OVERCAST_WINDY", 0.7, 0, 0.02, 0, 0.1, 5]];};
	if(_weather == 4) then {_template = [["LIGHT_RAIN", 0.8, 0.2, 0.03, 0, 0.1, 2],["LIGHT_RAIN_WINDY", 0.8, 0.2, 0.03, 0, 0.1, 5]];};
	if(_weather == 5) then {_template = [["HEAVY_RAIN", 0.9, 0.7, 0.05, 0, 0.1, 2],["HEAVY_RAIN-WINDY", 0.9, 0.7, 0.05, 0, 0.1, 5]];};
	if(_weather == 6) then {_template = [["THUNDERSTORM", 1, 1, 0.1, 1, 0.1, 6]];};
	if(_weather == 7) then {_template = [["LIGHTNINGS", 1, 0.2, 0.005, 1, 0.1, 3],["LIGHTNINGS_WINDY", 1, 0.2, 0.005, 1, 0.1, 5]];};
};			

_template = selectRandom _template;
gWeather = _template;
publicVariable "gWeather";

0 setOvercast (_template select 1);
0 setRain (_template select 2);
0 setFog (_template select 3);
0 setLightnings (_template select 4);
0 setWaves (_template select 5);
private _windDir = random 360;
private _windX = cos _windDir;
private _windY = sin _windDir;
setWind [_windX * (_template select 6), _windY * (_template select 6), true];
forceWeatherChange;

[_template] spawn {
	private _template = _this select 0;
	sleep 10;
	999999 setOvercast (_template select 1);
	999999 setRain (_template select 2);
	999999 setFog (_template select 3);
	999999 setLightnings (_template select 4);
	999999 setWaves (_template select 5);
};
