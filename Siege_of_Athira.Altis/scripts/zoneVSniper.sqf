private _unit =_this select 0;
private _sniper = vsniperS;
private _firstShot = false; //disabled first shot always miss 

sleep selectRandom [3, 4 ,5 ,6 , 7];

private _inSniperZone = true;

while {alive _unit && _inSniperZone} do 
{
	_inSniperZone = false;
	
	{
		if(_unit inArea _x) then
		{
			_inSniperZone = true;
		};
	}
	forEach gSniperZones;

	{
		if(_unit inArea _x) then
		{
			_inSniperZone = false;
		};
	}
	forEach gNoSniperZones;
	
	if (_inSniperZone && ((call fnc_isNight && gFlareActive) || !(call fnc_isNight))) then
	{
		private _northSniper = ([objNull, "VIEW"] checkVisibility [[((getPosASL vsniperFN) select 0), ((getPosASL vsniperFN) select 1), ((getPosASL vsniperFN) select 2) + 10], eyePos _unit]);
		private _southSniper = ([objNull, "VIEW"] checkVisibility [[((getPosASL vsniperFS) select 0), ((getPosASL vsniperFS) select 1), ((getPosASL vsniperFS) select 2) + 10], eyePos _unit]);
		
		private _sniperAim = _southSniper;
		
		if(_northSniper > _southSniper) then
		{
			_sniperAim = _northSniper;
			_sniper = vsniperN;
		};
		
		if (_sniperAim > 0.3) then
		{
			private _fortuneDice = 0;
			
			if (_sniperAim > 0.7) then
			{
				_fortuneDice = selectRandom [1,4,3,4,5,6];
			};
			
			if(_fortuneDice < 5 || _firstShot) then
			{
				_firstShot = false;
				
				if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then
				{
					playSound3D ["a3\sounds_f\weapons\hits\soft_ground_1.wss", _unit, false, getPosASL _unit, 1, 1, 100];
					sleep 1;
					playSound3D ["a3\sounds_f\weapons\GM6Lynx\gm6_st_1c.wss", _sniper, false, getPosASL _sniper, 1, 1, 5000];
				}
				else
				{
					playSound3D ["a3\sounds_f\weapons\GM6Lynx\gm6_st_1c.wss", _sniper, false, getPosASL _sniper, 1, 1, 5000];
					playSound3D ["a3\sounds_f\weapons\hits\soft_ground_1.wss", _unit, false, getPosASL _unit, 1, 1, 100];
				};
			}
			else
			{
				if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then
				{
					playSound3D ["a3\sounds_f\weapons\hits\body_1.wss", _unit, false, getPosASL _unit, 1, 1, 100];
					sleep 0.1;
					_unit setDamage((damage _unit) + 0.5);
					sleep 0.9;
					playSound3D ["a3\sounds_f\weapons\GM6Lynx\gm6_st_1c.wss", _sniper, false, getPosASL _sniper, 1, 1, 5000];
				}
				else
				{
					playSound3D ["a3\sounds_f\weapons\hits\body_1.wss", _unit, false, getPosASL _unit, 1, 1, 100];
					sleep 0.1;
					_unit setDamage((damage _unit) + 0.5);
					playSound3D ["a3\sounds_f\weapons\GM6Lynx\gm6_st_1c.wss", _sniper, false, getPosASL _sniper, 1, 1, 5000];
				};	
			};
		};
		
		sleep selectRandom [3, 4 ,5 ,6 , 7];
	};
};		

if (alive _unit) then
{
	_unit setVariable ["snipedField", false, true];
};

gZoneVSniperActive = false;
