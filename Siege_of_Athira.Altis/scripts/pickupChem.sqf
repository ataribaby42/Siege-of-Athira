private _caller = _this select 1;
private _chem = _this select 3;

gAction = true;

private _chem_color = ["Chemlight_blue", "Chemlight_green", "Chemlight_red", "Chemlight_yellow"];

{
	if(!isNil{_caller getVariable[_x, nil]}) then
	{
		_caller removeAction (_caller getVariable[_x, nil]);
		_caller setVariable[_x, nil, false];
	};
} forEach _chem_color;

if(!isNil{_caller getVariable["pickupChem", nil]}) then
{
	_caller removeAction (_caller getVariable["pickupChem", nil]);
	_caller setVariable["pickupChem", nil, false];
};

private _unit = _caller;
private _stance = stance _caller;
private _weapon = currentWeapon _caller;

if(_weapon == "") then
{
	switch (_stance) do {
		case "PRONE": { 
			_unit playMove "AmovPpneMstpSnonWnonDnon"; 
			sleep 0.1; 
			_unit playMove "AinvPpneMstpSnonWnonDnon"; 
		};
		default { 
			_unit playMove "AmovPknlMstpSnonWnonDnon"; 
			sleep 0.1; 
			_unit playMove "AmovPknlMstpSnonWnonDnon_gear"; 
			sleep 0.5; 
			_unit playMove "AinvPknlMstpSnonWnonDnon"; 
		};
	};
}
else
{
	if(_weapon isKindOf ["Rifle", configFile >> "CfgWeapons"]) then
	{
		switch (_stance) do {
			case "PRONE": { 
				_unit playMove "AmovPpneMstpSrasWrflDnon"; 
				sleep 0.1; 
				_unit playMove "AinvPpneMstpSrasWrflDnon"; 
			};
			default { 
				_unit playMove "AmovPknlMstpSlowWrflDnon"; 
				sleep 0.1; 
				_unit playMove "AmovPknlMstpSrasWrflDnon_gear_AmovPknlMstpSrasWrflDnon"; 
				sleep 0.5; 
				_unit playMove "AinvPknlMstpSrasWrflDnon";  
			};
		};
	}
	else
	{
		if(_weapon isKindOf ["Pistol", configFile >> "CfgWeapons"]) then
		{
			switch (_stance) do {
				case "PRONE": { 
					_unit playMove "AmovPpneMstpSrasWpstDnon"; 
					sleep 0.1; 
					_unit playMove "AinvPpneMstpSrasWpstDnon"; 
				};
				default { 
					_unit playMove "AmovPknlMstpSlowWpstDnon"; 
					sleep 0.1; 
					_unit playMove "AmovPknlMstpSrasWpstDnon_gear_AmovPknlMstpSrasWpstDnon"; 
					sleep 0.5; 
					_unit playMove "AinvPknlMstpSrasWpstDnon";
				};
			};
		}
		else
		{
			//Launcher
			switch (_stance) do {
				case "PRONE": { 
					_unit playMove "AmovPpneMstpSrasWlnrDnon"; 
					sleep 0.1; 
					_unit playMove "AinvPpneMstpSnonWnonDnon"; 
				};
				default { 
					_unit playMove "AmovPercMstpSrasWlnrDnon"; 
					sleep 0.1; 
					_unit playMove "AmovPknlMstpSnonWnonDnon_gear"; 
					sleep 0.5; 
					_unit playMove "AinvPknlMstpSrasWlnrDnon";  
				};
			};
		};
	};
};

sleep 0.5;

if(alive _caller && (lifeState _caller) != "INCAPACITATED" && gMenu == 0) then
{
	_chem attachTo [_caller, [0,-0.03,0.07], "LeftShoulder"];
	[_caller, _stance, _weapon] call fnc_stopAnim;
};

gAction = false;

