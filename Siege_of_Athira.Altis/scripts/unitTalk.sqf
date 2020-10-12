private _unit = _this select 0;
private _sound = _this select 1;
private _delay = _this select 2;

if ((_unit getVariable ["talking", false])) exitWith {};
if ((_unit getVariable ["dying_scream", false])) exitWith {};

_unit setVariable ["talking", true];

sleep(Random 3);

if(alive _unit) then
{
	playSound3D [MISSION_ROOT + "sounds\" + _sound, _unit, false, getPosASL _unit, 5, 1, 150];
	[_unit, true] remoteExec ["setRandomLip"];  
	sleep _delay;
	[_unit, false] remoteExec ["setRandomLip"];  
};

_unit setVariable ["talking", nil];
