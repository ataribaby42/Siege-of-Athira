private _varname = 0;
private _val = 0;
private _oldVal = 0;
private _label = 0;
private _newData = [];

if(gClientMode == "SINGLEPLAYER") then
{
	_label = gSavePrefix + "_sp";
}
else
{
	_label = gSavePrefix + "_mp";
};

if(gClientMode == "DEDICATED_SERVER") then
{

}
else
{
	_varname = _label + "_uid";
	_test = profileNamespace getVariable [_varname, nil];

	if(!(isNil "_test")) then
	{	
		_varname = _label + "_uid";
		_newData = _newData + [["uid", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];
		
		_varname = _label + "_raid";
		_newData = _newData + [["raid", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_killed";
		_newData = _newData + [["killed", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_loadout";
		_newData = _newData + [["loadout", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_stash";
		_newData = _newData + [["stash", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_damage";
		_newData = _newData + [["damage", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_damage_head";
		_newData = _newData + [["damage_head", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_damage_body";
		_newData = _newData + [["damage_body", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_damage_hands";
		_newData = _newData + [["damage_hands", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_damage_legs";
		_newData = _newData + [["damage_legs", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_dogtags";
		_newData = _newData + [["dogtags", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_totalDogtags";
		_newData = _newData + [["totalDogtags", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_totalKills";
		_newData = _newData + [["totalKills", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_kills";
		_newData = _newData + [["kills", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_totalPlayTime";
		_newData = _newData + [["totalPlayTime", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_playTime";
		_newData = _newData + [["playTime", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_raidGUID";
		_newData = _newData + [["raidGUID", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_food";
		_newData = _newData + [["food", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_stamina";
		_newData = _newData + [["stamina", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_deaths";
		_newData = _newData + [["deaths", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_totalRaids";
		_newData = _newData + [["totalRaids", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_raids";
		_newData = _newData + [["raids", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_score";
		_newData = _newData + [["score", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_topScore";
		_newData = _newData + [["topScore", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_rating";
		_newData = _newData + [["rating", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		_varname = _label + "_radio";
		_newData = _newData + [["radio", profileNamespace getVariable [_varname, nil]]];
		profileNamespace setVariable [_varname, nil];

		saveProfileNamespace;

		_newData call fnc_saveData;
	};
}

