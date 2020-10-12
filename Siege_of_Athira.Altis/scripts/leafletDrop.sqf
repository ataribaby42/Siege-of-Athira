private _spawn = getMarkerPos "leafletDroneSpawn";
private _drop = getMarkerPos  (_this select 0);

_droneGroup = createGroup east;
private _drone = createVehicle ["C_UAV_06_F", _spawn, [], 0, "FLY"];
_drone addMagazine "1Rnd_Leaflets_East_F";
_drone addWeapon "Bomb_Leaflets";
//_drone setCaptive 1;
createvehiclecrew _drone;
_crew = crew _drone;
_crew joinsilent _droneGroup;
_droneGroup addVehicle _drone;
_droneGroup selectLeader (commander _drone);
deleteWaypoint [_droneGroup, 0];
_droneGroup setCombatMode "BLUE";
_droneGroup setBehaviour "CARELESS";
_drone flyInHeight 30;
_drone setPos [getPos _drone select 0, getpos _drone select 1, 30];

private _wp1 = _droneGroup addWaypoint [_drop, 20];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointTimeout [5, 5, 5];
_wp1 setWaypointCompletionRadius 5;
_wp1 setWaypointStatements ["true", "if (isServer) then {diag_log '*** Leaflet waypoint reached and leaflets dropped'; (vehicle this) fire 'Bomb_Leaflets';};"];
private  _wp2 = _droneGroup addWaypoint [_spawn, 0];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointCompletionRadius 10;
_wp2 setWaypointStatements ["true", "if (isServer) then {diag_log '*** Leaflet final waypoint reached and drone cleaned-up'; _cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew _cleanUpveh + [_cleanUpveh];};"];