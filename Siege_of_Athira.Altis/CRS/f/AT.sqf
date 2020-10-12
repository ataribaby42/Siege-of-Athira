//DISPOSABLE AT
private _PLR=_this select 0;private _L=secondaryWeapon _PLR;private _wh=objNull;
sleep 2;
switch(secondaryWeapon _PLR)do{
case"launch_NLAW_F":{_wh=createSimpleObject["A3\weapons_F\launchers\nlaw\nlaw_F.p3d",[0,0,0]];
_wh setPosATL(_PLR getPos[1,getDir _PLR]); 
_wh setPosATL[getPosATL _wh select 0,getPosATL _wh select 1,(getPosATL _PLR select 2)+0.1];};
case"CUP_launch_NLAW":{_wh=createSimpleObject["CUP\Weapons\CUP_Weapons_NLAW\CUP_NLAW.p3d",[0,0,0]];
_wh setPosATL(_PLR getPos[1,getDir _PLR]); 
_wh setPosATL[getPosATL _wh select 0,getPosATL _wh select 1,(getPosATL _PLR select 2)+0.08];};
case"CUP_launch_M136":{_wh=createSimpleObject["CUP\Weapons\CUP_Weapons_M136\CUP_m136.p3d",[0,0,0]];
_wh setPosATL(_PLR getPos[1,getDir _PLR]); 
_wh setPosATL[getPosATL _wh select 0,getPosATL _wh select 1,(getPosATL _PLR select 2)+0.07];};
case"CUP_launch_RPG18":{_wh=createSimpleObject["CUP\Weapons\CUP_Weapons_RPG18\CUP_rpg18.p3d",[0,0,0]];
_wh setPosATL(_PLR getPos[1,getDir _PLR]); 
_wh setPosATL[getPosATL _wh select 0,getPosATL _wh select 1,(getPosATL _PLR select 2)+0.04];};
};
_PLR removeWeaponGlobal(secondaryWeapon _PLR);
_wh setDir(getDir _PLR);
sleep 120;
deleteVehicle _wh;