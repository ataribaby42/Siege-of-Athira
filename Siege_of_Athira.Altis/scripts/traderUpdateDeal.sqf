private _makeNotification = _this select 0;
private _makeDiscountNotification = _this select 1;

if(gTraderBoxIndex > -1 && count gTraderPayment > 0) then
{
	call fnc_traderProcessCrate;
	call fnc_traderCheckPayment;
	[["traderPayment", gTraderPayment]] call fnc_saveData;
	saveProfileNamespace;
};

if(gTraderBoxIndex > -1 && gTraderState == 3) then
{
	call fnc_traderSaveCrate;
};

if(_makeNotification) then
{
	execVM "scripts\traderShowDeal.sqf";
};

if(_makeDiscountNotification) then
{
	["TraderInfo",[localize "STR_Information", format[localize "STR_TraderDiscountInfo", call fnc_getTraderDiscount, "%"]]] call bis_fnc_showNotification;
};