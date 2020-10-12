private _crate = _this select 0;

clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

switch (selectRandom[1,2,3,4,5,6,7,8,9,10]) do {
	case 1: { 
		_crate addWeaponCargoGlobal["srifle_EBR_F", 1];
		_crate addMagazineCargoGlobal["20Rnd_762x51_Mag", selectRandom[3,4,5,6]];
		_crate addItemCargoGlobal["muzzle_snds_B", 1];
	};
	case 2: { 
		_crate addWeaponCargoGlobal["srifle_DMR_01_F", 1];
		_crate addMagazineCargoGlobal["10Rnd_762x54_Mag", selectRandom[3,4,5,6]];
		_crate addItemCargoGlobal["muzzle_snds_B", 1];
	};
	case 3: { 
		_crate addWeaponCargoGlobal["LMG_Zafir_F", 1];
		_crate addMagazineCargoGlobal["150Rnd_762x54_Box", selectRandom[1,2,3]];
		_crate addMagazineCargoGlobal["150Rnd_762x54_Box", selectRandom[1,2,3]];
	};
	case 4: { 
		_crate addWeaponCargoGlobal["LMG_Mk200_F", 1];
		_crate addMagazineCargoGlobal["200Rnd_65x39_cased_Box", selectRandom[1,2,3]];
		_crate addMagazineCargoGlobal["200Rnd_65x39_cased_Box_Tracer", selectRandom[1,2,3]];
	};
	case 5: { 
		_crate addWeaponCargoGlobal["arifle_MXM_F", 1];
		_crate addMagazineCargoGlobal["30Rnd_65x39_caseless_mag", selectRandom[1,2,3]];
		_crate addMagazineCargoGlobal["30Rnd_65x39_caseless_mag_Tracer", selectRandom[1,2,3]];
		_crate addItemCargoGlobal["muzzle_snds_H", 1];
	};
	case 6: { 
		_crate addWeaponCargoGlobal["arifle_MXM_Black_F", 1];
		_crate addMagazineCargoGlobal["30Rnd_65x39_caseless_mag", selectRandom[1,2,3]];
		_crate addMagazineCargoGlobal["30Rnd_65x39_caseless_mag_Tracer", selectRandom[1,2,3]];
		_crate addItemCargoGlobal["muzzle_snds_H", 1];
	};
	case 7: { 
		_crate addWeaponCargoGlobal["arifle_AK12_F", 1];
		_crate addMagazineCargoGlobal["30Rnd_762x39_Mag_F", selectRandom[1,2,3]];
		_crate addMagazineCargoGlobal["30Rnd_762x39_Mag_Tracer_Green_F", selectRandom[1,2,3]];
		_crate addItemCargoGlobal["muzzle_snds_B", 1];
	};
	case 8: { 
		_crate addWeaponCargoGlobal["arifle_AK12_GL_F", 1];
		_crate addMagazineCargoGlobal["30Rnd_762x39_Mag_F", selectRandom[1,2,3]];
		_crate addMagazineCargoGlobal["30Rnd_762x39_Mag_Tracer_Green_F", selectRandom[1,2,3]];
		_crate addMagazineCargoGlobal["1Rnd_HE_Grenade_shell", selectRandom[3,4,5]];
		_crate addItemCargoGlobal["muzzle_snds_B", 1];
	};
	case 9: { 
		_crate addWeaponCargoGlobal["arifle_AKS_F", 1];
		_crate addMagazineCargoGlobal["30Rnd_545x39_Mag_F", selectRandom[1,2,3]];
		_crate addMagazineCargoGlobal["30Rnd_545x39_Mag_Tracer_Green_F", selectRandom[1,2,3]];
	};
	case 10: { 
		_crate addWeaponCargoGlobal["SMG_05_F", 1];
		_crate addMagazineCargoGlobal["30Rnd_9x21_Mag_SMG_02", selectRandom[1,2,3]];
		_crate addItemCargoGlobal["muzzle_snds_L", 1];
	};
};

