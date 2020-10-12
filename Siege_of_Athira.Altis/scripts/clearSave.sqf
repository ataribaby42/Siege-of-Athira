private _result = [localize "STR_ClearSaveQuestion", localize "STR_Confirm", true, true, nil, false, false] call BIS_fnc_guiMessage;

if(_result) then
{
	gDisableSave = true;

	private _label = 0;

	if(gClientMode == "SINGLEPLAYER") then
	{
		_label = gSavePrefix + "_sp";
	}
	else
	{
		_label = gSavePrefix + "_mp";
	};

	private _varname = _label + "_data";
	profileNamespace setVariable [_varname, nil];
	saveProfileNamespace;
}