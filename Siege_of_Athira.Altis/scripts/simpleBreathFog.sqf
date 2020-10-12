private _unit = _this select 0;
private _int = _this select 1; //intensity of fog (0 to 1)

waitUntil {!isNil "gTimeSet"};
waitUntil {!isNil "gWeather"};

while {alive _unit} do {
	sleep (2 + random 2); // random time between breaths

	private _fogOn = false;

  	if(vehicle _unit == _unit) then
	{
		_fogOn = call fnc_isCold;
	};
	
	if(_fogOn) then
	{
		if(_unit call fnc_inHouse) then {_fogOn = false;};
		
		if(_fogOn) then
		{
			private _source = "logic" createVehicleLocal (getpos _unit);
			private _fog = "#particlesource" createVehicleLocal getpos _source;
			_fog setParticleParams [["\A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 12, 13,0],
			"", 
			"Billboard", 
			0.5, 
			0.5, 
			[0,0,0],
			[0, 0.2, -0.2], 
			1, 1.275,	1, 0.2, 
			[0, 0.2,0], 
			[[1,1,1, _int], [1,1,1, 0.01], [1,1,1, 0]], 
			[1000], 
			1, 
			0.04, 
			"", 
			"", 
			_source];
			_fog setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
			_fog setDropInterval 0.001;

			_source attachto [_unit,[0,0.15,0], "neck"]; // get fog to come out of player mouth

			sleep 0.5; // 1/2 second exhalation
			deletevehicle _fog;
			deletevehicle _source;
		};
	};
};