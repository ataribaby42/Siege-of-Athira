gPlayerPositions = [];

for "_i" from 1 to 99 do 
{
	private _pos = missionNamespace getVariable ["playerPos" + str(_i) , objNull];
	
	if (!(isNull _pos)) then {
		gPlayerPositions = gPlayerPositions + [_pos];
	};
};

gSniperZones = [];

for "_i" from 1 to 99 do 
{
	private _zone = missionNamespace getVariable ["sniperZone" + str(_i) , objNull];
	
	if (!(isNull _zone)) then {
		gSniperZones = gSniperZones + [_zone];
	};
};

gNoSniperZones = [];

for "_i" from 1 to 99 do 
{
	private _zone = missionNamespace getVariable ["noSniperZone" + str(_i) , objNull];
	
	if (!(isNull _zone)) then {
		gNoSniperZones = gNoSniperZones + [_zone];
	};
};

gMinesZones = [];

for "_i" from 1 to 99 do 
{
	private _zone = missionNamespace getVariable ["minesZone" + str(_i) , objNull];
	
	if (!(isNull _zone)) then {
		gMinesZones = gMinesZones + [_zone];
	};
};

gExtractions = [];

if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	private _allExtractions = [];

	for "_i" from 1 to 99 do 
	{
		private _exit = missionNamespace getVariable ["extraction" + str(_i) , objNull];
		
		if (!(isNull _exit)) then {
			_exit setTriggerText ("extraction" + str(_i));
			_allExtractions = _allExtractions + [_exit];
		};
	};

	[_allExtractions] execVM "scripts\randomizeExits.sqf";
};

gEntryPoints = [];

for "_i" from 1 to 99 do 
{
	private _entry = missionNamespace getVariable ["entry" + str(_i) , objNull];
	
	if (!(isNull _entry)) then {
		gEntryPoints = gEntryPoints + [_entry];
	};
};
	
gStarts = [];

for "_i" from 1 to 99 do 
{
	private _start = missionNamespace getVariable ["start" + str(_i) , objNull];
	
	if (!(isNull _start)) then {
		gStarts = gStarts + [_start];
	};
};	

gAreas = [];

for "_i" from 1 to 99 do 
{
	private _marker = "area" + str(_i);
	
	if (_marker in allMapMarkers) then {
		gAreas = gAreas + [_marker];
	};
};

gPatrolPositions = [];

for "_i" from 1 to 99 do 
{
	private _marker = "patrolPos" + str(_i);
	
	if (_marker in allMapMarkers) then {
		gPatrolPositions = gPatrolPositions + [_marker];
	};
};

gSpawnPoints = [];

for "_i" from 1 to 99 do 
{
	private _marker = "aiSpawn" + str(_i);

	if (_marker in allMapMarkers) then {
		gSpawnPoints = gSpawnPoints + [_marker];
	};
};

gHeliPads = [];

for "_i" from 1 to 99 do 
{
	private _entry = missionNamespace getVariable ["heliPad" + str(_i) , objNull];
	
	if (!(isNull _entry)) then {
		gHeliPads = gHeliPads + [_entry];
	};
};	

gLeafletDrops = [];

for "_i" from 1 to 99 do 
{
	private _marker = "leafletDroneDrop" + str(_i);

	if (_marker in allMapMarkers) then {
		gLeafletDrops = gLeafletDrops + [_marker];
	};
};	

gWeaponCaches = [];

if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	private _areaSize = getMarkerSize "safeZoneArea";
	private _size = _areaSize select 0;

	if(_areaSize select 1 > _size) then
	{
		_size = _areaSize select 1;
	};

	{
		if(_x inArea "safeZoneArea") then
		{
			gWeaponCaches = gWeaponCaches + [_x];
		};
	} forEach nearestObjects [getMarkerPos "safeZoneArea", ["Box_NATO_Wps_F"], _size, true];
};

gTraderBoxSpawns = [];
gTraderBoxes = [];

for "_i" from 1 to 99 do 
{
	private _entry = missionNamespace getVariable ["traderBoxSpawn" + str(_i) , objNull];
	
	if (!(isNull _entry)) then {
		gTraderBoxSpawns = gTraderBoxSpawns + [_entry];
	};
};	
