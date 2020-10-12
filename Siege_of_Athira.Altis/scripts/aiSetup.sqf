private _side = _this select 0;
private _unit = _this select 1;
private _renegade = _this select 2;
private _groupindex = _this select 3;
private _night = _this select 4;
private _moonlight = _this select 5;
private _bossTeam = _this select 6;
private _bandanaVoice = 3;

[_unit, "NoVoice"] remoteExecCall ["setSpeaker", 0]; 

_unit setVariable["voice", selectRandom[-1,0,1,2]];

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

private _fnc_getrandom_common = {
	floor(random 2) == 0;
};

private _fnc_getrandom_rare = {
	floor(random 10) > 7;
};

if(_bossTeam) then
{
	if(_groupindex == 0) then
	{
		 _unit forceAddUniform "U_BG_leader";
		 _unit addHeadgear "H_Beret_grn";
		 _unit setVariable["voice", 0];
		 _unit addGoggles "G_Aviator";
	}
	else
	{
		_unit addGoggles selectRandom["G_Balaclava_oli", "G_Balaclava_blk"]; 
		_unit addHeadgear "H_Cap_police";

		if(call fnc_isCold) then
		{
			_unit forceAddUniform selectRandom[ "U_BG_Guerrilla_6_1" ];
		}
		else
		{
		_unit forceAddUniform selectRandom[ "U_BG_Guerilla1_2_F" ];
		};

		_unit setVariable["voice", selectRandom[1,2]];
	};
}
else
{
	if(_side == west) then
	{
		if (_renegade) then
		{
			if(call fnc_isCold) then
			{
				_unit forceAddUniform selectRandom["U_B_CTRG_1", "U_B_CTRG_3"];
			}
			else
			{
				_unit forceAddUniform selectRandom["U_B_CTRG_1", "U_B_CTRG_2", "U_B_CTRG_3"];
			};
		}
		else
		{
			if(call fnc_isCold) then
			{
				_unit forceAddUniform selectRandom["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_worn"];
			}
			else
			{
				_unit forceAddUniform selectRandom["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_tshirt", "U_B_CombatUniform_mcam_worn"];
			};
		};
	}
	else
	{
		if(call fnc_isCold) then
		{
			_unit forceAddUniform selectRandom[ "U_BG_Guerilla3_1", "U_BG_Guerrilla_6_1"];
		}
		else
		{
			_unit forceAddUniform selectRandom[ "U_BG_Guerilla2_1", "U_BG_Guerilla2_2", "U_BG_Guerilla2_3", "U_BG_Guerilla3_1",
												"U_BG_Guerilla2_1", "U_BG_Guerilla2_2", "U_BG_Guerilla2_3", "U_BG_Guerilla3_1",
												"U_BG_Guerilla1_1", "U_BG_Guerrilla_6_1" ];
		};
	};

	if (_renegade) then
	{
		if(_side == west) then
		{
			_unit addGoggles selectRandom["G_Balaclava_oli", "G_Balaclava_blk"];
		}
		else
		{
			_unit addGoggles "G_Bandanna_beast";
			_unit setVariable["voice", _bandanaVoice];
		};
	}
	else
	{
		if(_side == west) then
		{
			switch (selectRandom[0, 0, 0, 1, 2, 3, 4]) do 
			{
				case 1:
				{
					_unit addGoggles "G_Bandanna_khk";
					_unit setVariable["voice", _bandanaVoice];
				};
				case 2:
				{
					_unit addGoggles "G_Bandanna_blk";
					_unit setVariable["voice", _bandanaVoice];
				};
				case 3:
				{
					_unit addGoggles "G_Bandanna_oli";
					_unit setVariable["voice", _bandanaVoice];
				};
				case 4:
				{
					_unit addGoggles "G_Bandanna_tan";
					_unit setVariable["voice", _bandanaVoice];
				};
				default 
				{
					removeGoggles _unit;
				};
			};
		}
		else
		{
			switch (selectRandom[0, 0, 0, 0, 1, 2, 3, 4, 5, 6]) do 
			{
				case 1:
				{
					_unit addGoggles "G_Bandanna_khk";
				};
				case 2:
				{
					_unit addGoggles "G_Bandanna_blk";
				};
				case 3:
				{
					_unit addGoggles "G_Bandanna_oli";
				};
				case 4:
				{
					_unit addGoggles "G_Bandanna_tan";
				};
				case 5:
				{
					_unit addGoggles "G_Balaclava_blk";
				};
				case 6:
				{
					_unit addGoggles "G_Balaclava_oli";
				};
				default 
				{
					removeGoggles _unit;
				};
			};
		};
	};

	if(_groupindex == 0) then
	{
		_unit setDamage selectRandom[0, 0, 0, 0, 0, 0.5];
	}
	else
	{
		_unit setDamage 0;
	};
};

