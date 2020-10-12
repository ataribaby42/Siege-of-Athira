private _slot = _this select 0;
private _count = _this select 1;

private _foodRack = missionNamespace getVariable ["foodRack" + str(_slot) , objNull];
"foodRack" + str(_slot) remoteExecCall ["publicVariable", 2, false];

if(!(isNull _foodRack)) then
{
	private _xPos = -0.3;
	private _yPos = 0;
	private _zPos = 1.62;
	private _column = 1;

	for "_i" from 1 to _count do 
	{
		private _veh = createVehicle["Land_BakedBeans_F", _foodRack modelToWorld [_xPos, _yPos, _zPos], [], 0, "CAN_COLLIDE"];
		_veh enableSimulationGlobal false;
		_veh allowDamage false;
		_veh setDir (random 360);
		_xPos = _xPos + 0.1;
		_column = _column + 1;
		
		if(_column > 7) then
		{
			_column = 1;
			_xPos = -0.3;
			_zPos = _zPos - 0.38;
		};
	};
};

