/*
	Author: Willem-Matthijs Crielaard, 1-2-2016

	Description:
	Calculate time for sunrise and sunset on a given date

		Based on information from http://www.pveducation.org/pvcdrom/properties-of-sunlight/elevation-angle

	Parameter(s):
		0: NUMBER - year
		1: NUMBER - month
		2: NUMBER - day
		3: NUMBER - hours (optional)
		4: NUMBER - minutes (optional)

	Returns:
	ARRAY [ NUMBER sunrise time, NUMBER sunset time ]

	Example:
	date call llw_fnc_getSunrise
	
	Alternative to get sunrise and sunset time for current in-game date:
	[] call llw_fnc_getSunElevationNoon
*/


// ARMA 3 seems to have its equinox off by a few days
#define EQUINOX_ERROR	2
// Equinox - 360 is the number of orbital degrees per year, 365 the number of days per year. 81 accounts for march equinox
#define EQUINOX_MAR		((360 * dateToNumber _date)-(360*(81+EQUINOX_ERROR)/365))
// current earth tilt irl to the sun in degrees
#define DECLINATION		(asin (sin 23.45 * sin EQUINOX_MAR))


/* =======================
		INITIALIZE
======================= */
private [	"_latitude","_date","_sunrise","_sunset","_cos_hraSunset"];
_latitude = -1*getNumber(configFile >> "CfgWorlds" >> worldName >> "latitude");
_date=_this;
_sunrise = 0; // initialize private variable
_sunset  = 0; // initialize private variable

if (isnil "_date") then
{
	_date = date;
} else {
	if (typeName _this != "ARRAY") then
	{
		_date = date;
	} else {
		if (count _date == 0) then
		{
			_date = date;
		} else {
			while {count _date < 5} do
			{
				_date pushBack 0;
			}
		};
	};
};


/* =======================
		MAIN
======================= */
_cos_hraSunset = (-tan _latitude * tan DECLINATION); // cosine of hour angle at sunset
if (_cos_hraSunset<-1) then
{
	// Polar summer, no sunset
	_sunrise = 999;
	_sunset  = 999;
} else {
	if (_cos_hraSunset >1) then
	{
		// polar winter, no sunrise
		_sunrise = -999;
		_sunset  = -999;
	} else {
		_sunrise = 12 - acos(_cos_hraSunset)/15;
		_sunset  = 12 + acos(_cos_hraSunset)/15;
	};
};

[_sunrise,_sunset]