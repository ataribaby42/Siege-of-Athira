private _unit =_this select 0;
private _sniper = _this select 1;

diag_log format["*** %1 acitaved on %2", _sniper, _unit];

private _shots = selectRandom [1,1,2];
sleep selectRandom [3,4,5,6,7,8,9,10];

scopeName "endSniper";
	
for "_i" from 1 to _shots do
{
	if(alive _unit && ((_unit distance2D getMarkerPos "respawn") > 500) && !(_unit inArea zone)) then
	{
		if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then
		{
			playSound3D ["a3\sounds_f\weapons\hits\soft_ground_1.wss", _unit, false, getPosASL _unit, 1, 1, 100];
			sleep 1;
			playSound3D ["a3\sounds_f\weapons\GM6Lynx\gm6_st_1c.wss", _sniper, false, getPosASL _sniper, 1, 1, 5000];
		}
		else
		{
			playSound3D ["a3\sounds_f\weapons\GM6Lynx\gm6_st_1c.wss", _sniper, false, getPosASL _sniper, 1, 1, 5000];
			playSound3D ["a3\sounds_f\weapons\hits\soft_ground_1.wss", _unit, false, getPosASL _unit, 1, 1, 100];
		};
	}
	else
	{
		if (alive _unit) then
		{
			_unit setVariable ["sniped", false, true];
		};
		breakTo "endSniper";
	};
	
	sleep selectRandom [5,6,7];
};

if(alive _unit && ((_unit distance2D getMarkerPos "respawn") > 500) && !(_unit inArea zone)) then
{
	if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then
	{
		playSound3D ["a3\sounds_f\weapons\hits\body_1.wss", _unit, false, getPosASL _unit, 1, 1, 100];
		sleep 0.1;
		_unit setDamage 1;
		sleep 0.9;
		playSound3D ["a3\sounds_f\weapons\GM6Lynx\gm6_st_1c.wss", _sniper, false, getPosASL _sniper, 1, 1, 5000];
	}
	else
	{
		playSound3D ["a3\sounds_f\weapons\hits\body_1.wss", _unit, false, getPosASL _unit, 1, 1, 100];
		sleep 0.1;
		_unit setDamage 1;
		playSound3D ["a3\sounds_f\weapons\GM6Lynx\gm6_st_1c.wss", _sniper, false, getPosASL _sniper, 1, 1, 5000];
	};
}
else
{
	if (alive _unit) then
	{
		_unit setVariable ["sniped", false, true];
	};
};

if (alive _unit) then
{
	_unit setVariable ["sniped", false, true];
};