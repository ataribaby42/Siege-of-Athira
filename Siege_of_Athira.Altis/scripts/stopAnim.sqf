private _unit = _this select 0;
private _stance = _this select 1;
private _weapon = _this select 2;

if(_weapon == "") then
{
	switch (_stance) do {
		case "STAND": { _unit playMoveNow "amovpercmstpsnonwnondnon"; };
		case "CROUCH": { _unit playMoveNow "amovpknlmstpsnonwnondnon"; };
		case "PRONE": { _unit playMoveNow "amovppnemstpsnonwnondnon"; };
		default { _unit playMoveNow "amovpercmstpsnonwnondnon"; };
	};
}
else
{
	if(_weapon isKindOf ["Rifle", configFile >> "CfgWeapons"]) then
	{
		switch (_stance) do {
			case "STAND": { _unit playMoveNow "amovpercmstpslowwrfldnon"; };
			case "CROUCH": { _unit playMoveNow "amovpknlmstpslowwrfldnon"; };
			case "PRONE": { _unit playMoveNow "amovppnemstpsraswrfldnon"; };
			default { _unit playMoveNow "amovpercmstpslowwrfldnon"; };
		};
	}
	else
	{
		if(_weapon isKindOf ["Pistol", configFile >> "CfgWeapons"]) then
		{
			switch (_stance) do {
				case "STAND": { _unit playMoveNow "amovpercmstpslowwpstdnon"; };
				case "CROUCH": { _unit playMoveNow "AmovPknlMstpSlowWpstDnon_AmovPknlMstpSrasWpstDnon"; };
				case "PRONE": { _unit playMoveNow "amovppnemstpsraswpstdnon"; };
				default { _unit playMoveNow "amovpercmstpslowwpstdnon"; };
			};
		}
		else
		{
			//Launcher
			switch (_stance) do {
				case "STAND": { _unit playMoveNow "amovpercmstpsraswlnrdnon"; };
				case "CROUCH": { _unit playMoveNow "amovpknlmstpsraswlnrdnon"; };
				case "PRONE": { _unit playMoveNow "amovpknlmstpsraswlnrdnon"; };
				default { _unit playMoveNow "amovpercmstpsraswlnrdnon"; };
			};
		};
	};
};