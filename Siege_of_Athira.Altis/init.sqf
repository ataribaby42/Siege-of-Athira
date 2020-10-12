enableSaving [ false, false ];
enableSentences false;
enableRadio false;
showChat false;
showSubtitles false;

gDebugEnabled = false;
gMissionSetupCompleted = false;
gClientSetupCompleted = false;
gServerSetupCompleted = false;

gSideE = createCenter east;
gSideW = createCenter west;
gSideR = createCenter resistance;

gObjectiveVisible = false;
gLockedTime = 0;
gPlayerLocked = false;
raidPlayerUIDin = "";
raidPlayerUIDout = "";
endWarning10 = false;
endWarning5 = false;
endWarning1 = false;
gAction = false;
gStamina = 1;
gFood = 0;
gFlareActive = false;
gCurrentView = "INTERNAL";

// flare intensity, replace 30 with desired value
al_flare_intensity = 15;
publicvariable "al_flare_intensity";

// flare range, replace 500 with desired value
al_flare_range = 500;
publicvariable "al_flare_range";

waitUntil {!isNil "soa_ClientMode_done"};

if (gClientMode == "CLIENT" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then
{
	private _localized = localize "STR_please_wait";
	private _duration = 3;  
	private _fadeInTime = 2;    
	private _introText = format["<t font='PuristaBold' size='1' align='right'>%1</t>",_localized];  
	gPleaseWaitHandler = [_introText,safezoneX+safezoneW-1.1,safezoneY+safezoneH-0.3,_duration,_fadeInTime,0,90] spawn bis_fnc_dynamicText;
};

waitUntil {!isNil "soa_init_done"};

addMissionEventHandler ["EntityKilled", {[_this select 0, _this select 1] execVM "scripts\killed.sqf";}];

private _handler = 0;

_handler = execVM "scripts\setupTimeAndWeather.sqf";
waitUntil { scriptDone _handler };

_handler = execVM "scripts\readMap.sqf";
waitUntil { scriptDone _handler };

_handler = execVM "scripts\setupPlayerSpawns.sqf";
waitUntil { scriptDone _handler };

_handler = execVM "scripts\setupMap.sqf";
waitUntil { scriptDone _handler };

if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	_handler = execVM "scripts\generateWeaponCaches.sqf";
	waitUntil { scriptDone _handler };
	
	gTimer = 0;
	publicVariable "gTimer";
	execVM "scripts\missionTimer.sqf";
};

execVM "scripts\setupServer.sqf";
execVM "scripts\setupClient.sqf";
execVM "scripts\mainLoop.sqf";
execVM "scripts\aiSpawnThread.sqf";
execVM "scripts\lootSpawnThread.sqf";

if (gClientMode == "DEDICATED_SERVER") then 
{
	waitUntil {gServerSetupCompleted};
	gMissionSetupCompleted = true;
};

if (gClientMode == "LOCAL_SERVER") then 
{
	waitUntil {gServerSetupCompleted && gClientSetupCompleted};
	gMissionSetupCompleted = true;
};

if (gClientMode == "SINGLEPLAYER") then 
{
	waitUntil {gClientSetupCompleted};
	gMissionSetupCompleted = true;
};

if (gClientMode == "CLIENT") then 
{
	waitUntil {gClientSetupCompleted};
	gMissionSetupCompleted = true;
};

if (gClientMode == "CLIENT" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then
{
	[false] call fnc_closeMenu;
	[]execVM"CRS\init.sqf";
	[]execVM "outlw_magRepack\MagRepack_init_sv.sqf";
};