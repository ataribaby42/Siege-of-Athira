disableSerialization;

if (gClientMode == "CLIENT" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then
{
	if(!(player in (list _this))) then
	{
		waitUntil {str(findDisplay 46) != "no display"};
		
		ctrlDelete (findDisplay 46 displayCtrl 999903);
	};
};
