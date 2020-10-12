disableSerialization;
private _result = true;
private _skipTrader = false;
gDiscount = 0;

if(gTraderBoxIndex > -1 && gTraderState == 3) then
{
	_result = [localize "STR_traderCompleteDealQuestion", localize "STR_Confirm", true, true, nil, false, false] call BIS_fnc_guiMessage; 
};

if(!_result) ExitWith {};

fnc_setChat = {
    private _display = findDisplay 999920;

    private _LbTraderInvetory = _display displayCtrl 1500;
	private _LbYourInventory = _display displayCtrl 1501;
	private _LbPurchase = _display displayCtrl 1502;
	private _LbPayment = _display displayCtrl 1503;
	private _PcMood = _display displayCtrl 1200;
	private _BtDeal = _display displayCtrl 1601;
	private _BtPurchaseAdd = _display displayCtrl 1602;
	private _BtPurchaseRemove = _display displayCtrl 1603;
	private _BtPaymentAdd = _display displayCtrl 1604;
	private _BtPaymentRemove = _display displayCtrl 1605;
	private _TxTraderChat = _display displayCtrl 1100;

	(_display displayCtrl 1000) ctrlShow false;
	(_display displayCtrl 1001) ctrlShow false;
	(_display displayCtrl 1002) ctrlShow false;
	(_display displayCtrl 1003) ctrlShow false;
	(_display displayCtrl 1004) ctrlShow false;
	(_display displayCtrl 1600) ctrlShow false;
	_LbTraderInvetory ctrlShow false;
	_LbYourInventory ctrlShow false;
	_LbPurchase ctrlShow false;
	_LbPayment ctrlShow false;
	_PcMood ctrlShow false;
	_BtDeal ctrlShow false;
	_BtPurchaseAdd ctrlShow false;
	_BtPurchaseRemove ctrlShow false;
	_BtPaymentAdd ctrlShow false;
	_BtPaymentRemove ctrlShow false;
	_TxTraderChat ctrlShow true;
};

fnc_setTrade = {
	gDiscount = call fnc_getTraderDiscount;

    private _display = findDisplay 999920;

    private _LbTraderInvetory = _display displayCtrl 1500;
	private _LbYourInventory = _display displayCtrl 1501;
	private _LbPurchase = _display displayCtrl 1502;
	private _LbPayment = _display displayCtrl 1503;
	private _PcMood = _display displayCtrl 1200;
	private _BtDeal = _display displayCtrl 1601;
	
	if(gDiscount == 0) then
	{
		ctrlSetText [1601, localize "STR_DialogTraderDeal"];
	}
	else
	{
		ctrlSetText [1601, format["%1 (-%2%3)", localize "STR_DialogTraderDeal", gDiscount, "%"]];
	};

	private _BtPurchaseAdd = _display displayCtrl 1602;
	private _BtPurchaseRemove = _display displayCtrl 1603;
	private _BtPaymentAdd = _display displayCtrl 1604;
	private _BtPaymentRemove = _display displayCtrl 1605;
	private _TxTraderChat = _display displayCtrl 1100;

	(_display displayCtrl 1000) ctrlShow true;
	(_display displayCtrl 1001) ctrlShow true;
	(_display displayCtrl 1002) ctrlShow true;
	(_display displayCtrl 1003) ctrlShow true;
	(_display displayCtrl 1004) ctrlShow true;
	(_display displayCtrl 1600) ctrlShow true;
	_LbTraderInvetory ctrlShow true;
	_LbYourInventory ctrlShow true;
	_LbPurchase ctrlShow true;
	_LbPayment ctrlShow true;
	_PcMood ctrlShow true;
	_BtDeal ctrlShow true;
	_BtPurchaseAdd ctrlShow true;
	_BtPurchaseRemove ctrlShow true;
	_BtPaymentAdd ctrlShow true;
	_BtPaymentRemove ctrlShow true;
	_TxTraderChat ctrlShow false;
};

private _index = 0;

private _slot = player getVariable["slot", 0];
private _crate = missionNamespace getVariable ["playerCrate" + str(_slot) , objNull];;
[_crate] call fnc_loadStash;

private _dialog = createdialog "soaDialogTrader";
private _display = findDisplay 999920;

call fnc_setChat;

