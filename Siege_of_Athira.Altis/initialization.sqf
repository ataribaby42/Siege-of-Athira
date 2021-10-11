["MENU",false] call bis_fnc_blackOut;
0 fadeSound 0; 

gVersion = "2.30";
MISSION_ROOT = getMissionPath "";

//client mode

if(!isMultiplayer) then
{
	gClientMode = "SINGLEPLAYER";
}
else
{
	if (isServer && !isDedicated) then 
	{ 
		gClientMode = "LOCAL_SERVER";
	}
	else
	{
		if (isDedicated) then 
		{ 
			gClientMode = "DEDICATED_SERVER";
		}
		else
		{
			if (!isDedicated) then 
			{ 
				gClientMode = "CLIENT"; 
			}
		};
	};
};

soa_ClientMode_done = true;

//precompile functions

fnc_globalizeDate = compileFinal preprocessFileLineNumbers "scripts\globalizeDate.sqf";
fnc_generateGUID = compileFinal preprocessFileLineNumbers "scripts\generateGUID.sqf";
fnc_cleanUp = compileFinal preprocessFileLineNumbers "scripts\cleanUp.sqf";
fnc_resetPlayerRaid = compileFinal preprocessFileLineNumbers "scripts\resetPlayerRaid.sqf";
fnc_loadPlayer = compileFinal preprocessFileLineNumbers "scripts\loadPlayer.sqf";
fnc_savePlayer = compileFinal preprocessFileLineNumbers "scripts\savePlayer.sqf";
fnc_resetPlayer = compileFinal preprocessFileLineNumbers "scripts\resetPlayer.sqf";
fnc_loadStash = compileFinal preprocessFileLineNumbers "scripts\loadStash.sqf";
fnc_saveStash = compileFinal preprocessFileLineNumbers "scripts\saveStash.sqf";
fnc_aiGenerator = compileFinal preprocessFileLineNumbers "scripts\aiGenerator.sqf";
fnc_aiSetup = compileFinal preprocessFileLineNumbers "scripts\aiSetup.sqf";
fnc_getSpawnPos = compileFinal preprocessFileLineNumbers "scripts\getSpawnPos.sqf";
fnc_getRandomStart = compileFinal preprocessFileLineNumbers "scripts\getRandomStart.sqf";
fnc_zoneVSniper = compileFinal preprocessFileLineNumbers "scripts\zoneVSniper.sqf";
fnc_vsniper = compileFinal preprocessFileLineNumbers "scripts\vsniper.sqf";
fnc_playerAgent = compileFinal preprocessFileLineNumbers "scripts\playerAgent.sqf";
fnc_aiAgent = compileFinal preprocessFileLineNumbers "scripts\aiAgent.sqf";
fnc_patrol = compileFinal preprocessFileLineNumbers "scripts\patrol.sqf";
fnc_closeMenu = compileFinal preprocessFileLineNumbers "scripts\closeMenu.sqf";
fnc_processSnipers = compileFinal preprocessFileLineNumbers "scripts\processSnipers.sqf";
fnc_processPlayersInRaid = compileFinal preprocessFileLineNumbers "scripts\processPlayersInRaid.sqf";
fnc_addActions = compileFinal preprocessFileLineNumbers "scripts\addActions.sqf";
fnc_processChems = compileFinal preprocessFileLineNumbers "scripts\processChems.sqf";
fnc_stopAnim = compileFinal preprocessFileLineNumbers "scripts\stopAnim.sqf";
fnc_aiChemOn = compileFinal preprocessFileLineNumbers "scripts\aiChemOn.sqf";
fnc_aiChemOff = compileFinal preprocessFileLineNumbers "scripts\aiChemOff.sqf";
fnc_initKillboard = compileFinal preprocessFileLineNumbers "scripts\initKillboard.sqf";
fnc_updateKillboard = compileFinal preprocessFileLineNumbers "scripts\updateKillboard.sqf";
fnc_placeFood = compileFinal preprocessFileLineNumbers "scripts\placeFood.sqf";
fnc_placeLoot = compileFinal preprocessFileLineNumbers "scripts\placeLoot.sqf";
fnc_addShelterFood = compileFinal preprocessFileLineNumbers "scripts\addShelterFood.sqf";
fnc_fireFlare = compileFinal preprocessFileLineNumbers "scripts\fireFlare.sqf";
fnc_fireFlares = compileFinal preprocessFileLineNumbers "scripts\fireFlares.sqf";
fnc_loot = compileFinal preprocessFileLineNumbers "scripts\loot.sqf";
fnc_leafletDrop = compileFinal preprocessFileLineNumbers "scripts\leafletDrop.sqf";
fnc_searchHouse = compileFinal preprocessFileLineNumbers "scripts\searchHouse.sqf";
fnc_simpleBreathFog = compileFinal preprocessFileLineNumbers "scripts\simpleBreathFog.sqf";
fnc_aiCSATagent = compileFinal preprocessFileLineNumbers "scripts\aiCSATagent.sqf";
fnc_unitTalk = compileFinal preprocessFileLineNumbers "scripts\unitTalk.sqf";
fnc_chitChat = compileFinal preprocessFileLineNumbers "scripts\chitchat.sqf";
fnc_earthquake = compileFinal preprocessFileLineNumbers "scripts\earthquake.sqf";
fnc_scoreDialog = compileFinal preprocessFileLineNumbers "scripts\scoreDialog.sqf";
fnc_saveData = compileFinal preprocessFileLineNumbers "scripts\saveData.sqf";
fnc_loadData = compileFinal preprocessFileLineNumbers "scripts\loadData.sqf";
fnc_migrateData = compileFinal preprocessFileLineNumbers "scripts\migrateData.sqf";
llw_fnc_getSunAngle = compileFinal preprocessFileLineNumbers "scripts\getSunAngle.sqf";
llw_fnc_getSunrise = compileFinal preprocessFileLineNumbers "scripts\getSunrise.sqf";
llw_fnc_getTemperature = compileFinal preprocessFileLineNumbers "scripts\getTemperature.sqf";

