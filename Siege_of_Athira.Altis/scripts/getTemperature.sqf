/*
	Author: Willem-Matthijs Crielaard, 1-2-2016

	Description:
	Calculate the air and sea temperatures on a given moment

		Based on https://engineering.dartmouth.edu/~d30345d/books/EFM/chap12.pdf and many others.

	Parameters (optional):
		0: NUMBER - annual average air temperature
		1: NUMBER - seasonal temperature variation; difference between average summer and average winter temperatures
		2: NUMBER - seasonal temperature lag; delay between solstice and min/max temperature levels
		3: NUMBER - diurnal temperature variation; difference between daily min and max temperatures
		4: NUMBER - diurnal temperature lag; fraction of time between noon and sunset unti  maximum temperature is reached; 0 for noon, 1 for sunset (default 0.5)
		5: NUMBER - annual average sea temperature
		6: NUMBER - seasonal sea temperature variation; difference between average summer and average winter temperatures
		7: NUMBER - seasonal sea temperature lag ; delay between solstice and min/max temperature levels
		 
	
	Returns:
		ARRAY
			0: NUMBER - air temperature in degrees Celcius
			1: NUMBER - sea temperature in degrees Celcius

	Example:
	[20,7,30,12,0.5,10,2,60] call llw_fnc_getAirTemperature

	When no parameters are given, the script will estimate climatological data based on latitude.
	Climatological data in this script was estimated using several sources on the internet.
	
	Example:
	[] call llw_fnc_getAirTemperature

	When available, the script will read climatological data from: configFile >> "CfgWorlds" >> worldName >> "climate" 
	
	class climate
	{
		t_air_avg = 17.5;	// annual average air temperature
		stv_air = 7.333333; // seasonal air temperature variation
		stl_air = 30;		// seasonal air temperature lag in days
		dtv_air = 7.333333; // diurnal air temperature variation
		dtl_air = 0.5;		// diurnal air temperature lag as a fraction of time between noon and sunset; 0=max diurnal temperature at noon, 1=max diurnal temperature at sunset
		t_sea_avg = 16;		// annual average sea temperature
		stv_sea = 2; 		// seasonal sea temperature variation
		stl_sea = 60;		// seasonal sea temperature lag in days
	}
*/	

// ARMA 3 seems to have its equinox and solstice off by a few days
#define EQUINOX_ERROR	2
// 10 accounts for winter solstice in december
#define SOLARDAY		((360 * dateToNumber date)+(360*(10-EQUINOX_ERROR)/365))

// interpolate meteo data from data-arrays (e.g. AIRTEMPBYLAT)
#define SELECTBYLAT(ARRAY,LAT)	( (ARRAY select floor ((LAT+90)/10))*(1-(((LAT+90)/10) mod 1)) \
								+ (ARRAY select ceil ((LAT+90)/10))*(((LAT+90)/10) mod 1) )

// Yearly average air temperature; Datapoints per 10 deg lat, 0 lat in parentheses, additional element prevents overflows
#define AIRTEMPBYLAT	[-40,-20,0,5,10,12.5,15,20,25,(25),30,25,20,15,5,0,0,-10,-20,-20]
// year average air temperature
#define T_AIR_AVG		SELECTBYLAT(AIRTEMPBYLAT,_latitude)
// seasonal temperature variation for air (0 to 40 deg C)
#define STV_AIR			((1-cos(2*_latitude))*20)
// Seasonal air temperature lag in days
#define STL_AIR			30
// Diurnal air temperature variation by latitude; Datapoints per 10 deg lat, 0 lat in parentheses, additional element prevents overflows
#define DTVAIRBYLAT		[2,3,4,5,7,12,16,14,12,(9.5),12,14.5,15.5,12.5,9,8,6.5,4.5,2,2]
// diurnal temperature variation for air
#define DTV_AIR			SELECTBYLAT(DTVAIRBYLAT,_latitude)	
// diurnal air temperature lag as a fraction of time between noon and sunset; 0=max diurnal temperature at noon, 1=max diurnal temperature at sunset
#define DTL_AIR			0.5
// time at which temperature is at its minimum
#define MINTEMPTIME		(date call  llw_fnc_getSunRise select 0)
// time at which thermal equilibrium is reached
#define MAXTEMPTIME		(((date call llw_fnc_getSunRise select 1)-12)*DTL_AIR+12)
// total time of air heating
#define HEATINGTIME		(MAXTEMPTIME-MINTEMPTIME)
// total cooldown time from max temperature to minimum temperature in hours
#define COOLDOWNTIME	(24-HEATINGTIME)
// impact of overcast on temperature as fraction on minimum and maximum
#define CLOUDINSULATION	0.7	
// maximum inversion boundary altitude
#define BOUNDARYALT		3000

