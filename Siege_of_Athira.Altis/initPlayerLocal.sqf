private _unit = _this select 0; 
private _jip = _this select 1; 

_unit switchMove "HubSpectator_stand";
_unit allowDamage false;
_unit enableSimulation false;

0 enableChannel false;
1 enableChannel false;
2 enableChannel false;
3 enableChannel false;
4 enableChannel false;
/*
0 = Global
1 = Side
2 = Command
3 = Group
4 = Vehicle
5 = Direct
6 = System
*/

waitUntil {!isNil "soa_init_done"};
waitUntil {!isNil "gMissionSetupCompleted"};
waitUntil {gMissionSetupCompleted};

execVM "scripts\setupPlayer.sqf";

if (gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	[_unit, 0.01] remoteExec ["fnc_simpleBreathFog", 0, _unit]; 
}
else
{
	[_unit, 0.01] remoteExec ["fnc_simpleBreathFog", -2, _unit]; 
};
