disableSerialization;

private _unit = _this select 0; 
private _killed =  _this select 1; 
private _extracted =  _this select 2; 

_unit switchMove "HubSpectator_stand";
_unit allowDamage false;
_unit enableSimulation false;

[_unit, "NoVoice"] remoteExecCall ["setSpeaker", 0]; 

gogglesFix = "";

_unit setVariable ["scoreItems", nil, true];
_unit setVariable ["sniped", false, true];
_unit setVariable ["snipedField", false, true];
_unit setVariable ["inZone", false, true];
_unit setVariable ["dogtags", [name _unit, getPlayerUID _unit], true];
_unit setVariable ["kills", nil, true];
_unit setVariable ["dogtagsNum", nil, true];
_unit setVariable ["stamina", nil, true];
_unit setVariable ["food", nil, true];
_unit setVariable ["dying_scream", nil, true];
_unit setVariable ["renagade", nil, true];

waitUntil {(player getVariable["slot", 0]) != 0};
private _slot = _unit getVariable["slot", 0];
_slot execVM "scripts\resetShelter.sqf";
call fnc_initKillboard;

gInventoryOpen = false;
gObjectiveVisible = false;
gDogtags = 0;
gMenu = 1;

if (visibleMap) then {openMap false;};

private _gearDialog = findDisplay 602;

if (!isNull _gearDialog) then
{
	closeDialog _gearDialog;
};

waitUntil {gMissionSetupCompleted && scriptDone gPleaseWaitHandler};

if (visibleMap) then {openMap false;};

_gearDialog = findDisplay 602;

if (!isNull _gearDialog) then
{
	closeDialog _gearDialog;
};

private _text = localize "STR_SafeHouse";
private _duration = 10;  
private _fadeInTime = 2;    
private _introText = format["<t font='PuristaBold' size='1' align='right'>%1</t><br /><t size='0.9' align='right'>%2 %3</t>", _text, date call fnc_globalizeDate, format ["%1", ([dayTime, "HH:MM"] call BIS_fnc_timeToString)]];

if(!_extracted) then
{
	[_introText,safezoneX+safezoneW-1.1,safezoneY+safezoneH-0.4,_duration,_fadeInTime,0,90] spawn bis_fnc_dynamicText;
};

private _missingInRaid = _unit call fnc_resetPlayerRaid;

private _handle = 0;
private _firstTime = false;

if(_killed || !(isNil "_missingInRaid")) then
{
	[_unit, true, false] call fnc_resetPlayer;
	_firstTime = [_unit, false] call fnc_loadPlayer;
	[_unit, false] call fnc_savePlayer;
	saveProfileNamespace;
	
	if(_killed) then
	{
		_handle = ["killed"] execVM "scripts\menu.sqf";
	}
	else
	{
		_handle = ["killedByQuit"] execVM "scripts\menu.sqf";
	};
}
else
{
	_firstTime = [_unit, false] call fnc_loadPlayer;
	[_unit, false] call fnc_savePlayer;
	saveProfileNamespace;
	
	if(_extracted) then
	{
		_handle = ["extracted"] execVM "scripts\menu.sqf";
	}
	else
	{
		_handle = ["alive"] execVM "scripts\menu.sqf";
	};
};

gStamina = ["stamina", 1] call fnc_loadData;

if(gStamina >= 0) then
{
	_unit forceWalk false;
	_unit allowSprint true;
};

if(gStamina < -1) then
{
	_unit forceWalk true;
	_unit allowSprint false;
}
else
{
	if(gStamina < 0) then
	{
		_unit allowSprint false;
	};
};

private _kills = ["kills", 0] call fnc_loadData;
private _dogtags = ["dogtags", 0] call fnc_loadData;

[_kills, _dogtags] call fnc_updateKillboard;

if(_firstTime) then
{
	[["raidGUID", gRaidGUID]] call fnc_saveData;
	hintSilent parseText localize "STR_Welcome";
};

private _position = gPlayerPositions select (_slot - 1);

_unit setpos (getPosATL _position);
_unit setDir 90;
sleep 1;

private _shelter = missionNamespace getVariable ["shelter" + str(_slot), objNull]; _unit setpos (_shelter modelToWorld [1.9,0.9,-0.1]);
_unit setDir 90;

_unit switchMove "";
_unit enableSimulation true;
player switchCamera gCurrentView;

