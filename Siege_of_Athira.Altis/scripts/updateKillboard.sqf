private _kills = _this select 0;
private _dogtags = _this select 1;
private _slot = player getVariable["slot", 0];
private _killboard_left = missionNamespace getVariable ["killboard_left" + str(_slot) , objNull];
private _killboard_right = missionNamespace getVariable ["killboard_right" + str(_slot) , objNull];

if(!isNull _killboard_left && !isNull _killboard_right) then
{
	if(_kills > 150) then 
	{
		_kills = 150;
	};

	if(_dogtags > 150) then 
	{
		_dogtags = 150;
	};

	_killboard_left setObjectMaterial [0, "\a3\data_f\default.rvmat"];
	_killboard_left setObjectMaterial [0, "\a3\data_f\default.rvmat"];

	_killboard_left SetObjectTexture [0, format["textures\blackboard_L_%1.jpg", _kills]]; 
	_killboard_right SetObjectTexture [0, format["textures\blackboard_R_%1.jpg", _dogtags]]; 
};
