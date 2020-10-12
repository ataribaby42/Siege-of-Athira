/*
hint ""; hint str typeof cursorTarget; copyToClipboard str typeof cursorTarget; systemChat str(count (cursorTarget buildingPos -1));
*/

private _unit = _this select 0;
private _house = _this select 1;

private _timeout = 0;
private _positions = _house buildingPos -1;
private _posNum = 0;
private _position = [];
_positions = [_positions,[],{_x select 2},"ASCEND"] call BIS_fnc_sortBy;

while {alive _unit && _posNum < count _positions} do {
	_position = _positions select _posNum;
	_unit doMove (_position);
	_unit moveTo (_position);
	_timeout = time + 50;
	waitUntil {moveToCompleted _unit || moveToFailed _unit || !alive _unit || _timeout < time};	
	_posNum = _posNum + 1;
};

if (alive _unit) then
{
	_unit doFollow leader _unit; 
	_unit setVariable["searching",false,true];
};