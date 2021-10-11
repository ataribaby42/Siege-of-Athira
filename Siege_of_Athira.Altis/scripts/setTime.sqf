private _realtime = _this;

waitUntil {time > 0};

//if(gPersistentTime) then
if(gSinglePlayerTime) then
{
	/*
	private _date = [];
	private _label = gSavePrefix + "_sp";
	private _varname = _label + "_data";
	private _saveDataTest = profileNamespace getVariable [_varname, nil];

	if(isNil "_saveDataTest") then
	{
		_date = gSPstartDate	
	}
	else
	{
		_date = ["date", gSPstartDate] call fnc_loadData;
		_date = [_date select 0, _date select 1, _date select 2, (_date select 3) + (4 + floor(random 20)), _date select 4];
	};

	setDate _date;
	*/

	private _date = systemTime;
	private _year = gRealtimeServerTimeYear;
	private _month = _date select 1;
	private _day = _date select 2;
	private _hours = _date select 3;
	private _seconds = _date select 4;
	setDate [_year, _month, _day, _hours, _seconds];
}
else
{
	if(_realtime) then
	{
		private _date = systemTime;
		private _year = gRealtimeServerTimeYear;
		private _month = _date select 1;
		private _day = _date select 2;
		private _hours = _date select 3;
		private _seconds = _date select 4;
		setDate [_year, _month, _day, _hours, _seconds];
	}
	else
	{
		setDate (selectRandom gRandomMissionStartTimes);
	};
};

gTimeSet = true;

if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then
{
	diag_log format["*** mission date: %1", date];
	publicVariable "gTimeSet";
};



