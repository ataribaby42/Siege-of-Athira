disableSerialization;

if (!gMissionEnded && (gClientMode == "CLIENT" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") && ((findDisplay 46 displayCtrl 999903) isEqualTo controlNull)) then
{
	private _time = 1;
	private _w = 1.0;
	private _h = 0.12;

	waitUntil {str(findDisplay 46) != "no display"};
	
	private _entryControl = (findDisplay 46) ctrlCreate ["RscStructuredText", 999903];
	_entryControl ctrlSetPosition [0.5 - (_w / 2), 1 - _h, _w, _h];
	_entryControl ctrlCommit 0;
	
	if(gPlayerLocked) then
	{
		_entryControl ctrlSetBackgroundColor [1,0,0,1];
		
		while {gPlayerLocked} do 
		{
			private _lockedCountdown = 0;
		
			if(!(isNil "gMissionTime")) then
			{
				_lockedCountdown = floor(gTimeout - (gTimer - gLockedTime));
				if(_lockedCountdown < 0) then {_lockedCountdown = 0;};
			};
			
			private _minutes = floor(_lockedCountdown / 60);
			private _seconds = _lockedCountdown mod 60;
			
			if(_minutes < 10) then
			{
				_minutes = format ["0%1", _minutes];
			}
			else
			{
				_minutes = format ["%1", _minutes];
			};
			
			if(_seconds < 10) then
			{
				_seconds = format ["0%1", _seconds];
			}
			else
			{
				_seconds = format ["%1", _seconds];
			};
			
			_entryControl ctrlSetStructuredText parseText format[localize "STR_EntryLocked", _minutes, _seconds];
			sleep 0.2;
		};
	};
	
	entryTimer = 0;
	
	private _handle = [] spawn
	{
		while {true} do 
		{ 
			entryTimer = entryTimer + 0.1;
			Sleep 0.1;
		};
	};
	
	private _endTime = gEntryTime;
	_entryControl ctrlSetBackgroundColor [0,1,0,1];

	while {_time > 0 && alive player && !((findDisplay 46 displayCtrl 999903) isEqualTo controlNull)} do 
	{
		_time = _endTime - entryTimer ; 
		
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
		
		_entryControl ctrlSetStructuredText parseText format[localize "STR_EntryInProgress", _timeSeconds, _timeMs];
		sleep 0.1;
	};
	
	terminate _handle;

	if(!((findDisplay 46 displayCtrl 999903) isEqualTo controlNull)) then
	{
		ctrlDelete (findDisplay 46 displayCtrl 999903);
		_entryControl = nil;	
		
		if(alive player && !gPlayerLocked && !gMissionEnded) then
		{
			gMenu = 0;
		};
	};
};