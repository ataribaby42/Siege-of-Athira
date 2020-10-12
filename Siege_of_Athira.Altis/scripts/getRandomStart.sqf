private _start = selectRandom gStarts;
private _pos = getPosATL _start;

for "_i" from 0 to 50 do {
	private _entities = nearestObjects [_pos, [gGuerrillaAiClass, gPlayerClass, gPlayerAiClass] + gEnemyReconClasses, 100, true];
	private _onlyAlive = [];
	
	{
		if(alive _x) then
		{
			_onlyAlive = _onlyAlive + [_x];
		};
	}
	forEach _entities;
	
	private _alive = count(_onlyAlive);

	if (_alive == 0) exitwith {_start;};
	_start = selectRandom gStarts;
	_pos = getPosATL _start;
};

_start;