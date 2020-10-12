private _slot = player getVariable["slot", 0];

private _killboard = missionNamespace getVariable ["killboard" + str(_slot) , objNull];
private _killboard_left = missionNamespace getVariable ["killboard_left" + str(_slot) , objNull];
private _killboard_right = missionNamespace getVariable ["killboard_right" + str(_slot) , objNull];

if(!isNull _killboard && !isNull _killboard_left && !isNull _killboard_right) then
{
	detach _killboard_left;
	detach _killboard_right;
	_killboard_left setdir getdir(_killboard); 
	_killboard_left attachTo [_killboard,[-0.498,-.03,0.6]];
	_killboard_right setdir getdir(_killboard); 
	_killboard_right attachTo [_killboard,[0.498,-.03,0.6]];
};
