private _unit = _this select 0;

private _chemFound = false;
private _objects = nearestObjects [_unit, [], 20];

{
	if(_x isKindOf "Man" && !(alive _x)) then
	{
		private _obj = _x;
		private _found = false;
		private _actions = actionIDs _obj;
		
		{
			private _params = _obj actionParams _x;
			
			if((_params select 1) == "scripts\searchBody.sqf") then
			{
				_found = true;
			};
		} forEach _actions;
		
		if(!_found) then
		{
			_obj addAction [format["<img size='2' image='\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa' /><t> %1</t>", localize "STR_searchBody"], "scripts\searchBody.sqf", [], 10, true, true, "", "_this == player && isNil{_this getVariable['searchingBody', nil]} && !gAction", 2, false];
		};
	};
	
	if(typeOf _x == "Land_BakedBeans_F" && alive _x) then
	{
		private _obj = _x;
		private _found = false;
		private _actions = actionIDs _obj;
		
		{
			private _params = _obj actionParams _x;
			
			if((_params select 1) == "scripts\takeFood.sqf") then
			{
				_found = true;
			};
		} forEach _actions;
		
		if(!_found) then
		{
			_obj addAction [format["<img size='2' image='\A3\ui_f\data\igui\cfg\actions\take_ca.paa' /><t> %1</t>", localize "STR_TakeFood"], "scripts\takeFood.sqf", [], 11, true, true, "", "_this == player && isNil{_this getVariable['takingFood', nil]} && isNil{_target getVariable['taken', nil]} && !gAction", 2, false];
		};
	};
	
	if(_x isKindOf "Chemlight_blue" || _x isKindOf "Chemlight_green" || _x isKindOf "Chemlight_red" || _x isKindOf "Chemlight_yellow") then
	{
		private _pickupChem = _unit getVariable["pickupChem", nil];
		private _distance = _unit distance _x; 
		
		if(_distance < 2) then
		{
			_chemFound = true;
			
			if(isNil "_pickupChem") then
			{
				private _id = _unit addAction [format["<img size='2' image='\A3\ui_f\data\igui\cfg\actions\take_ca.paa' /><t> %1</t>", localize "STR_action_pickup_chem"], "scripts\pickupChem.sqf", _x, 9, true, true, "", "player == _target && !gChemAttached && !gAction", 1.35, false];
				_unit setVariable["pickupChem", _id, false];
			};
		};
	};
}
forEach _objects;

if(!_chemFound && !isNil{_unit getVariable["pickupChem", nil]}) then
{
	_unit removeAction (_unit getVariable["pickupChem", nil]);
	_unit setVariable["pickupChem", nil, false];
};
