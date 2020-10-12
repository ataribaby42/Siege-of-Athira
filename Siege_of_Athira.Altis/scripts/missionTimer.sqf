waitUntil {gMissionSetupCompleted};

while {true} do 
{ 
	gTimer = gTimer + 1;
	publicVariable "gTimer";
	Sleep 1;
};