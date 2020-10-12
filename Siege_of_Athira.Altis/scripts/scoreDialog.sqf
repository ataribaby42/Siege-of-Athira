disableSerialization;

private _score = _this select 0;
private _scoreItems = _this select 1;
private _radioNotice = _this select 2;

private _dialog = createdialog "soaDialogScore";

private _display = findDisplay 999910;

private _text = _display displayCtrl 1001;
_text ctrlSetText format[localize "STR_DialogScoreTxRaidScore", _score];

private _listbox = _display displayCtrl 1500;

{
	_listbox lbAdd format[localize ("STR_" + (_x select 0)) , _x select 1, _x select 2];
} forEach _scoreItems;

waitUntil { !dialog };

private _text = localize "STR_SafeHouse";
private _duration = 10;  
private _fadeInTime = 2;    
private _introText = format["<t font='PuristaBold' size='1' align='right'>%1</t><br /><t size='0.9' align='right'>%2 %3</t>", _text, date call fnc_globalizeDate, format ["%1", ([dayTime, "HH:MM"] call BIS_fnc_timeToString)]];
[_introText,safezoneX+safezoneW-1.1,safezoneY+safezoneH-0.4,_duration,_fadeInTime,0,90] spawn bis_fnc_dynamicText;

if(_radioNotice) then
{
	hintSilent parseText localize "STR_RadioNotice";
};

if(!isNil "gPersonalScoreBeaten") then
{
	if(gPersonalScoreBeaten) then
	{
		gPersonalScoreBeaten = false;
		["TrophyInfo",[localize "STR_Information", localize "STR_PersonalScoreBeaten"]] call bis_fnc_showNotification;
	};
};

if(!isNil "gTopTenAdded") then
{
	if(gTopTenAdded) then
	{
		gTopTenAdded = false;
		["TrophyInfo",[localize "STR_Information", localize "STR_TopTenScoreBeaten"]] call bis_fnc_showNotification;
	};
};

waitUntil {gTraderLoaded};
[true, false] execVM "scripts\traderUpdateDeal.sqf";

