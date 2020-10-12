private _blasted=_this;
if(isPlayer _blasted)then{playSound"combat_deafness";};
_blasted setDamage 0.9;
[_blasted,true]remoteExec["setUnconscious",_blasted,true];
sleep 8;
[_blasted,false]remoteExec["setUnconscious",_blasted,true];