if (gClientMode == "DEDICATED_SERVER" || gClientMode == "LOCAL_SERVER") then 
{
	topTen = [];
	playersInRaid = [];
	gMissionTime = 0;
	gMissionEnded = false;
	gRaidGUID = call fnc_generateGUID;
	publicVariable "gRaidGUID";
	
	publicVariable "playersInRaid";
	publicVariable "gMissionTime";                                                 
	publicVariable "gMissionEnded";
	publicVariable "topTen";
		
    "raidPlayerUIDin" addPublicVariableEventHandler 
	{ 
		private _found = false;
		
		scopeName "exit";

		{
			if(_x select 0 == raidPlayerUIDin select 0) then
			{
				playersInRaid set [_forEachIndex, [_x select 0, gTimer]];
				_found = true;
				breakTo "exit";
			};
		} forEach playersInRaid;
		
		if(!_found) then 
		{
			playersInRaid = playersInRaid + [[raidPlayerUIDin select 0, gTimer]];
		};
		
		publicVariable "playersInRaid";
	};
	
	"raidPlayerUIDout" addPublicVariableEventHandler 
	{ 
		private _found = false;
		private _record = [];
		
		scopeName "exit";

		{
			if(_x select 0 == raidPlayerUIDout) then
			{
				_record = [_x select 0, _x select 1];
				_found = true;
				breakTo "exit";
			};
			
		} forEach playersInRaid;
		
		if(_found) then
		{
			playersInRaid = playersInRaid - [_record];
		};
		
		publicVariable "playersInRaid";
	};
	
	if (gClientMode == "DEDICATED_SERVER") then
	{
		"topTenUpdate" addPublicVariableEventHandler 
		{ 
			private _temp = [];
			private _name = topTenUpdate select 0;
			private _score = topTenUpdate select 1;
			private _client = topTenUpdate select 2;
			topTen = topTen + [[_name, _score, _client]];
			topTen = [topTen,[],{_x select 1},"DESCEND"] call BIS_fnc_sortBy;

			for "_i" from 0 to ((10 min (count topTen)) - 1) do 
			{
				_temp = _temp + [[topTen select _i select 0, topTen select _i select 1]];
				
				if((topTen select _i select 2) == _client) then
				{
					gTopTenAdded = true;
					_client publicVariableClient "gTopTenAdded";
				}
			};
			
			topTen = _temp;
			publicVariable "topTen";
			profileNamespace setVariable [gSavePrefix + "_mp_topten", topTen];
			saveProfileNamespace;
		};
		
		topTen = profileNamespace getVariable [gSavePrefix + "_mp_topten", []];
		publicVariable "topTen";
	};
	
	diag_log "*** mission started";
	diag_log format["*** missionStart: %1", missionStart];
	diag_log format["*** date: %1", date];
	
	waitUntil {!isNil "gTimeSet"};
	waitUntil {!isNil "gWeather"};
	waitUntil {!isNil "gTimer"};
	gTemp = gClimate call llw_fnc_getTemperature select 0;
	publicVariable "gTemp";
	gSunElevation = [] call llw_fnc_getSunAngle;
	publicVariable "gSunElevation";
	gMoonPhase = call fnc_computeMoonPhase;
	publicVariable "gMoonPhase";
	gServerSetupCompleted = true;
};

