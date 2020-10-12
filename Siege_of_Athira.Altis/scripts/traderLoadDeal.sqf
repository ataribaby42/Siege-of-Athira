private _traderRaidGUID = ["traderRaidGUID", ""] call fnc_loadData;
gTraderBoxIndex = ["traderBoxIndex", -1] call fnc_loadData;

//if(_traderRaidGUID != gRaidGUID && gTraderBoxIndex > -1 && gClientMode != "SINGLEPLAYER") then
if(_traderRaidGUID != gRaidGUID && gTraderBoxIndex > -1) then
{
	[["traderFail", true], ["traderRaidGUID", nil], ["traderCrate", nil], ["traderState", nil], ["traderBoxIndex", nil], ["traderPurchase", nil], ["traderPayment", nil]] call fnc_saveData;
	saveProfileNamespace;
};

gTraderBoxIndex = ["traderBoxIndex", -1] call fnc_loadData;
gTraderPurchase = ["traderPurchase", []] call fnc_loadData;
gTraderPayment = ["traderPayment", []] call fnc_loadData;
gTraderState = ["traderState", 0] call fnc_loadData;

if(isNil "gTraderBoxIndex" || !gTraderActive) then
{
	gTraderBoxIndex = -1;
	gTraderPurchase = [];
	gTraderPayment = [];
	gTraderState = 0;
};

call fnc_traderResetCrates;

if(gTraderBoxIndex > -1 && gTraderState == 3) then
{
	call fnc_traderLoadCrate;
};