#include"CRS\CFG.sqf";
#include"scripts\traderFunctions.sqf";

CRS_AT=compileFinal preprocessFile"CRS\f\AT.sqf";
CRS_BB=compileFinal preprocessFile"CRS\f\BB.sqf";
CRS_BBlasted=compileFinal preprocessFile"CRS\f\BBlasted.sqf";
CRS_FB=compileFinal preprocessFile"CRS\f\FB.sqf";
CRS_Flashed=compileFinal preprocessFile"CRS\f\flashed.sqf";
CRS_Holster=compileFinal preprocessFile"CRS\f\holster.sqf";
CRS_AI=compileFinal preprocessFile"CRS\f\CRSAI.sqf";

fnc_balance_magazines = {
	private _magazines = _this select 0;
	private _ammo_list = [];
	private _magazines_repacked = [];
	private _found = false;
	private _current_item = "";
	private _current_amount = 0;
	private _magazine_size = 0;
	
	{
		_current_item = (_x select 0);
		_current_amount = (_x select 1);
		_found = false;

		{
			if ((_x select 0) == _current_item) then {
				_found = true;
				_x set [1, (_x select 1) + _current_amount];
			};
		} forEach _ammo_list;

		if (!_found) then {
			_ammo_list pushBack [_current_item, _current_amount];
		};	
	} forEach _magazines;

	{
		_magazine_size = getNumber(configfile >> "CfgMagazines" >> (_x select 0) >> "count");
		_magazines_count = floor((_x select 1) / _magazine_size);
		for "_i" from 1 to _magazines_count do {
			_magazines_repacked pushBack [(_x select 0), _magazine_size];
		};

		_magazines_count = ((_x select 1) % _magazine_size);
		if (_magazines_count > 0) then {
			_magazines_repacked pushBack [(_x select 0), _magazines_count];
		};
		
	} forEach _ammo_list;

	_magazines_repacked;
};

fnc_inHouse = {
	private _house = "";
	lineIntersectsSurfaces [
		getPosWorld _this, 
		getPosWorld _this vectorAdd [0, 0, 50], 
		_this, objNull, true, 1, "GEOM", "NONE"
	] select 0 params ["","","","_house"];
	if (_house isKindOf "House") exitWith {true};
	false
};

fnc_computeMoonPhase = {
	private _phase = moonIntensity;
	_phase;
};

