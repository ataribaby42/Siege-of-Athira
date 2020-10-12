// by ALIAS
// Flare Fix DEMO
// Tutorial: https://www.youtube.com/user/aliascartoons
// [[[_al_flare],"AL_flare_fix\al_flare_enhance.sqf"],"BIS_fnc_execVM",true,true] spawn BIS_fnc_MP;

if (!hasInterface) exitWith {};

private _al_flare = _this select 0;

// you need to list in array bellow the class names for flares you want to alter
private _type_flares = ["F_40mm_White_Infinite","F_40mm_Red_Infinite","F_40mm_Yellow_Infinite","F_40mm_Green_Infinite"];
private _al_color_flare = [0.7,0.7,0.8];

if ((typeOf _al_flare) in _type_flares) then {
	
switch (typeOf _al_flare) do {
    case "F_40mm_White_Infinite": {_al_color_flare = [0.7,0.7,0.8]};
    case "F_40mm_Red_Infinite": {_al_color_flare = [0.7,0.15,0.1] };
    case "F_40mm_Yellow_Infinite": {_al_color_flare = [0.7,0.7,0] };
    case "F_40mm_Green_Infinite": {_al_color_flare = [0.1,0.7,0.1] };	
};

	[_al_flare] spawn 
	{
		private _flare = _this select 0;
		
		while {alive _flare} do {
			_flare say3d "FLARE_BURN";
			sleep 2 + (random 2) ;
		};
	};
	
	private _al_flare_light = "#lightpoint" createVehicle getPosATL _al_flare;  
	_al_flare_light setLightAmbient _al_color_flare;  
	_al_flare_light setLightColor _al_color_flare;
	_al_flare_light setLightIntensity al_flare_intensity;
	_al_flare_light setLightUseFlare true;
	_al_flare_light setLightFlareSize 10;
	_al_flare_light setLightFlareMaxDistance 2000;
	_al_flare_light setLightAttenuation [/*start*/ al_flare_range, /*constant*/1, /*linear*/ 100, /*quadratic*/ 0, /*hardlimitstart*/50,/* hardlimitend*/al_flare_range-10]; 
	_al_flare_light setLightDayLight true;

	private _int_mic = 0;
	private _flare_brig = 0;
	
	while {alive _al_flare} do {
		_int_mic = 0.05 + random 0.1;
		sleep _int_mic;
		_flare_brig = al_flare_intensity + random 5;
		_al_flare_light setLightIntensity _flare_brig;
		_al_flare_light setpos (getPosATL _al_flare);
	};

	_int_mic = 3;

	while {_int_mic>0} do {
		_flare_brig = _flare_brig - 10;
		_al_flare_light setLightIntensity _flare_brig;
		_int_mic = _int_mic-0.03;
		sleep 0.01;
	};

	deleteVehicle _al_flare_light;
};