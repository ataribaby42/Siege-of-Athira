private _killed = _this select 0;
private _killer = _this select 1;

_killed unassignItem "ItemMap";
_killed removeItem "ItemMap";
_killed unassignItem "ItemGPS";
_killed removeItem "ItemGPS";

_killed removeWeapon "Binocular"; 
_killed removeWeapon "Rangefinder"; 
_killed removeItemFromBackpack "Medikit";

if (gClientMode == "CLIENT" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then
{
	if (_killer != _killed && (typeOf _killed == gGuerrillaAiClass || typeOf _killed == gPlayerClass || typeOf _killed == gPlayerAiClass)) then
	{
		if (_killer == player) then
		{
			private _kills = player getVariable["kills", 0];
			_kills = _kills + 1;
			player setVariable["kills", _kills, true];
			
			private _scoreToAdd = 0;
			
			if((_killed getVariable["slot", -1]) > -1) then
			{
				if(_killed getVariable ["renagade", false]) then
				{
					_killer addRating 1600;

					private _scoreItems = player getVariable["scoreItems", []];
					_scoreItems = _scoreItems + [["scoreKilledNatoRenegadePlayer", 100, ""]];
					player setVariable["scoreItems", _scoreItems, true];
				}
				else
				{
					private _scoreItems = player getVariable["scoreItems", []];
					_scoreItems = _scoreItems + [["scoreKilledNatoPlayer", 100, ""]];
					player setVariable["scoreItems", _scoreItems, true];
				};
			}
			else
			{
				if(typeOf _killed == gPlayerAiClass) then
				{
					if(_killed getVariable ["renagade", false]) then
					{
						private _scoreItems = player getVariable["scoreItems", []];
						_scoreItems = _scoreItems + [["scoreKilledNatoRenegadeAi", 100, ""]];
						player setVariable["scoreItems", _scoreItems, true];
					}
					else
					{
						private _scoreItems = player getVariable["scoreItems", []];
						_scoreItems = _scoreItems + [["scoreKilledNatoAi", 100, ""]];
						player setVariable["scoreItems", _scoreItems, true];
					};
				}
				else
				{
					private _aiType = _killed getVariable["ai", ""];

					if(_aiType == "guerrillaBoss") then
					{
						private _scoreItems = player getVariable["scoreItems", []];
						_scoreItems = _scoreItems + [["scoreKilledGuerrillaBossAi", 500, ""]];
						player setVariable["scoreItems", _scoreItems, true];
					}
					else
					{
						if(_aiType == "guerrillaBossGuard") then
						{
							private _scoreItems = player getVariable["scoreItems", []];
							_scoreItems = _scoreItems + [["scoreKilledGuerrillaBossGuardAi", 250, ""]];
							player setVariable["scoreItems", _scoreItems, true];
						}
						else
						{
							private _scoreItems = player getVariable["scoreItems", []];
							_scoreItems = _scoreItems + [["scoreKilledGuerrillaAi", 50, ""]];
							player setVariable["scoreItems", _scoreItems, true];
						};
					};
				};
			};
		};
	};
	
	if (_killer != _killed && ((typeOf _killed) in gEnemyReconClasses)) then
	{
		if (_killer == player) then
		{
			private _kills = player getVariable["kills", 0];
			_kills = _kills + 1;
			player setVariable["kills", _kills, true];

			private _scoreItems = player getVariable["scoreItems", []];
			_scoreItems = _scoreItems + [["scoreKilledCSAT", 500, ""]];
			player setVariable["scoreItems", _scoreItems, true];
		};
	};

	if (_killer != _killed && (typeOf _killed) == "C_UAV_06_F") then
	{
		if (_killer == player) then
		{
			private _kills = player getVariable["kills", 0];
			_kills = _kills + 1;
			player setVariable["kills", _kills, true];

			private _scoreItems = player getVariable["scoreItems", []];
			_scoreItems = _scoreItems + [["scoreKilledCSATDrone", 200, ""]];
			player setVariable["scoreItems", _scoreItems, true];
		};
	};
};

private _time = 0;

if(!isNil "gTimer") then
{
	_time = gTimer;
};

if (gClientMode == "SINGLEPLAYER") then 
{
	_killed setVariable ["killed", _time , true];
};

if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then 
{
	_killed setVariable ["killed", _time , true];
	
	if (_killer != _killed) then
	{
		diag_log format["*** %1 killed %2", _killer, _killed];
	};
};

sleep 0.25;

if(!(_killed getVariable ["dying_scream", false])) then
{
	if (typeOf _killed == gGuerrillaAiClass || typeOf _killed == gPlayerClass || typeOf _killed == gPlayerAiClass || ((typeOf _killed) in gEnemyReconClasses)) then
	{
		_killed setVariable ["dying_scream", true, true];
		playSound3D [MISSION_ROOT + "sounds\" + selectRandom ["dying1.ogg","dying2.ogg","dying3.ogg"], _killed, false, getPosASL _killed, 5, 1, 150];
	};
};