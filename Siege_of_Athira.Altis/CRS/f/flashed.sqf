private _flashed=_this;
	if(isPlayer _flashed)then{
	0 cutText["","WHITE OUT",0.1];playSound"combat_deafness";0 fadeSound 0.01;0 fadeRadio 0.01;
	sleep 1;
	0 cutText["","WHITE IN",8];9 fadeSound 1;9 fadeRadio 1;
	}else{
	[_flashed,"Acts_CrouchingCoveringRifle01"]remoteExec["switchMove",0,true];
	sleep 4+random 3;
	[_flashed,""]remoteExec["switchMove",0,true];};