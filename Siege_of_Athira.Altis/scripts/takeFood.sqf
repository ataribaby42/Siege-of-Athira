private _target = _this select 0;
private _caller = _this select 1;

private _food = _caller getVariable["food", 0];

if(_food >= gFoodCarryLimit)  exitWith {["SearchResult",[localize "STR_Information", format[localize "STR_CarryFullFood", gFoodCarryLimit]]] call bis_fnc_showNotification;};

_caller setVariable["takingFood", true, true];
_target setVariable["taken", true, true];

gAction = true;

private _unit = _caller;
private _stance = stance _caller;
private _weapon = currentWeapon _caller;

if(_weapon == "") then
{
	switch (_stance) do {
		case "STAND": { 
			_unit playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"; 
		};
		case "CROUCH": { 
			_unit playMove "AinvPknlMstpSnonWnonDnon_Putdown_AmovPknlMstpSnonWnonDnon"; 
		};
		case "PRONE": { 
			_unit playMove "AinvPpneMstpSnonWnonDnon_Putdown_AmovPpneMstpSnonWnonDnon"; 
		};
		default { 
			_unit playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"; 
		};
	};
}
else
{
	if(_weapon isKindOf ["Rifle", configFile >> "CfgWeapons"]) then
	{
		switch (_stance) do {
			case "STAND": { 
				_unit playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon"; 
			};
			case "CROUCH": { 
				_unit playMove "AinvPknlMstpSrasWrflDnon_Putdown_AmovPknlMstpSrasWrflDnon"; 
			};
			case "PRONE": { 
				_unit playMove "AinvPpneMstpSrasWrflDnon_Putdown_AmovPpneMstpSrasWrflDnon"; 
			};
			default { 
				_unit playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon"; 
			};
		};
	}
	else
	{
		if(_weapon isKindOf ["Pistol", configFile >> "CfgWeapons"]) then
		{
			switch (_stance) do {
				case "STAND": { 
					_unit playMove "AinvPercMstpSrasWpstDnon_Putdown_AmovPercMstpSrasWpstDnon"; 
				};
				case "CROUCH": { 
					_unit playMove "AinvPknlMstpSrasWpstDnon_Putdown_AmovPknlMstpSrasWpstDnon"; 
				};
				case "PRONE": { 
					_unit playMove "AinvPpneMstpSrasWpstDnon_Putdown_AmovPpneMstpSrasWpstDnon"; 
				};
				default { 
					_unit playMove "AinvPercMstpSrasWpstDnon_Putdown_AmovPercMstpSrasWpstDnon"; 
				};
			};
		}
		else
		{
			//Launcher
			switch (_stance) do {
				case "STAND": { 
					_unit playMove "AinvPercMstpSrasWlnrDnon_Putdown_AmovPercMstpSrasWlnrDnon"; 
				};
				case "CROUCH": { 
					_unit playMove "AinvPknlMstpSrasWlnrDnon_Putdown_AmovPknlMstpSrasWlnrDnon"; 
				};
				case "PRONE": { 
					_unit playMove "AinvPpneMstpSrasWrflDnon_Putdown_AmovPpneMstpSrasWrflDnon"; 
				};
				default { 
					_unit playMove "AinvPercMstpSrasWlnrDnon_Putdown_AmovPercMstpSrasWlnrDnon"; 
				};
			};
		};
	};
};

sleep 0.5;

if(alive _caller && (lifeState _caller) != "INCAPACITATED" && gMenu == 0) then
{
	deleteVehicle _target;
	_food = _food + 1;
	_caller setVariable["food", _food, true];
}
else
{
	_target setVariable["taken", nil, true];
};

_caller setVariable["takingFood", nil, true];

gAction = false;

