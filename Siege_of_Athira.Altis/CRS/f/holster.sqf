if(!alive player)exitWith{};
if((primaryWeapon player!="")||{(handgunWeapon player!="")})then{player action["switchWeapon",player,player,-1];};