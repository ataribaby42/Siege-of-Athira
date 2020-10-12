private _unit = _this select 0;
private _bossTeam = _this select 1;
private _patrol = 0;
private _chemCount = 0;
private _chemAttached = false;
private _useChems = floor random 10;
private _searchedHouses = [];
private _searchHousesTimer =  12 + (floor random 12);
private _voice = _unit getVariable["voice", 0];
private _chemLifeTime = 180;

[_unit, "NoVoice"] remoteExec ["setSpeaker", 0]; 

if (gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	[_unit, 0.01] remoteExec ["fnc_simpleBreathFog", 0, _unit]; 
}
else
{
	[_unit, 0.01] remoteExec ["fnc_simpleBreathFog", -2, _unit]; 
};

_unit call CRS_AI;

while {alive _unit} do 
{
	while {alive _unit} do 
	{
		if((call fnc_isCold) && ((uniform _unit) == "" || !((uniform _unit) in gWarmUniforms))) then
		{
			if(selectRandom[0,0,1] == 1) then
			{
				private _sound = ["SHIVER1","SHIVER2","SHIVER3","SHIVER4","SHIVER5"];

				if (gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then  
				{ 
					[_unit, [selectRandom _sound, 100, 1]] remoteExec ["say3D", 0];  
				} 
				else 
				{ 
					[_unit, [selectRandom _sound, 100, 1]] remoteExec ["say3D", -2];  
				};
			};
		};

		private _night = call fnc_predictNight;
		
		[_unit, "NoVoice"] remoteExecCall ["setSpeaker", 0]; 
		
		_chemAttached = false;

		{
			if(_x isKindOf "Chemlight_blue" || _x isKindOf "Chemlight_green" || _x isKindOf "Chemlight_red" || _x isKindOf "Chemlight_yellow") then
			{
				_chemAttached = true;
			};
		} forEach attachedObjects _unit;

		if(_chemAttached && _chemCount > _chemLifeTime) then
		{
			[_unit] call fnc_aiChemOff;
			_chemCount = 0;
			_chemAttached = false;
		};
		
		if(_night) then
		{
			if ((hmd _unit) != gOldNVGClass && (hmd _unit) != gModernNVGClass) then
			{
				if ((gOldNVGClass in (vestItems _unit + uniformItems _unit + backpackItems _unit)) && !(gOldNVGClass in (assignedItems  _unit))) then
				{
					_unit assignItem gOldNVGClass;
				};

				if ((hmd _unit) != gOldNVGClass) then
				{
					if ((gModernNVGClass in (vestItems _unit + uniformItems _unit + backpackItems _unit)) && !(gModernNVGClass in (assignedItems  _unit))) then
					{
						_unit assignItem gModernNVGClass;
					};
				};
			};

			if ((hmd _unit) != gOldNVGClass && (hmd _unit) != gModernNVGClass) then
			{
				private _currentWeapon = currentWeapon _unit;
				private _hasFlashlight = false;

				if(_currentWeapon isKindOf ["Rifle", configFile >> "CfgWeapons"]) then
				{
					if("acc_flashlight" in primaryWeaponItems _unit || "acc_flashlight_smg_01" in primaryWeaponItems _unit) then
					{
						_hasFlashlight = true;
					};
				}
				else
				{
					if(_currentWeapon isKindOf ["Pistol", configFile >> "CfgWeapons"]) then
					{
						if("acc_flashlight_pistol" in handgunItems _unit) then
						{
							_hasFlashlight = true;
						};
					};
				};

				if(!_chemAttached && ((_useChems > 5 && _hasFlashlight) || !_hasFlashlight)) then
				{
					[_unit] call fnc_aiChemOn;
					_chemCount = 0;
				};
				
				_unit enableGunLights "forceOn";
			}
			else
			{
				_unit enableGunLights "forceOff";
				
				if(_chemAttached) then
				{
					_chemCount = _chemLifeTime;
				};
			};
		}
		else
		{
			if ((hmd _unit) == gOldNVGClass || (hmd _unit) == gModernNVGClass) then
			{
				if (_unit canAdd (hmd _unit)) then
				{
					_unit unassignItem (hmd _unit);
				};
			};

			_unit enableGunLights "forceOff";

			if(_chemAttached) then
			{
				_chemCount = _chemLifeTime;
			};
		};
		
		if(leader group _unit == _unit) then
		{
			if(_patrol <= 0) then
			{
				_patrol = selectRandom[5 * 60, 10 * 60, 15 * 60, 20 * 60];

				private _group = group _unit;
				
				if(count(waypoints _group) > 0) then
				{
					deleteWaypoint ((waypoints _group) select (count(waypoints _group) - 1));
				};
				
				while {(count (waypoints _group)) > 0} do
				{
					deleteWaypoint ((waypoints _group) select 0);
				};
				
				sleep 0.2;
				
				private _patrolPos = selectRandom gPatrolPositions;
				[_unit, getMarkerPos _patrolPos, 200, 5, _bossTeam]call fnc_patrol;
			};
			
			_patrol = _patrol - 5;
		};
		
		private _inSniperZone = false;
		
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
		
		if(_inSniperZone && ((call fnc_isNight && gFlareActive) || !(call fnc_isNight))) then 
		{
			if(_bossTeam) then
			{
				_unit setUnitPos "DOWN";
			}
			else
			{
				_unit setUnitPos selectRandom["DOWN", "DOWN", "MIDDLE"];
			};
		}
		else
		{
			_unit setUnitPos "AUTO";
		};


		private _inMinesZone = false;
		
		{
			if(_unit inArea _x) then
			{
				_inMinesZone = true;
			};
		}
		forEach gMinesZones;

		if(_inMinesZone) then 
		{
			if(_bossTeam) then
			{
				_unit setUnitPos "MIDDLE";
			}
			else
			{
				_unit setUnitPos selectRandom["MIDDLE", "MIDDLE", "AUTO"];
			};
		}
		else
		{
			_unit setUnitPos "AUTO";
		};
		
		if(_chemAttached) then
		{
			_chemCount = _chemCount + 1;
		};
		
		if(selectRandom[0,0,1,1] == 1 && !(_unit getVariable["looting",false]) && !(_unit getVariable["searching",false])) then
		{
			private _body = objNull;
			private _distance = 99999;

			{ 
				if(typeOf _x == gGuerrillaAiClass || typeOf _x == gPlayerClass || typeOf _x == gPlayerAiClass || ((typeOf _x) in gEnemyReconClasses)) then
				{
					private _d = _unit distance2D _x;

					if(!(_x getVariable["isBeingLooted",false]) && !(_x in (_unit getVariable["looted",[]])) && _d <= 50) then
					{
						if(_d < _distance) then
						{
							_distance = _d;
							_body = _x;
						};
					};
				};
			} forEach allDeadMen;

			if(!isNull _body) then
			{
				_unit setVariable["looting",true,true];
				_body setVariable["isBeingLooted",true,true];
				[_unit, _body] spawn fnc_loot;
			};
		};
		
		if(selectRandom[1,2,3,4,5,6] > 3 && !(_unit getVariable["looting",false]) && !(_unit getVariable["searching",false]) && _searchHousesTimer <= 0) then
		{
			private _house = nearestObjects [_unit, gSearchableHouses, 50, true] select 0; 

			_searchHousesTimer = 12 + (floor random 24);
		
			if(!isNil "_house") then
			{
				if(!(_house in _searchedHouses)) then
				{
					if(count _searchedHouses > 5) then
					{
						_searchedHouses = [];
					};
					
					_searchedHouses = _searchedHouses + [_house];
					_unit setVariable["searching", true, true];
					[_unit, _house] spawn fnc_searchHouse;
				};
			};
		};
		
		if(_voice > -1) then
		{
			private _lastTaunt = _unit getVariable["lastTaunt", 0];
			private _nextTauntDelay = _unit getVariable["nextTauntDelay", 0];

			if(time > (_lastTaunt + _nextTauntDelay)) then
			{
				private _nearEnemy = false;
				private _enemies = [_unit findNearestEnemy _unit];

				{
					if(isNull _x) exitWith {};
					
					private _distance = _unit distance _x;

					if(_distance <= 50) then
					{
						//private _visibility = [_unit, "VIEW"] checkVisibility [eyepos _unit, eyepos _x]; 

						_visibility = 1;

						if(_visibility > 0) exitWith 
						{
							_nearEnemy = true;
						};
					};
				} forEach _enemies;

				if(_nearEnemy) then
				{
					if(selectRandom[0, 1] == 1) then
					{
						_unit setVariable["lastTaunt", time];
						_unit setVariable["nextTauntDelay", 10 + (Random 30)];
						[_unit, "TAUNT", _voice] spawn fnc_chitChat;
					};
				};
			};
		};

		sleep 5;

		_searchHousesTimer = _searchHousesTimer - 1;
	};
};

_unit removeAllEventHandlers "Fired";