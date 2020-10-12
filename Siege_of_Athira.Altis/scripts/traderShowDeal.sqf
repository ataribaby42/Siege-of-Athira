if(!isNil "gTraderTask") then
{
	player removeSimpleTask gTraderTask;
};

if(gTraderBoxIndex > -1  && count gTraderPayment > 0  && gTraderState == 1) then
{
	private _text = localize "STR_traderDeliverTask" + "<br /><br />" + localize "STR_traderDeliverTaskPayment" + ":";

	{
		_text = _text + "<br />" + _x; 				
	} forEach (gTraderPayment call fnc_traderGetItemsDesc);

	_text = _text + "<br /><br />" + localize "STR_traderDeliverTaskPurchase" + ":";

	{
		_text = _text + "<br />" + _x; 				
	} forEach (gTraderPurchase call fnc_traderGetItemsDesc);

	_text = _text + format["<br /><br /><img image='images\map%1.jpg'/><br /><br />", gTraderBoxIndex + 1];

	gTraderTask = player createSimpleTask [localize "STR_TraderBoxPayment"];
	gTraderTask setSimpleTaskDescription [
	_text,
	localize "STR_TraderBoxPayment",
	""
	];
	gTraderTask setTaskState "Created";	
	gTraderTask setTaskState "Assigned";

	["TaskAssigned",["",(localize "STR_TraderBoxPayment") + " - " + (localize "STR_TraderTaskHint")]] call BIS_fnc_showNotification;
};

if(gTraderBoxIndex > -1  && count gTraderPayment == 0 && gTraderState == 2) then
{
	private _text = localize "STR_traderPaymentDoneTask" + "<br /><br />" + localize "STR_traderPickupTaskPurchase" + ":";

	{
		_text = _text + "<br />" + _x; 				
	} forEach (gTraderPurchase call fnc_traderGetItemsDesc);

	_text = _text + format["<br /><br /><img image='images\map%1.jpg'/><br /><br />", gTraderBoxIndex + 1];

	gTraderTask = player createSimpleTask [localize "STR_TraderContact"];
	gTraderTask setSimpleTaskDescription [
	_text,
	localize "STR_TraderContact",
	""
	];
	gTraderTask setTaskState "Created";	
	gTraderTask setTaskState "Assigned";

	["TaskAssigned",["",(localize "STR_TraderContact") + " - " + (localize "STR_TraderTaskHint")]] call BIS_fnc_showNotification;
};

if(gTraderBoxIndex > -1  && count gTraderPayment == 0 && gTraderState == 3) then
{
	private _text = localize "STR_traderPickupTask" + "<br /><br />" + localize "STR_traderPickupTaskPurchase" + ":";

	{
		_text = _text + "<br />" + _x; 				
	} forEach (gTraderPurchase call fnc_traderGetItemsDesc);

	_text = _text + format["<br /><br /><img image='images\map%1.jpg'/><br /><br />", gTraderBoxIndex + 1];

	gTraderTask = player createSimpleTask [localize "STR_TraderBoxPickup"];
	gTraderTask setSimpleTaskDescription [
	_text,
	localize "STR_TraderBoxPickup",
	""
	];
	gTraderTask setTaskState "Created";	
	gTraderTask setTaskState "Assigned";

	["TaskAssigned",["",(localize "STR_TraderBoxPickup") + " - " + (localize "STR_TraderTaskHint")]] call BIS_fnc_showNotification;
};
