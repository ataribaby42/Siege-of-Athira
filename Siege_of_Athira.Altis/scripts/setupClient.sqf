if (gClientMode == "CLIENT" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then
{
	"gMissionEnded" addPublicVariableEventHandler { 
		if(gMissionEnded) then
		{
			[false] call fnc_closeMenu;
		}
	};

	//create local trader boxes
	if(gTraderActive) then
	{
		{
			private _box = "Box_IND_Support_F" createVehicleLocal [0,0,0];
			_box setVehiclePosition [getPosATL _x, [], 0, "CAN_COLLIDE"];
			_box setDir getDir _x;
			_box allowDamage false;

			clearWeaponCargoGlobal _box;
			clearMagazineCargoGlobal _box;
			clearItemCargoGlobal _box;
			clearBackpackCargoGlobal _box;

			gTraderBoxes = gTraderBoxes + [_box];
		} forEach gTraderBoxSpawns;
	};

	//remove clock from map
	waitUntil {str(findDisplay 12) != "no display"};
	waitUntil {!((findDisplay 12 displayCtrl 101) isEqualTo controlNull)};
	findDisplay 12 displayCtrl 101 ctrlShow false;
	
	{_x setMarkerAlpha 0} foreach gAreas + gSpawnPoints + gPatrolPositions + gLeafletDrops + ["zoneCenter", "respawn", "graveyard", "helispawn", "dronespawn", "leafletDroneSpawn"];
	
	if (gClientMode == "CLIENT") then 
	{
		gExtractions = [];
		
		waitUntil {!isNil "gActiveExtractions"};

		{
			private _exit = missionNamespace getVariable [_x, objNull];
			
			if (!(isNull _exit)) then {
				_exit setTriggerText (_x);
				gExtractions = gExtractions + [_exit];
			};
		} foreach gActiveExtractions;
	};

/*
	if (gClientMode == "CLIENT") then 
	{
		{
			if(_x iskindof "Leaflet_05_F") then
			{
				["init",[_x, "images\leaflet_co.paa", localize "STR_Leaflet"]] call bis_fnc_initLeaflet; 
			};
		} foreach (nearestObjects [getMarkerPos "zoneCenter", [], 3000, true]); 
	};		
*/
	
	if (gClientMode == "SINGLEPLAYER") then
	{
		gMissionTime = 0;
		gMissionEnded = false;
	};
	
	if (gClientMode == "CLIENT") then
	{
		waitUntil {!isNil "gRaidGUID" && !isNil "gDate" && !isNil "gSunElevation" && !isNil "gMoonPhase" && !isNil "gTemp"};
		setDate gDate;
		gClientSetupCompleted = true;
	};
	
	if (gClientMode == "LOCAL_SERVER") then
	{
		gClientSetupCompleted = true;
	};
	
	if (gClientMode == "SINGLEPLAYER") then 
	{
		waitUntil {!isNil "gTimeSet"};
		waitUntil {!isNil "gWeather"};
		waitUntil {!isNil "gTimer"};
		gRaidGUID = call fnc_generateGUID;
		gTemp = gClimate call llw_fnc_getTemperature select 0;
		gSunElevation = [] call llw_fnc_getSunAngle;
		gMoonPhase = call fnc_computeMoonPhase;
		gClientSetupCompleted = true;
	};
	
	gStart = true;
};