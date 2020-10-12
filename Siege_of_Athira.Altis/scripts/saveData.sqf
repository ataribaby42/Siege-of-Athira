private _data =  _this;
private _varname = 0;
private _val = 0;
private _label = 0;
private _add = [];

if(gDisableSave) exitWith {};

if(gClientMode == "SINGLEPLAYER") then
{
	_label = gSavePrefix + "_sp";
}
else
{
	_label = gSavePrefix + "_mp";
};

_varname = _label + "_data";
_val = profileNamespace getVariable [_varname, []];

{
	private _dataName = _x select 0;
	private _dataValue = _x select 1;
	private _found = false;

	{
		if((_x select 0) == _dataName) exitWith
		{
			if(!(isNil "_dataValue")) then
			{
				_val set [_forEachIndex, [_dataName, _dataValue]];
			}
			else
			{
				_val set [_forEachIndex, [_dataName, nil]];
			};

			_found = true;
		};

	} forEach _val;

	if(!_found) then
	{
		if(!(isNil "_dataValue")) then
		{
			_add = _add + [[_dataName, _dataValue]];
		}
		else
		{
			_add = _add + [[_dataName, nil]];
		}
	};

} forEach _data;

_val = _val + _add;
profileNamespace setVariable [_varname, _val];