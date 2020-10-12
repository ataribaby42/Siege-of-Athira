private _dataName = _this select 0;
private _defaultValue = _this select 1;
private _varname = 0;
private _val = 0;
private _label = 0;
private _found = false;
private _result = 0;

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
	if((_x select 0) == _dataName) exitWith
	{
		_found = true;
		_result = _x select 1;
	};

} forEach _val;

if(_found && !(isNil "_result")) then
{
	_result
}
else
{
	if(!(isNil "_defaultValue")) then
	{
		_defaultValue
	}
	else
	{
		nil
	};
};