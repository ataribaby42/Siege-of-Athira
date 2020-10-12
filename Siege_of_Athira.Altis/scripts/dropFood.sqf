private _caller = _this select 1;

gAction = true;

private _unit = _caller;
private _stance = stance _caller;
private _weapon = currentWeapon _caller;

if(_weapon == "") then
{
	switch (_stance) do {
		case "STAND": { 
			_unit playMove "AmovPercMstpSnonWnonDnon"; 
			sleep 0.1; 
			_unit playMove "AinvPercMstpSnonWnonDnon"; 
		};
		case "CROUCH": { 
			_unit playMove "AmovPknlMstpSnonWnonDnon"; 
			sleep 0.1; 
			_unit playMove "AinvPknlMstpSnonWnonDnon"; 
		};
		case "PRONE": { 
			_unit playMove "AmovPpneMstpSnonWnonDnon"; 
			sleep 0.1; 
			_unit playMove "AinvPpneMstpSnonWnonDnon"; 
		};
		default { 
			_unit playMove "AmovPercMstpSnonWnonDnon"; 
			sleep 0.1; 
			_unit playMove "AinvPercMstpSnonWnonDnon";
		};
	};
}
else
{
	if(_weapon isKindOf ["Rifle", configFile >> "CfgWeapons"]) then
	{
		switch (_stance) do {
			case "STAND": { 
				_unit playMove "AmovPercMstpSlowWrflDnon"; 
				sleep 0.1; 
				_unit playMove "AinvPercMstpSrasWrflDnon"; 
			};
			case "CROUCH": { 
				_unit playMove "AmovPknlMstpSlowWrflDnon"; 
				sleep 0.1; 
				_unit playMove "AinvPknlMstpSrasWrflDnon"; 
			};
			case "PRONE": { 
				_unit playMove "AmovPpneMstpSrasWrflDnon"; 
				sleep 0.1; 
				_unit playMove "AinvPpneMstpSrasWrflDnon"; 
			};
			default { 
				_unit playMove "AmovPercMstpSlowWrflDnon"; 
				sleep 0.1; 
				_unit playMove "AinvPercMstpSrasWrflDnon"; 
			};
		};
	}
	else
	{
		if(_weapon isKindOf ["Pistol", configFile >> "CfgWeapons"]) then
		{
			switch (_stance) do {
				case "STAND": { 
					_unit playMove "AmovPercMstpSlowWpstDnon"; 
					sleep 0.1; 
					_unit playMove "AinvPercMstpSrasWpstDnon"; 
				};
				case "CROUCH": { 
					_unit playMove "AmovPknlMstpSlowWpstDnon"; 
					sleep 0.1; 
					_unit playMove "AinvPknlMstpSrasWpstDnon"; 
				};
				case "PRONE": { 
					_unit playMove "AmovPpneMstpSrasWpstDnon"; 
					sleep 0.1; 
					_unit playMove "AinvPpneMstpSrasWpstDnon"; 
				};
				default { 
					_unit playMove "AmovPercMstpSlowWpstDnon"; 
					sleep 0.1;
					_unit playMove "AinvPercMstpSrasWpstDnon"; 
				};
			};
		}
		else
		{
			//Launcher
			switch (_stance) do {
				case "STAND": { 
					_unit playMove "AmovPercMstpSrasWlnrDnon"; 
					sleep 0.1; 
					_unit playMove "AinvPercMstpSrasWlnrDnon"; 
				};
				case "CROUCH": { 
					_unit playMove "AmovPknlMstpSrasWlnrDnon"; 
					sleep 0.1; 
					_unit playMove "AinvPknlMstpSrasWlnrDnon"; 
				};
				case "PRONE": { 
					_unit playMove "AmovPpneMstpSrasWlnrDnon"; 
					sleep 0.1; 
					_unit playMove "AinvPpneMstpSnonWnonDnon"; 
				};
				default { 
					_unit playMove "AmovPercMstpSrasWlnrDnon"; 
					sleep 0.1; 
					_unit playMove "AinvPercMstpSrasWlnrDnon"; 
				};
			};
		};
	};
};

sleep 0.5;

if(alive _caller && (lifeState _caller) != "INCAPACITATED" && gMenu == 0) then
{
	private _xPos = 0;
	private _yPos = 0.5;
	private _zPos = 0;
	private _veh = createVehicle ["Land_BakedBeans_F", _caller modelToWorld [_xPos, _yPos, _zPos], [], 0, "CAN_COLLIDE"]; 
	_veh setDir (random 360);	
	_veh setVariable ["loot", true, true];

	private _food = _caller getVariable["food", 0];
	_food = _food - 1;

	if(_food <= 0) then
	{
		_caller setVariable["food", nil, true];
	}
	else
	{
		_caller setVariable["food", _food, true];
	};

	[_caller, stance _caller, currentWeapon _caller] call fnc_stopAnim;
};

gAction = false;