/*
private _backpackList = [["B_AssaultPack_mcamo", "B_AssaultPack_cbr", "B_FieldPack_khk"],
["B_AssaultPack_mcamo", "B_FieldPack_khk"],
["B_AssaultPack_mcamo", "B_FieldPack_khk", "B_TacticalPack_blk"]];
*/

private _backpackList = [["B_Messenger_Olive_F", "B_Messenger_Gray_F", "B_Messenger_Coyote_F","B_Messenger_Black_F","B_Messenger_Olive_F", "B_Messenger_Gray_F", "B_Messenger_Coyote_F","B_Messenger_Black_F","B_AssaultPack_mcamo", "B_AssaultPack_cbr", "B_FieldPack_khk"],
["B_Messenger_Olive_F", "B_Messenger_Gray_F", "B_Messenger_Coyote_F","B_Messenger_Black_F","B_AssaultPack_mcamo", "B_FieldPack_khk"],
["B_AssaultPack_mcamo", "B_FieldPack_khk", "B_TacticalPack_blk"]];

private _vestList = ["V_HarnessO_gry", "V_TacVestIR_blk", "V_TacVest_blk", "V_TacVest_camo", 
					"V_TacVest_oli", "V_Chestrig_oli", "V_Chestrig_khk", "V_Chestrig_rgr",
					"V_PlateCarrier1_rgr", "V_PlateCarrier1_blk"
					];

private _bossVestList = ["V_PlateCarrierH_CTRG", "V_PlateCarrier2_blk", "V_PlateCarrier2_rgr"];					

private _bossGuardVestList = ["V_TacVest_blk_POLICE"];	

private _weapons_pistols = [1,[["hgun_Pistol_heavy_02_F", ["6Rnd_45ACP_Cylinder"],[[]]],
["hgun_Rook40_F", ["16Rnd_9x21_Mag"],[["muzzle_snds_L"]]],
["hgun_P07_F", ["16Rnd_9x21_Mag"],[["muzzle_snds_L"]]],
["hgun_ACPC2_F", ["9Rnd_45ACP_Mag"],[["muzzle_snds_acp"]]],
["hgun_Pistol_heavy_01_F", ["11Rnd_45ACP_Mag"],[["muzzle_snds_acp"]]]
]];

private _weapons_pistols_night = [1,[["hgun_Pistol_heavy_02_F", ["6Rnd_45ACP_Cylinder"],[[]]],
["hgun_ACPC2_F", ["9Rnd_45ACP_Mag"],[["muzzle_snds_acp"]]],
["hgun_Pistol_heavy_01_F", ["11Rnd_45ACP_Mag"],[["muzzle_snds_acp"]]]
]];

private _weapons_smg = [2,[["hgun_PDW2000_F", ["30Rnd_9x21_Mag"],[["muzzle_snds_L"], ["optic_Aco","optic_Aco_grn","optic_Aco_smg","optic_Aco_grn_smg","optic_Holosight_smg"]]],
["SMG_02_F", ["30Rnd_9x21_Mag_SMG_02"],[["muzzle_snds_L"], ["optic_Aco","optic_Aco_grn","optic_Aco_smg","optic_Aco_grn_smg","optic_Holosight_smg"]]],
["SMG_01_F", ["30Rnd_45ACP_Mag_SMG_01"],[["muzzle_snds_acp"], ["optic_Aco","optic_Aco_grn","optic_Aco_smg","optic_Aco_grn_smg","optic_Holosight_smg"]]]
]];

private _weapons_smg_night = [2,[["SMG_02_F", ["30Rnd_9x21_Mag_SMG_02"],[["muzzle_snds_L"], ["optic_Aco","optic_Aco_grn","optic_Aco_smg","optic_Aco_grn_smg","optic_Holosight_smg"]]],
["SMG_01_F", ["30Rnd_45ACP_Mag_SMG_01"],[["muzzle_snds_acp"], ["optic_Aco","optic_Aco_grn","optic_Aco_smg","optic_Aco_grn_smg","optic_Holosight_smg"]]]
]];

