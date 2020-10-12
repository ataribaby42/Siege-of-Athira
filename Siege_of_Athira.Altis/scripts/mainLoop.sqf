waitUntil {gMissionSetupCompleted};

enableEnvironment [false, true];

private _clock = 1;
private _flareMortarFire = 20 + (random 20);
private _flareMortarFireCounter = 0;

private _CSATteamTime = -1;
private _CSATteamDice = floor random 10;
private _CSATteamDeployed = false;
private _bossTeamDice = floor random 10;

private _earthquakes = [];

if(_CSATteamDice > 7) then
{
	if (gClientMode == "SINGLEPLAYER") then 
	{
		_CSATteamTime = (60 * 5) + (random (60 * 5));
	}
	else
	{
		_CSATteamTime = (60 * 10) + (random (60 * 10));
	};
};

diag_log format["*** CSATteamTime %1", _CSATteamTime];

if (_bossTeamDice > 3 && (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER")) then 
{
    diag_log "*** Guerilla Boss Team will be triggered";
};

if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then 
{
	estimatedTimeLeft gMissionDuration;
};

while {true} do 
{  
	if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then 
	{
		gDate = date;
		publicVariable "gDate";
		call fnc_processPlayersInRaid;
	};

	if ((_clock % 60) == 0 && (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER")) then 
	{
		estimatedTimeLeft (0 max (gMissionDuration - gMissionTime));
	};

	if (_clock > 30 && _bossTeamDice > 3 && (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER")) then 
	{
		_bossTeamDice = -1;
		execVM "scripts\bossTeam.sqf";
		diag_log "*** Guerilla Boss Team triggered";
	};
	
	if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
	{
		gTemp = gClimate call llw_fnc_getTemperature select 0;
		
		if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then {publicVariable "gTemp";};

		gSunElevation = [] call llw_fnc_getSunAngle;
		
		if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then {publicVariable "gSunElevation";};
		
		gMoonPhase = call fnc_computeMoonPhase;
		
		if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then {publicVariable "gMoonPhase";};
		
		if((_clock % 10) == 0) then {call fnc_processSnipers;};
		
		if(_flareMortarFireCounter >= _flareMortarFire) then 
		{
			if(call fnc_isNight) then
			{
				[] spawn fnc_fireFlares;
			};
			
			_flareMortarFireCounter = 0;
			_flareMortarFire = 200 + (random 200);
		};
		
		if(!_CSATteamDeployed && _CSATteamTime > -1 && _clock >= _CSATteamTime) then
		{
			_CSATteamDeployed = true;
			execVM "scripts\CSATteam.sqf";
			diag_log "*** CSAT Team triggered";
		};

		if(!isNil "gCSATteam") then
		{
			if(!isNil "gCSATdrone") then
			{
				if(gCSATteam && !gCSATdrone && !(call fnc_isNight)) then
				{
					execVM "scripts\CSATdrone.sqf";
					diag_log "*** CSAT drone triggered";
				};
			}
			else
			{
				if(gCSATteam && !(call fnc_isNight)) then
				{
					execVM "scripts\CSATdrone.sqf";
					diag_log "*** CSAT drone triggered";
				};
			};
		};
	};
	
	if (gClientMode == "SINGLEPLAYER" || gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then
	{
		if(!gMissionEnded) then
		{
			gMissionTime = gTimer;
			
			if(gMissionTime >= gMissionDuration) then
			{
				gMissionEnded = true;
				gMissionTime = gMissionDuration;
				
				if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then
				{
					publicVariable "gMissionTime";
					publicVariable "gMissionEnded";
					diag_log "*** mission ended";
					if(gClientMode == "LOCAL_SERVER") then {[false] call fnc_closeMenu;};
					"End1" call BIS_fnc_endMissionServer;
				};
				
				if (gClientMode == "SINGLEPLAYER" || gClientMode == "LOCAL_SERVER") then
				{
					[false] call fnc_closeMenu;
					"End1" call BIS_fnc_endMission;
				};
			};
			
			if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then
			{
				publicVariable "gMissionTime";
				publicVariable "gMissionEnded";
			};
			
			if((_clock % 60) == 0) then {call fnc_cleanup;};
		};
	};
	
	if((_clock % 10) == 0) then 
	{
		enableEnvironment [false, true];
	};
	
	if((_clock % 30) == 0 && (gClientMode == "SINGLEPLAYER" || gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER")) then 
	{
		[gWeather] spawn {
			private _template = _this select 0;
			0 setRain (_template select 2);
			0 setLightnings (_template select 4);
			sleep 10;
			999999 setRain (_template select 2);
			999999 setLightnings (_template select 4);
		};
	};
	
	if((_clock % 600) == 0 && selectRandom[0,1] == 1 && (gClientMode == "SINGLEPLAYER" || gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER")) then 
	{
		if(!(call fnc_isNight) 
			&& (gWeather select 0) != "LIGHTNINGS_WINDY"
			&& (gWeather select 0) != "LIGHTNINGS"
			&& (gWeather select 0) != "THUNDERSTORM"
			&& (gWeather select 0) != "HEAVY_RAIN-WINDY"
			&& (gWeather select 0) != "HEAVY_RAIN"
			&& (gWeather select 0) != "HEAVY_RAIN-WINDY"
		) then
		{
			execVM "scripts\leaflets.sqf";
		};
	};

	if(gClientMode == "SINGLEPLAYER" || gClientMode == "LOCAL_SERVER" || gClientMode == "CLIENT") then
	{
		private _raidEndsIn = ceil((gMissionDuration - gMissionTime) / 60);
		private _magnitude = 0;
		private _timeCheck = 0;
		
		_timeCheck = 10;

		if(_raidEndsIn == _timeCheck && !(_timeCheck in _earthquakes)) then
		{
			_magnitude = 1;
			_earthquakes = _earthquakes + [_timeCheck];
		};

		_timeCheck = 7;

		if(_raidEndsIn == _timeCheck && !(_timeCheck in _earthquakes)) then
		{
			_magnitude = 1;
			_earthquakes = _earthquakes + [_timeCheck];
		};

		_timeCheck = 6;

		if(_raidEndsIn == _timeCheck && !(_timeCheck in _earthquakes)) then
		{
			_magnitude = 2;
			_earthquakes = _earthquakes + [_timeCheck];
		};

		_timeCheck = 5;

		if(_raidEndsIn == _timeCheck && !(_timeCheck in _earthquakes)) then
		{
			_magnitude = 2;
			_earthquakes = _earthquakes + [_timeCheck];
		};

		_timeCheck = 4;

		if(_raidEndsIn == _timeCheck && !(_timeCheck in _earthquakes)) then
		{
			_magnitude = 3;
			_earthquakes = _earthquakes + [_timeCheck];
		};

		_timeCheck = 3;

		if(_raidEndsIn == _timeCheck && !(_timeCheck in _earthquakes)) then
		{
			_magnitude = 3;
			_earthquakes = _earthquakes + [_timeCheck];
		};

		_timeCheck = 2;

		if(_raidEndsIn == _timeCheck && !(_timeCheck in _earthquakes)) then
		{
			_magnitude = 4;
			_earthquakes = _earthquakes + [_timeCheck];
		};

		_timeCheck = 1;

		if(_raidEndsIn == _timeCheck && !(_timeCheck in _earthquakes)) then
		{
			_magnitude = 4;
			_earthquakes = _earthquakes + [_timeCheck];
		};

		if(_magnitude > 0) then
		{
			if(!isNil "gMenu") then
			{
				if(gMenu == 1) then
				{
					_magnitude = 1;
				};
			};

			if (gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
			{
				[_magnitude] remoteExec ["fnc_earthquake", 0]; 
			}
			else
			{
				[_magnitude] remoteExec ["fnc_earthquake", -2]; 
			};
		};
	};
	
	_flareMortarFireCounter = _flareMortarFireCounter + 1;
	_clock = _clock + 1;
	sleep 1;
};