gDebug = false;
gTraderActive = true;
gRealtimeServerTime = [false,true] select ("soaRealtimeServerTime" call BIS_fnc_getParamValue); //Works only for hosted or dedicated MP server! Consider to use -autoInit dedicated server starting parameter otherwise not very reliable.
gRandomMissionStartTimes = [[2035, 7, 13, 4, 30], [2035, 7, 13, 6, 0], [2035, 7, 13, 11, 30], [2035, 7, 13, 18, 0], [2035, 7, 13, 19, 30], [2035, 7, 13, 22, 0], [2035, 6, 24, 23, 0], [2036, 1, 15, 8, 0], [2036, 1, 15, 2, 0]];

private _startTime = "soaManualTime" call BIS_fnc_getParamValue;
if(_startTime > 0) then
{
	if(_startTime == 1) then {gRandomMissionStartTimes = [[2035, 7, 13, 4, 30]];};
	if(_startTime == 2) then {gRandomMissionStartTimes = [[2035, 7, 13, 6, 0]];};
	if(_startTime == 3) then {gRandomMissionStartTimes = [[2035, 7, 13, 11, 30]];};
	if(_startTime == 4) then {gRandomMissionStartTimes = [[2035, 7, 13, 18, 0]];};
	if(_startTime == 5) then {gRandomMissionStartTimes = [[2035, 7, 13, 19, 30]];};
	if(_startTime == 6) then {gRandomMissionStartTimes = [[2035, 7, 13, 23, 0]];};
	if(_startTime == 7) then {gRandomMissionStartTimes = [[2035, 6, 24, 23, 0]];};
	if(_startTime == 8) then {gRandomMissionStartTimes = [[2036, 1, 15, 8, 0]];};
	if(_startTime == 9) then {gRandomMissionStartTimes = [[2036, 1, 15, 2, 0]];};
};

//gPersistentTime = false;
gSinglePlayerTime = false;
gRealtimeServerTimeYear = 2035;
gForceFirstPerson = [false,true] select ("soaForceFirstPerson" call BIS_fnc_getParamValue);
gExtractionTime = 20; //seconds
gEntryTime = 5;  //seconds
gTimeout = "soaDeathTimeout" call BIS_fnc_getParamValue; //seconds
gMissionDuration = ("soaMissionDuration" call BIS_fnc_getParamValue) * 60; //seconds
gGuerrillaLimit = "soaGuerrillaLimit" call BIS_fnc_getParamValue;
gNatoLimit = selectRandom[0,1,2,3,4,5];

private _natoLimit = "soaNatoLimit" call BIS_fnc_getParamValue;
if(_natoLimit > -1) then
{
	gNatoLimit = _natoLimit;
};

gAiSpawnCheckTime = 30; //seconds
gCleanUpDelay = 10 * 60; //seconds
gCleanUpRangeFromPlayer = 100; //meters
gNumOfExits = "soaNumOfExits" call BIS_fnc_getParamValue; //minimum of 1 exit!
gMinDistanceBetweenExits = 100; //meters
gExitIconVisibility = 50; //meters;
gTraderIconVisibility = 100; //meters;
gDegradeNVG = true;
gFoodLimit = "soaFoodLimit" call BIS_fnc_getParamValue;
gFoodSpawnCheckTime = 10 * 60; //seconds
gFoodCarryLimit = 3;
gClimate = [];
gSPstartDate = [2035,11,6,8,0];
gZoneVSniperActive = false;

//Searchable houses for AI

gSearchableHouses = [
"Land_u_House_Big_01_V1_F",
"Land_i_House_Big_02_V2_F",
"Land_i_House_Big_02_V3_F",
"Land_i_Stone_HouseBig_V3_F",
"Land_i_House_Small_02_V2_F",
"Land_i_House_Big_01_V2_F",
"Land_i_House_Small_01_V3_F",
"Land_u_House_Big_02_V1_F",
"Land_i_Stone_HouseBig_V2_F",
"Land_i_House_Small_01_V2_F",
"Land_i_House_Small_01_V1_F",
"Land_i_Stone_HouseSmall_V2_F",
"Land_i_House_Small_02_V1_F",
"Land_Chapel_Small_V1_F",
"Land_u_House_Small_02_V1_F",
"Land_d_Stone_HouseBig_V1_F",
"Land_i_Stone_HouseSmall_V3_F",
"Land_CarService_F",
"Land_u_House_Small_01_V1_F",
"Land_i_House_Big_01_V3_F",
"Land_i_House_Small_02_V3_F",
"Land_i_House_Big_02_V1_F",
"Land_i_House_Big_01_V1_F",
"Land_u_House_Big_02_V1_F",
"Land_i_Stone_HouseSmall_V1_F",
"Land_i_Stone_HouseBig_V1_F"
];

//base game definitions

gSavePrefix = "soa";
gPlayerClass = "B_Soldier_F";
gPlayerAiClass = "B_Survivor_F";
gGuerrillaAiClass = "I_G_Soldier_F";
gEnemyReconClasses = ["O_recon_TL_F", "O_recon_F", "O_recon_medic_F", "O_recon_M_F"];
gOldNVGClass = "NVGoggles";
gModernNVGClass = "NVGoggles_OPFOR";
gHandGuns = ["hgun_Pistol_heavy_02_F", "hgun_Rook40_F", "hgun_P07_F", "hgun_ACPC2_F", "hgun_Pistol_heavy_01_F"];
gSubmachineGuns = ["hgun_PDW2000_F", "SMG_02_F", "SMG_01_F"];
gWarmUniforms = ["U_O_SpecopsUniform_ocamo", "U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_worn", "U_BG_Guerilla3_1", "U_BG_Guerrilla_6_1", "U_B_CTRG_1", "U_B_CTRG_3"];