private _weapons_rifles = [2,[["arifle_Katiba_F", ["30Rnd_65x39_caseless_green"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_H"], ["acc_flashlight"]]],
["arifle_Katiba_GL_F", ["30Rnd_65x39_caseless_green", "1Rnd_HE_Grenade_shell", "1Rnd_Smoke_Grenade_shell"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_H"], ["acc_flashlight"]]],
["arifle_Mk20_plain_F", ["30Rnd_556x45_Stanag"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_M"], ["acc_flashlight"]]],
["arifle_Mk20_F", ["30Rnd_556x45_Stanag"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_M"], ["acc_flashlight"]]],
["arifle_Mk20_GL_plain_F", ["30Rnd_556x45_Stanag", "1Rnd_HE_Grenade_shell", "1Rnd_Smoke_Grenade_shell"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_M"], ["acc_flashlight"]]],
["arifle_Mk20_GL_F", ["30Rnd_556x45_Stanag", "1Rnd_HE_Grenade_shell", "1Rnd_Smoke_Grenade_shell"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_M"], ["acc_flashlight"]]],
["arifle_TRG20_F", ["30Rnd_556x45_Stanag"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_M"], ["acc_flashlight"]]],
["arifle_TRG21_F", ["30Rnd_556x45_Stanag"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_M"], ["acc_flashlight"]]],
["arifle_TRG21_GL_F", ["30Rnd_556x45_Stanag", "1Rnd_HE_Grenade_shell", "1Rnd_Smoke_Grenade_shell"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_M"], ["acc_flashlight"]]],
["arifle_MX_F", ["30Rnd_65x39_caseless_mag"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_H"], ["acc_flashlight"]]],
["arifle_MX_Black_F", ["30Rnd_65x39_caseless_mag"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_H"], ["acc_flashlight"]]],
["arifle_MX_GL_F", ["30Rnd_65x39_caseless_mag", "1Rnd_HE_Grenade_shell", "1Rnd_Smoke_Grenade_shell"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_H"], ["acc_flashlight"]]],
["arifle_MX_GL_Black_F", ["30Rnd_65x39_caseless_mag", "1Rnd_HE_Grenade_shell", "1Rnd_Smoke_Grenade_shell"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_H"], ["acc_flashlight"]]]
]];

private _boss_weapons_rifles = [2,[
	["arifle_AK12_F", ["30Rnd_762x39_Mag_F"],[["optic_ERCO_blk_F","optic_Holosight_blk_F","optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_B"], ["acc_flashlight"]]],
	["SMG_05_F", ["30Rnd_9x21_Mag_SMG_02"],[["optic_Holosight_smg_blk_F","optic_Aco_smg","optic_Aco_grn_smg"], ["muzzle_snds_L"], ["acc_flashlight"]]],
	["arifle_SPAR_01_blk_F", ["30Rnd_556x45_Stanag"],[["optic_ERCO_blk_F","optic_Holosight_blk_F","optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_M"], ["acc_flashlight"]]],
	["arifle_MX_Black_F", ["30Rnd_65x39_caseless_mag"],[["optic_ERCO_blk_F","optic_Holosight_blk_F","optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_H"], ["acc_flashlight"]]],
	["arifle_MXC_Black_F", ["30Rnd_65x39_caseless_mag"],[["optic_ERCO_blk_F","optic_Holosight_blk_F","optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_H"], ["acc_flashlight"]]],
	["SMG_03_TR_black", ["50Rnd_570x28_SMG_03"],[["optic_Holosight_blk_F", "optic_Holosight_smg_blk_F","optic_Aco","optic_Aco_grn","optic_Aco_smg","optic_Aco_grn_smg"], ["muzzle_snds_570"], ["acc_flashlight"]]],
	["SMG_03C_TR_black", ["50Rnd_570x28_SMG_03"],[["optic_Holosight_blk_F", "optic_Holosight_smg_blk_F","optic_Aco","optic_Aco_grn","optic_Aco_smg","optic_Aco_grn_smg"], ["muzzle_snds_570"], ["acc_flashlight"]]]
]];

private _weapons_heavy = [2,[["LMG_Mk200_F", ["200Rnd_65x39_cased_Box"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_H"], ["acc_flashlight"]]],
["LMG_Zafir_F", ["150Rnd_762x54_Box"],[["optic_Aco","optic_Aco_grn", "optic_Hamr", "optic_MRCO"], ["muzzle_snds_H"], ["acc_flashlight"]]]
]];

private _weapons_launcher = [2,[["launch_RPG32_F", ["RPG32_HE_F"],[[]]]
]];

private _headgear_list = [["H_Hat_brown","H_Cap_tan", "H_Cap_grn", "H_Cap_blk", "H_Cap_oli", "H_Cap_red", "H_Bandanna_blu", "H_Bandanna_cbr"],
["H_Booniehat_khk_hs", "H_Bandanna_camo", "H_Booniehat_tan", "H_Watchcap_cbr"],
["H_HelmetB","H_HelmetB_sand"]];

private _loot_gear_list = [["acc_flashlight", "FirstAidKit", "MiniGrenade", "HandGrenade", "SmokeShell"], 
["1Rnd_HE_Grenade_shell", "1Rnd_Smoke_Grenade_shell", "muzzle_snds_acp", "muzzle_snds_H", "optic_Aco", "optic_Aco_grn", "optic_Aco_smg", "optic_Aco_grn_smg", "optic_Holosight", "optic_Holosight_smg", "optic_Hamr", "optic_MRCO"/*, "DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag"*/]];

private _fnc_setbackpack = {
	private _unit = _this select 0;
	private _backpacklist = _this select 1;
	private _force_equip = _this select 2;
	if (isNil "_force_equip") then {
		_force_equip = false;
	};

	private _equip = ((call _fnc_getrandom_common) || _force_equip);

	if (_equip && !_bossTeam) then {
		_unit addBackpack (selectRandom _backpacklist);
		// first aid kit
		
		if((damage _unit) < 0.1) then
		{
			for "_i" from 0 to 2 do {
				if (call _fnc_getrandom_rare) then {
					_unit addItemToBackpack "FirstAidKit";
				};
			};
		};

		{
			if (call _fnc_getrandom_common && (_x != "FirstAidKit" || (_x == "FirstAidKit" && (damage _unit) < 0.1))) then {
				[_unit, 2, _x] call _fnc_additem_to_storage;
			};
		} forEach (_loot_gear_list select 0);

		_limit = 0;
		{
			if (call _fnc_getrandom_rare && _limit < 3 && (_x != "FirstAidKit" || (_x == "FirstAidKit" && (damage _unit) < 0.1))) then {
				[_unit, 2, _x] call _fnc_additem_to_storage;
				_limit = _limit + 1;
			};
		} forEach (_loot_gear_list select 1);

		// random ammo
		if (call _fnc_getrandom_rare) then {
			private _weapon_list = ((selectRandom ([_weapons_smg, _weapons_rifles, _weapons_heavy])) select 1);
			private _amount = ceil(random 2);
			if (_amount == 0) then { _amount = 1; };

			for "_i" from 0 to 2 do {
				[_unit, 2, (selectRandom ((selectRandom _weapon_list) select 1))] call _fnc_additem_to_storage;
			};
		};
	};

	_equip;
};

private _fnc_additem_to_storage = {
	private _unit = _this select 0;
	private _storage = _this select 1;
	private _item = _this select 2;

	switch ( _storage) do { 
		case 1 : { _unit addItemToVest _item;}; 
		case 2 : { _unit addItemToBackpack _item;}; 
		default { _unit addItemToUniform _item;}; 
	};
};

private _fnc_setweapon = {
	private _unit = _this select 0;
	private _weapon =  (selectRandom((_this select 1) select 1));
	private _ammo = (_weapon select 1);
	private _attachments = (_weapon select 2);
	private _storage = _this select 2;
	private _weapon_class = ((_this select 1) select 0);

	// ammo
	private _amount = 2;
	
	_unit setVariable["ammo", _ammo, true];
	
	if(_weapon_class == 1) then {_amount = 3;};

	if(_bossTeam) then {_amount = 8;};
	
	{
		for "_i" from 0 to _amount do {
			[_unit, _storage, _x] call _fnc_additem_to_storage;
		};

	} forEach _ammo;

	// weapon
	_unit addWeapon (_weapon select 0);

	//attachment
	for "_j" from 0 to ((count _attachments) -1) do {
		if (((call _fnc_getrandom_rare) || (_bossTeam && call _fnc_getrandom_common)) && ((count (_attachments select _j)) > 0)) then {
			private _attachment = selectRandom(_attachments select _j);
			switch (_weapon_class) do { 
				case 1 : { _unit addHandgunItem _attachment; }; 
				case 2 : { _unit addPrimaryWeaponItem _attachment; }; 
				default {   }; 
			};
			
		};
	};
	
	//special case for Vermin SMG integral flashlight
	if((_weapon select 0) == "SMG_01_F") then
	{
		_unit addPrimaryWeaponItem "acc_flashlight_smg_01";
	};
};

private _fnc_setheadgear = {
	private _unit = _this select 0;
	private _gearlist =  _this select 1;
	private _equip = _this select 2;

	if (_equip && !_bossTeam) then {
		_unit addHeadgear selectRandom(_gearlist);
	};

	_equip;
};

private _fnc_setvest = {
	private _unit = _this select 0;
	private _equip = _this select 1;

	if (_bossTeam) then 
	{
		if(_groupindex == 0) then
		{
			_unit addVest selectRandom(_bossVestList);
		}
		else
		{
			_unit addVest selectRandom(_bossGuardVestList);
		};
	}
	else
	{	
		if (_equip) then {
			_unit addVest selectRandom(_vestList);
		};
	};

	_equip;
};


private _fnc_loadoutLvl1 = {
	private _unit = _this select 0;
	
	private _pistolsList = _weapons_pistols;
	
	if(_night) then { _pistolsList = _weapons_pistols_night;};

	// weapon
	[_unit, _pistolsList, 0] call _fnc_setweapon;
};

private _fnc_loadoutLvl2 = {
	private _unit = _this select 0;

	// backpack
	[_unit, _backpackList select 0] call _fnc_setbackpack;

	private _smgList = _weapons_smg;
	private _pistolsList = _weapons_pistols;
	
	if(_night) then { _smgList = _weapons_smg_night; _pistolsList = _weapons_pistols_night;};
	
	[_unit, selectRandom([_pistolsList, _pistolsList, _smgList]), 0] call _fnc_setweapon;

	// gear
	[_unit, (_headgear_list select 0), (call _fnc_getrandom_common)] call _fnc_setheadgear;
};

private _fnc_loadoutLvl3 = {
	private _unit = _this select 0;
	
	// backpack
	[_unit, _backpackList select 1] call _fnc_setbackpack;

	// vest
	_equip_vest = [_unit, (call _fnc_getrandom_common)] call _fnc_setvest;
	_storage = if (_equip_vest) then {1} else {0};

	// weapon
	private _smgList = _weapons_smg;
	if(_night) then { _smgList = _weapons_smg_night;};
	[_unit, _smgList, _storage] call _fnc_setweapon;

	// gear
	[_unit, (_headgear_list select 0), (call _fnc_getrandom_common)] call _fnc_setheadgear;
};

private _fnc_loadoutLvl4 = {
	private _unit = _this select 0;
	
	// backpack
	[_unit, _backpackList select 2] call _fnc_setbackpack;

	// vest
	[_unit, true] call _fnc_setvest;

	// weapon
	if(_bossTeam) then
	{
		[_unit, _boss_weapons_rifles, 1] call _fnc_setweapon;
	}
	else
	{
		[_unit, _weapons_rifles, 1] call _fnc_setweapon;
	};

	// gear
	[_unit, (_headgear_list select 1), (call _fnc_getrandom_common)] call _fnc_setheadgear;
};

private _fnc_loadoutLvl5 = {
	private _unit = _this select 0;

	// vest
	[_unit, true] call _fnc_setvest;

	// weapon
	if(_bossTeam) then
	{
		[_unit, _boss_weapons_rifles, 1] call _fnc_setweapon;
	}
	else
	{
		[_unit, selectRandom([_weapons_rifles,_weapons_heavy]), 1] call _fnc_setweapon;
	};

	if (call _fnc_getrandom_rare) then 
	{
		[_unit, _backpackList select 1, true] call _fnc_setbackpack;
		//[_unit, _weapons_launcher, 2] call _fnc_setweapon;
	};

	// gear
	[_unit, (_headgear_list select 2), (call _fnc_getrandom_common)] call _fnc_setheadgear;

	if (call _fnc_getrandom_common && !_bossTeam) then 
	{
		_unit linkItem gOldNVGClass;

		if(!_night && _unit canAdd gOldNVGClass) then 
		{
			_unit unassignItem gOldNVGClass;
		};
	};
};

private _loudouts = [_fnc_loadoutLvl1, _fnc_loadoutLvl2, _fnc_loadoutLvl3, _fnc_loadoutLvl4, _fnc_loadoutLvl5];

private _lvldistrib = [0,0,0,0,0,0,0,0,1,1,1,1,1,2,2,2,3,3,4];
private _unitLvl = selectRandom(_lvldistrib);

switch (_groupindex) do { 
	case 0 : {  }; 
	case 1 : {  
		if (_unitLvl > 3) then {
		  _unitLvl = 3;
		};
	}; 
	default { 
		if (_unitLvl > 2) then {
		  _unitLvl = 2;
		};
	}; 
};

if(_bossTeam) then
{
	if(_groupindex == 0) then
	{
		 _unitLvl = 4;
	}
	else
	{
		 _unitLvl = 3;
	};
};

private _fleeingBase = [0.7, 0.6, 0.4, 0.2, 0] select _unitLvl;
_unit allowFleeing (random(0.3) + _fleeingBase);

/*
if(_night && !_moonlight && _unitLvl < 2) then
{
	_unitLvl = 2;
};
*/

[_unit] call (_loudouts select _unitLvl);
_unit setVariable ["ailvl",_unitLvl, true];

if(selectRandom[1, 2, 3, 4, 5, 6] > 3) then
{
	_unit linkItem "ItemWatch";
};

if(_night || _bossTeam /*&& !_moonlight*/) then
{
	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit addHandgunItem "acc_flashlight_pistol";
};

if(selectRandom[1, 2] > 1) then
{
	_unit addHandgunItem "acc_flashlight_pistol";
};

private _chem_color = [];
private _count = 0;

if(!isNull(unitBackpack _unit)) then
{
	_chem_color = selectRandom["Chemlight_blue", "Chemlight_green", "Chemlight_red", "Chemlight_yellow"];
	_count = selectRandom[0, 0, 0, 1, 2, 3];
	
	if(_count > 0) then
	{
		for "_i" from 1 to _count do {_unit addItemToBackpack "Chemlight_blue";};
	};
};

if(vest _unit != "") then
{
	_chem_color = selectRandom["Chemlight_blue", "Chemlight_green", "Chemlight_red", "Chemlight_yellow"];
	_count = selectRandom[0, 0, 0, 1, 2, 3];
	
	if(_count > 0) then
	{
		for "_i" from 1 to _count do {_unit addItemToVest "Chemlight_blue";};
	};
};

if(uniform _unit != "") then
{
	_chem_color = selectRandom["Chemlight_blue", "Chemlight_green", "Chemlight_red", "Chemlight_yellow"];
	_count = selectRandom[0, 0, 0, 1, 2, 3];
	
	if(_count > 0) then
	{
		for "_i" from 1 to _count do {_unit addItemToUniform _chem_color;};
	};
};

private _food = selectRandom[ 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2];

if(_food > 0) then
{
	_unit setVariable["food", _food, true];
};

/*
Novice < 0.25
Rookie >= 0.25 and <= 0.45
Recruit > 0.45 and <= 0.65
Veteran > 0.65 and <= 0.85
Expert > 0.85
*/

if(_bossTeam) then
{
	_unit setskill 0.9;
}
else
{
	private _skills = [0.6, 0.65, 0.7, 0.8, 0.9];

	if(_side == west) then
	{
		_skills = [0.75, 0.75, 0.8, 0.8, 0.9];
	};

	_unit setskill (_skills select _unitLvl);
};

/*
_x setskill ["general",1];
_x setskill ["aimingAccuracy",1];
_x setskill ["aimingShake",1];
_x setskill ["aimingSpeed",1];
_x setskill ["commanding",1];
_x setskill ["courage",1];
_x setskill ["endurance",1];
_x setskill ["reloadSpeed",1];
_x setskill ["spotDistance",1];
_x setskill ["spotTime",1];
*/
