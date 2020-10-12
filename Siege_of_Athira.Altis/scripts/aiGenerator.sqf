private _guerrillaCount = 0;
private _natoCount = 0;
private _players = count (allPlayers - entities "HeadlessClient_F");

{
	if (alive _x) then
	{
		if (_x getVariable["ai", "none"] == "guerrilla") then {_guerrillaCount = _guerrillaCount + 1;};
		if (_x getVariable["ai", "none"] == "nato") then {_natoCount = _natoCount + 1;};
	};
} forEach allUnits;

if (_guerrillaCount < gGuerrillaLimit) then
{
	private _renegade = false;
	private _groupSize = selectRandom [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 3, 3, 3];
	
	if (_groupSize == 1) then
	{
		private _dice = selectRandom [1, 2, 3, 4, 5, 6];

		if(_dice > 2) then
		{
			_renegade = true;
		};
	};
	
	private _pos = call fnc_getSpawnPos;
	private _side = resistance;
	private _grp = createGroup _side;

	for "_i" from 1 to _groupSize do 
	{
		private _unit = _grp createUnit [gGuerrillaAiClass, _pos, [], 0, "NONE"];
		_unit setVariable ["BIS_enableRandomization", false];
		
		if(_i == 1) then
		{
			_grp selectLeader _unit;
		};
		
		waitUntil {!isNil{name _unit}};
		waitUntil {(name _unit) != ""};
		
		/*
		if(gClientMode == "SINGLEPLAYER" && selectRandom[0,0,0,1,1] == 1) then
		{
			_unit setVariable ["dogtags", [name _unit, "AI"], true];
		};
		*/
		
		[_unit] joinsilent _grp;
		
		if(_renegade) then
		{
			_unit setVariable ["renagade", true, true];
			[-10000, _unit] call fnc_setRating;
		};
		
		_unit setVariable ["ai","guerrilla", true];
		
		if(_groupSize == 1) then
		{
			[_side, _unit, _renegade, 0, call fnc_predictNight, call fnc_isMoonlight, false] call fnc_aiSetup;
		}
		else
		{
			[_side, _unit, _renegade, _i, call fnc_predictNight, call fnc_isMoonlight, false] call fnc_aiSetup;
		};
		
		sleep 0.1;
	};
	
	_grp setCombatMode "RED";
	deleteWaypoint [_grp, 0];
	
	{
		[_x, false] spawn fnc_aiAgent;
	} foreach units _grp; 
};

private _natoMax = (10 - _players) min gNatoLimit;

if (_natoCount < _natoMax) then
{
	private _renegade = false;
	private _groupSize = selectRandom [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 3];
	
	if (_groupSize == 1) then
	{
		private _dice = selectRandom [1, 2, 3, 4, 5, 6];

		if(_dice > 2) then
		{
			_renegade = true;
		};
	};

	private _pos = call fnc_getSpawnPos;
	private _side = west;
	private _grp = createGroup _side;

	for "_i" from 1 to _groupSize do 
	{
		private _unit = _grp createUnit [gPlayerAiClass, _pos, [], 0, "NONE"];
		_unit setVariable ["BIS_enableRandomization", false];
		
		waitUntil {!isNil{name _unit}};
		waitUntil {(name _unit) != ""};
		
		_unit setVariable ["dogtags", [name _unit, "AI"], true];

		if(_renegade) then
		{
			_unit setVariable ["renagade", true, true];
			[_unit] joinSilent natoBadGuy; 
			[_unit] joinSilent grpNull; 
			_unit addRating -10000;
			_grp = group _unit;
		}
		else
		{
			[_unit] joinsilent _grp;
		};

		if(_i == 1) then
		{
			_grp selectLeader _unit;
		};
		
		_unit setVariable ["ai","nato", true];
		
		if(_groupSize == 1) then
		{
			[_side, _unit, _renegade, 0, call fnc_predictNight, call fnc_isMoonlight, false] call fnc_aiSetup;
		}
		else
		{
			[_side, _unit, _renegade, _i, call fnc_predictNight, call fnc_isMoonlight, false] call fnc_aiSetup;
		};
		
		sleep 0.1;
	};
	
	_grp setCombatMode "RED";
	deleteWaypoint [_grp, 0];
	
	{
		[_x, false] spawn fnc_aiAgent;
	} foreach units _grp; 
};
