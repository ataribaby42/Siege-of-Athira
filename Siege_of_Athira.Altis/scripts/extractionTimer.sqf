disableSerialization;

if ((gClientMode == "CLIENT" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") && !gPlayerLocked && ((findDisplay 46 displayCtrl 999901) isEqualTo controlNull)) then
{
	extractTimer = 0;
	
	private _handle = [] spawn
	{
		while {true} do 
		{ 
			extractTimer =extractTimer + 0.1;
			Sleep 0.1;
		};
	};
	
	private _time = 1;
	private _endTime = gExtractionTime;
	private _w = 1.0;
	private _h = 0.12;

	waitUntil {str(findDisplay 46) != "no display"};
	
	private _extractionControl = (findDisplay 46) ctrlCreate ["RscStructuredText", 999901];
	_extractionControl ctrlSetPosition [0.5 - (_w / 2), 1 - _h, _w, _h];
	_extractionControl ctrlSetBackgroundColor [1,1,0,1];
	_extractionControl ctrlCommit 0;

	while {_time > 0 && lifeState player != "INCAPACITATED" && alive player && !((findDisplay 46 displayCtrl 999901) isEqualTo controlNull)} do 
	{
		_time = _endTime - extractTimer; 
		
		if(_time < 0) then {_time = 0;};
		
		private _timeSeconds = floor(_time);
		private _timeMs = round((_time - _timeSeconds) * 1000);
		
		if(_timeSeconds < 10) then
		{
			_timeSeconds = format ["0%1", _timeSeconds];
		}
		else
		{
			_timeSeconds = format ["%1", _timeSeconds];
		};
		
		if(_timeMs < 10) then
		{
			_timeMs = format ["00%1", _timeMs];
		}
		else
		{
			if(_timeMs < 100) then
			{
				_timeMs = format ["0%1", _timeMs];
			}
			else
			{
				_timeMs = format ["%1", _timeMs];
			};
		};
		
		_timeMs = _timeMs select [0, 1];
		
		_extractionControl ctrlSetStructuredText parseText format[localize "STR_ExtractionInProgress", _timeSeconds, _timeMs];
		sleep 0.1;
	};
	
	terminate _handle;

	if(!((findDisplay 46 displayCtrl 999901) isEqualTo controlNull)) then
	{
		ctrlDelete (findDisplay 46 displayCtrl 999901);
		_extractionControl = nil;	
		
		if(alive player && lifeState player != "INCAPACITATED") then
		{
			[player] execVM "scripts\extractPlayer.sqf";
		};
	};
};