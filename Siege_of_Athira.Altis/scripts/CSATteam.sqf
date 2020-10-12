private _spawn = getMarkerPos "helispawn";
private _land = selectRandom gHeliPads;

diag_log "*** CSAT SF Recon team deployed";

private _heloGroup = createGroup east;
private _helo = createVehicle ["O_Heli_Light_02_unarmed_F", _spawn, [], 0, "FLY"];
_helo allowDamage false;
createvehiclecrew _helo;
private _crew = crew _helo;
_crew joinsilent _heloGroup;

{
	_x allowDamage false;
} forEach _crew;

_heloGroup addVehicle _helo;
_heloGroup selectLeader (commander _helo);
deleteWaypoint [_heloGroup, 0];
_heloGroup setCombatMode "BLUE";
_heloGroup setBehaviour "COMBAT";
_helo flyInHeight 50;
_helo setPos [getPos _helo select 0, getpos _helo select 1, 50];
private _grp = createGroup east;

//leader

private _unit = _grp createUnit [gEnemyReconClasses select 0, [0,0,0], [], 0, "NONE"];

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit forceAddUniform "U_O_SpecopsUniform_ocamo";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addItemToUniform "SmokeShell";
_unit addVest "V_HarnessOGL_brn";
for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
for "_i" from 1 to 2 do {_unit addItemToVest "30Rnd_65x39_caseless_green_mag_Tracer";};
for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
_unit addItemToVest "SmokeShellRed";
_unit addItemToVest "SmokeShellOrange";
_unit addItemToVest "SmokeShellYellow";
for "_i" from 1 to 2 do {_unit addItemToVest "Chemlight_red";};
_unit addHeadgear "H_HelmetLeaderO_ocamo";

_unit addWeapon "arifle_Katiba_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Arco_blk_F";
_unit addWeapon "hgun_Rook40_F";
_unit addHandgunItem "muzzle_snds_L";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "NVGoggles_OPFOR";

if (gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	[_unit, "CSAT_ScimitarRegiment"] remoteExecCall ["bis_fnc_setUnitInsignia", 0, _unit]; 
}
else
{
	[_unit, "CSAT_ScimitarRegiment"] remoteExecCall ["bis_fnc_setUnitInsignia", 0, _unit]; 
};

_unit removeWeapon "Binocular"; 
_unit removeWeapon "Rangefinder"; 
waitUntil {!isNil{name _unit}};
waitUntil {(name _unit) != ""};
_unit setVariable ["dogtags", [name _unit, "AI"], true];
_grp selectLeader _unit;
[_unit] spawn fnc_aiCSATagent;

//scout