// Yearly average sea temperature; Datapoints per 10 deg lat, 0 lat in brackets, additional element prevents overflows
#define SEATEMPBYLAT	[ -4,-3,0,1,4,10,14,20,26,(27),28,27,26,20,14,10,4,-2,-4,-4]
// Seasonal sea temperature lag in days
#define T_SEA_AVG		SELECTBYLAT(SEATEMPBYLAT,_latitude)
// seasonal temperature variation for sea
#define STV_SEA			(8*(abs _latitude)/90+2)
// seasonal temperature lag for sea
#define STL_SEA			60

// Diurnal sea temperature variation assumed nil
// Diurnal sea temperature lag assumed nil

								
/* =======================
		INITIALIZE
======================= */

private ["_latitude","_hemisphere", "_t_air_avg","_stv_air","_stl_air","_dtv_air","_dtl_air","_t_sea_avg","_stv_sea","_stl_sea","_cover","_return"];

// gather positional data
_latitude = -1*getNumber(configFile >> "CfgWorlds" >> worldName >> "latitude");
_hemisphere = 1;	// variable to factor in northern or southern hemisphere seasonal effects
if (_latitude<0) then {_hemisphere=-1};

// set climatological parameters
_t_air_avg 	= T_AIR_AVG;	//annual average temperature
_stv_air 	= STV_AIR;		//seasonal temperature variation
_stl_air 	= STL_AIR;		//seasonal temperature lag
_dtv_air 	= DTV_AIR;		//diurnal temperature variation
_dtl_air 	= DTL_AIR;		//diurnal temperature lag
_t_sea_avg 	= T_SEA_AVG;	//annual average temperature
_stv_sea 	= STV_SEA;		//seasonal temperature variation
_stl_sea 	= STL_SEA;		//seasonal temperature lag

if (count _this > 0) then
{
	_t_air_avg	= (_this select 0);		//annual average temperature
	_stv_air	= (_this select 1);		//seasonal temperature variation
	_stl_air	= (_this select 2);		//seasonal temperature lag
	_dtv_air	= (_this select 3);		//diurnal temperature variation
	_dtl_air	= (_this select 4);		//diurnal temperature lag
	_t_sea_avg	= (_this select 5);		//annual average temperature
	_stv_sea	= (_this select 6);		//seasonal temperature variation
	_stl_sea	= (_this select 7);		//seasonal temperature lag
} else {
	if ((configFile >> "CfgWorlds" >> worldName >> "climate") in ("TRUE" configClasses (configFile >> "CfgWorlds" >> worldName >> "latitude"))) then
	{
		_t_air_avg = getNumber(configFile >> "CfgWorlds" >> worldName >> "climate" >> "t_air_avg" );
		_stv_air = getNumber(configFile >> "CfgWorlds" >> worldName >> "climate" >> "stv_air" );
		_stl_air = getNumber(configFile >> "CfgWorlds" >> worldName >> "climate" >> "stl_air" );
		_dtv_air = getNumber(configFile >> "CfgWorlds" >> worldName >> "climate" >> "dtv_air" );
		_dtl_air = getNumber(configFile >> "CfgWorlds" >> worldName >> "climate" >> "dtl_air" );
		_t_sea_avg = getNumber(configFile >> "CfgWorlds" >> worldName >> "climate" >> "t_sea_avg" );
		_stv_sea = getNumber(configFile >> "CfgWorlds" >> worldName >> "climate" >> "stv_sea" );
		_stl_sea = getNumber(configFile >> "CfgWorlds" >> worldName >> "climate" >> "stl_sea" );	
	};
};



/* =======================
		MAIN
======================= */

// determine cloud and fog cover
_cover = 0;
if ( (fogparams select 2 >= 100) OR ((fogparams select 2 >= 10) AND (fogparams select 1 >= 0.1) ) ) then
{
	_cover = overcast max (fogParams select 1);
} else {
	_cover = overcast;
};

// determine air temperature
_return = [_t_air_avg +(0.5*_stv_air*-cos(SOLARDAY-_stl_air)*_hemisphere)];
if (dayTime < MINTEMPTIME) then
{
	// after midnight cooling
	_return set	[0,(_return select 0)
					- (
						_dtv_air *(24-MAXTEMPTIME+daytime)/COOLDOWNTIME
						- 0.5*_dtv_air
						) *(1-CLOUDINSULATION*_cover)
				];
} else {
	if (dayTime > MAXTEMPTIME) then
	{
		// sunset cooling
		_return set	[0, (_return select 0)
						- (
							_dtv_air *(DayTime-MAXTEMPTIME)/COOLDOWNTIME
							- 0.5*_dtv_air
							) *(1-CLOUDINSULATION*_cover)
					];
	} else {
		// heating
		_return set	[0, (_return select 0)
						+ (
							0.5 * _dtv_air * -cos(180*(daytime-MINTEMPTIME)/HEATINGTIME)
							) *(1-CLOUDINSULATION*_cover)
					];
	};
};

// determine sea temperature
_return pushBack (_t_sea_avg +(0.5*_stv_sea*-cos(SOLARDAY-_stl_sea)*_hemisphere));

_return
