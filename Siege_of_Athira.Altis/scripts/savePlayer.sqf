private _unit = _this select 0;
private _resetRaid = _this select 1;

private _val = 0;
private _saveData = [];

_val = getPlayerUID player;
_saveData = _saveData + [["uid", _val]];

_val = getUnitLoadout player;
_saveData = _saveData + [["loadout", _val]];

if (_resetRaid) then
{
	_saveData = _saveData + [["raid", nil]];
};

_val = damage _unit;
_saveData = _saveData + [["damage", _val]];

_val = _unit getHit "head";
_saveData = _saveData + [["damage_head", _val]];

_val = _unit getHit "body";
_saveData = _saveData + [["damage_body", _val]];

_val = _unit getHit "hands";
_saveData = _saveData + [["damage_hands", _val]];

_val = _unit getHit "legs";
_saveData = _saveData + [["damage_legs", _val]];

private _dogtags = ["dogtags", 0] call fnc_loadData;
private _dogtagsAdd = _unit getVariable["dogtagsNum", 0];
_unit setVariable["dogtagsNum", nil, true];
_dogtags = _dogtags + _dogtagsAdd;
_saveData = _saveData + [["dogtags", _dogtags]];

private _totalDogtags = ["totalDogtags", 0] call fnc_loadData;
_totalDogtags = _totalDogtags + _dogtagsAdd;
_saveData = _saveData + [["totalDogtags", _totalDogtags]];

private _kills = ["kills", 0] call fnc_loadData;
private _killsAdd = _unit getVariable["kills", 0];
_unit setVariable["kills", nil, true];
_kills = _kills + _killsAdd;
_saveData = _saveData + [["kills", _kills]];

private _totalKills = ["totalKills", 0] call fnc_loadData;
_totalKills = _totalKills + _killsAdd;
_saveData = _saveData + [["totalKills", _totalKills]];

private _food = ["food", 0] call fnc_loadData;
private _foodAdd = _unit getVariable["food", 0];
_food = _food + _foodAdd;
_unit setVariable["food", nil, true];
_saveData = _saveData + [["food", _food]];

_val = rating _unit;
_saveData = _saveData + [["rating", _val]];

_saveData call fnc_saveData;