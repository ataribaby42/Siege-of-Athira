private _unit = _this select 0;
private _chem_color = ["Chemlight_blue", "Chemlight_green", "Chemlight_red", "Chemlight_yellow"];

gChemAttached = false;
	
{
	if(_x isKindOf "Chemlight_blue" || _x isKindOf "Chemlight_green" || _x isKindOf "Chemlight_red" || _x isKindOf "Chemlight_yellow") then
	{
		gChemAttached = true;
	};
} forEach attachedObjects player;

{
	if(!gChemAttached && (_x in magazines _unit) && isNil{_unit getVariable[_x, nil]}) then
	{
		private _text = "";
		
		if(_x == "Chemlight_blue") then
		{
			_text = format["<img shadow='0' color='#990000ff' size='2' image='\A3\ui_f\data\gui\cfg\hints\Chemlights_CA.paa' /><t> %1</t>", localize "STR_action_attach_blue_chemlight"];
		};
		
		if(_x == "Chemlight_green") then
		{
			_text = format["<img shadow='0' color='#9900ff00' size='2' image='\A3\ui_f\data\gui\cfg\hints\Chemlights_CA.paa' /><t> %1</t>", localize "STR_action_attach_green_chemlight"];
		};
		
		if(_x == "Chemlight_red") then
		{
			_text = format["<img shadow='0' color='#99ff0000' size='2' image='\A3\ui_f\data\gui\cfg\hints\Chemlights_CA.paa' /><t> %1</t>", localize "STR_action_attach_red_chemlight"];
		};
		
		if(_x == "Chemlight_yellow") then
		{
			_text = format["<img shadow='0' color='#99ffff00' size='2' image='\A3\ui_f\data\gui\cfg\hints\Chemlights_CA.paa' /><t> %1</t>", localize "STR_action_attach_yellow_chemlight"];
		};
		
		private _id = _unit addAction [_text, "scripts\chemOn.sqf", _x, 8, false, true, "", "player == _target && !gAction", 2, false];
		_unit setVariable[_x, _id, false];
	};
	
	if(!(_x in magazines _unit) && !isNil{_unit getVariable[_x, nil]}) then
	{
		_unit removeAction (_unit getVariable[_x, nil]);
		_unit setVariable[_x, nil, false];
	};
} forEach _chem_color;

if(gChemAttached) then
{
	{
		if(!isNil{_unit getVariable[_x, nil]}) then
		{
			_unit removeAction (_unit getVariable[_x, nil]);
			_unit setVariable[_x, nil, false];
		};
	} forEach _chem_color;
};

if(gChemAttached && isNil{_unit getVariable["ChemDrop", nil]}) then
{
	private _id = _unit addAction [format["<img size='2' image='\A3\ui_f\data\igui\cfg\actions\take_ca.paa' /><t> %1</t>", localize "STR_action_drop_chemlight"], "scripts\chemOff.sqf", [], 2, false, true, "", "player == _target && !gAction", 2, false];
	_unit setVariable["ChemDrop", _id, false];
};

if(!gChemAttached && !isNil{_unit getVariable["ChemDrop", nil]}) then
{
	_unit removeAction (_unit getVariable["ChemDrop", nil]);
	_unit setVariable["ChemDrop", nil, false];
};