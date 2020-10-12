private _unit = _this select 0; 

waitUntil {!isNil "soa_init_done"};

_unit setVariable ["killed", gTimer, true];
_unit setVariable ["inZone", false, true];
raidPlayerUIDin = [getPlayerUID player, gTimer];
publicVariableServer "raidPlayerUIDin";

gogglesFix = goggles _unit;

[_unit, false, true] call fnc_resetPlayer;

gStart = true;

sleep 1;

["MENU",false] call bis_fnc_blackOut;
0 fadeSound 0;