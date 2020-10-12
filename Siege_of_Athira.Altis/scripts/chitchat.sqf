private _unit = _this select 0;
private _sound = _this select 1;
private _voice = _this select 2;

private _taunts = [
	[
		["t1-1.ogg", 1.8],
		["t1-2.ogg", 0.45],
		["t1-3.ogg", 0.9],
		["t1-4.ogg", 0.8],
		["t1-5.ogg", 1.3],
		["t1-6.ogg", 1.6],
		["t1-7.ogg", 1.2],
		["t1-8.ogg", 1.6],
		["t1-9.ogg", 1.0],
		["t1-10.ogg", 0.75],
		["t1-11.ogg", 0.9]
	],
	[
		["t3-1.ogg", 2.25],
		["t3-2.ogg", 0.8],
		["t3-3.ogg", 1.3],
		["t3-4.ogg", 0.4],
		["t3-5.ogg", 1.0],
		["t3-6.ogg", 1.5],
		["t3-7.ogg", 1.8],
		["t3-8.ogg", 2.0],
		["t3-9.ogg", 1.9],
		["t3-10.ogg", 2.2],
		["t3-11.ogg", 1.0],
		["t3-12.ogg", 2.5],
		["t3-13.ogg", 2.5],
		["t3-14.ogg", 1.6],
		["t3-15.ogg", 3.5],
		["t3-16.ogg", 2.7],
		["t3-17.ogg", 1.4],
		["t3-18.ogg", 2.1],
		["t3-19.ogg", 1.6],
		["t3-20.ogg", 1.4],
		["t3-21.ogg", 1.7],
		["t3-22.ogg", 2.0],
		["t3-23.ogg", 0.9]
	],
	[
		["t2-1.ogg", 1.5],
		["t2-2.ogg", 2.8],
		["t2-3.ogg", 1.0]
	],
	[
		["t4-1.ogg", 2.3],
		["t4-2.ogg", 2.1],
		["t4-3.ogg", 2.2],
		["t4-4.ogg", 0.8],
		["t4-5.ogg", 1.5],
		["t4-6.ogg", 1.9],
		["t4-7.ogg", 2.5],
		["t4-8.ogg", 3.0],
		["t4-9.ogg", 1.2],
		["t4-10.ogg", 2.6],
		["t4-11.ogg", 1.2],
		["t4-12.ogg", 2.3],
		["t4-13.ogg", 1.2],
		["t4-14.ogg", 0.8],
		["t4-15.ogg", 1.3]
	]
];

switch (_sound) do 
{
	case "TAUNT":
	{
		private _sentences = _taunts select _voice;
		private _sentence = selectRandom _sentences;
		[_unit, _sentence select 0, _sentence select 1] call fnc_unitTalk;
	};
	default 
	{
		
	};
};

