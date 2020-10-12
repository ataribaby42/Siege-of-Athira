waitUntil {!isNil "soa_ClientMode_done"};
waitUntil {time > 0}; 

if (gClientMode == "CLIENT" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then
{
	while {true} do 
	{ 
		_this say3D "GENERATOR";
		sleep 1.6 + (random 0.5);
	};
};




