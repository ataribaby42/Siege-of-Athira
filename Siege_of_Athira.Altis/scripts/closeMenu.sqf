disableSerialization;

private _fromMap =  _this select 0;

waitUntil {str(findDisplay 46) != "no display"};

if(!((findDisplay 46 displayCtrl 999901) isEqualTo controlNull)) then
{
	ctrlDelete (findDisplay 46 displayCtrl 999901);
};

if(!((findDisplay 46 displayCtrl 999902) isEqualTo controlNull)) then
{
	ctrlDelete (findDisplay 46 displayCtrl 999902);
};

if(!_fromMap && !((findDisplay 46 displayCtrl 999903) isEqualTo controlNull)) then
{
	ctrlDelete (findDisplay 46 displayCtrl 999903);
};

if(!((findDisplay 46 displayCtrl 999904) isEqualTo controlNull)) then
{
	ctrlDelete (findDisplay 46 displayCtrl 999904);
};

if(!((findDisplay 46 displayCtrl 999905) isEqualTo controlNull)) then
{
	ctrlDelete (findDisplay 46 displayCtrl 999905);
};

if(!((findDisplay 46 displayCtrl 999906) isEqualTo controlNull)) then
{
	ctrlDelete (findDisplay 46 displayCtrl 999906);
};