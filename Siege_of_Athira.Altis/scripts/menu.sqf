disableSerialization;

private _state = _this select 0;

waitUntil {str(findDisplay 46) != "no display"};

waitUntil {(player getVariable["slot", 0]) != 0};
private _slot = player getVariable["slot", 0];

private _menuControl = 0;
private _diaryControl = 0;
private _topTenControl = 0;
private _kiaControl = 0;

private _fnc_openMenu = {
	_menuControl = (findDisplay 46) ctrlCreate ["RscStructuredText", 999902];
	_menuControl ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, 0.07];
	_menuControl ctrlSetBackgroundColor [0,0,0,0.8];
	_menuControl ctrlCommit 0;
};

private _fnc_updateMenu = {
	private _raidEndsIn = ceil((gMissionDuration - gMissionTime) / 60);
	private _time = localize "STR_TimeDay";
	
	if(call fnc_isNight) then {_time = localize "STR_TimeNight";};
	if(call fnc_isNight && call fnc_isMoonlight) then {_time = localize "STR_TimeNightMoon";};
	
	private _weather = "";
	_weather = format["%1 %2°C", localize ("STR_Weather_" + (gWeather select 0)), str(round gTemp)];
	
	private _text = "";
	private _stamina = "";
	
	if(gStamina < 1) then
	{
		_stamina = " - " + localize "STR_MenuHungry";
	};

	if(gStamina < -1) then
	{
		_stamina = " - " + localize "STR_MenuVeryWeak";
	}
	else
	{
		if(gStamina < 0) then
		{
			_stamina = " - " + localize "STR_MenuWeak";
		};
	};
	
	if(_state == "killed" || _state == "killedByQuit") then
	{
		_text = _text + format["<t font='EtelkaMonospacePro' size='1.5' shadow='0' color='#ffffff' align='left'>%1 | </t>", (localize "STR_StatusKilled") + _stamina];
	};

	if(_state == "extracted") then
	{
		_text = _text + format["<t font='EtelkaMonospacePro' size='1.5' shadow='0' color='#ffffff' align='left'>%1 | </t>", (localize "STR_StatusSurvived") + _stamina];
	};

	if(_state == "alive") then
	{
		_text = _text + format["<t font='EtelkaMonospacePro' size='1.5' shadow='0' color='#ffffff' align='left'>%1 | </t>", (localize "STR_StatusAlive") + _stamina];
	};
	
	_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='left'>%1: %2</t>", localize "STR_Score", _score];

	if(_renegade) then
	{
		_text = _text + format["<t font='EtelkaMonospacePro' size='0.6' shadow='0' color='#ffffff' align='left'> (%1)</t>", localize "STR_Renegade"];
	};

	private _color = "#ffffff";
	
	if(_raidEndsIn <= 10) then
	{
	_color = "#ff0000";
	};
	
	_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='right'>%1: %2 | %3: %4 | %5: </t><t font='EtelkaMonospacePro' size='0.8' shadow='0' color='" + _color + "' align='right'>" + localize "STR_RaidEndTemplate" + "</t>", localize "STR_Time", _time, localize "STR_Weather", _weather, localize "STR_RaidEnd", _raidEndsIn];
	
	_menuControl ctrlSetStructuredText parseText _text;
};

waitUntil {time > 0};
private _future = time + 1;
waitUntil {time > _future};

private _crate = 0;
private _position = 0;
private _wholders = 0;
private _objects = 0;
private _renegade = false;

gPlayerLocked = false;
gLockedTime = 0;

if(_state == "killed" || _state == "killedByQuit") then
{
	[["raidGUID", gRaidGUID]] call fnc_saveData;

	private _deaths = ["deaths", 0] call fnc_loadData;
	_deaths = _deaths + 1;
	[["deaths", _deaths]] call fnc_saveData;
};

