private _unit = _this select 0;
private _resetRaid = _this select 1;
private _killed = _this select 2;

if (_resetRaid) then
{
	[["raid", nil]] call fnc_saveData;
};

if (_killed) then
{
	[["killed", true]] call fnc_saveData;
}
else
{
	[["killed", nil]] call fnc_saveData;
};

[["loadout", nil]] call fnc_saveData;
[["damage", nil]] call fnc_saveData;
[["damage_head", nil]] call fnc_saveData;
[["damage_body", nil]] call fnc_saveData;
[["damage_hands", nil]] call fnc_saveData;
[["damage_legs", nil]] call fnc_saveData;
[["dogtags", nil]] call fnc_saveData;
[["kills", nil]] call fnc_saveData;
[["playTime", nil]] call fnc_saveData;
[["raids", nil]] call fnc_saveData;
[["stamina", nil]] call fnc_saveData;
[["food", nil]] call fnc_saveData;
[["raidGUI", nil]] call fnc_saveData;
[["score", nil]] call fnc_saveData;
[["rating", nil]] call fnc_saveData;
[["traderNewGuy", nil], ["traderFail", nil], ["traderRaidGUID", nil], ["traderCrate", nil], ["traderState", nil], ["traderBoxIndex", nil], ["traderPurchase", nil], ["traderPayment", nil]] call fnc_saveData;

saveProfileNamespace;

call fnc_traderResetCrates;