private _remove = [];
			
{
	if((_x select 1) + gTimeout <= gTimer) then
	{
		_remove = _remove + [[_x select 0, _x select 1]];
	};
} forEach playersInRaid;

if(count _remove > 0) then
{
	{
		playersInRaid = playersInRaid - [_x];
	} forEach _remove;
	
	publicVariable "playersInRaid";
};