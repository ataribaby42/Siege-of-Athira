  ______________________________________
 |	        			|
 |      C O M B A T   R E A L I S M	|
 |	     	S C R I P T S		|
 |					|
 |		BY: PHRONK		|
 |	       www.ATCAG.com		| v0.1		22NOV2017
_|______________________________________|_______________________
[ D E S C R I P T I O N ]					|
-----------------------						|
  Combat Realism Scripts is a totally addon-free set of light	|
weight scripts for Arma 3 which enhance the gameplay in your	|
mission.  Features are SP, MP, and Dedicated compatible.  Script|
will deactivate itself if it detects ACE running. 		|
								|
								|
								|
[ F E A T U R E S ]						|
-------------------------					|
• No mods required!						|
								|
• No DLCs required!						|
								|
• Compatible with single-player, client-host, and dedicated	|
								|
• Backblast:							|
  -Knocks down & severely injures those in your backblast radius|
								|
• Disposable AT:						|
  -Single-use disposable launchers				|
	-M136 (CUP Weapons)					|
	-NLAW (CUP Weapons)					|
	-PCML							|
	-RPG18 (CUP Weapons)					|
								|
• Flashbang:							|
  -RGN Grenade acts as a flashbang (blinds players/AI)		|
								|
• Fragmentation Grenade:					|
  -RGO Grenades spew shrapnel upon detonation			|
								|
• Holster Weapon:						|
  -You can holster your sidearm/sling rifle on your back	|
								|
• STFU CARL:							|
  -Mutes your character's voice					|
								|
• Tactical Point:						|
  -Player points at what he's Tactical Pinging			|
								|
• Weapons Animations:						|
  -Appropriate animations when mounting/dismounting attachments |
								|
• Weapon Jamming:						|
  -Rare chance for weapon to jam while firing			|
								|
________________________________________________________________|_______________________
[ C H A N G E - L O G ]									|
-------------------------								|
•Initial release									|
											|
________________________________________________________________________________________|
[ T O    D O    L I S T ]								|
-------------------------								|
• Breaching Charges									|
• Cookoff										|
• Deafness										|
• Ear Pro										|
• Hand Flares										|
• Interact										|
• Drag / Carry incapacitated players							|
• Shoulder Tap										|
• Surrender										|
• Tactical Hand Gestures								|
• Weapon Safety										|
• Wire Cutters										|
• And more!										|
											|
________________________________________________________________________________________|
[ K N O W N   B U G S ]									|
-------------------------								|
 • Post-process effects do not reset after being backblasted				|
 • Weapon attachment animations play when moving attachment into/out of container	|
											|
________________________________________________________________________________________|
[ I N S T A L L A T I O N ]
-------------------------
1. Move the "CRS" folder from downloaded file, to your mission	folder.
EXAMPLE: "Documents\ArmA 3 - Other Profiles\<profile>\missions\myMission.VR"



2. Copy & Paste below code into your mission's "init.sqf":

	null=[]execVM"CRS\init.sqf";



3. Copy & Paste below code into your mission's "description.ext":

	class CfgSounds {
	#include "CRS\f\SFX.hpp"
	sounds[]={};
	};


[OPTIONAL] 4. The "CFG.sqf" file in the "CRS" folder is the settings file.

//Toggle specific CRS features:	TRUE = enabled / FALSE = disabled
CRS_BackBlast=TRUE;
CRS_DisposableAT=TRUE;
CRS_FlashBang=TRUE;
CRS_Fragmentation=TRUE;
CRS_GunAnimations=TRUE;
CRS_Holstering=TRUE;
CRS_STFUCarl=TRUE;
CRS_TacticalPoint=TRUE;
CRS_WeaponJamming=TRUE;


________________________________________________________________________
[ C R E D I T S ]							|
-------------------------						|
	Phronk: Script Creator						|
	Bohemia Interactive: Models, textures, configs, and BIS_fnc	|
									|
	[TESTERS]							|
	1. Chaser [ATCAG]						|
	2. Sjakal							|
	3. PRYMSUSPEC							|
									|
________________________________________________________________________|
[ C O N T A C T ]							|
-------------------------						|
Need help?  Want to report a bug?  Comments?  You can contact me via 	|
E-mail or on my TeamSpeak at:						|
				Frankie.Hutzler@GMail.com		|
				or					|
				ATCAG.TS.NFOServers.com			|
________________________________________________________________________|
[ D I S C L A I M E R ]							|
----------------------------						|
As author of this script, I grant permission to all scripters/mission	|
designers to modify this script to their liking for PERSONAL USE.  	|
This includes granted permission to individuals and ArmA groups to host |
a mission using the script on a server.  HOWEVER, I DO NOT consent	|
publishing ANY VERSION of the script as their own.  """"""		|
									|
If you've made major changes to the script and wish to publish it,	|
PLEASE CONTACT ME FIRST FOR PERMISSION TO BE GRANTED!			|
									|
Thank you and enjoy!							|
Phronk   (A.K.A.  Hustler)						|
________________________________________________________________________|