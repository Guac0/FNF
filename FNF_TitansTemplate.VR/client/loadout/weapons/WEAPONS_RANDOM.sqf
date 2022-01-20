
/*_machineGuns = ("true" configClasses (configFile >> "cfgWeapons")) select
{
 _parents = [_x,true] call BIS_fnc_returnParents;
 _name = configName _x;

 ("MGun" in _parents) and (getNumber (_x >> 'scope') > 1)
};*/ //only returns statics and vehicle weapons
/*_greandeLaunchers = ("true" configClasses (configFile >> "cfgWeapons")) select
  {
    _parents = [_x,true] call BIS_fnc_returnParents;
    _name = configName _x;

  ("GrenadeLauncher" in _parents) and (getNumber (_x >> 'scope') > 1)
  };
  phx_loadout_rifle_weapon = configName (selectRandom _greandeLaunchers);*/ //can't easily sort by grenade launcher for infantry
if (isNil "randomWeaponsHaveRun") then {
  //pistols
  pistols = ("true" configClasses (configFile >> "cfgWeapons")) select
  {
    _parents = [_x,true] call BIS_fnc_returnParents;
    _name = configName _x;

    ("Pistol" in _parents) and (getNumber (_x >> 'scope') > 1)
  };
  //rifles
  rifles = ("true" configClasses (configFile >> "cfgWeapons")) select
  {
    _parents = [_x,true] call BIS_fnc_returnParents;
    _name = configName _x;

    ("Rifle" in _parents) and (getNumber (_x >> 'scope') > 1)
  };
  phx_loadout_rifle_weapon = configName (selectRandom _rifles); //sometimes gives UBGLs but no ammo if they're not an SL. Sometimes gives light marksman rifles
  //long rifles
  longRifles = ("true" configClasses (configFile >> "cfgWeapons")) select
  {
    _parents = [_x,true] call BIS_fnc_returnParents;
    _name = configName _x;

    ("Rifle_Long_Base_F" in _parents) and (getNumber (_x >> 'scope') > 1)
  };
  //launchers 
   launchers = ("true" configClasses (configFile >> "cfgWeapons")) select
  {
    _parents = [_x,true] call BIS_fnc_returnParents;
    _name = configName _x;

    ("Launcher" in _parents) and (getNumber (_x >> 'scope') > 1)
  };
  //short rifles
  shortRifles = ("true" configClasses (configFile >> "cfgWeapons")) select
  {
    _parents = [_x,true] call BIS_fnc_returnParents;
    _name = configName _x;

    ("Rifle_Short_Base_F" in _parents) and (getNumber (_x >> 'scope') > 1)
  };
  //set variable so this doesnt run again
  randomWeaponsHaveRun = true;
};

phx_loadout_sidearm_weapon = configName (selectRandom pistols);

//put all the config crawlers inside the if statements so we execute them as infrequently as possible as they cause a short lag as they run (maybe move them to somewhere else where they only execute once per match?)
if (!phx_loadout_hasSpecial) then {
  phx_loadout_rifle_weapon = configName (selectRandom rifles); //sometimes gives UBGLs but no ammo if they're not an SL. Sometimes gives light marksman rifles
};
if (pRole == ROLE_AR || pRole == ROLE_MG || pRole == ROLE_MK) then {
  phx_loadout_rifle_weapon = configName (selectRandom longRifles); //has both MGs and DMRs
};
/*if (pRole == ROLE_MG) then {
  phx_loadout_rifle_weapon = "";
};*/
if (pRole == ROLE_RAT) then {
  phx_loadout_antitank_weapon = configName (selectRandom launchers); //sometimes gives ACE CSW bags and doesn't give ammo for non-single shot stuff
};
/*if (pRole == ROLE_MK) then {
  phx_loadout_rifle_weapon = configName (selectRandom longRifles);
};*/
if (pRole == ROLE_CLS) then {
  phx_loadout_rifle_weapon = configName (selectRandom shortRifles);
};

//include this if you use randomized weapons so that it'll detect the mags for you
phx_loadout_sidearm_mag = ([phx_loadout_sidearm_weapon] call CBA_fnc_compatibleMagazines select 0) + ":2";
phx_loadout_rifle_mag_tracer = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 1) + ":4";
phx_loadout_rifle_mag = ([phx_loadout_rifle_weapon] call CBA_fnc_compatibleMagazines select 0) + ":7";
phx_loadout_antitank_mag = ([phx_loadout_antitank_weapon] call CBA_fnc_compatibleMagazines select 0); //only add 1 AT ammo