private _dogtags = ["dogtags", 0] call fnc_loadData;
private _score = ["score", 0] call fnc_loadData;
private _topScore = ["topScore", 0] call fnc_loadData;
private _totalDogtags = ["totalDogtags", 0] call fnc_loadData;
private _kills = ["kills", 0] call fnc_loadData;
private _totalKills = ["totalKills", 0] call fnc_loadData;
private _playTime = ["playTime", 0] call fnc_loadData;
private _totalPlayTime = ["totalPlayTime", 0] call fnc_loadData;
private _totalRaids = ["totalRaids", 0] call fnc_loadData;
private _raids = ["raids", 0] call fnc_loadData;
private _deaths = ["deaths", 0] call fnc_loadData;

_crate = missionNamespace getVariable ["playerCrate" + str(_slot) , objNull];
_position = gPlayerPositions select (_slot - 1);

gFood = ["food", 0] call fnc_loadData;

private _radio = false;

if(gTraderActive) then
{
	_radio = ["radio", false] call fnc_loadData;
};

private _radioObject = missionNamespace getVariable ["radio" + str(_slot) , objNull];

if(!_radio) then
{
	_radioObject hideObject true;
}
else
{
	_radioObject hideObject false;
};

if(rating player < -2000) then
{
	_renegade = true;
};

clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

_wholders = nearestObjects [position _position, ["WeaponHolder","GroundWeaponHolder","WeaponHolderSimulated"], 15, true];

{
	deleteVehicle _x;
} forEach _wholders;

_objects = nearestObjects [position _position, [], 15, true];

{
	if(typeOf _x == "Land_BakedBeans_F" || _x isKindOf "SmokeShell" || _x isKindOf "DemoCharge_Remote_Ammo" || _x isKindOf "SatchelCharge_Remote_Ammo" || _x isKindOf "Chemlight_blue" || _x isKindOf "Chemlight_green" || _x isKindOf "Chemlight_red" || _x isKindOf "Chemlight_yellow") then
	{
		deleteVehicle _x
	};
} forEach _objects;

[_slot, gFood] remoteExecCall ["fnc_addShelterFood", 2, false];
[_crate] call fnc_loadStash;

call _fnc_openMenu;

waitUntil {!isNil "playersInRaid"};

private _found = false;

scopeName "exit1";

{
	if(_x select 0 == (getPlayerUID player)) then
	{
		gPlayerLocked = true;
		gLockedTime = _x select 1;
		breakTo "exit1";
	};
} forEach playersInRaid;

call _fnc_updateMenu;

if(_state == "killed" || _state == "killedByQuit") then
{
	[_state] spawn 
	{
		disableSerialization;
		private _state = _this select 0;
		
		private _w = 1.0;
		private _h = 0.12;

		_kiaControl = (findDisplay 46) ctrlCreate ["RscStructuredText", 999906];
		_kiaControl ctrlSetPosition [0.5 - (_w / 2), 0.5 - (_h / 2), _w, _h];
		_kiaControl ctrlSetBackgroundColor [1,0,0,1];
		_kiaControl ctrlCommit 0;
				
		private _text = format["<t font='EtelkaMonospacePro' size='3' shadow='0' color='#000000' align='center'>%1</t>", localize "STR_KIA"];

		if(_state == "killedByQuit") then
		{
			_text = format["<t font='EtelkaMonospacePro' size='3' shadow='0' color='#000000' align='center'>%1</t>", localize "STR_MIA"];
		};

		_kiaControl ctrlSetStructuredText parseText _text;
		
		sleep 3;
		
		if(!((findDisplay 46 displayCtrl 999906) isEqualTo controlNull)) then
		{
			ctrlDelete (findDisplay 46 displayCtrl 999906);
		};
	};
};

player addEventHandler ["Reloaded", {
	params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

	if(_unit == player) then
	{
		[player, false] call fnc_savePlayer;
		private _slot = player getVariable["slot", 0];
		private _crate = missionNamespace getVariable ["playerCrate" + str(_slot) , objNull];
		[_crate] call fnc_saveStash;

		saveProfileNamespace;
	};
}];

