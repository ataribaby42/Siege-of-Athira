private _exits = _this select 0;
private _selectedExits = [];
private _exit = selectRandom _exits;

if(gDebug) then {[position _exit,"ColorRed"] call fnc_createMarker;};

_exits = _exits - [_exit];
_selectedExits = _selectedExits + [_exit];

for "_i" from 1 to (gNumOfExits - 1) do 
{
	scopeName "nextExit";
	
	for "_j" from 1 to 20 do 
	{
		scopeName "badExit";
		
		_exit = selectRandom _exits;
		private _soNear = false;
		
		{
			private _distance = _exit distance2D _x;
			if (_distance <= gMinDistanceBetweenExits) then {_soNear = true; breakTo "badExit";};
		} foreach _selectedExits;

		if(!_soNear) then {breakTo "nextExit";};
	};
	
	if(gDebug) then {[position _exit,"ColorRed"] call fnc_createMarker;};
	_exits = _exits - [_exit];
	_selectedExits = _selectedExits + [_exit];
};

{
	deleteVehicle _x;
} foreach _exits;

gExtractions = _selectedExits;
gActiveExtractions = [];

{
	gActiveExtractions = gActiveExtractions + [triggerText _x];
} foreach gExtractions;

publicVariable "gActiveExtractions";