fnc_setRating = {
	private _setRating = _this select 0;
	private _unit = _this select 1;
	private _getRating = rating _unit;
	private _addVal = _setRating - _getRating;
	_unit addRating _addVal;
};

fnc_isNight = {
	private _angle = [] call llw_fnc_getSunAngle select 0;
	private _night = false;
	
	if(_angle <= -7.5) then
	{
		_night = true;
	};
	
	_night;
};

fnc_predictNight = {
	private _angle = [] call llw_fnc_getSunAngle select 0;
	private _night = false;
	
	if(_angle < -7) then
	{
		_night = true;
	};
	
	_night;
};

fnc_isMoonlight = {
	private _moonlight = true;
	
	if(gMoonPhase <= 0.2) then
	{
		_moonlight = false;
	};
	
	_moonlight;
};

fnc_isCold = {
	private _cold = false;
	
	if(!isNil "gTemp") then
	{
		if(gTemp < 11) then
		{
			_cold = true;
		}
	};
	
	_cold;
};

fnc_weaponDown = {
	private _unit = _this select 0;
	private _weapon = currentWeapon _unit;

	if(_weapon == "") then
	{
		
	}
	else
	{
		if(_weapon isKindOf ["Rifle", configFile >> "CfgWeapons"]) then
		{
			_unit switchMove "AidlPercMstpSlowWrflDnon_G01";
		}
		else
		{
			if(_weapon isKindOf ["Pistol", configFile >> "CfgWeapons"]) then
			{
				_unit switchMove "AidlPercMstpSlowWpstDnon_G01";
			}
			else
			{
				//Launcher
				_unit action ["SWITCHWEAPON", player, player, -1];
			};
		};
	};
};

// Figures out how zoomed in you are (KillzoneKid is Awesome)
KK_fnc_getZoom = {
    (
        [0.5,0.5] 
        distance 
        worldToScreen 
        positionCameraToWorld 
        [0,1.05,1]
    ) * (
        getResolution 
        select 
        5
    )
};

fnc_createMarker = {
  private _pos = 0;
  private _m = 0;
  
  _pos = _this select 0;
  _m = createMarker [format["mPos%1%2",(floor(_pos select 0)),(floor(_pos select 1))],_pos];
  _m setmarkerColor (_this select 1);
  _m setMarkerShape "Icon";
  _m setMarkerType "mil_dot";
};

/*
	Author: Terra
	
	Description:
	 Substitute a certain part of a string with another string.
	
	Parameters:
	1: STRING - Source string
	2: STRING - Part to edit
	3: STRING - Substitution
	
	Returns: STRING
	
	Example: 
		["12345 123456", "123", "abc"] call TER_fnc_editString;
		Returns: "abc45 abc456"
*/
TER_fnc_editString = 
{
  params ["_str", "_toFind", "_subsitution"];
  _char = count _toFind;
  _no = _str find _toFind;
  while {-1 != _str find _toFind} do {
      _no = _str find _toFind;
      _splitStr = _str splitString "";
      _splitStr deleteRange [(_no +1), _char -1];
      _splitStr set [_no, _subsitution];
      _str = _splitStr joinString "";
  };
  _str
};

fnc_noWhiteSpaces =
{
	private _string = _this;
	private _noWhitespace = "";

	_noWhitespace = toArray(_this);
	{
		// if statement is false if character is not: space, tab, carriage return, newline
		if ([32, 9, 13, 10] find _x > -1) then
		{
			_noWhitespace deleteAt _forEachIndex;
		};
	} forEach _noWhitespace;

	toString(_noWhitespace);
};

fnc_getItemTooltip =
{
	params ["_name", "_desc", "_dlc"];
	private _tooltip = "";
	
	_tooltip = _name;

	if(_desc != "" && _name != _desc) then
	{
		_tooltip = format["%1\n%2", _tooltip, [[_desc, "<br />", toString [13, 10]] call TER_fnc_editString, "<br/>", toString [13, 10]] call TER_fnc_editString];
	};

	/*
	if(_dlc != "") then
	{
		_tooltip = format["%1\nDLC:%2", _tooltip, _dlc];
	};
	*/
	
	_tooltip
};

//settings
#include "settings.sqf";

gDisableSave = false;

call fnc_migrateData;

soa_init_done = true;