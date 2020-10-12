private _slot = _this;

private _shelter = missionNamespace getVariable ["shelter" + str(_slot) , objNull];
private _root =  getPosASL _shelter;

private _crate = missionNamespace getVariable ["playerCrate" + str(_slot) , objNull];

_crate enableSimulation false;
_crate setVectorUp [0,0,1];
_crate setPosASL [(_root select 0) - 1.559, (_root select 1) + 0.24, (_root select 2) + 0.175];
_crate setDir 356.569;
_crate enableSimulation true;

private _radio = missionNamespace getVariable ["radio" + str(_slot) , objNull];
_radio hideObject true;

_shelter animate [ format["door_%1_rot",1], 0]; 