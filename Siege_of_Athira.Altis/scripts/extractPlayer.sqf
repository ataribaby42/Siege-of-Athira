private _unit = _this select 0;

if (damage _unit < 0.26 && gStamina > 0) then
{
	private _damage = damage _unit;
	_damage = _damage - 0.1;
	if(_damage < 0) then {_damage = 0;};
	_unit setDamage _damage;
};

_unit allowDamage false;
_unit setVariable ["inZone", false, true];

private _timeInRaid = gTimer - (_unit getVariable["startTime", 0]);

[_unit, true] call fnc_savePlayer;

private _handleTrader = [false, false] execVM "scripts\traderUpdateDeal.sqf";
waitUntil {scriptDone _handleTrader};

/*
if(gPersistentTime) then
{
	[["date", date]] call fnc_saveData;
};
*/

private _raids = ["raids", 0] call fnc_loadData;
_raids = _raids + 1;
[["raids", _raids]] call fnc_saveData;

private _totalRaids = ["totalRaids", 0] call fnc_loadData;
_totalRaids = _totalRaids + 1;
[["totalRaids", _totalRaids]] call fnc_saveData;

private _scoreItems = _unit getVariable["scoreItems", []];
_scoreItems = _scoreItems + [["scoreTimeSpentInRaid", round((_timeInRaid / gMissionDuration) * 1000), ""]];
private _addScore = 0;
{
	_addScore = _addScore + (_x select 1);
} forEach _scoreItems;

private _score = ["score", 0] call fnc_loadData;
_score = _score + _addScore;
[["score", _score]] call fnc_saveData;

gTopTenAdded = false;
topTenUpdate = [profileName, _score, clientOwner];
publicVariableServer "topTenUpdate";

private _topScore = ["topScore", 0] call fnc_loadData;

gPersonalScoreBeaten = false;

if(_score > _topScore) then
{
	[["topScore", _score]] call fnc_saveData;
	gPersonalScoreBeaten = true;
};

private _radioNotice = false;

if(gTraderActive) then
{
	if("ItemRadio" in (VestItems _unit + Uniformitems _unit + backpackItems _unit + assignedItems _unit)) then
	{
		private _radio = ["radio", false] call fnc_loadData;

		if(!_radio) then
		{
			if("ItemRadio" in assignedItems _unit) then
			{
				_unit unlinkItem "ItemRadio";
			}
			else
			{
				_unit removeItem "ItemRadio";
			};

			[["radio", true]] call fnc_saveData;
			[_unit, false] call fnc_savePlayer;

			_radioNotice = true;
		};
	};
};

["MENU",false] call bis_fnc_blackOut;
0 fadeSound 0; 

saveProfileNamespace;

raidPlayerUIDout = getPlayerUID player;
publicVariableServer "raidPlayerUIDout";

_unit switchMove "HubSpectator_stand";

waitUntil {(player getVariable["slot", 0]) != 0};

private _slot = _unit getVariable["slot", 0];
private _position = "playerPos" + str(_slot);

_unit setPos getMarkerPos _position;
_unit setDir markerDir _position;

_unit switchMove "HubSpectator_stand";
_unit enableSimulation false;

{
		if(_x isKindOf "Chemlight_blue" || _x isKindOf "Chemlight_green" || _x isKindOf "Chemlight_red" || _x isKindOf "Chemlight_yellow") then
	{
		deleteVehicle _x;
	};
} forEach attachedObjects _unit;

[_unit, false, true] execVM "scripts\createPlayer.sqf";

sleep 2;

[_addScore, _scoreItems, _radioNotice] spawn fnc_scoreDialog;
