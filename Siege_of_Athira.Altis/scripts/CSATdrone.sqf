gCSATdrone = true; 
publicVariable "gCSATdrone";

private _spawn = getMarkerPos "dronespawn";

diag_log "*** CSAT drone deployed";

private _droneGroup = createGroup east;
private _drone = createVehicle ["O_UAV_02_CAS_F", _spawn, [], 0, "FLY"];
_drone allowDamage false;
createvehiclecrew _drone;
private _crew = crew _drone;
_crew joinsilent _droneGroup;

{
	_x allowDamage false;
} forEach _crew;

_droneGroup addVehicle _drone;
_droneGroup selectLeader (commander _drone);
deleteWaypoint [_droneGroup, 0];
_droneGroup setCombatMode "BLUE";
_drone setBehaviour "CARELESS";
_drone setSpeedMode "LIMITED"; 
_drone flyInHeight 150;
_drone setPos [getPos _drone select 0, getpos _drone select 1, 500];

private _wp = _droneGroup addWaypoint [getMarkerPos "zoneCenter", 0];
_wp setWaypointType "LOITER";
_wp setWaypointStatements ["true", ""];

waitUntil {sleep 1; (!gCSATteam || call fnc_isNight);};

deleteWaypoint [_droneGroup, 0];

_wp = _droneGroup addWaypoint [getMarkerPos "dronespawn", 0];
_wp setWaypointType "MOVE";
_wp setWaypointStatements ["true", ""];
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointCombatMode "BLUE";
_wp setWaypointCompletionRadius 100;
_wp setWaypointStatements ["true", "if (isServer) then {_cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew _cleanUpveh + [_cleanUpveh];}; gCSATdrone = false; publicVariable 'gCSATdrone';"];