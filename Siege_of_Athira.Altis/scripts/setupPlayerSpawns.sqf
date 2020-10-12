if (gClientMode == "SINGLEPLAYER") then
{
	private _player = 0;
	
	playersInRaid = [];
	
	for "_i" from 2 to 10 do 
	{
		_player = missionNamespace getVariable ["player" + str(_i) , objNull];
		deleteVehicle _player;
	};
};

if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	{
		clearWeaponCargoGlobal _x; 
		clearMagazineCargoGlobal _x; 
		clearItemCargoGlobal _x; 
		clearBackpackCargoGlobal _x;
	} forEach [playerCrate1, playerCrate2, playerCrate3, playerCrate4, playerCrate5, playerCrate6, playerCrate7, playerCrate8, playerCrate9, playerCrate10];
};