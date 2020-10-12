waitUntil {!isNil "soa_ClientMode_done"};

if (gClientMode == "CLIENT" || gClientMode == "LOCAL_SERVER" || gClientMode == "SINGLEPLAYER") then
{
	private _light = "#lightpoint" createVehicleLocal position _this;
	_light setLightBrightness 0.3; _light setLightAmbient[0.0, 0.0, 0.0];
	_light setLightColor[1.0, 0.9, 0.8];
	_light lightAttachObject [_this, [0,0,0]]; 
};