if (gStart) then
{
	sleep 1;
	_unit playAction "SitDown";
	sleep 1.5;
	private _shelter = missionNamespace getVariable ["shelter" + str(_slot), objNull]; _unit setpos (_shelter modelToWorld [1.9,-1.6,-0.1]);
	_unit setDir 90;
	sleep 1.5;
}
else
{
	sleep 1;
	private _shelter = missionNamespace getVariable ["shelter" + str(_slot), objNull]; _unit setpos (_shelter modelToWorld [1.9,0.9,-0.1]);
	_unit setDir 90;
	sleep 1.5;
	[player] call fnc_weaponDown;
};

_unit setDir 90;

["MENU"] spawn bis_fnc_blackIn;
0 fadeSound 1; 

private _handleTrader = execVM "scripts\traderLoadDeal.sqf";
waitUntil {scriptDone _handleTrader};
gTraderLoaded = true;

if(!_extracted) then
{
	[true, false] execVM "scripts\traderUpdateDeal.sqf";
};

waitUntil {scriptDone _handle};

gStart = false;
gTraderLoaded = false;

["MENU",false] call bis_fnc_blackOut;
0 fadeSound 0; 

sleep 0.5;

raidPlayerUIDin = [getPlayerUID _unit, gTimer];
publicVariableServer "raidPlayerUIDin";

[_unit, true] call fnc_loadPlayer;

private _start = call fnc_getRandomStart;

_unit switchMove "aidlppnemstpsraswrfldnon0s";
_unit setPos getPosATL _start;
_unit setDir getDir _start;
_unit setVariable ["inZone", true, true];

_text = localize "STR_TitleText";
_duration = 4;  
_fadeInTime = 2;    
_introText = format["<t font='PuristaBold' size='1' align='right'>%1</t><br /><t size='0.9' align='right'>%2 %3</t>", _text, date call fnc_globalizeDate, format ["%1", ([dayTime, "HH:MM"] call BIS_fnc_timeToString)]];
[_introText,safezoneX+safezoneW-1.1,safezoneY+safezoneH-0.4,_duration,_fadeInTime,0,90] spawn bis_fnc_dynamicText;

_unit setVariable ["startTime", gTimer, true];
_unit setVariable ["scoreItems", [], true];

private _raidGUID  = ["raidGUID", ""] call fnc_loadData;

private _foodConsumed = false;
private _noFood = false;

if(_raidGUID != gRaidGUID || gStamina < 1) then
{
	[["raidGUID", gRaidGUID]] call fnc_saveData;

	gFood = gFood - 1;
	
	if(gFood < 0) then
	{
		gFood = 0;
		gStamina = gStamina - 1;
		_noFood = true;
	}
	else
	{
		_foodConsumed = true;
		gStamina = 1;
	};
};

if(gStamina >= 0) then
{
	_unit forceWalk false;
	_unit allowSprint true;
};

if(gStamina < -1) then
{
	_unit forceWalk true;
	_unit allowSprint false;
}
else
{
	if(gStamina < 0) then
	{
		_unit allowSprint false;
	};
};

[["food", gFood]] call fnc_saveData;

_unit setVariable["stamina", gStamina, true];
[["stamina", gStamina]] call fnc_saveData;

gPlayingTimeCounting = gTimer;

gObjectiveVisible = true;
gAction = false;

[_unit] spawn fnc_playerAgent; 

sleep 0.5;

player switchCamera gCurrentView;
[player] call fnc_weaponDown;

["MENU"] spawn bis_fnc_blackIn;
0 fadeSound 1; 

if ((call fnc_isNight) && ((hmd _unit) == gOldNVGClass || (hmd _unit) == gModernNVGClass)) then
{
	_unit action["NVGoggles", _unit];
};

if(_foodConsumed) then
{
	["FoodInfo",[localize "STR_Information", format[localize "STR_FoodCanConsumed", gFood]]] call bis_fnc_showNotification;
};

if(_noFood) then
{
	["FoodInfo",[localize "STR_Information", localize "STR_NoFood"]] call bis_fnc_showNotification;
};

if(gStamina < 1) then
{
	["StaminaWarning",[localize "STR_Warning", localize "STR_Hungry"]] call bis_fnc_showNotification;
};

if(gStamina < -1) then
{
	["StaminaWarning",[localize "STR_Warning", localize "STR_VeryWeak"]] call bis_fnc_showNotification;
}
else
{
	if(gStamina < 0) then
	{
		["StaminaWarning",[localize "STR_Warning", localize "STR_Weak"]] call bis_fnc_showNotification;
	};
};

sleep 10;
_unit allowDamage true;
