if (!isServer) exitWith {};

waitUntil {!isNil "soa_init_done"};

private _car = _this select 0;
private _tires = _this select 1;
private _glass = _this select 2;

if(_tires select 0) then {_car setHit ["wheel_1_1_steering", 1, false]}; 
if(_tires select 1) then {_car setHit ["wheel_1_2_steering", 1, false]}; 
if(_tires select 2) then {_car setHit ["wheel_2_1_steering", 1, false]}; 
if(_tires select 3) then {_car setHit ["wheel_2_2_steering", 1, false]};

if(_glass select 0) then {_car setHit ["glass1", 1, false]}; 
if(_glass select 1) then {_car setHit ["glass2", 1, false]}; 
if(_glass select 2) then {_car setHit ["glass3", 1, false]}; 
if(_glass select 3) then {_car setHit ["glass4", 1, false]};

clearWeaponCargoGlobal _car;
clearMagazineCargoGlobal _car;
clearItemCargoGlobal _car;
clearBackpackCargoGlobal _car;

private _crate = _car;

if((floor random 20) == 19) then
{
	switch (selectRandom[1,2,3,4,5]) do {
		case 1: { 
			_crate addWeaponCargoGlobal["SMG_02_F", 1];
			_crate addMagazineCargoGlobal["30Rnd_9x21_Mag_SMG_02", selectRandom[3,4,5,6]];
			_crate addItemCargoGlobal["muzzle_snds_L", 1];
		};
		case 2: { 
			_crate addWeaponCargoGlobal["arifle_Mk20_plain_F", 1];
			_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag", selectRandom[3,4,5,6]];
			_crate addItemCargoGlobal["muzzle_snds_M", 1];
		};
		case 3: { 
			_crate addWeaponCargoGlobal["arifle_Mk20_F", 1];
			_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag", selectRandom[1,2,3]];
			_crate addItemCargoGlobal["muzzle_snds_M", selectRandom[1,2,3]];
		};
		case 4: { 
			_crate addWeaponCargoGlobal["arifle_AKS_F", 1];
			_crate addMagazineCargoGlobal["30Rnd_545x39_Mag_F", selectRandom[1,2,3]];
			_crate addMagazineCargoGlobal["30Rnd_545x39_Mag_Tracer_Green_F", selectRandom[1,2,3]];
		};
		case 5: { 
			_crate addWeaponCargoGlobal["arifle_AKM_F", 1];
			_crate addMagazineCargoGlobal["30Rnd_762x39_Mag_F", selectRandom[1,2,3]];
		};
	};
};

if((floor random 20) == 19) then
{
	_crate addItemCargoGlobal[selectRandom["V_HarnessO_gry", "V_TacVestIR_blk", "V_TacVest_blk","V_TacVest_camo","V_TacVest_oli","V_Chestrig_oli","V_Chestrig_khk", "V_Chestrig_rgr"], 1];
};

if((floor random 10) == 9) then
{
	_crate addItemCargoGlobal["optic_Holosight", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,1,1]];
	_crate addItemCargoGlobal["optic_Holosight_smg", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,1,1]];
	_crate addItemCargoGlobal["optic_MRD", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,1,1]];

	_crate addMagazineCargoGlobal["20Rnd_762x51_Mag", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2]];
	_crate addMagazineCargoGlobal["10Rnd_762x54_Mag", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2]];
	_crate addMagazineCargoGlobal["150Rnd_762x54_Box", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2]];
	_crate addMagazineCargoGlobal["200Rnd_65x39_cased_Box", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2]];
	_crate addMagazineCargoGlobal["200Rnd_65x39_cased_Box_Tracer", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]];
	_crate addMagazineCargoGlobal["30Rnd_65x39_caseless_mag", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2]];
	_crate addMagazineCargoGlobal["30Rnd_65x39_caseless_mag_Tracer", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]];
	_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2]];
	_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag_Tracer_Red", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]];
	_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag_Tracer_Green", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]];
	_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag_Tracer_Yellow", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]];
	_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag_green", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]];
	_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag_red", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]];
	_crate addMagazineCargoGlobal["30Rnd_762x39_Mag_F", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2]];
	_crate addMagazineCargoGlobal["30Rnd_762x39_Mag_Tracer_Green_F", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]];
	_crate addMagazineCargoGlobal["30Rnd_545x39_Mag_F", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2]];
	_crate addMagazineCargoGlobal["30Rnd_545x39_Mag_Tracer_Green_F", selectRandom[0,0,0,0,0,0,0,1]];
	_crate addMagazineCargoGlobal["1Rnd_HE_Grenade_shell", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2]];
};

_crate addItemCargoGlobal["ItemRadio", selectRandom[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]];
_crate addItemCargoGlobal["FirstAidKit", selectRandom[0,0,0,0,0,0,0,0,0,1,1,1]];

if((floor random 10) == 9) then
{
	switch (selectRandom[1,2,3,4,5,6,7,8,9,10,11,12]) do {
		case 1: { 
			_crate addBackpackCargoGlobal["B_AssaultPack_blk", 1];
		};
		case 2: { 
			_crate addBackpackCargoGlobal["B_AssaultPack_ocamo", 1];
		};
		case 3: { 
			_crate addBackpackCargoGlobal["B_AssaultPack_sgg", 1];
		};
		case 4: { 
			_crate addBackpackCargoGlobal["B_AssaultPack_mcamo", 1];
		};
		case 5: { 
			_crate addBackpackCargoGlobal["B_AssaultPack_khk", 1];
		};
		case 6: { 
			_crate addBackpackCargoGlobal["B_AssaultPack_rgr", 1];
		};
		case 7: { 
			_crate addBackpackCargoGlobal["B_TacticalPack_oli", 1];
		};
		case 8: { 
			_crate addBackpackCargoGlobal["B_TacticalPack_rgr", 1];
		};
		case 9: { 
			_crate addBackpackCargoGlobal["B_Kitbag_rgr", 1];
		};
		case 10: { 
			_crate addBackpackCargoGlobal["B_Kitbag_mcamo", 1];
		};
		case 11: { 
			_crate addBackpackCargoGlobal["B_Kitbag_sgg", 1];
		};
		case 12: { 
			_crate addBackpackCargoGlobal["B_Kitbag_cbr", 1];
		};
	};
};
