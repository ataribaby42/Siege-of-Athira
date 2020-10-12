private _purchase = _this select 0;
private _payment = _this select 1;
private _raidGUID =  _this select 2;

gTraderBoxIndex = floor random (count gTraderBoxes);
gTraderPurchase = _purchase;
gTraderPayment = _payment;
gTraderState = 1;

private _crate = gTraderBoxes select gTraderBoxIndex;
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

[["traderRaidGUID", _raidGUID], ["traderState", gTraderState], ["traderBoxIndex", gTraderBoxIndex], ["traderPurchase", gTraderPurchase], ["traderPayment", gTraderPayment]] call fnc_saveData;
saveProfileNamespace;

sleep 1;

[true, false] execVM "scripts\traderUpdateDeal.sqf";

