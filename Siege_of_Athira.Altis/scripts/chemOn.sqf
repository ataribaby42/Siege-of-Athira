private _caller = _this select 1;
private _chem = _this select 3;

gAction = true;

if((_chem in magazines _caller)) then
{
	private _chem_color = ["Chemlight_blue", "Chemlight_green", "Chemlight_red", "Chemlight_yellow"];

	{
		if(!isNil{_caller getVariable[_x, nil]}) then
		{
			_caller removeAction (_caller getVariable[_x, nil]);
			_caller setVariable[_x, nil, false];
		};
	} forEach _chem_color;

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
		_caller removeMagazine _chem;
		
		private _stick = _chem createVehicle (position _caller);
		_stick attachTo [_caller, [0,-0.03,0.07], "LeftShoulder"];
		
		sleep 0.5;
		
		[_caller, stance _caller, currentWeapon _caller] call fnc_stopAnim;
	};
};

gAction = false;