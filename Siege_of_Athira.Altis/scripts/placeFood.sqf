private _furniture = _this select 0;

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
		_xPos = (random 0.6) - 0.3;
		_yPos = (random 1.6) - 0.8;
		_zPos = -0.025;
	};

	if (typeOf _furniture == "Land_TableDesk_F") then
	{
		_xPos = (random 1.6) - 0.8;
		_yPos = (random 0.6) - 0.3;
		_zPos = 0.41;
	};

	if (typeOf _furniture == "Land_WoodenTable_large_F") then
	{
		_xPos = (random 0.6) - 0.3;
		_yPos = (random 1.6) - 0.8;
		_zPos = 0.43;
	};

	if (typeOf _furniture == "Land_WoodenTable_small_F") then
	{
		_xPos = (random 0.6) - 0.3;
		_yPos = (random 0.6) - 0.3;
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

	private _veh = createVehicle ["Land_BakedBeans_F", _furniture modelToWorld [_xPos, _yPos, _zPos], [], 0, "CAN_COLLIDE"]; 
	_veh setDir (random 360);	
	_veh setVariable ["loot", true, true];
};