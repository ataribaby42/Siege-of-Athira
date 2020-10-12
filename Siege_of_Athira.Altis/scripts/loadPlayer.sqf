private _unit = _this select 0;
private _setRaid = _this select 1;

private _val = ["uid", "_new_player_"] call fnc_loadData;
private _firstTime = true;

if(_val != "_new_player_") then {_firstTime = false};

private _loadout = ["loadout", nil] call fnc_loadData;
[["loadout", nil]] call fnc_saveData;

if (_setRaid) then
{
	[["raid", true]] call fnc_saveData;
};

saveProfileNamespace;

private _val = ["damage", 0] call fnc_loadData;
_unit setDamage _val;

_val = ["damage_head", 0] call fnc_loadData;
_unit setHit ["head", _val];

_val = ["damage_body", 0] call fnc_loadData;
_unit setHit ["body", _val];

_val = ["damage_hands", 0] call fnc_loadData;
_unit setHit ["hands", _val];

_val = ["damage_legs", 0] call fnc_loadData;
_unit setHit ["legs", _val];

_val = ["rating", 0] call fnc_loadData;
[_val, _unit] call fnc_setRating;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

if(!(isNil "_loadout")) then
{
	_unit setUnitLoadout [_loadout, false];
}
else
{
	[["food", 1]] call fnc_saveData;
	[["stamina", 1]] call fnc_saveData;

	if(call fnc_isCold) then
	{
		_unit forceAddUniform selectRandom ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_worn"];
	}	
	else
	{	
		_unit forceAddUniform selectRandom ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_tshirt", "U_B_CombatUniform_mcam_worn"];
	};
	
	private _dice = selectRandom [1, 2];
	
	if (_dice == 1) then
	{
		for "_i" from 1 to 3 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
		_unit addWeapon "hgun_Pistol_heavy_01_F";
		_unit addHandgunItem "acc_flashlight_pistol";
	};
	
	if (_dice == 2) then
	{
		for "_i" from 1 to 3 do {_unit addItemToUniform "9Rnd_45ACP_Mag";};
		_unit addWeapon "hgun_ACPC2_F";
		_unit addHandgunItem "acc_flashlight_pistol";
	};
	
	for "_i" from 1 to 2 do {_unit addItemToUniform "Chemlight_blue";};
};

_firstTime;