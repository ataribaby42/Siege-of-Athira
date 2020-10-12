private _crate = _this select 0;

private _cargo = "";

if (alive _crate) then
{
	// magazines
	private _ammo = magazinesAmmoCargo _crate;
	
	// items
	private _items = getItemCargo _crate;
	
	//backpacks
	private _backpacks = getBackpackCargo _crate;
	
	private _weapons = [[],[]];

	// weapons
	{
		{
			// base weapon without any attachments
			if (_forEachIndex == 0) then 
			{
				_weapons select 0 append [[_x] call BIS_fnc_baseWeapon];
				_weapons select 1 append [1];
			}
			else
			{
				// mags
				if (typeName _x == "ARRAY") then {
					if (count _x > 0) then {
						_ammo = _ammo + [[_x select 0 , _x select 1]];
					};
				};
				// attachments
				if (typeName _x == "STRING") then {
					if (_x != "") then {
						_items select 0 append [_x];
						_items select 1 append [1];
					};
				};
			}
		} forEach _x;
		
	} forEach weaponsItemsCargo _crate;
	
	// containers
	{
		// magazines
		_ammo append magazinesAmmoCargo (_x select 1);
		
		// items
		{
			if (_forEachIndex == 0) then 
			{
				_items select 0 append _x;
			};
			
			if (_forEachIndex == 1) then 
			{
				_items select 1 append _x;
			};
		} forEach getItemCargo (_x select 1);
		
		// weapons
		{
			{
				// base weapon without any attachments
				if (_forEachIndex == 0) then 
				{
					//_weapons select 0 append [_x];
					_weapons select 0 append [[_x] call BIS_fnc_baseWeapon];
					_weapons select 1 append [1];
				}
				else
				{
					// mags
					if (typeName _x == "ARRAY") then {
						if (count _x > 0) then {
							_ammo = _ammo + [[_x select 0 , _x select 1]];
						};
					};
					// attachments
					if (typeName _x == "STRING") then {
						if (_x != "") then {
							_items select 0 append [_x];
							_items select 1 append [1];
						};
					};
				}
			} forEach _x;
		} forEach weaponsItemsCargo (_x select 1);
		
	} forEach everyContainer _crate;
	
	_cargo = [_weapons, _ammo, _items, _backpacks];
};

[["stash", _cargo]] call fnc_saveData;

