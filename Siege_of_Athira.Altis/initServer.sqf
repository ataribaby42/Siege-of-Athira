addMissionEventHandler ['HandleDisconnect',{ if(((_this select 0) distance2D getMarkerPos "respawn") < 500) then {deleteVehicle (_this select 0);}; }];