private _unit = _this select 0; 
private _body = _this select 1; 

if(!isNull _body) then
{
	_body addGoggles gogglesFix;
	[_unit, true, false] execVM "scripts\createPlayer.sqf";
	
	if (gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
	{
		[_unit, 0.01] remoteExec ["fnc_simpleBreathFog", 0, _unit]; 
	}
	else
	{
		[_unit, 0.01] remoteExec ["fnc_simpleBreathFog", -2, _unit]; 
	};
};





	
