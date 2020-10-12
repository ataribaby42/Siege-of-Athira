if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	waitUntil {gMissionSetupCompleted};

	for "_i" from 1 to (gGuerrillaLimit + gNatoLimit) do 
	{
		[] call fnc_aiGenerator;
		sleep 0.1;
	};

	while {true} do 
	{
		sleep gAiSpawnCheckTime;
		[] call fnc_aiGenerator;
	};	
};