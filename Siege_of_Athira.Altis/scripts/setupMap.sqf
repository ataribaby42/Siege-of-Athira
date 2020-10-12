private _seed = 1138;
_seed =  round(_seed % 42);
if (_seed == 0) then {_seed = 42;};


(getMarkerPos "zoneCenter") execVM "scripts\killLights.sqf";

if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	private _houses = nearestTerrainObjects [getmarkerpos "zoneCenter", ["House","Building"], 1000];  
	{  
		private _pos = position _x;
		private _posX = _pos select 0;
		private _posY = _pos select 1;
		private _posTotal = _posX + _posY;
		private _seedLocal = (_posTotal % _seed) / _seed;

		if (_seedLocal >= 0.3) then
		{
			_x setDamage 0.5;
		};

	} count _houses;
};
