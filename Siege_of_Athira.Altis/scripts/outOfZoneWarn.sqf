if((player getVariable ["inZone", false]) && ((player distance2D getMarkerPos "respawn") > 500)) then 
{
	["OutOfZone",[localize "STR_LeaveTownWarnTitle", localize "STR_LeaveTownWarnMessage"]] call bis_fnc_showNotification;
};