player addEventHandler ["Put", {
	params ["_unit", "_container", "_item"];

	if(_unit == player) then
	{
		[player, false] call fnc_savePlayer;
		private _slot = player getVariable["slot", 0];
		private _crate = missionNamespace getVariable ["playerCrate" + str(_slot) , objNull];
		[_crate] call fnc_saveStash;

		saveProfileNamespace;
	};
}];

player addEventHandler ["Take", {
	params ["_unit", "_container", "_item"];

	if(_unit == player) then
	{
		[player, false] call fnc_savePlayer;
		private _slot = player getVariable["slot", 0];
		private _crate = missionNamespace getVariable ["playerCrate" + str(_slot) , objNull];
		[_crate] call fnc_saveStash;

		saveProfileNamespace;
	};
}];

player addEventHandler ["FiredMan", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

	if(_unit == player) then
	{
		[player, false] call fnc_savePlayer;
		private _slot = player getVariable["slot", 0];
		private _crate = missionNamespace getVariable ["playerCrate" + str(_slot) , objNull];
		[_crate] call fnc_saveStash;

		saveProfileNamespace;
	};
}];

player addEventHandler ["InventoryOpened", {
	params ["_unit", "_container"];
	
	if(_unit == player) then
	{
		[player, false] call fnc_savePlayer;
		private _slot = player getVariable["slot", 0];
		private _crate = missionNamespace getVariable ["playerCrate" + str(_slot) , objNull];
		[_crate] call fnc_saveStash;

		saveProfileNamespace;
	};
}];

player addEventHandler ["InventoryClosed", {
	params ["_unit", "_container"];

	if(_unit == player) then
	{
		[player, false] call fnc_savePlayer;
		private _slot = player getVariable["slot", 0];
		private _crate = missionNamespace getVariable ["playerCrate" + str(_slot) , objNull];
		[_crate] call fnc_saveStash;

		saveProfileNamespace;
	};
}];

