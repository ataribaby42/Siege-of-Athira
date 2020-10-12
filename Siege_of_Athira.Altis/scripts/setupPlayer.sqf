if (gClientMode == "CLIENT" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then
{
	waitUntil {!(isNull player)};
	
	execVM "scripts\hudTags.sqf";
	[player] execVM "scripts\createDiary.sqf";
	private _killed =  ["killed", false] call fnc_loadData;
	[player, _killed, false] execVM "scripts\createPlayer.sqf";
};