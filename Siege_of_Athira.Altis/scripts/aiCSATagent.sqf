private _unit = _this select 0;

_unit call CRS_AI;

if (gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	[_unit, 0.01] remoteExec ["fnc_simpleBreathFog", 0, _unit]; 
}
else
{
	[_unit, 0.01] remoteExec ["fnc_simpleBreathFog", -2, _unit]; 
};

while {alive _unit} do 
{
	while {alive _unit} do 
	{
		private _night = call fnc_predictNight;
		
		if(_night) then
		{
			_unit enableIRLasers true;
		};
		
		sleep 5;
	};
};

_unit removeAllEventHandlers "Fired";