waitUntil 
{
	private _gearDialog = findDisplay 602;
	
	if ((dialog || visibleMap || !isNull _gearDialog) && !((findDisplay 46 displayCtrl 999902) isEqualTo controlNull)) then
	{
		[true] call fnc_closeMenu;
		hintSilent "";
	};
	
	if (!dialog && !gMissionEnded && !visibleMap && isNull _gearDialog && ((findDisplay 46 displayCtrl 999902) isEqualTo controlNull)) then
	{
		call _fnc_openMenu;
	};
	
	private _found = false;

	scopeName "exit2";

	{
		if(_x select 0 == (getPlayerUID player)) then
		{
			_found = true;
			gLockedTime = _x select 1;
			breakTo "exit2";
		};
	} forEach playersInRaid;
	
	if(_found) then
	{
		if(!gPlayerLocked) then
		{
			gPlayerLocked = true;
		};
	}
	else
	{
		if(gPlayerLocked) then
		{
			gPlayerLocked = false;
			private _slot = player getVariable["slot", 0];
			private _entry = missionNamespace getVariable ["entry" + str(_slot) , objNull];
			
			if(!(isNull _entry )) then
			{
				if(player in list _entry) then
				{
					execVM "scripts\entryTimer.sqf";
				};
			};
		};
	};
	
	call _fnc_updateMenu;
	
	if((cursorTarget iskindOf "Land_File1_F") && ((findDisplay 46 displayCtrl 999904) isEqualTo controlNull)) then
	{
		if((player distance2D cursorTarget) <= 2) then
		{
			_diaryControl = (findDisplay 46) ctrlCreate ["RscStructuredText", 999904];
			_diaryControl ctrlSetPosition [0.1, 0.1, 0.8, 0.8];
			_diaryControl ctrlSetBackgroundColor [0,0,0,0.6];
			_diaryControl ctrlCommit 0;
			
			private _text = "";
			_text = _text + format["<br /><t font='EtelkaMonospacePro' size='2' shadow='0' color='#ffffff' align='center'>%1</t><br />", localize "STR_Diary"];
			
			_text = _text + format["<br /><br /><t font='EtelkaMonospacePro' size='1' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;%1</t><br />", localize "STR_DiaryGlobalStats"];
			
			private _hours = 0;
			private _minutes = 0;
			private _seconds = 0;
			
			_hours = floor(_totalPlayTime / (60 * 60));
			_minutes = floor((_totalPlayTime mod (60 * 60)) / 60);
			_seconds = floor((_totalPlayTime mod (60 * 60)) mod 60);
			
			if(_minutes < 10) then
			{
				_minutes = format ["0%1", _minutes];
			}
			else
			{
				_minutes = format ["%1", _minutes];
			};
			
			if(_seconds < 10) then
			{
				_seconds = format ["0%1", _seconds];
			}
			else
			{
				_seconds = format ["%1", _seconds];
			};
			
			_text = _text + format["<br /><t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;%1</t>", localize "STR_DiaryTotalPlayTime"];
			_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='right'>%1:%2:%3&#160;&#160;&#160;&#160;</t>", _hours, _minutes, _seconds];
			
			_text = _text + format["<br /><t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;%1</t>", localize "STR_DiaryDeaths"];
			_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='right'>%1&#160;&#160;&#160;&#160;</t>", _deaths];
			
			_text = _text + format["<br /><t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;%1</t>", localize "STR_DiaryTotalRaids"];
			_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='right'>%1&#160;&#160;&#160;&#160;</t>", _totalRaids];
			
			_text = _text + format["<br /><t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;%1</t>", localize "STR_DiaryTotalKills"];
			_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='right'>%1&#160;&#160;&#160;&#160;</t>", _totalKills];

			_text = _text + format["<br /><t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;%1</t>", localize "STR_DiaryTotalDogtags"];
			_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='right'>%1&#160;&#160;&#160;&#160;</t>", _totalDogtags];
			
			_text = _text + format["<br /><t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;%1</t>", localize "STR_DiaryTopScore"];
			_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='right'>%1&#160;&#160;&#160;&#160;</t>", _topScore];
			
			_text = _text + format["<br /><br /><t font='EtelkaMonospacePro' size='1' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;%1</t><br />", localize "STR_DiaryCurrentChar"];
			
			_hours = floor(_playTime / (60 * 60));
			_minutes = floor((_playTime mod (60 * 60)) / 60);
			_seconds = floor((_playTime mod (60 * 60)) mod 60);
			
			if(_minutes < 10) then
			{
				_minutes = format ["0%1", _minutes];
			}
			else
			{
				_minutes = format ["%1", _minutes];
			};
			
			if(_seconds < 10) then
			{
				_seconds = format ["0%1", _seconds];
			}
			else
			{
				_seconds = format ["%1", _seconds];
			};
			
			_text = _text + format["<br /><t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;%1</t>", localize "STR_DiaryPlayTime"];
			_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='right'>%1:%2:%3&#160;&#160;&#160;&#160;</t>", _hours, _minutes, _seconds];
			
			_text = _text + format["<br /><t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;%1</t>", localize "STR_DiaryRaids"];
			_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='right'>%1&#160;&#160;&#160;&#160;</t>", _raids];
			
			_text = _text + format["<br /><t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;%1</t>", localize "STR_DiaryKills"];
			_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='right'>%1&#160;&#160;&#160;&#160;</t>", _kills];
			
			_text = _text + format["<br /><t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;%1</t>", localize "STR_DiaryDogtags"];
			_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='right'>%1&#160;&#160;&#160;&#160;</t>", _dogtags];
			
			_diaryControl ctrlSetStructuredText parseText _text;
		};
	};
	
	if(!(cursorTarget iskindOf "Land_File1_F") && !((findDisplay 46 displayCtrl 999904) isEqualTo controlNull)) then
	{
		ctrlDelete _diaryControl;
	};
	
	if(!(isNil "topTen")) then
	{
		if(count topTen > 0 && (cursorTarget iskindOf "Land_FilePhotos_F") && ((findDisplay 46 displayCtrl 999905) isEqualTo controlNull)) then
		{
			if((player distance2D cursorTarget) <= 2) then
			{
				_topTenControl = (findDisplay 46) ctrlCreate ["RscStructuredText", 999905];
				_topTenControl ctrlSetPosition [0.1, 0.1, 0.8, 0.8];
				_topTenControl ctrlSetBackgroundColor [0,0,0,0.6];
				_topTenControl ctrlCommit 0;
				
				private _text = "";
				_text = _text + format["<br /><t font='EtelkaMonospacePro' size='2' shadow='0' color='#ffffff' align='center'>%1</t><br /><br /><br />", localize "STR_TopTen"];
				
				private _lastScore = -1;
				private _pos = 0;
				
				for "_i" from 0 to ((count topTen) - 1) do 
				{
					if(_lastScore != (topTen select _i select 1)) then
					{
						_lastScore = topTen select _i select 1;
						_pos = _pos + 1;
					};
					
					_text = _text + format["<br /><t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='left'>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;%1. %2</t>", _pos, topTen select _i select 0];
					_text = _text + format["<t font='EtelkaMonospacePro' size='0.8' shadow='0' color='#ffffff' align='right'>%1&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</t>", topTen select _i select 1];
				};
				
				_topTenControl ctrlSetStructuredText parseText _text;
			};
		};
	};
	
	if(!(cursorTarget iskindOf "Land_FilePhotos_F") && !((findDisplay 46 displayCtrl 999905) isEqualTo controlNull)) then
	{
		ctrlDelete _topTenControl;
	};
	
	if ((player distance2D position _position) > 12) then
	{
		player setpos (getPosATL _position);
		player setDir 90;
	};
	
	sleep 0.2;
		
	gMenu == 0 && !gPlayerLocked
};

