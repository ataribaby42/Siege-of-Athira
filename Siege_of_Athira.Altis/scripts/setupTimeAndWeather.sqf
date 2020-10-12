if (gClientMode == "SINGLEPLAYER") then
{
	gPersistentTime = true;
	false execVM "scripts\setTime.sqf";
	execVM "scripts\setWeather.sqf";
};

if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then 
{	
	gRealtimeServerTime execVM "scripts\setTime.sqf";
	execVM "scripts\setWeather.sqf";
};