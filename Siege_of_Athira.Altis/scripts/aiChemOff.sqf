private _unit = _this select 0;

sleep (random 5);

private _stance = stance _unit;
private _weapon = currentWeapon _unit;

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

sleep 1;

{
	if(_x isKindOf "Chemlight_blue" || _x isKindOf "Chemlight_green" || _x isKindOf "Chemlight_red" || _x isKindOf "Chemlight_yellow") then
	{
		detach _x; 
		deleteVehicle _x;
	};
} forEach attachedObjects _unit;

sleep 1;

[_unit, stance _unit, currentWeapon _unit] call fnc_stopAnim;