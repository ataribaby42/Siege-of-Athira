//M-164 has backblast radius of 90 degrees, 100 meters	TODO: lineIntersectsSurfaces	BUG: Standing behind a unit can block backblast
private _caller=_this select 0;
private _behindMe=_caller nearEntities["Man",25];
if(count _behindMe<1)exitWith{};
{private _BBArc=[getPosATL _caller,(getDir _caller)-180,90,getPosATL _x]call BIS_fnc_inAngleSector; 
if(_BBArc)then{
	private _LoS=lineIntersects[eyePos _caller,eyePos _x,objNull,_caller];
	if(!_LoS)then{_x remoteExec["CRS_BBlasted",0,true];};};
}forEach _behindMe-[_caller];