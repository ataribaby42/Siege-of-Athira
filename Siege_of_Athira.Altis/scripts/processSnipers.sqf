if(!(isNil{list zone})) then 
{
	{
		if(!(_x getVariable ["nosnipers", false])) then
		{
			if((side _x) != civilian && (side _x) != east && alive _x && ((_x distance2D getMarkerPos "respawn") > 500) && !(_x getVariable ["sniped", false])) then
			{
				if(!(_x inArea zone)) then
				{
					private _orig = position _x;
					private _dest = getMarkerPos "zoneCenter";
					private _vector = ((((_dest select 0) - (_orig select 0)) atan2 ((_dest select 1) - (_orig select 1))) + 360) % 360;
					private _sniper = vsniperN;
					if(_vector < 45 || _vector > 315) then {_sniper = vsniperS};
					if(_vector >= 45 && _vector <= 135) then {_sniper = vsniperW};
					if(_vector <= 315 && _vector >= 255) then {_sniper = vsniperE};
					_x setVariable ["sniped", true, true];
					[_x, _sniper] spawn fnc_vsniper;
				};
				
				private _inSniperZone = false;
				private _unit = _x;
				
				{
					if(_unit inArea _x) then
					{
						_inSniperZone = true;
					};
				}
				forEach gSniperZones;

				{
					if(_unit inArea _x) then
					{
						_inSniperZone = false;
					};
				}
				forEach gNoSniperZones;

				if(!gZoneVSniperActive && _inSniperZone && !(_x getVariable ["snipedField", false])) then
				{
					gZoneVSniperActive = true;
					_x setVariable ["snipedField", true, true];
					[_x] spawn fnc_zoneVSniper;
				};
			};
		};
	} forEach allUnits;
};