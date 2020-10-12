if(isClass(configFile>>"cfgPatches">>"ace_common"))exitWith{};

private _unit = _this;

//FLASHBANG: TODO: Find better flashed animation?
if(CRS_FlashBang)then{
_unit addEventHandler["Fired",{if(_this select 5=="MiniGrenade")then{
_fbang=(_this select 6);
_fbangVelocity=velocity _fbang;
_fbangVectorDir=vectorDirVisual _fbang;
_fbangPos=getPosVisual _fbang;
deleteVehicle _fbang;
_newFbang=createVehicle["GrenadeHand_stone",_fbangPos,[],0,"can_collide"];
_newFbang setVectorDir _fbangVectorDir;
_newFbang setVelocity _fbangVelocity;
_newFbang remoteExec["CRS_FB",0];};}];};

//FRAGMENTATION GRENADE
if(CRS_Fragmentation)then{
CRS_NadeList=["HandGrenade","CUP_HandGrenade_RGO","CUP_HandGrenade_M67","CUP_HandGrenade_RGD5","CUP_HandGrenade_L109A1_HE","CUP_HandGrenade_L109A2_HE"];
_unit addEventHandler["Fired",{if(_this select 5 in CRS_NadeList)then{
_nade=(_this select 6);
[_nade]spawn{
private _nade=(_this select 0);
waitUntil{vectorMagnitude velocity _nade==0};
sleep 1;
private _nadePos=getPosATL _nade;
waitUntil{isNull _nade};
for"_i"from 0 to(floor(random 15)+15)step 1 do{
private _fragm=createVehicle["B_762x51_Ball",_nadePos,[],0,"can_collide"];
_fragm setVectorDirAndUp[[
random[-0.001,0,0.003],
random[-0.001,0,0.005],
random[0,0.0001,0.0002]], 

[random[0.001,0,0.005],
random[0.001,0,0.001],
random[0.001,0,0.001
]]];
_fragm setVelocity[
random[-50,0,50],
random[-50,0,50],
random[1,8,12]];
sleep 0.015;};};};
}];};
