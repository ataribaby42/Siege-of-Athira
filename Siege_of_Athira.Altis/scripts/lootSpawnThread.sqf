if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then 
{
	private _furnitureFood = [];
	private _furnitureBig = [];
	private _furnitureSmall = [];
	
	waitUntil {gMissionSetupCompleted};
	
	private _areaSize = getMarkerSize "safeZoneArea";
	private _size = _areaSize select 0;
	
	if(_areaSize select 1 > _size) then
	{
		_size = _areaSize select 1;
	};
	
	{
		if(_x inArea "safeZoneArea") then
		{
			if(typeOf _x in ["Land_Sleeping_bag_F", "Land_Sleeping_bag_blue_F", "Land_Sleeping_bag_brown_F", "Land_TableDesk_F", "Land_WoodenTable_large_F", "Land_WoodenTable_small_F", "Land_ShelvesWooden_F", "Land_Metal_rack_F", "Land_CashDesk_F"]) then
			{
				_furnitureFood = _furnitureFood + [_x];
			};
		};
	} forEach nearestObjects [getMarkerPos "safeZoneArea", [], _size, true];

	{
		if(_x inArea "safeZoneArea") then
		{
			if(typeOf _x in ["Land_TableDesk_F", "Land_WoodenTable_large_F", "Land_WoodenTable_small_F", "Land_ShelvesWooden_F", "Land_CashDesk_F"]) then
			{
				_furnitureSmall = _furnitureSmall + [_x];
			};
		};
	} forEach nearestObjects [getMarkerPos "safeZoneArea", [], _size, true];

	{
		if(_x inArea "safeZoneArea") then
		{
			if(typeOf _x in ["Land_Sleeping_bag_F", "Land_Sleeping_bag_blue_F", "Land_Sleeping_bag_brown_F", "Land_TableDesk_F", "Land_WoodenTable_large_F", "Land_WoodenTable_small_F"]) then
			{
				_furnitureBig = _furnitureBig + [_x];
			};
		};
	} forEach nearestObjects [getMarkerPos "safeZoneArea", [], _size, true];
	
	// items spawner
	private _items = [
		["Item_MineDetector", selectRandom[0,1,2]], 
		["Item_ItemRadio", selectRandom[0,1,2,3,4]], 
		["Item_ItemWatch", selectRandom[0,1,2,3,4,5,6,7,8,9,10]],
		["Item_ItemCompass", selectRandom[0,1,2,3,4]],
		["Item_FirstAidKit", selectRandom[0,1,2,3,4,5,6]]
	];

	private _itemsBig = [
		[
			[
				["B_Kitbag_rgr","B"],
			 	["B_Kitbag_mcamo","B"],
			 	["B_Kitbag_sgg","B"], 
			 	["B_Kitbag_cbr","B"], 
			 	["B_AssaultPack_blk","B"],
				["B_AssaultPack_ocamo","B"],
				["B_AssaultPack_sgg","B"],
				["B_AssaultPack_mcamo","B"],
				["B_AssaultPack_khk","B"],
				["B_AssaultPack_rgr","B"],
				["B_TacticalPack_oli","B"],
				["B_TacticalPack_rgr","B"],
				["Headgear_H_Booniehat_oli","I"],
				["Headgear_H_Booniehat_mcamo","I"],
				["Headgear_H_Booniehat_khk","I"],
				["Headgear_H_Cap_blk","I"],
				["Headgear_H_Cap_grn","I"],
				["Headgear_H_Cap_oli","I"],
				["Headgear_H_Cap_blk_ION","I"],
				["Headgear_H_Cap_press","I"],
				["Headgear_H_Cap_blk_Raven","I"],
				["Headgear_H_Cap_khaki_specops_UK","I"],
				["Headgear_H_Cap_tan_specops_US","I"],
				["Headgear_H_Cap_usblack","I"],
				["Headgear_H_Cap_brn_SPECOPS","I"],
				["Headgear_H_Cap_red","I"],
				["Headgear_H_Cap_blu","I"],
				["Headgear_H_StrawHat_dark","I"],
				["Headgear_H_StrawHat_dark","I"],
				["Headgear_H_Bandanna_camo","I"],
				["Headgear_H_Beret_02","I"]
			]
		,selectRandom[0,1,2,3,4,5,6,7,8,9,10]]
	];

	{
		for "_i" from 1 to (_x select 1) do 
		{
			private _holder = selectRandom _furnitureSmall;
			[_holder, _x select 0, "I"] call fnc_placeLoot;
		};
	} forEach _items;

	{
		for "_i" from 1 to (_x select 1) do 
		{
			private _holder = selectRandom _furnitureBig;
			private _item = selectRandom(_x select 0);
			[_holder, _item select 0, _item select 1] call fnc_placeLoot;
		};
	} forEach _itemsBig;

	//food spawner
	while {true} do 
	{
		private _areaSize = getMarkerSize "safeZoneArea";
		private _size = _areaSize select 0;
		
		if(_areaSize select 1 > _size) then
		{
			_size = _areaSize select 1;
		};
			
		private _food = nearestObjects [getMarkerPos "safeZoneArea", ["Land_BakedBeans_F"], _size, true];
		private _foodCount = 0;
		
		{
			if(_x getVariable["loot", false]) then
			{
				_foodCount = _foodCount + 1;
			};
		} forEach _food;
		
		for "_i" from 1 to (gFoodLimit - _foodCount) do 
		{
			private _holder = selectRandom _furnitureFood;
			private _test = nearestObject [_holder, "Land_BakedBeans_F"];
			private _distance = 9999;
			private _count = 0;
			
			private _entities = nearestObjects [getPos _holder, [gPlayerClass], 20, true];
			private _onlyAlive = [];

			{
				if(alive _x) then
				{
					_onlyAlive = _onlyAlive + [_x];
				};
			}
			forEach _entities;

			private _alive = count(_onlyAlive);
			
			scopeName "foodPlaced";
			
			while {_distance > 2 && _alive == 0} do 
			{	
				private _entities = nearestObjects [getPos _holder, [gPlayerClass], 20, true];
				private _onlyAlive = [];

				{
					if(alive _x) then
					{
						_onlyAlive = _onlyAlive + [_x];
					};
				}
				forEach _entities;

				private _alive = count(_onlyAlive);

				if(!(isNull _test)) then
				{
					_distance = (getPosASL _holder) distance (getPosASL _test);
				};
				
				if(_distance > 2 && _alive == 0) then
				{
					[_holder] call fnc_placeFood;
					breakTo "foodPlaced";
				}
				else
				{
					sleep 0.1;
					_holder = selectRandom _furnitureFood;
					_test = nearestObject [_holder, "Land_BakedBeans_F"];
					_distance = 9999;
					
					_entities = nearestObjects [getPos _holder, [gPlayerClass], 20, true];
					_onlyAlive = [];

					{
						if(alive _x) then
						{
							_onlyAlive = _onlyAlive + [_x];
						};
					}
					forEach _entities;

					_alive = count(_onlyAlive);
				};
				
				_count = _count + 1;
				
				if(_count > 100) then
				{
					[_holder] call fnc_placeFood;
					breakTo "foodPlaced";
				};
			};
			
			sleep 0.1;
		};
		
		sleep gFoodSpawnCheckTime;
	};
};