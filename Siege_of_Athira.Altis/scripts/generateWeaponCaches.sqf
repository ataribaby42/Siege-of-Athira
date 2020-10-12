gActiveWeaponCaches = [];
private _cache = 0;

for "_i" from 1 to 2 do 
{
	_cache = selectRandom gWeaponCaches;
	gActiveWeaponCaches = gActiveWeaponCaches + [_cache];
	gWeaponCaches = gWeaponCaches - [_cache];
};

{
	deleteVehicle _x;
} forEach gWeaponCaches;

gWeaponCaches = nil;

{
	[_x] execVM "scripts\fillWeaponCache.sqf";
} forEach gActiveWeaponCaches;

publicVariable "gActiveWeaponCaches";