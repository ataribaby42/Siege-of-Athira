private _unit = _this;

private _missingInRaid = ["raid", nil] call fnc_loadData;
[["raid", nil]] call fnc_saveData;

saveProfileNamespace;

if(isNil "_missingInRaid") then
{
	nil;
}
else
{
	_missingInRaid;
};