private _pos = call fnc_getSpawnPos;
private _side = resistance;
private _grp = createGroup _side;
private _unit = 0;
private _groupSize = 3;

//boss
_unit = _grp createUnit [gGuerrillaAiClass, _pos, [], 0, "NONE"];
_unit setVariable ["BIS_enableRandomization", false];
waitUntil {!isNil{name _unit}};
waitUntil {(name _unit) != ""};
[_unit] joinsilent _grp;
_grp selectLeader _unit;
_unit setVariable ["ai","guerrillaBoss", true];
_unit setVariable ["dogtags", [name _unit, "AI"], true];
[_side, _unit, false, 0, call fnc_predictNight, call fnc_isMoonlight, true] call fnc_aiSetup;

sleep 0.1;

//boss guards
for "_i" from 1 to _groupSize do 
{
	_unit = _grp createUnit [gGuerrillaAiClass, _pos, [], 0, "NONE"];
	_unit setVariable ["BIS_enableRandomization", false];
	waitUntil {!isNil{name _unit}};
	waitUntil {(name _unit) != ""};
	_unit setVariable ["dogtags", [name _unit, "AI"], true];
	[_unit] joinsilent _grp;
	_unit setVariable ["ai","guerrillaBossGuard", true];
	[_side, _unit, false, _i, call fnc_predictNight, call fnc_isMoonlight, true] call fnc_aiSetup;
	sleep 0.1;
};

_grp setCombatMode "YELLOW";
deleteWaypoint [_grp, 0];

{
	[_x, true] spawn fnc_aiAgent;
} foreach units _grp; 