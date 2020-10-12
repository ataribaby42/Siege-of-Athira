private _slot = player getVariable["slot", 0];
private _shelter = missionNamespace getVariable ["shelter" + str(_slot) , objNull];
private _nvgOn = false;

if(currentVisionMode player == 1) then
{
	_nvgOn = true;
};

player action ["nvGogglesOff", player];
shelterBase = _shelter;
cameraShelter = "camera" camCreate (_shelter modelToWorld [5,-2,1.5]);
cameraShelter camSetTarget (player modelToWorld [0,0,1]);
cameraShelter cameraEffect ["internal", "back"];
cameraShelter camCommit 0;
camUseNVG false;
false setCamUseTI 0;
cameraShelterAlt = false;

private _weapon = currentWeapon player;

cutText [localize "STR_CameraAction","PLAIN",-1, false];

if(_weapon == "") then
{
	player switchMove "AidlPercMstpSnonWnonDnon_G01";
}
else
{
	if(_weapon isKindOf ["Rifle", configFile >> "CfgWeapons"]) then
	{
		player switchMove "AidlPercMstpSlowWrflDnon_G01";
	}
	else
	{
		if(_weapon isKindOf ["Pistol", configFile >> "CfgWeapons"]) then
		{
			player switchMove "AidlPercMstpSlowWpstDnon_G01"; //pistol
		}
		else
		{
			player switchMove "AidlPercMstpSrasWlnrDnon_G01"; //launcher
		};
	};
};

sleep 0.2;
gCamQuit = false;
waituntil {!isnull (finddisplay 46)};
private _myEH = (findDisplay 46) displayAddEventHandler ["KeyDown", "if(_this select 1 == 57) then {gCamQuit = true;}; if(_this select 1 == 46) then {cameraShelterAlt = !cameraShelterAlt; if(cameraShelterAlt) then {cameraShelter camSetPos (shelterBase modelToWorld [1.5,-1.5,1.5]);} else {cameraShelter camSetPos (shelterBase modelToWorld [5,-2,1.5]);}; cameraShelter camCommit 0;};"];
waitUntil {sleep 0.1; gCamQuit};
(findDisplay 46) displayRemoveEventHandler ["KeyDown", _myEH];
sleep 0.2;
player switchMove "aidlppnemstpsraswrfldnon0s";
cameraShelter cameraEffect ["terminate", "back"];
camDestroy cameraShelter;
player switchCamera gCurrentView;
cutText ["","PLAIN"];

if(_nvgOn) then
{
	player action ["nvGoggles", player];
};