gInventory = false;

player removeAllEventHandlers "Reloaded";
player removeAllEventHandlers "Put";
player removeAllEventHandlers "Take";
player removeAllEventHandlers "FiredMan";
player removeAllEventHandlers "InventoryOpened";
player removeAllEventHandlers "InventoryClosed";

[player, false] call fnc_savePlayer;
[_crate] call fnc_saveStash;

if(gPersistentTime) then
{
	[["date", date]] call fnc_saveData;
};

saveProfileNamespace;

clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

_wholders = nearestObjects [position _position, ["WeaponHolder","GroundWeaponHolder","WeaponHolderSimulated"], 15, true];

{
	deleteVehicle _x;
} forEach _wholders;

_objects = nearestObjects [position _position, [], 15, true];

{
	if(typeOf _x == "Land_BakedBeans_F" || _x isKindOf "SmokeShell" || _x isKindOf "DemoCharge_Remote_Ammo" || _x isKindOf "SatchelCharge_Remote_Ammo" || _x isKindOf "Chemlight_blue" || _x isKindOf "Chemlight_green" || _x isKindOf "Chemlight_red" || _x isKindOf "Chemlight_yellow") then
	{
		deleteVehicle _x
	};
} forEach _objects;

ctrlDelete _menuControl;
_menuControl = nil;

if(!((findDisplay 46 displayCtrl 999904) isEqualTo controlNull)) then
{
	ctrlDelete (findDisplay 46 displayCtrl 999904);
};

if(!((findDisplay 46 displayCtrl 999905) isEqualTo controlNull)) then
{
	ctrlDelete (findDisplay 46 displayCtrl 999905);
};

if(!((findDisplay 46 displayCtrl 999906) isEqualTo controlNull)) then
{
	ctrlDelete (findDisplay 46 displayCtrl 999906);
};

hintSilent "";