_crate addMagazineCargoGlobal["20Rnd_762x51_Mag", selectRandom[0,1,2]];
_crate addMagazineCargoGlobal["10Rnd_762x54_Mag", selectRandom[0,1,2]];
_crate addMagazineCargoGlobal["150Rnd_762x54_Box", selectRandom[0,1,2]];
_crate addMagazineCargoGlobal["200Rnd_65x39_cased_Box", selectRandom[0,1,2]];
_crate addMagazineCargoGlobal["200Rnd_65x39_cased_Box_Tracer", selectRandom[0,1]];
_crate addMagazineCargoGlobal["30Rnd_65x39_caseless_mag", selectRandom[0,1,2]];
_crate addMagazineCargoGlobal["30Rnd_65x39_caseless_mag_Tracer", selectRandom[0,1]];
_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag", selectRandom[0,1,2]];
_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag_Tracer_Red", selectRandom[0,1]];
_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag_Tracer_Green", selectRandom[0,1]];
_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag_Tracer_Yellow", selectRandom[0,1]];
_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag_green", selectRandom[0,1]];
_crate addMagazineCargoGlobal["30Rnd_556x45_Stanag_red", selectRandom[0,1]];
_crate addMagazineCargoGlobal["30Rnd_762x39_Mag_F", selectRandom[0,1,2]];
_crate addMagazineCargoGlobal["30Rnd_762x39_Mag_Tracer_Green_F", selectRandom[0,1]];
_crate addMagazineCargoGlobal["30Rnd_545x39_Mag_F", selectRandom[0,1,2]];
_crate addMagazineCargoGlobal["30Rnd_545x39_Mag_Tracer_Green_F", selectRandom[0,1]];
_crate addMagazineCargoGlobal["1Rnd_HE_Grenade_shell", selectRandom[0,1,2]];

_crate addBackpackCargoGlobal[selectRandom["B_Kitbag_mcamo","B_Carryall_cbr","B_Carryall_ocamo","B_Carryall_oucamo","B_Carryall_oli","B_Carryall_mcamo","B_Carryall_khk","B_Kitbag_sgg","B_Kitbag_rgr","B_Kitbag_cbr"], 1];
_crate addItemCargoGlobal[selectRandom["V_PlateCarrierIA1_dgtl", "V_PlateCarrierIA2_dgtl", "V_PlateCarrierH_CTRG","V_PlateCarrier2_blk","V_PlateCarrier2_rgr","V_PlateCarrierL_CTRG","V_PlateCarrier1_blk","V_PlateCarrier1_rgr"], 1];
_crate addItemCargoGlobal[selectRandom["G_Balaclava_combat","G_Combat"], 1];
_crate addItemCargoGlobal[selectRandom["H_HelmetSpecB","H_HelmetSpecB_blk","H_HelmetSpecB_paint2","H_HelmetSpecB_paint1","H_HelmetSpecB_sand","H_HelmetSpecB_snakeskin"], 1];

_crate addItemCargoGlobal["optic_MRD", selectRandom[0,1]];
_crate addItemCargoGlobal["optic_DMS", selectRandom[0,1]];
_crate addItemCargoGlobal["optic_LRPS", selectRandom[0,1]];
_crate addItemCargoGlobal["optic_Arco", selectRandom[0,1]];
_crate addItemCargoGlobal["optic_SOS", selectRandom[0,1]];
_crate addItemCargoGlobal["optic_Holosight", selectRandom[0,1]];
_crate addItemCargoGlobal["optic_Holosight_smg", selectRandom[0,1]];
//_crate addItemCargoGlobal["optic_tws", selectRandom[0,1]];
_crate addItemCargoGlobal[gOldNVGClass, selectRandom[0,1]];
//_crate addItemCargoGlobal["G_Aviator", selectRandom[0,1]];

/*
_crate addItemCargoGlobal["ClaymoreDirectionalMine_Remote_Mag", selectRandom[0,0,1,2]];
_crate addItemCargoGlobal["APERSTripMine_Wire_Mag", selectRandom[0,0,1,2]];
_crate addItemCargoGlobal["APERSMine_Range_Mag", selectRandom[0,0,1,2]];
_crate addItemCargoGlobal["APERSBoundingMine_Range_Mag", selectRandom[0,0,1,2]];
_crate addItemCargoGlobal["SLAMDirectionalMine_Wire_Mag", selectRandom[0,0,1,2]];
*/