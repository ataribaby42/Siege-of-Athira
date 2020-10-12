private _target = _this select 0;
private _caller = _this select 1;

gAction = true;

_caller setVariable["searchingBody", true, true];
_caller playMove "AinvPknlMstpSnonWnonDr_medic4"; 

private _time = time;
private _abort = false;
private _endAnim = false;

while {(time - _time) < 9 && !_abort} do {
	if(alive _caller && (lifeState _caller) != "INCAPACITATED" && (gMenu == 1 || inputAction "moveFastForward" > 0 || inputAction "moveForward" > 0 || inputAction "moveBack" > 0 || inputAction "turnLeft" > 0 || inputAction "turnRight" > 0)) then
	{
		_abort = true;
		[_caller, "CROUCH", currentWeapon _caller] call fnc_stopAnim;
	};
	
	if(!_abort) then
	{
		sleep 0.2;
	};

	if(!_endAnim && !_abort && alive _caller && (lifeState _caller) != "INCAPACITATED" && (time - _time) >= 8) then
	{
		_endAnim = true;
		[_caller, "CROUCH", currentWeapon _caller] call fnc_stopAnim;
	};
};

_caller setVariable["searchingBody", nil, true];

if(!_abort) then
{
	private _dogtags = _target getVariable["dogtags", nil];
	private _food = _target getVariable["food", nil];
	private _looted = _target getVariable["looted", nil];

	private _result = "";
	private _foundSomething = false;

	if(alive _caller && (lifeState _caller) != "INCAPACITATED") then
	{
		_target setVariable["looted", true, true];
		
		if(!isNil "_dogtags") then
		{
			if((_dogtags select 1) != getPlayerUID _caller) then
			{
				_result = format[localize "STR_FoundDogtags", _dogtags select 0];
				private _dogtagsNum = _caller getVariable["dogtagsNum", 0];
				_dogtagsNum = _dogtagsNum + 1;
				_target setVariable["dogtags", nil, true];
				_caller setVariable["dogtagsNum", _dogtagsNum, true];
				_foundSomething = true;

				private _scoreItems = _caller getVariable["scoreItems", []];
				_scoreItems = _scoreItems + [["scoreDogtagFound", 200, _dogtags select 0]];
				_caller setVariable["scoreItems", _scoreItems, true];

				["SearchResult",[localize "STR_Information", _result]] call bis_fnc_showNotification;
			};
		};
		
		private _foodNumOrig = 0;

		if(!isNil "_food") then
		{
			_result = format[localize "STR_FoundFood", str _food];
			private _foodNum = _caller getVariable["food", 0];
			_foodNumOrig = _foodNum;

			if(_foodNum < gFoodCarryLimit) then
			{
				_foodNum = _foodNum + _food;
				_target setVariable["food", nil, true];
				_caller setVariable["food", _foodNum, true];
			};
			
			_foundSomething = true;
			["SearchResult",[localize "STR_Information", _result]] call bis_fnc_showNotification;
		};
		
		if(!_foundSomething) then
		{
			_result = localize "STR_NothingFound";
			["SearchResult",[localize "STR_Information", _result]] call bis_fnc_showNotification;
		};

		if(_foodNumOrig >= gFoodCarryLimit) then
		{
			["SearchResult",[localize "STR_Information", format[localize "STR_CarryFullFood", gFoodCarryLimit]]] call bis_fnc_showNotification;
		};
	};
}
else
{
	["SearchResult",[localize "STR_Information", localize "STR_searchBodyAborted"]] call bis_fnc_showNotification;
};

gAction = false;