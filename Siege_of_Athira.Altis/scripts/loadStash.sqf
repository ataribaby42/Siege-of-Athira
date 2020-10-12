private _crate = _this select 0;
private _repack = false;

if(count _this == 4) then
{
	_repack = _this select 3;
};

clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

private _cargo = ["stash", nil] call fnc_loadData;

if (!(isNil "_cargo")) then 
{
	if (typeName _cargo == "ARRAY") then 
	{
		private _weapons = _cargo select 0;
		private _ammo = _cargo select 1;
		private _items = _cargo select 2;
		private _backpacks = _cargo select 3;
		
		for "_i" from 0 to ((count (_weapons select 0)) - 1) do {
			_crate addWeaponWithAttachmentsCargoGlobal [[((_weapons select 0) select _i), "", "", "", [], [], ""], ((_weapons select 1) select _i)];
		};

		_ammo = [_ammo] call fnc_balance_magazines;
		
		{
			_crate addMagazineAmmoCargo [_x select 0, 1, _x select 1];
		}
		forEach (_ammo);
		
		for "_i" from 0 to ((count (_items select 0)) - 1) do {
			_crate addItemCargoGlobal [((_items select 0) select _i), ((_items select 1) select _i)];
		};
		
		for "_i" from 0 to ((count (_backpacks select 0)) - 1) do {
			_crate addBackpackCargoGlobal [((_backpacks select 0) select _i), ((_backpacks select 1) select _i)];
		};
	};
};

// clear all containers
{
	clearMagazineCargoGlobal (_x select 1);
	clearItemCargo (_x select 1);
	clearWeaponCargoGlobal (_x select 1);
} foreach (everyContainer _crate);

if(_repack) then
{
	["StashMagazinesRepacked",[localize "STR_Information", localize "STR_magazinesRepacked"]] call bis_fnc_showNotification;

	[player, false] call fnc_savePlayer;
	private _slot = player getVariable["slot", 0];
	private _crate = missionNamespace getVariable ["playerCrate" + str(_slot) , objNull];
	[_crate] call fnc_saveStash;

	saveProfileNamespace;
};

