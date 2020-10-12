//Unit that should patrol
private _unit 	= _this select 0;

//Starting location
private _start	= _this select 1;

//Maximum range
private _range	= _this select 2;

//Amount of waypoints
private _amount = _this select 3;

private _bossTeam = _this select 4;

private _grp = group _unit;

private _i = 0;

private _behaviour = selectRandom["COMBAT", "STEALTH", "AWARE", "SAFE"];
private _mode = selectRandom["RED", "YELLOW", "WHITE", "GREEN"];
private _formation = selectRandom["COLUMN", "VEE", "WEDGE", "STAG COLUMN"];
private _speed = selectRandom["LIMITED", "NORMAL", "FULL"];

if(_bossTeam) then
{
	_behaviour = selectRandom["AWARE"];
	_mode = selectRandom["YELLOW"];
	_formation = selectRandom["STAG COLUMN"];
	_speed = selectRandom["LIMITED"];
};

_grp setBehaviour _behaviour;
_grp setCombatMode _mode;
_grp setFormation _formation;
_grp setSpeedMode _speed;

private _wxs = 0;
private _wys = 0;

while { _i < _amount} do { 
	private _distance = 0;
	private _wdir = 0;
	private _wx = 0;
	private _wy = 0;
	private _wp = 0;
	
	scopeName "foundWP";
	
	private _count = 0;
	
	while {true} do {
		scopeName "badWP";
		
		private _valid = true;
		_distance = random _range;
		_wdir = 10 max (random 360);
		_wx = (_start select 0) + (_distance * (sin _wdir));
		_wy = (_start select 1) + (_distance * (cos _wdir));
		
		{
			if([_wx, _wy] inArea _x) then {_valid = false; breakTo "badWP";};
		} forEach gAreas;
		
		if(_valid || _count > 100) then {breakTo "foundWP";};
		
		_count = _count + 1;
		sleep 0.01;
	};
	
	_wp = _grp addWaypoint [[_wx,_wy], 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointStatements ["true", ""];
	_wp setWaypointCompletionRadius 30;
	
	if ( _i == 0 ) then {
		_wxs = _wx;
		_wys = _wy;
		_wp setWaypointBehaviour _behaviour;
		_wp setWaypointCombatMode _mode;
		_wp setWaypointFormation _formation;
		_wp setWaypointSpeed _speed; 
	};
	
	_i = _i + 1;
};

private _wp = _grp addWaypoint [[_wxs,_wys], 0];
_wp setWaypointStatements ["true", ""];
_wp setWaypointType "CYCLE";    
_wp setWaypointCompletionRadius 30;          