private _text = "";
private _dist = 0;
private _color = 0;

waitUntil {!isNil "soa_init_done"};

if (player != player) then {waitUntil {player == player};};

waitUntil {(player getVariable["slot", 0]) != 0};

gVisionMode = currentVisionMode player;
gInventoryOpen = false;

hudTags = addMissionEventHandler ["Draw3D", 
{
	if(alive player && cameraOn == player && (cameraView == "EXTERNAL" || cameraView == "INTERNAL")) then
	{
		gCurrentView = cameraView;
	};

	if(cameraView == "EXTERNAL" && gForceFirstPerson)then
	{
		player switchCamera "INTERNAL";
		gCurrentView = "INTERNAL";
	};
	
	if(gStamina < 0) then
	{
		player setFatigue 1;
	};
	
	if(accTime != 1.0 && accTime != 0) then 
	{
		setAccTime 1.0;
	};
	
	/*
	0 = Global
	1 = Side
	2 = Command
	3 = Group
	4 = Vehicle
	5 = Direct
	6 = System
	*/
	if(currentChannel != 5) then 
	{
		setCurrentChannel 5;
	};

	if(gDebug && inputAction "User20" > 0) then
	{
		gDebugEnabled = true;
	};
	
	if(inputAction "User1" > 0) then
	{
		player action ["SWITCHWEAPON", player, player, -1];
	};
	
	if(gMenu == 1) then
	{
		private _slot = player getVariable["slot", 0];
		
		if(alive player) then
		{
			private _crate = missionNamespace getVariable ["playerCrate" + str(_slot) , objNull];
			_text = localize "STR_Equipment";
			_dist = (player distance _crate) / 20.0;
			_color =  [1,1,1,1];
		
			if (_dist > 1) then {_dist = 1};
			if (_dist < 0) then {_dist = 0};
			_color set [3, 1 - _dist];
			
			drawIcon3D [
				"\a3\Ui_f\data\IGUI\Cfg\Actions\gear_ca.paa",
				_color,
				[
					getPos _crate select 0,
					getPos _crate select 1,
					(getPos _crate select 2) + 2.4
				],
				1.7,
				1.7,
				0,
				_text,
				2,
				0.08,
				'PuristaMedium',
				"center",
				true
			];
		};
		
		if(alive player) then
		{
			private _crate = missionNamespace getVariable ["foodRack" + str(_slot) , objNull];
			_text = format[localize "STR_FoodCount", str gFood];
			_dist = (player distance _crate) / 20.0;
			_color =  [1,1,1,1];
		
			if (_dist > 1) then {_dist = 1};
			if (_dist < 0) then {_dist = 0};
			_color set [3, 1 - _dist];
			
			drawIcon3D [
				MISSION_ROOT + "images\eat_ca.paa",
				_color,
				[
					getPos _crate select 0,
					getPos _crate select 1,
					(getPos _crate select 2) + 2
				],
				1.7,
				1.7,
				0,
				_text,
				2,
				0.08,
				'PuristaMedium',
				"center",
				true
			];
		};
		
		if(alive player) then
		{
			private _entry = gEntryPoints select (_slot -1);
			_text = localize "STR_Entry";
			_dist = (player distance _entry) / 20.0;
			_color =  [1,1,1,1];
		
			if (_dist > 1) then {_dist = 1};
			if (_dist < 0) then {_dist = 0};
			_color set [3, 1 - _dist];
			
			drawIcon3D [
				"\A3\ui_f\data\igui\cfg\actions\open_door_ca.paa",
				_color,
				[
					getPos _entry select 0,
					getPos _entry select 1,
					(getPos _entry select 2) + 1.5
				],
				1.5,
				1.5,
				0,
				_text,
				2,
				0.08,
				'PuristaMedium',
				"center",
				true
			];
		};
	}
	else
	{
		private _gearDialog = findDisplay 602;

		if (!isNull _gearDialog && !gInventoryOpen) then
		{
			gInventoryOpen = true;
			private _text = format[localize "STR_FoodInventory", player getVariable["food", 0]];
			private _text = _text + "<br/>" + format[localize "STR_DogtagsInventory", player getVariable["dogtagsNum", 0]];
			hintSilent parseText _text;
		};
		
		if (isNull _gearDialog && gInventoryOpen) then
		{
			gInventoryOpen = false;
			hintSilent "";
		};
		
		if(gDebugEnabled) then
		{
			private _areaSize = getMarkerSize "safeZoneArea";
			private _size = _areaSize select 0;
			
			if(_areaSize select 1 > _size) then
			{
				_size = _areaSize select 1;
			};
			
			private _food = nearestObjects [getMarkerPos "safeZoneArea", ["Land_BakedBeans_F"], _size, true];
			
			{
				if(alive player) then
				{
					_text = localize "STR_Food";
					_dist = (player distance _x) / 10000;
					_color =  [1,1,0,1];
				
					if (_dist > 1) then {_dist = 1};
					if (_dist < 0) then {_dist = 0};
					_color set [3, 1 - _dist];
					
					drawIcon3D [
						"",
						_color,
						[
							getPos _x select 0,
							getPos _x select 1,
							getPos _x select 2
						],
						1.5,
						1.5,
						0,
						_text,
						2,
						0.04,
						'PuristaMedium',
						"center",
						true
					];
				};
			} forEach _food;
			
			{
				if(alive player) then
				{
					_text = localize "STR_WeaponCache";
					_dist = (player distance _x) / 10000;
					_color =  [0,1,0,1];
				
					if (_dist > 1) then {_dist = 1};
					if (_dist < 0) then {_dist = 0};
					_color set [3, 1 - _dist];
					
					drawIcon3D [
						"",
						_color,
						[
							getPos _x select 0,
							getPos _x select 1,
							getPos _x select 2
						],
						1.5,
						1.5,
						0,
						_text,
						2,
						0.04,
						'PuristaMedium',
						"center",
						true
					];
				};
			} forEach gActiveWeaponCaches;
		};

		if(alive player) then
		{
			_text = localize "STR_Monument";
			_dist = (player distance monument) / 20;
			_color =  [1,1,1,1];
		
			if (_dist > 1) then {_dist = 1};
			if (_dist < 0) then {_dist = 0};
			_color set [3, 1 - _dist];
			
			drawIcon3D [
				"",
				_color,
				[
					getPos monument select 0,
					getPos monument select 1,
					(getPos monument select 2) + 2.0
				],
				1.5,
				1.5,
				0,
				_text,
				2,
				0.04,
				'PuristaMedium',
				"center",
				true
			];
		};
		
		{
			if(alive player) then
			{
				private _range = gExitIconVisibility;
				
				if(gDebugEnabled) then
				{
					_range = 10000;
				};
				
				_text = localize "STR_SafeHouse";
				_dist = (player distance _x) / _range;
				_color =  [1,1,1,1];
			
				if (_dist > 1) then {_dist = 1};
				if (_dist < 0) then {_dist = 0};
				_color set [3, 1 - _dist];
				
				drawIcon3D [
					"\A3\ui_f\data\igui\cfg\actions\open_door_ca.paa",
					_color,
					[
						getPos _x select 0,
						getPos _x select 1,
						(getPos _x select 2) + 2.0
					],
					1.5,
					1.5,
					0,
					_text,
					2,
					0.08,
					'PuristaMedium',
					"center",
					true
				];
			};
		} forEach gExtractions;
		
		if(alive player && gObjectiveVisible) then
		{
			_text = localize "STR_Survive";
			_dist = (player distance zone) / 3000.0;
			_color =  [1,1,1,1];
		
			if (_dist > 1) then {_dist = 1};
			if (_dist < 0) then {_dist = 0};
			_color set [3, 1 - _dist];
			
			drawIcon3D [
				"\a3\Ui_f\data\IGUI\Cfg\simpleTasks\types\attack_ca.paa",
				_color,
				[
					getPos zone select 0,
					getPos zone select 1,
					(getPos zone select 2) + 45
				],
				1.3,
				1.3,
				0,
				_text,
				2,
				0.08,
				'PuristaMedium',
				"center",
				true
			];
		};

		if(alive player && gTraderBoxIndex > -1 && count gTraderBoxes > 0 && (gTraderState == 1 || gTraderState == 3)) then
		{
			private _range = gTraderIconVisibility;
			private _box = gTraderBoxes select gTraderBoxIndex;
			_text = "";

			if(gTraderState == 3) then
			{
				_text = localize "STR_TraderBoxPickup";
			}
			else
			{
				_text = localize "STR_TraderBoxPayment";
			};

			//_dist = 0.7 min ((player distance _box) / _range);
			_dist = (player distance _box) / _range;
			_color =  [1,1,1,1];

			if (_dist > 1) then {_dist = 1};
			if (_dist < 0) then {_dist = 0};
			_color set [3, 1 - _dist];
			
			drawIcon3D [
				"\A3\weapons_f\ammoBoxes\data\ui\map_AmmoBox_F_CA.paa",
				_color,
				[
					getPos _box select 0,
					getPos _box select 1,
					(getPos _box select 2) + 1.0
				],
				2.0,
				2.0,
				0,
				_text,
				1,
				0.05,
				'PuristaMedium',
				"center",
				true
			];
		};
	};
	
	// Degraded NVG
	// Adds Effects When NV Enabled
	if(((vehicle player) == player) && ((currentVisionMode player) == 1) && gVisionMode != 1) then
	{
		gVisionMode = 1;
		
		if (cameraView == "INTERNAL" || cameraView == "GUNNER") then {playsound "NVG_WEAR_ON";};
		
		if((hmd player) == gOldNVGClass) then {playsound "NVG_ON";};
		
		if(gDegradeNVG && (hmd player) == gOldNVGClass) then
		{
			// Effects below. If you wanna know what this stuff means so you can change the effects, go to https://community.bistudio.com/wiki/Post_process_effects
			// Effect modifiers that change based on range like overall blur and film grain size are further down

			// Dynamic Blur
			ppBlur = ppEffectCreate ["dynamicBlur", 500]; 
			ppBlur ppEffectEnable true;    
			500 ppEffectForceInNVG true;


			// Edge Blur
			ppRim = ppEffectCreate ["RadialBlur", 250]; 
			ppRim ppEffectEnable true;   
			ppRim ppEffectAdjust [0.015, 0.015, 0.22, 0.3];
			ppRim ppEffectCommit 0;  
			501 ppEffectForceInNVG true;


			// Color and Contrast
			ppColor = ppEffectCreate ["ColorCorrections", 1500];  ppColor ppEffectEnable true;
			ppColor ppEffectAdjust [0.6, 1.4, -0.02, [1, 1, 1, 0], [1, 1, 1, 1], [0, 0, 0, 0]]; 
			ppColor ppEffectCommit 0;
			ppColor ppEffectForceInNVG true;


			// Film Grain
			ppFilm = ppEffectCreate ["FilmGrain", 2501]; 
			ppFilm ppEffectEnable true;   
			2501 ppEffectForceInNVG true;
		};
	};
	
	// Scaling effects during Zooming
	if(gDegradeNVG && (hmd player) == gOldNVGClass && ((vehicle player) == player) && ((currentVisionMode player) == 1)) then
	{
		private _zoomintensity = (call kk_fnc_getZoom * 10) /30;

		ppBlur ppEffectAdjust [0.25 + (_zoomIntensity * 0.35)]; 
		ppBlur ppEffectCommit 0; 

		ppFilm ppEffectAdjust [0.22, 1, _zoomIntensity, 0.4, 0.2, false];
		ppFilm ppEffectCommit 0;  
	};

	//Removes Effects When NV Disabled
	if((((vehicle player) != player) || ((currentVisionMode player) != 1)) && gVisionMode == 1) then   
	{
		if ((cameraView == "INTERNAL" || cameraView == "GUNNER")) then {playsound "NVG_WEAR_OFF";};

		gVisionMode = currentVisionMode player;

		if(gDegradeNVG) then
		{
			ppEffectDestroy ppBlur; 
			ppEffectDestroy ppRim; 
			ppEffectDestroy ppColor;
			ppEffectDestroy ppFilm;
		};
	};
}];