private _unit = _grp createUnit [gEnemyReconClasses select 1, [0,0,0], [], 0, "NONE"];

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit forceAddUniform "U_O_SpecopsUniform_ocamo";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_green";};
_unit addItemToUniform "Chemlight_red";
_unit addVest "V_HarnessO_brn";
for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
for "_i" from 1 to 2 do {_unit addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellRed";
_unit addItemToVest "Chemlight_red";
_unit addHeadgear "H_HelmetSpecO_ocamo";

_unit addWeapon "arifle_Katiba_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addWeapon "hgun_Rook40_F";
_unit addHandgunItem "muzzle_snds_L";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "NVGoggles_OPFOR";

if (gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	[_unit, "CSAT_ScimitarRegiment"] remoteExecCall ["bis_fnc_setUnitInsignia", 0, _unit]; 
}
else
{
	[_unit, "CSAT_ScimitarRegiment"] remoteExecCall ["bis_fnc_setUnitInsignia", 0, _unit]; 
};

_unit removeWeapon "Binocular"; 
_unit removeWeapon "Rangefinder"; 
waitUntil {!isNil{name _unit}};
waitUntil {(name _unit) != ""};
_unit setVariable ["dogtags", [name _unit, "AI"], true];
[_unit] spawn fnc_aiCSATagent;

//medic

private _unit = _grp createUnit [gEnemyReconClasses select 2, [0,0,0], [], 0, "NONE"];

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit forceAddUniform "U_O_SpecopsUniform_ocamo";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addItemToUniform "SmokeShell";
_unit addVest "V_HarnessO_brn";
for "_i" from 1 to 5 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
_unit addItemToVest "SmokeShellRed";
for "_i" from 1 to 2 do {_unit addItemToVest "Chemlight_red";};
_unit addBackpack "B_FieldPack_ocamo_ReconMedic";
_unit addItemToBackpack "Medikit";
for "_i" from 1 to 5 do {_unit addItemToBackpack "FirstAidKit";};
_unit addItemToBackpack "SmokeShellRed";
_unit addItemToBackpack "SmokeShellBlue";
_unit addItemToBackpack "SmokeShellOrange";
_unit addHeadgear "H_HelmetSpecO_ocamo";

_unit addWeapon "arifle_Katiba_C_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addWeapon "hgun_Rook40_F";
_unit addHandgunItem "muzzle_snds_L";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "NVGoggles_OPFOR";

if (gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	[_unit, "CSAT_ScimitarRegiment"] remoteExecCall ["bis_fnc_setUnitInsignia", 0, _unit]; 
}
else
{
	[_unit, "CSAT_ScimitarRegiment"] remoteExecCall ["bis_fnc_setUnitInsignia", 0, _unit]; 
};

_unit removeWeapon "Binocular"; 
_unit removeWeapon "Rangefinder"; 
waitUntil {!isNil{name _unit}};
waitUntil {(name _unit) != ""};
_unit setVariable ["dogtags", [name _unit, "AI"], true];
[_unit] spawn fnc_aiCSATagent;

//marksman

private _unit = _grp createUnit [gEnemyReconClasses select 3, [0,0,0], [], 0, "NONE"];

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit forceAddUniform "U_O_SpecopsUniform_ocamo";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "10Rnd_762x54_Mag";};
_unit addVest "V_TacVest_khk";
for "_i" from 1 to 6 do {_unit addItemToVest "10Rnd_762x54_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellRed";
for "_i" from 1 to 2 do {_unit addItemToVest "Chemlight_red";};
_unit addHeadgear "H_HelmetSpecO_blk";

_unit addWeapon "srifle_DMR_01_F";
_unit addPrimaryWeaponItem "muzzle_snds_B";
_unit addPrimaryWeaponItem "optic_DMS";
_unit addPrimaryWeaponItem "bipod_02_F_blk";
_unit addWeapon "hgun_Rook40_F";
_unit addHandgunItem "muzzle_snds_L";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "NVGoggles_OPFOR";

if (gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	[_unit, "CSAT_ScimitarRegiment"] remoteExecCall ["bis_fnc_setUnitInsignia", 0, _unit]; 
}
else
{
	[_unit, "CSAT_ScimitarRegiment"] remoteExecCall ["bis_fnc_setUnitInsignia", 0, _unit]; 
};

_unit removeWeapon "Binocular"; 
_unit removeWeapon "Rangefinder"; 
waitUntil {!isNil{name _unit}};
waitUntil {(name _unit) != ""};
_unit setVariable ["dogtags", [name _unit, "AI"], true];
[_unit] spawn fnc_aiCSATagent;

deleteWaypoint [_grp, 0];
_grp setCombatMode "RED";
_grp setBehaviour "COMBAT";
_grp setFormation "WEDGE";

{
	_x setskill 0.9;
	_x assignAsCargo _helo;
	_x moveInCargo _helo;
} forEach units _grp;

private _wp1 = _heloGroup addWaypoint [position _land, 0];
_wp1 setWaypointType "TR UNLOAD";
_wp1 setWaypointStatements ["true", ""];
private  _wp2 = _heloGroup addWaypoint [_spawn, 0];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointStatements ["true", "if (isServer) then {_cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew _cleanUpveh + [_cleanUpveh];};"];

if({ alive _x } count units _grp == 0) exitWith {gCSATteam = false; publicVariable "gCSATteam";}; 

waitUntil {sleep 0.2; ({_x in _helo} count (units _grp) == 0) || ({ alive _x } count units _grp == 0);};

if({ alive _x } count units _grp == 0) exitWith {gCSATteam = false; publicVariable "gCSATteam";}; 

gCSATteam = true; 
publicVariable "gCSATteam";
sleep 0.2;

private _start	= getMarkerPos "zoneCenter";
private _range	= 200;
private _amount = 4;
private _i = 0;

while { _i < _amount} do {
	private _distance = 0;
	private _wdir = 0;
	private _wx = 0;
	private _wy = 0;
	private _wp = 0;
	
	scopeName "foundWP";
	
	private _count = 0;
	
	while {true} do {
		scopeName "badWP";
		
		private _valid = true;
		_distance = random _range;
		_wdir = 10 max (random 360);
		_wx = (_start select 0) + (_distance * (sin _wdir));
		_wy = (_start select 1) + (_distance * (cos _wdir));
		
		{
			if([_wx, _wy] inArea _x) then {_valid = false; breakTo "badWP";};
		} forEach gAreas;
		
		if(_valid || _count > 100) then {breakTo "foundWP";};
		
		_count = _count + 1;
		sleep 0.01;
	};
	
	private _wp = _grp addWaypoint [[_wx,_wy], 0];
	
	if ( _i == 0 ) then 
	{
		_wp setWaypointType "MOVE";
		_wp setWaypointStatements ["true", ""];
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointFormation "WEDGE";
		_wp setWaypointCompletionRadius 30;
	}
	else
	{
		_wp setWaypointType "MOVE";
		_wp setWaypointStatements ["true", ""];
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointFormation "WEDGE";
		_wp setWaypointCompletionRadius 30;
	};
	_i = _i + 1;
};

private _wp = _grp addWaypoint [position _land, 0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointCombatMode "RED";
_wp setWaypointFormation "WEDGE";
_wp setWaypointCompletionRadius 30;
_wp setWaypointStatements ["true", "if (isServer) then {{deleteVehicle _x} forEach (units (group this)); gCSATteam = false; publicVariable 'gCSATteam';};"];

waitUntil {sleep 1; ({ alive _x } count units _grp == 0);};

gCSATteam = false; 
publicVariable "gCSATteam";

