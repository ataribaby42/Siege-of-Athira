private _unit = _this select 0;

private _clock = 1;
private _objective = 0;
private _coldCheck = 5;

private _chem_color = ["Chemlight_blue", "Chemlight_green", "Chemlight_red", "Chemlight_yellow"];

endWarning10 = false;
endWarning5 = false;
endWarning1 = false;

if(((gMissionDuration - gMissionTime) / 60) < 10) then {endWarning10 = true;};
if(((gMissionDuration - gMissionTime) / 60) < 5) then {endWarning5 = true;};
if(((gMissionDuration - gMissionTime) / 60) < 1) then {endWarning1 = true;};

private _id = _unit addAction [format["<img size='2' image='\A3\ui_f\data\igui\cfg\actions\take_ca.paa' /><t> %1</t>", localize "STR_DropFood"], "scripts\dropFood.sqf", [], 7, true, true, "", "_this == player && (_this getVariable['food', 0] > 0) && !gAction", 2, false];
_unit setVariable["dropFoodId", _id, false];

while {alive player && (player getVariable ["inZone", false])} do 
{
	if((_clock % _coldCheck) == 0) then 
	{
		_coldCheck = 5 + floor(random 6);

		if((call fnc_isCold) && ((uniform player) == "" || !((uniform player) in gWarmUniforms))) then
		{
			if(selectRandom[0,0,1] == 1) then
			{
				private _sound = ["SHIVER1","SHIVER2","SHIVER3","SHIVER4","SHIVER5"];

				if (gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then  
				{ 
					[player, [selectRandom _sound, 100, 1]] remoteExec ["say3D", 0];  
				} 
				else 
				{ 
					[player, [selectRandom _sound, 100, 1]] remoteExec ["say3D", -2];  
				};
			};

			enableCamShake true;
			addCamShake[1 + floor(random 5), 1 + floor(random 5), 9 + floor(random 3)];
		};
	};

	if((_clock % 10) == 0) then 
	{
		raidPlayerUIDin = [getPlayerUID player, gTimer];
		publicVariableServer "raidPlayerUIDin";
		
		private _timeToAdd = gTimer - gPlayingTimeCounting;
		gPlayingTimeCounting = gTimer;
		
		private _saveData = [];

		private _playTime = ["playTime", 0] call fnc_loadData;
		private _playTime = _playTime + _timeToAdd;
		_saveData = _saveData + [["playTime", _playTime]];
		
		private _totalPlayTime = ["totalPlayTime", 0] call fnc_loadData;
		private _totalPlayTime = _totalPlayTime + _timeToAdd;
		_saveData = _saveData + [["totalPlayTime", _totalPlayTime]];

		_saveData call fnc_saveData;	
		
		if(_objective >= 4) then {gObjectiveVisible = false;};
		
		_objective = _objective + 1;
		
		if(!endWarning10 && !endWarning5 && !endWarning1 && ((gMissionDuration - gMissionTime) / 60) <= 10) then
		{
			endWarning10 = true;
			["RaidEndWarning",[localize "STR_RaidEndWarnTitle", localize "STR_RaidEndWarn10Message"]] call bis_fnc_showNotification;
		};
		
		if(!endWarning5 && !endWarning1 &&((gMissionDuration - gMissionTime) / 60) <= 5) then
		{
			endWarning5 = true;
			["RaidEndWarning",[localize "STR_RaidEndWarnTitle", localize "STR_RaidEndWarn5Message"]] call bis_fnc_showNotification;
		};
		
		if(!endWarning1 && ((gMissionDuration - gMissionTime) / 60) <= 1) then
		{
			endWarning1 = true;
			["RaidEndWarning",[localize "STR_RaidEndWarnTitle", localize "STR_RaidEndWarn1Message"]] call bis_fnc_showNotification;
		};
	};
	
	if(gStamina < 0) then
	{
		_unit setFatigue 1;
	};

	if(rating _unit < -2000 && !(_unit getVariable ["renagade", false])) then
	{
		_unit setVariable ["renagade", true, true];
	};

	if(rating _unit >= -2000 && (_unit getVariable ["renagade", false])) then
	{
		_unit setVariable ["renagade", nil, true];
	};

	private _rating = rating _unit;
	
	if(_rating > 0) then {[0, _unit] call fnc_setRating;};
	if(_rating < -10000) then {[-10000, _unit] call fnc_setRating;};
	
	[_unit] call fnc_processChems;
	[_unit] call fnc_addActions;
	
	_clock = _clock + 1;
	sleep 0.5;
};

{
	if(!isNil{_unit getVariable[_x, nil]}) then
	{
		_unit removeAction (_unit getVariable[_x, nil]);
		_unit setVariable[_x, nil, false];
	};
} forEach _chem_color;

if(!isNil{_unit getVariable["pickupChem", nil]}) then
{
	_unit removeAction (_unit getVariable["pickupChem", nil]);
	_unit setVariable["pickupChem", nil, false];
};

if(!isNil{_unit getVariable["ChemDrop", nil]}) then
{
	_unit removeAction (_unit getVariable["ChemDrop", nil]);
	_unit setVariable["ChemDrop", nil, false];
};

if(!isNil{_unit getVariable["dropFoodId", nil]}) then
{
	_unit removeAction (_unit getVariable["dropFoodId", nil]);
	_unit setVariable["dropFoodId", nil, false];
};

_unit setVariable["searchingBody", nil, false];