private _LbTraderInvetory = _display displayCtrl 1500;
private _LbYourInventory = _display displayCtrl 1501;
private _LbPurchase = _display displayCtrl 1502;
private _LbPayment = _display displayCtrl 1503;
private _PcMood = _display displayCtrl 1200;
private _BtDeal = _display displayCtrl 1601;
private _BtPurchaseAdd = _display displayCtrl 1602;
private _BtPurchaseRemove = _display displayCtrl 1603;
private _BtPaymentAdd = _display displayCtrl 1604;
private _BtPaymentRemove = _display displayCtrl 1605;
private _TxTraderChat = _display displayCtrl 1100;

private _saveTraderContacted = false;

if(isNull (findDisplay 999920)) ExitWith {};

if((["traderFail", false] call fnc_loadData)) then
{
	_skipTrader = true;

	private _deals = 10 min (["traderDiscountDeals", 0] call fnc_loadData);
	private _oldDeals = _deals;
	_deals = 0 max (_deals - 2);

	[["traderDiscountDeals", _deals], ["traderFail", nil]] call fnc_saveData;
	saveProfileNamespace;

	sleep 0.5;

	private _text = format["<t color='#ff0000'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Transmitter", localize "STR_traderChat_SentenceHello"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_SentenceHello";
	sleep 2;

	if(isNull (findDisplay 999920)) ExitWith {if(_oldDeals != _deals) then {["TraderInfo",[localize "STR_Information", format[localize "STR_TraderDiscountInfo", call fnc_getTraderDiscount, "%"]]] call bis_fnc_showNotification;};};

	_text = _text + format["<br /><t color='#00ff00'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Receiver", localize "STR_traderChat_Fail"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_Fail";
	sleep 8;

	if(isNull (findDisplay 999920)) ExitWith {if(_oldDeals != _deals) then {["TraderInfo",[localize "STR_Information", format[localize "STR_TraderDiscountInfo", call fnc_getTraderDiscount, "%"]]] call bis_fnc_showNotification;};};
	
	if(_oldDeals != _deals) then {["TraderInfo",[localize "STR_Information", format[localize "STR_TraderDiscountInfo", call fnc_getTraderDiscount, "%"]]] call bis_fnc_showNotification;};
	closeDialog 0;
};

if(isNull (findDisplay 999920)) ExitWith {};

if(!(["traderContacted", false] call fnc_loadData)) then
{
	_saveTraderContacted = true;

	sleep 0.5;

	private _text = format["<t color='#ff0000'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Transmitter", localize "STR_traderChat_Sentence1"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_Sentence1";
	sleep 3;

	if(isNull (findDisplay 999920)) ExitWith {};
	
	_text = _text + format["<br /><t color='#00ff00'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Receiver", "..."];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "TRADER_NOISE2";
	sleep 2;

	if(isNull (findDisplay 999920)) ExitWith {};

	_text = _text + format["<br /><t color='#ff0000'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Transmitter", localize "STR_traderChat_SentenceHello"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_SentenceHello";
	sleep 2;

	if(isNull (findDisplay 999920)) ExitWith {};

	_text = _text + format["<br /><t color='#00ff00'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Receiver", "..."];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "TRADER_NOISE1";
	sleep 2;

	if(isNull (findDisplay 999920)) ExitWith {};

	_text = _text + format["<br /><t color='#ff0000'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Transmitter", localize "STR_traderChat_SentenceAnybodyHearMe"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_SentenceAnybodyHearMe";
	sleep 3;

	if(isNull (findDisplay 999920)) ExitWith {};

	_text = _text + format["<br /><t color='#00ff00'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Receiver", "..."];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "TRADER_NOISE2";
	sleep 2;

	if(isNull (findDisplay 999920)) ExitWith {};

	_text = _text + format["<br /><t color='#00ff00'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Receiver", localize "STR_traderChat_Sentence2"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_Sentence2";
	sleep 11;

	if(isNull (findDisplay 999920)) ExitWith {};

	_text = _text + format["<br /><t color='#ff0000'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Transmitter", localize "STR_traderChat_Sentence3"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_Sentence3";
	sleep 5;

	if(isNull (findDisplay 999920)) ExitWith {};

	_text = _text + format["<br /><t color='#00ff00'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Receiver", localize "STR_traderChat_Sentence4"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_Sentence4";
	sleep 8;

	if(isNull (findDisplay 999920)) ExitWith {};

	_text = _text + format["<br /><t color='#ff0000'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Transmitter", localize "STR_traderChat_Sentence5"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_Sentence5";
	sleep 5;

	if(isNull (findDisplay 999920)) ExitWith {};

	_text = _text + format["<br /><t color='#00ff00'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Receiver", localize "STR_traderChat_Sentence6"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_Sentence6";
	sleep 29;

	if(isNull (findDisplay 999920)) ExitWith {};
};

if(isNull (findDisplay 999920)) ExitWith {};

if(_saveTraderContacted) then
{
	[["traderContacted", true], ["traderNewGuy", true]] call fnc_saveData;
	saveProfileNamespace;
};

if((["traderState", 0] call fnc_loadData) == 1) then
{
	_skipTrader = true;

	sleep 0.5;

	private _text = format["<t color='#ff0000'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Transmitter", localize "STR_traderChat_SentenceHello"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_SentenceHello";
	sleep 2;

	if(isNull (findDisplay 999920)) ExitWith {};

	_text = _text + format["<br /><t color='#00ff00'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Receiver", localize "STR_traderChat_PaymentIncomplete"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_PaymentIncomplete";
	sleep 9;

	if(isNull (findDisplay 999920)) ExitWith {};
	
	closeDialog 0;
};

if(isNull (findDisplay 999920)) ExitWith {};

if((["traderState", 0] call fnc_loadData) == 3) then
{
	_skipTrader = true;

	private _deals = 10 min (["traderDiscountDeals", 0] call fnc_loadData);
	private _oldDeals = _deals;
	_deals = 10 min (_deals + 1);

	[["traderDiscountDeals", _deals], ["traderFail", nil], ["traderRaidGUID", nil], ["traderCrate", nil], ["traderState", nil], ["traderBoxIndex", nil], ["traderPurchase", nil], ["traderPayment", nil]] call fnc_saveData;
	saveProfileNamespace;
	
	gTraderBoxIndex = -1;
	gTraderPurchase = [];
	gTraderPayment = [];
	gTraderState = 0;

	call fnc_traderResetCrates;

	sleep 0.5;

	private _text = format["<t color='#ff0000'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Transmitter", localize "STR_traderChat_DealCompleteNotify"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_DealCompleteNotify";
	sleep 5;

	if(isNull (findDisplay 999920)) ExitWith {[true, _oldDeals != _deals] execVM "scripts\traderUpdateDeal.sqf";};

	_text = _text + format["<br /><t color='#00ff00'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Receiver", localize "STR_traderChat_DealCompleteAnswer"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_DealCompleteAnswer";
	sleep 8;

	if(isNull (findDisplay 999920)) ExitWith {[true, _oldDeals != _deals] execVM "scripts\traderUpdateDeal.sqf";};

	closeDialog 0;
	[true, _oldDeals != _deals] execVM "scripts\traderUpdateDeal.sqf";
};

if(isNull (findDisplay 999920)) ExitWith {};

if((["traderState", 0] call fnc_loadData) == 2) then
{
	_skipTrader = true;

	[["traderState", 3]] call fnc_saveData;
	saveProfileNamespace;
	
	gTraderState = 3;
	call fnc_traderFillOrderCrate;
	call fnc_traderSaveCrate;

	sleep 0.5;

	private _text = format["<t color='#ff0000'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Transmitter", localize "STR_traderChat_SentenceHello"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_SentenceHello";
	sleep 2;

	if(isNull (findDisplay 999920)) ExitWith {[true, false] execVM "scripts\traderUpdateDeal.sqf";};

	_text = _text + format["<br /><t color='#00ff00'>%1: </t><t color='#ffffff'>%2</t>", localize "STR_traderChat_Receiver", localize "STR_traderChat_PaymentComplete"];
	_TxTraderChat ctrlSetStructuredText parseText _text;
	playSound "traderChat_PaymentComplete";
	sleep 10;

	if(isNull (findDisplay 999920)) ExitWith {[true, false] execVM "scripts\traderUpdateDeal.sqf";};

	closeDialog 0;
	[true, false] execVM "scripts\traderUpdateDeal.sqf";
};

if(isNull (findDisplay 999920)) ExitWith {};

fnc_td_fillPlayerInventory = {
	private _ammo = magazinesAmmoCargo _crate;
	private _items = getItemCargo _crate;
	private _backpacks = getBackpackCargo _crate;
	private _weapons = weaponsItemsCargo _crate;

	{
		if([_x select 0] call fnc_traderItemInTraderList) then
		{
			private _config = [_x select 0] call fnc_TraderGetConfig;
			private _weaponName = getText(configFile >> _config >> _x select 0 >> "DisplayName");
			private _pictrure = getText(configFile >> _config >> _x select 0 >> "picture");
			private _text = format["%1", _weaponName];
			private _desc = getText(configFile >> _config >> _x select 0 >> "DescriptionShort");
			private _dlc = getText(configFile >> _config >> _x select 0 >> "DLC");
			private _tooltip = [_text, _desc, _dlc] call fnc_getItemTooltip;
			_index = _LbYourInventory lbAdd _text;
			_LbYourInventory lbSetData [_index, _x select 0];
			_LbYourInventory lbSetValue [_index, 1];
			_LbYourInventory lbSetTooltip [_index, _tooltip];
			_LbYourInventory lbSetPicture [_index, _pictrure];
			_LbYourInventory lbSetPictureColor [_index, [0, 0, 0, 0]];
		};
	} forEach _weapons;

	{
		if([_x select 0] call fnc_traderItemInTraderList) then
		{
			private _config = [_x select 0] call fnc_TraderGetConfig;
			private _ammoCount = _x select 1;
			private _magazineSize = getNumber(configfile >> _config >> _x select 0 >> "count");

			if(_ammoCount == _magazineSize) then
			{
				private _magName = getText(configFile >> _config >> _x select 0 >> "DisplayName");
				private _pictrure = getText(configFile >> _config >> _x select 0 >> "picture");
				private _text = "";
				private _desc = getText(configFile >> _config >> _x select 0 >> "DescriptionShort");
				private _dlc = getText(configFile >> _config >> _x select 0 >> "DLC");

				if(_magazineSize == 1 && _ammoCount == 1) then
				{
					_text = format["%1", _magName];
				}
				else
				{
					_text = format["%1 (%2/%3)", _magName, _ammoCount, _magazineSize];
				};
				
				private _tooltip = [_text, _desc, _dlc] call fnc_getItemTooltip;
				_index = _LbYourInventory lbAdd _text;
				_LbYourInventory lbSetData [_index, _x select 0];
				_LbYourInventory lbSetValue [_index, _x select 1];
				_LbYourInventory lbSetTooltip [_index, _tooltip];
				_LbYourInventory lbSetPicture [_index, _pictrure];
				_LbYourInventory lbSetPictureColor [_index, [0, 0, 0, 0]];
			};
		};
	} forEach _ammo;

	{
		if([_x] call fnc_traderItemInTraderList) then
		{
			private _config = [_x] call fnc_TraderGetConfig;
			private _itemName = getText(configFile >> _config >> _x >> "DisplayName");
			private _pictrure = getText(configFile >> _config >> _x >> "picture");
			private _desc = getText(configFile >> _config >> _x >> "DescriptionShort");
			private _dlc = getText(configFile >> _config >> _x >> "DLC");

			for "_i" from 1 to (_items select 1 select _forEachIndex) do 
			{
				private _text = format["%1", _itemName];

				if(_x == "acc_flashlight_smg_01") then
				{
					_text = _text + " (SMG)";	
				};
				
				private _tooltip = [_text, _desc, _dlc] call fnc_getItemTooltip;
				_index = _LbYourInventory lbAdd _text;
				_LbYourInventory lbSetData [_index, _x];
				_LbYourInventory lbSetValue [_index, 1];
				_LbYourInventory lbSetTooltip [_index, _tooltip];
				_LbYourInventory lbSetPicture [_index, _pictrure];
				_LbYourInventory lbSetPictureColor [_index, [0, 0, 0, 0]];
			};
		};
	} forEach (_items select 0);
	
	{
		if([_x] call fnc_traderItemInTraderList) then
		{
			private _config = [_x] call fnc_TraderGetConfig;
			private _backpackName = getText(configFile >> _config >> _x >> "DisplayName");
			private _pictrure = getText(configFile >> _config >> _x >> "picture");
			private _desc = getText(configFile >> _config >> _x >> "DescriptionShort");
			private _dlc = getText(configFile >> _config >> _x >> "DLC");

			for "_i" from 1 to (_backpacks select 1 select _forEachIndex) do 
			{
				private _text = format["%1", _backpackName];
				private _tooltip = [_text, _desc, _dlc] call fnc_getItemTooltip;
				_index = _LbYourInventory lbAdd _text;
				_LbYourInventory lbSetData [_index, _x];
				_LbYourInventory lbSetValue [_index, 1];
				_LbYourInventory lbSetTooltip [_index, _tooltip];
				_LbYourInventory lbSetPicture [_index, _pictrure];
				_LbYourInventory lbSetPictureColor [_index, [0, 0, 0, 0]];
			};
		};
	} forEach (_backpacks select 0);

	lbSort _LbYourInventory;
};

fnc_td_fillTraderInventory = {
	{
		if(_x select 1 > 0) then
		{
			private _item = _x select 0;
			private _text = "";
			private _desc = "";
			private _dlc = "";
			private _itemName = "";
			private _config = "";
			private _magazineSize = 0;
			private _pictrure = "";
			private _tooltip = "";
			
			switch true do
			{
				case(isClass(configFile >> "CfgMagazines" >> _item)): {
					_config = "CfgMagazines";
					_itemName = getText(configFile >> _config >> _item >> "DisplayName");
					_text = format["%1", _itemName];
					_desc = getText(configFile >> _config >> _item >> "DescriptionShort");
					_dlc = getText(configFile >> _config >> _item >> "DLC");
					_magazineSize = getNumber(configfile >> _config >> _item >> "count");
					_pictrure = getText(configFile >> _config >> _item >> "picture");
						
					if(_magazineSize == 1) then
					{
						_text = format["%1", _itemName];
					}
					else
					{
						_text = format["%1 (%2/%3)", _itemName, _magazineSize, _magazineSize];
					};
				};
				case(isClass(configFile >> "CfgWeapons" >> _item)): {
					_config = "CfgWeapons";
					_itemName = getText(configFile >> _config >> _item >> "DisplayName");
					_magazineSize = 1;
					_pictrure = getText(configFile >> _config >> _item >> "picture");
					_text = format["%1", _itemName];
					_desc = getText(configFile >> _config >> _item >> "DescriptionShort");
					_dlc = getText(configFile >> _config >> _item >> "DLC");
				};
				case(isClass(configFile >> "CfgVehicles" >> _item)): {
					_config = "CfgVehicles";
					_itemName = getText(configFile >> _config >> _item >> "DisplayName");
					_magazineSize = 1;
					_pictrure = getText(configFile >> _config >> _item >> "picture");
					_text = format["%1", _itemName];
					_desc = getText(configFile >> _config >> _item >> "DescriptionShort");
					_dlc = getText(configFile >> _config >> _item >> "DLC");
				};
				case(isClass(configFile >> "CfgGlasses" >> _item)): {
					_config = "CfgGlasses";
					_itemName = getText(configFile >> _config >> _item >> "DisplayName");
					_magazineSize = 1;
					_pictrure = getText(configFile >> _config >> _item >> "picture");
					_text = format["%1", _itemName];
					_desc = getText(configFile >> _config >> _item >> "DescriptionShort");
					_dlc = getText(configFile >> _config >> _item >> "DLC");
				};
			};

			if(_item == "acc_flashlight_smg_01") then
			{
				_text = _text + " (SMG)";	
			};
			
			_tooltip = [_text, _desc, _dlc] call fnc_getItemTooltip;

			_index = _LbTraderInvetory lbAdd _text;
			_LbTraderInvetory lbSetData [_index, _item];
			_LbTraderInvetory lbSetValue [_index, _magazineSize];
			_LbTraderInvetory lbSetTooltip [_index, _tooltip];
			_LbTraderInvetory lbSetPicture [_index, _pictrure];
			_LbTraderInvetory lbSetPictureColor [_index, [0, 0, 0, 0]];
		};
	} forEach gTraderList;

	lbSort _LbTraderInvetory;
};

fnc_td_BtPaymentAddHandler = {
	private _display = findDisplay 999920;
	private _LbYourInventory = _display displayCtrl 1501;
	private _LbPayment = _display displayCtrl 1503;

	if(lbCurSel _LbYourInventory > -1) then
	{
		private _index = _LbPayment lbAdd (_LbYourInventory lbText (lbCurSel _LbYourInventory));
		_LbPayment lbSetData [_index, _LbYourInventory lbData (lbCurSel _LbYourInventory)];
		_LbPayment lbSetValue [_index, _LbYourInventory lbValue (lbCurSel _LbYourInventory)];
		_LbPayment lbSetTooltip [_index, _LbYourInventory lbText (lbCurSel _LbYourInventory)];
		_LbPayment lbSetPicture [_index, _LbYourInventory lbPicture (lbCurSel _LbYourInventory)];
		_LbPayment lbSetPictureColor [_index, [0, 0, 0, 0]];

		_LbYourInventory lbDelete (lbCurSel _LbYourInventory);

		lbSort _LbPayment;
		_LbPayment lbSetCurSel -1;
	};

	call fnc_td_validate;
};

fnc_td_BtPaymentRemoveHandler = {
	private _display = findDisplay 999920;
	private _LbYourInventory = _display displayCtrl 1501;
	private _LbPayment = _display displayCtrl 1503;
	
	if(lbCurSel _LbPayment > -1) then
	{
		private _index = _LbYourInventory lbAdd (_LbPayment lbText (lbCurSel _LbPayment));
		_LbYourInventory lbSetData [_index, _LbPayment lbData (lbCurSel _LbPayment)];
		_LbYourInventory lbSetValue [_index, _LbPayment lbValue (lbCurSel _LbPayment)];
		_LbYourInventory lbSetTooltip [_index, _LbPayment lbText (lbCurSel _LbPayment)];
		_LbYourInventory lbSetPicture [_index, _LbPayment lbPicture (lbCurSel _LbPayment)];
		_LbYourInventory lbSetPictureColor [_index, [0, 0, 0, 0]];

		_LbPayment lbDelete (lbCurSel _LbPayment);

		lbSort _LbYourInventory;
		_LbYourInventory lbSetCurSel -1;
	};

	call fnc_td_validate;
};

fnc_td_BtPurchaseAdd = {
	private _display = findDisplay 999920;
	private _LbTraderInvetory = _display displayCtrl 1500;
	private _LbPurchase = _display displayCtrl 1502;

	if(lbCurSel _LbTraderInvetory > -1) then
	{
		private _index = _LbPurchase lbAdd (_LbTraderInvetory lbText (lbCurSel _LbTraderInvetory));
		_LbPurchase lbSetData [_index, _LbTraderInvetory lbData (lbCurSel _LbTraderInvetory)];
		_LbPurchase lbSetValue [_index, _LbTraderInvetory lbValue (lbCurSel _LbTraderInvetory)];
		_LbPurchase lbSetTooltip [_index, _LbTraderInvetory lbText (lbCurSel _LbTraderInvetory)];
		_LbPurchase lbSetPicture [_index, _LbTraderInvetory lbPicture (lbCurSel _LbTraderInvetory)];
		_LbPurchase lbSetPictureColor [_index, [0, 0, 0, 0]];

		lbSort _LbPurchase;
		_LbPurchase lbSetCurSel -1;
	};

	call fnc_td_validate;
};

fnc_td_BtPurchaseRemove = {
	private _display = findDisplay 999920;
	private _LbPurchase = _display displayCtrl 1502;
	
	if(lbCurSel _LbPurchase > -1) then
	{
		_LbPurchase lbDelete (lbCurSel _LbPurchase);
	};

	call fnc_td_validate;
};

fnc_td_BtDealHandler = {
	if(call fnc_td_validate) then
	{
		private _display = findDisplay 999920;
		private _LbPurchase = _display displayCtrl 1502;
		private _LbPayment = _display displayCtrl 1503;

		private _purchase = [];
		private _payment = [];
		private _size = lbSize _LbPurchase;

		for "_i" from 0 to (_size - 1) do 
		{
			_purchase = _purchase + [[_LbPurchase lbData _i, _LbPurchase lbValue _i]];
		};

		_size = lbSize _LbPayment;

		for "_i" from 0 to (_size - 1) do 
		{
			_payment = _payment + [[_LbPayment lbData _i, _LbPayment lbValue _i]];
		};

		[_purchase, _payment, gRaidGUID] execVM "scripts\traderCreateDeal.sqf";

		closeDialog 0;
	};
};

fnc_td_validate = {
	private _priceToBuy = 0;
	private _paymentValue = 0;

	private _display = findDisplay 999920;
	private _LbPurchase = _display displayCtrl 1502;
	private _LbPayment = _display displayCtrl 1503;
	private _PcMood = _display displayCtrl 1200;
	private _BtDeal = _display displayCtrl 1601;
	
	private _size = lbSize _LbPurchase;

	for "_i" from 0 to (_size - 1) do 
	{
		private _item = _LbPurchase lbData _i;
		private _value = _LbPurchase lbValue _i;

		_priceToBuy = _priceToBuy + ([_item, _value] call fnc_td_getItemBuyValue);
	};

	_size = lbSize _LbPayment;

	for "_i" from 0 to (_size - 1) do 
	{
		private _item = _LbPayment lbData _i;
		private _value = _LbPayment lbValue _i;

		_paymentValue = _paymentValue + ([_item, _value] call fnc_td_getItemSellValue);
	};

	if(_paymentValue > 0 && _priceToBuy > 0 && _paymentValue >= _priceToBuy) then
	{
		_BtDeal ctrlEnable true;
		_PcMood ctrlSetText "images\happy.paa";
		true
	}
	else
	{
		_BtDeal ctrlEnable false;

		if(_priceToBuy > 0) then
		{
			if((_paymentValue / _priceToBuy) >= 0.5) then
			{
				_PcMood ctrlSetText "images\soso.paa";
			}
			else
			{
				_PcMood ctrlSetText "images\sad.paa";
			};
		}
		else
		{
			_PcMood ctrlSetText "images\sad.paa";
		};

		false
	};
};

fnc_td_getItemBuyValue = {
	private _item = _this select 0;
	private _count = _this select 1;
	private _value = 0;
	private _found = false;

	scopeName "exit";

	{
		if((_x select 0) == _item) then
		{
			_value = _x select 1;
			_found = true;
			breakTo "exit";
		};
	} forEach gTraderList;

	if(!_found) then
	{
		diag_log format["*** Trader buy list missing item: %1", _item];
	};

	_value - (_value * (gDiscount / 100))
};

fnc_td_getItemSellValue = {
	private _item = _this select 0;
	private _count = _this select 1;
	private _value = 0;
	private _found = false;

	scopeName "exit";

	{
		if((_x select 0) == _item) then
		{
			_value = _x select 2;
			_found = true;
			breakTo "exit";
		};
	} forEach gTraderList;

	if(!_found) then
	{
		diag_log format["*** Trader sell list missing item: %1", _item];
	};

	_value
};

if(!_skipTrader && (["traderState", 0] call fnc_loadData) == 0) then
{
	if(!(["traderNewGuy", false] call fnc_loadData)) then
	{
		[["traderNewGuy", true]] call fnc_saveData;
		saveProfileNamespace;
		playSound "trader_NewGuy";
	}
	else
	{
		playSound "trader_in";
	};

	call fnc_setTrade;

	_BtDeal ctrlEnable false;
	call fnc_td_fillPlayerInventory;
	call fnc_td_fillTraderInventory;
	call fnc_td_validate;

	_BtDeal ctrlSetEventHandler ["ButtonClick","[_this] call fnc_td_BtDealHandler"];
	_BtPaymentAdd ctrlSetEventHandler ["ButtonClick","[_this] call fnc_td_BtPaymentAddHandler"];
	_BtPaymentRemove ctrlSetEventHandler ["ButtonClick","[_this] call fnc_td_BtPaymentRemoveHandler"];
	_BtPurchaseAdd ctrlSetEventHandler ["ButtonClick","[_this] call fnc_td_BtPurchaseAdd"];
	_BtPurchaseRemove ctrlSetEventHandler ["ButtonClick","[_this] call fnc_td_BtPurchaseRemove"];

	waitUntil {(isNull (findDisplay 999920))};
	playSound "trader_out";
};

