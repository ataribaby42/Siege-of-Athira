diag_log "*** CSAT leaflet drop";

private _drops = [];

{
		_drops = _drops + [_x];
} forEach gLeafletDrops;

for "_i" from 1 to 5 do 
{
	private _drop = selectRandom _drops;
	_drops = _drops - [_drop];
	[_drop] spawn fnc_leafletDrop;
	sleep 5;
};
