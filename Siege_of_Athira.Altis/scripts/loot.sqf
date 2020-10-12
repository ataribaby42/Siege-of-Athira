private _unit = _this select 0;
private _body = _this select 1;

if(alive _unit) then
{
	_unit doMove (_body modelToWorld [0,0,0]);
	_unit moveTo (_body modelToWorld [0,0,0]);
	private _timeout = time + (60*5);
	waitUntil {moveToCompleted _unit || moveToFailed _unit || !alive _unit || isNull _body || _timeout < time};	
};

if(alive _unit) then
{
	doStop _unit;
	sleep 0.2;
};

private _distance =  9999;

if(alive _unit && !(isNull _body)) then
{
	_distance =  _unit distance2D _body;
};

if(alive _unit && !(isNull _body) && _distance <= 2) then
{
	_unit playMoveNow "AinvPknlMstpSnonWnonDr_medic4"; 
	sleep 8;
};

if(alive _unit && _distance <= 2) then
{
	[_unit, "CROUCH", currentWeapon _unit] call fnc_stopAnim;
};

if(alive _unit && !(isNull _body) && _distance <= 2) then
{
	if(backpack _unit == "" && backpack _body != "") then
	{
		_unit action ["AddBag", _body, backpack _body];
		sleep 5;
	};
};

private _vestTaken = false;

if(alive _unit && !(isNull _body) && _distance <= 2) then
{
	if(vest _unit == "" && vest _body != "") then
	{
		_unit addVest (vest _body);
		_vestTaken = true;
	};
};

if(alive _unit && !(isNull _body) && _distance <= 2) then
{
	if(hmd _unit == "" && hmd _body != "") then
	{
		_unit linkItem (hmd _body);
		_body unlinkItem (hmd _body);
	};
};

private _ammo = "";

if(alive _unit && !(isNull _body) && _distance <= 2) then
{
	_ammo = (_unit getVariable["ammo", []]) select 0;
};

if(alive _unit && !(isNull _body) && _distance <= 2) then
{
	for "_i" from 1 to 3 do 
	{
		if(_ammo in (VestItems _body + Uniformitems _body + backpackItems _body)) then
		{
			_body removeMagazine _ammo;
			_unit addMagazine _ammo;
		};
	};
};

if(alive _unit && !(isNull _body) && _distance <= 2) then
{
	if(!("FirstAidKit" in (VestItems _unit + Uniformitems _unit + backpackItems _unit))) then
	{
		for "_i" from 1 to 2 do 
		{
			if("FirstAidKit" in (VestItems _body + Uniformitems _body + backpackItems _body)) then
			{
				_body removeItem "FirstAidKit";
				_unit addItem "FirstAidKit";
			};
		};
	};
};

if(alive _unit && !(isNull _body) && _distance <= 2) then
{
	if(_vestTaken) then
	{
		removeVest _body;
	};
};

if(alive _unit && !(isNull _body) && _distance <= 2) then
{
	private _box = (nearestObjects [_body, ["WeaponHolder", "WeaponHolderSimulated", "GroundWeaponHolder"], 5]) select 0; 

	if(!isNil "_box") then
	{
		private _boxContents = weaponCargo _box; 
		
		if(count _boxContents > 0) then
		{
			private _weapon = _boxContents select 0; 
			private _take = false;

			if(primaryWeapon _unit == "") then
			{
				if(!(_weapon in (gHandGuns))) then
				{
					_take = true;
				};
			}
			else
			{
				private _primary = primaryWeapon _unit;

				if(
					!(_weapon in (gHandGuns)) &&
					!(_weapon in (gSubmachineGuns)) &&
					(_primary in (gSubmachineGuns))
				) then
				{
					_take = true;
				};
			};

			if(_take) then
			{
				_unit action ["TakeWeapon", _box, _weapon];
				sleep 2;
				_unit action ["rearm", _body];
				sleep 2;
			};
		};
	};
};

if(alive _unit) then
{
	_unit doFollow leader _unit; 
	
	if(!(isNull _body)) then
	{
		private _looted = _unit getVariable["looted",[]];
		_looted = _looted + [_body];
		_unit setVariable["looted",_looted,true];
	};
	
	_unit setVariable["looting",false,true];
};

if(!(isNull _body)) then
{
	_body setVariable["isBeingLooted",false,true];
};

