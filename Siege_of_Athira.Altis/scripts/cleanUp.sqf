private _deleteDistance = 500;

//dead bodies
{
	private _killed = _x getVariable ["killed", nil];
	
	private _entities = nearestObjects [position _x, [gPlayerClass], gCleanUpRangeFromPlayer, true];
	private _onlyPlayers = [];
	
	{
		if(alive _x) then
		{
			_onlyPlayers = _onlyPlayers + [_x];
		};
	}
	forEach _entities;
	
	private _players = count(_onlyPlayers);
	
	if (!(isNil "_killed") && _players == 0) then
	{
		if ((gTimer - _killed) > gCleanUpDelay) then
		{
			_x setVariable ["killed", nil, true];
			_x setPos  getMarkerPos "graveyard";
		};
	};
	
	if (!(_x getVariable ["persist", false]) && (_x distance2D getMarkerPos "graveyard") < _deleteDistance) then 
	{
		deleteVehicle _x;
	};
} forEach allDeadMen;

//empty groups
{if ((count (units _x)) == 0) then {deleteGroup _x; _x = grpNull; _x = nil}} foreach allGroups;

//gear on ground

private _wholders = nearestObjects [getMarkerPos "zoneCenter", ["WeaponHolder","GroundWeaponHolder","WeaponHolderSimulated"], 3000, true];

{
	if (!(_x getVariable ["persist", false])) then 
	{	
		private _dropped = _x getVariable ["dropped", nil];
		
		if (isNil "_dropped") then
		{
			_x setVariable ["dropped", gTimer, true];
		};
		
		private _entities = nearestObjects [position _x, [gPlayerClass], gCleanUpRangeFromPlayer, true];
		private _onlyPlayers = [];
		
		{
			if(alive _x) then
			{
				_onlyPlayers = _onlyPlayers + [_x];
			};
		}
		forEach _entities;
		
		private _players = count(_onlyPlayers);
		
		if (!(isNil "_dropped") && _players == 0) then
		{
			if ((gTimer - _dropped) > gCleanUpDelay) then
			{
				_x setVariable ["_dropped", nil, true];
				_x setPos  getMarkerPos "graveyard";
			};
		};
	};
} forEach _wholders;

_wholders = nearestObjects [getMarkerPos "graveyard", ["WeaponHolder","GroundWeaponHolder","WeaponHolderSimulated"], _deleteDistance, true];

{
	deleteVehicle _x;
} forEach _wholders;
