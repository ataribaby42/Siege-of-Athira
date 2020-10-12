if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then
{
	sleep 1;
	playSound3D ["a3\sounds_f\weapons\mortar\mortar_01.wss", vsniperN, false, getPosASL vsniperN, 1, 1, 3000];
	sleep 9;
}
else
{
	playSound3D ["a3\sounds_f\weapons\mortar\mortar_01.wss", vsniperN, false, getPosASL vsniperN, 1, 1, 3000];
	sleep 10;
};

private _xPos = getMarkerPos "zoneCenter" select 0;
private _yPos = getMarkerPos "zoneCenter" select 1;
private _zPos = getTerrainHeightASL(getMarkerPos "zoneCenter");
private _position = [_xPos, _yPos, _zPos] vectorAdd [(random 200) - 100, (random 200) - 100, 620]; 
private _flare = 0;

private _green = false;

if(!isNil "gCSATteam") then
{
	if(gCSATteam) then
	{
		_green = true;
	};
};

if(_green) then
{
	_flare = createVehicle ["F_40mm_Green_Infinite", _position, [], 0, "none"]; 
}
else
{
	_flare = createVehicle ["F_40mm_White_Infinite", _position, [], 0, "none"]; 
};

_flare setVelocity [wind select 0, wind select 1, 0.1];

[[[_flare],"scripts\al_flare_enhance.sqf"],"BIS_fnc_execVM", true, true] spawn BIS_fnc_MP;

gFlareActive = true;
publicVariable "gFlareActive";

sleep 140;
deleteVehicle _flare;

gFlareActive = false;
publicVariable "gFlareActive";