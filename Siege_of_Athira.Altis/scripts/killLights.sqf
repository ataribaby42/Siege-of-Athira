private _pos = _this;

private _list = [];
_list = _list + ["Lamps_base_F"];
_list = _list + ["Land_LampStreet_small_F"];
_list = _list + ["Land_LampStreet_F"];
_list = _list + ["Land_LampDecor_F"];
_list = _list + ["Land_LampHalogen_F"];
_list = _list + ["Land_LampHarbour_F"];
_list = _list + ["Land_LampShabby_F"];
_list = _list + ["Land_LampAirport_F"];
_list = _list + ["Land_LampSolar_F"];
_list = _list + ["Land_runway_edgelight"];
_list = _list + ["Land_runway_edgelight_blue_F"];
_list = _list + ["Land_Flush_Light_green_F"];
_list = _list + ["Land_Flush_Light_red_F"];
_list = _list + ["Land_Flush_Light_yellow_F"];
_list = _list + ["Land_Runway_PAPI"];
_list = _list + ["Land_Runway_PAPI_2"];
_list = _list + ["Land_Runway_PAPI_3"];
_list = _list + ["Land_Runway_PAPI_4"];
_list = _list + ["Land_fs_roof_F"];
_list = _list + ["Land_fs_sign_F"];
_list = _list + ["Land_runway_edgelight"];
_list = _list + ["Land_NavigLight"];
_list = _list + ["PowerLines_base_F"];
_list = _list + ["Land_PowerPoleWooden_L_F"];
_list = _list + ["Land_PowerPoleWooden_small_F"];


private _lamps = nearestObjects [_pos, _list, 6000, true];
{_x setHit ["light_1_hitpoint", 0.97, false]} forEach _lamps;
{_x setHit ["light_2_hitpoint", 0.97, false]} forEach _lamps;
{_x setHit ["light_3_hitpoint", 0.97, false]} forEach _lamps;
{_x setHit ["light_4_hitpoint", 0.97, false]} forEach _lamps;
{_x setHit ["light_1", 0.97, false]} forEach _lamps;
{_x setHit ["light_2", 0.97, false]} forEach _lamps;
{_x setHit ["light_3", 0.97, false]} forEach _lamps;
{_x setHit ["light_4", 0.97, false]} forEach _lamps;