private _guid = "";
private _chars = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];

for "_i" from 1 to 20 do 
{
	_guid = _guid + selectRandom _chars;
};

_guid;