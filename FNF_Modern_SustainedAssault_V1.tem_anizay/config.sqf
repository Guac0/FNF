#include "description\configDefs.hpp"

////////////////////////////////////////////////////////////

// MISSION MAKER NOTES //
// 0 or more of the below can be included. At minimum, it's suggested to populate the "briefingNotes" item.

// "Background" should include any lore you wish to explain.
phx_briefingBackground = "";
// "WorldInfo" should include any notable details about the AO.
phx_briefingWorldInfo = "";
// "Notes" can include anything else.
phx_briefingNotes = "Each side is granted a set number of respawn tickets. Your objective is to capture and hold the mosque If one side captures the sector, the other will passively bleed respawn tickets. If either side reaches 0, the mission will end. If the countdown timer reaches 0, the side with the highest score will win.<br/><br/>This mission will allow you to test the different loadouts and systems present in our newest framework while having a bit of competitive fun doing so.<br/><br/><br/><br/><br/>1. Rearm vehicles are provided at the Howitzers on each side. Use ACE Interact > Rearm to reload nearby vehicles.<br/><br/>2. Respawns are available for jeeps (30 seconds), armed trucks (4 minutes), base AA (5 minutes), helos (10 minutes), howitzers (15 minutes), and planes (15 minutes). Players will respawn in waves every 25 seconds.<br/><br/>3. Sides will be tuned to matching frequencies.";
// "Rules" should include any mission-specific rules that you want to spell out for players.
phx_briefingRules = "Rule 1. All FNF rules still apply. You can call an admin using the built-in Contact Staff button in your pause menu, just like in the main event.<br/><br/>Rule 2: No firing into enemy's main base.<br/><br/>Rule 3: No movement into the side markers (hashed and colored).";

////////////////////////////////////////////////////////////

// SCENARIO SETTINGS //

phx_gameMode = "";
/*
  MAKE SURE YOU SET THE ATTACKING AND DEFENDING SIDES BELOW IF YOUR CHOSEN MODE IS AN ATK/DEF
  DO NOT DELETE ANY OF THE OTHER TEMPLATE OBJECTIVE OBJECTS
  they will be deleted automatically if not in use
*/
phx_defendingSide = sideEmpty; // west/east/independent
phx_attackingSide = sideEmpty; // west/east/independent
// Leave it as sideEmpty if chosen mode is neutral

phx_vnArtillerySide = sideEmpty; // west/east/independent
// which side's PLT SGT will have access to VN Artillery interface (requires Prairie Fire)
// use sideEmpty to not give anyone access

phx_enemyStartVisible = true; // Set to false to hide enemy start zone markers
phx_maxViewDistance = 5000;
/*
  Maximum client view distance (meters)
    LOW: 500 (for urban combat)
    MEDIUM: 1000 (for hilly terrain, open areas)
    HIGH: 1500 (for large open ground, mountains)
*/

phx_fortifyPoints = 125;
/*
  Currency for fortify - individual to each Combat Engineer - set to 0 to disable
    LOW: 60
    MEDIUM: 125
    HIGH: 250
*/

phx_fortifyStyle = "Modern";
/*
  Determines what objects will be available for phx_defendingSide CEs to place using Fortify tool
    "Modern" will auto-dermine tan or green hescos, sandbags, etc depending on map
    "ModernGreen" will force modern green objects
    "ModernTan" will force modern tan objects
    "NVA" will give Vietnam-era NVA/VC emplacements (requires Prairie Fire)
    "MACV" will give Vietnam-era US Army emplacements (requires Prairie Fire)
*/

phx_magnifiedOptics = 0;
/*
  Allow players to grab magnified optics from the gear selector
  0 will restrict 4x+ optics to designated marksmen and snipers.
  1 will allow 4x+ optic choices for all except MGs.
  -1 will force ironsights.
*/

phx_addNVG = 1;
/*
  Automatically add NVGs & lasers to players (Gen3, Black)
  Examples:
    phx_addNVG = 0 OR [] will not give anyone NVGs
    phx_addNVG = 1 OR [east, west, independent] will give all sides NVGs
    phx_addNVG = [east] will give side east NVGs
    phx_addNVG = [east,west] will give sides east and west NVGs
*/

////////////////////////////////////////////////////////////

// UNIFORM AND GEAR CHOICES //

//BLUFOR
phx_bluforUniform = "RHS_UNI_US_MARINES_WOODLAND_2010";
phx_bluforGear = "RHS_GEAR_US_ARMY_2010_M16A4";

//OPFOR
phx_opforUniform = "RHS_UNI_RU_RATNIK_D_2020";
phx_opforGear = "RHS_GEAR_RU_ARMY_2010_AK74M";

//INDFOR
phx_indforUniform = "RHS_UNI_ID_NAVSOG_2010";
phx_indforGear = "RHS_GEAR_ID_NAVSOG_2010_M16A4";


////////////////////////////////////////////////////////////

// MAT SELECTION //

// BLUFOR
phx_bluAT_Bravo = GEARDEFAULT;
phx_bluAT_Delta = GEARDEFAULT;

// OPFOR
phx_redAT_Bravo = GEARDEFAULT;
phx_redAT_Delta = GEARDEFAULT;

// INDFOR
phx_grnAT_Bravo = GEARDEFAULT;
phx_grnAT_Delta = GEARDEFAULT;


////////////////////////////////////////////////////////////

// SQUAD HQ AUXILIARY ROLES //
// "SHQAUX"
// Adjusts what loadout the two extra Squad HQ members will receive
// Set to 0 to make default crewman, set to one of the options to enable equipment for it.
// OPFOR
  phx_eastAlphaAuxRole = MORTAR_2B14(8,6,2);
  phx_eastBravoAuxRole = MORTAR_2B14(8,6,2);
  phx_eastCharlieAuxRole = MORTAR_2B14(8,6,2);
  phx_eastDeltaAuxRole = MORTAR_2B14(8,6,2);

// BLUFOR
  phx_westAlphaAuxRole = MORTAR_M252(8,6,2);
  phx_westBravoAuxRole = MORTAR_M252(8,6,2);
  phx_westCharlieAuxRole = MORTAR_M252(8,6,2);
  phx_westDeltaAuxRole = MORTAR_M252(8,6,2);

// INDFOR
  phx_guerAlphaAuxRole = 0;
  phx_guerBravoAuxRole = 0;
  phx_guerCharlieAuxRole = 0;
  phx_guerDeltaAuxRole = 0;


////////////////////////////////////////////////////////////

// SYSTEM SETTINGS //

// Show/Hide unit / group icons on map, GPS for players
// Used in limited-intel scenarios like WWII and Vietnam
phx_showUnitIcons = true;
phx_showGroupIcons = true;
phx_showAlliedFactions = true;
