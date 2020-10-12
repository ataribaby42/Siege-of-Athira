private _furniture = _this select 0;
private _item = _this select 1;
private _type = _this select 2;

if(!isNil "_furniture") then
{
	private _xPos = 0;
	private _yPos = 0;
	private _zPos = 0;

	if (typeOf _furniture == "Land_Sleeping_bag_F" ||
		typeOf _furniture == "Land_Sleeping_bag_blue_F" ||
		typeOf _furniture == "Land_Sleeping_bag_brown_F"
	) then
	{
		_xPos = (random 0.2) - 0.1;
		_yPos = (random 1.0) - 0.5;
		_zPos = -0.025;
	};

	if (typeOf _furniture == "Land_TableDesk_F") then
	{
		_xPos = (random 1.0) - 0.5;
		_yPos = (random 0.2) - 0.1;
		_zPos = 0.41;
	};

	if (typeOf _furniture == "Land_WoodenTable_large_F") then
	{
		_xPos = (random 0.2) - 0.1;
		_yPos = (random 1.0) - 0.5;
		_zPos = 0.43;
	};

	if (typeOf _furniture == "Land_WoodenTable_small_F") then
	{
		_xPos = (random 0.2) - 0.1;
		_yPos = (random 0.2) - 0.1;
		_zPos = 0.43;
	};

	if (typeOf _furniture == "Land_ShelvesWooden_F") then
	{
		_xPos = (random 0.4) - 0.2;
		_yPos = (random 0.6) - 0.3;
		_zPos = 0.49;
	};

	if (typeOf _furniture == "Land_Metal_rack_F") then
	{
		_xPos = (random 0.8) - 0.4;
		_yPos = 0;
		_zPos = 0.56;
	};

	if (typeOf _furniture == "Land_CashDesk_F") then
	{
		_xPos = ((random 0.4) + 0.3) * -1.0;
		_yPos = (random 0.4) - 0.2;
		_zPos = 1.02;
	};

	private _holder = 0;

	if(_type == "B") then
	{
		_holder = createVehicle ["groundweaponHolder", _furniture modelToWorld [_xPos, _yPos, _zPos], [], 0, "CAN_COLLIDE"];
		_holder setVariable ["loot", true, true];
		_holder setVariable ["persist", true, true];
		_holder setDir (random 360);	
		_holder addBackpackCargoGlobal [_item, 1];
		_backpacks = everyBackpack _holder;

		{
			_x addItemCargoGlobal ["MineDetector", selectRandom[0,0,0,0,0,1]];
			_x addItemCargoGlobal ["FirstAidKit", selectRandom[0,0,1,2,3]];	
			_x addItemCargoGlobal ["ItemRadio", selectRandom[0,0,0,0,0,1]];	
			_x addItemCargoGlobal ["ItemWatch", selectRandom[0,0,1]];
			_x addItemCargoGlobal ["ItemCompass", selectRandom[0,0,1]];
			_x addItemCargoGlobal [gOldNVGClass, selectRandom[0,0,0,0,0,1]];
			_x addItemCargoGlobal ["optic_MRD", selectRandom[0,0,0,1]];
			_x addItemCargoGlobal ["muzzle_snds_B", selectRandom[0,0,0,1]];
			_x addItemCargoGlobal ["muzzle_snds_H", selectRandom[0,0,0,1]];
			_x addItemCargoGlobal ["muzzle_snds_L", selectRandom[0,0,0,1]];
			_x addItemCargoGlobal ["muzzle_snds_acp", selectRandom[0,0,0,1]];
			_x addItemCargoGlobal ["muzzle_snds_M", selectRandom[0,0,0,1]];
			_x addItemCargoGlobal ["30Rnd_556x45_Stanag", selectRandom[0,0,0,1,2]];
			_x addItemCargoGlobal ["30Rnd_65x39_caseless_mag", selectRandom[0,0,0,1,2]];
			_x addItemCargoGlobal ["30Rnd_65x39_caseless_green", selectRandom[0,0,0,1,2]];
			_x addItemCargoGlobal ["30Rnd_9x21_Mag_SMG_02", selectRandom[0,0,0,1,2]];
			_x addItemCargoGlobal ["30Rnd_45ACP_Mag_SMG_01", selectRandom[0,0,0,1,2]];
			_x addItemCargoGlobal ["optic_Holosight", selectRandom[0,0,0,1]];
			_x addItemCargoGlobal ["optic_Holosight_smg", selectRandom[0,0,0,1]];
		} forEach _backpacks;

		if(gDebug) then {[position _holder,"ColorPink"] call fnc_createMarker;};
	};

	if(_type == "I") then
	{
		_holder = createVehicle [_item, _furniture modelToWorld [_xPos, _yPos, _zPos], [], 0, "CAN_COLLIDE"]; 
		_holder setVariable ["loot", true, true];
		_holder setVariable ["persist", true, true];
		_holder setDir (random 360);	

		if(gDebug) then {[position _holder,"ColorOrange"] call fnc_createMarker;};
	};
};


