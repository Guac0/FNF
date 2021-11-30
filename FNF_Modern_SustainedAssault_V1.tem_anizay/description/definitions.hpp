Saving = 0;
disabledAI = 1;
enableDebugConsole = 1;

respawn = 3;
respawnDialog = 1;
respawnDelay = 15;
respawnOnStart = 1;
joinUnassigned = 0;

class Weapons
{
	class vn_m16		{ count = 8; };
	class vn_m16_xm148		{ count = 2; };
	class vn_m1911	{ count = 2; };
};

allowProfileGlasses = 0;

disableChannels[] = {2};

onPauseScript[] = {\
    phx_fnc_removeRespawnButton,\
    phx_fnc_addStaffContactButton,\
    phx_admin_fnc_adminGameEnd,\
    phx_admin_fnc_addAdminKickButton\
};

class CfgDebriefingSections {
    class acex_killTracker {
        title = "ACEX Killed Events";
        variable = "acex_killTracker_outputText";
    };
};




class CfgRoles
{
	class Rifleman // Class name used in CfgRespawnInventory
	{
		displayName = "Rifleman"; // Name of the role, displayed in the respawn menu
		icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa"; // Icon shown next to the role name in the respawn screen
	};
};


class CfgRespawnInventory
{
	class RI
{
	displayName = "Rifleman2";
	icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
	role = "Rifleman";
	show = "side (group _this) == west";
	uniformClass = "vn_b_uniform_macv_06_07";
	backpack = "vn_b_pack_trp_02_02";
	weapons[] = {"vn_m14","vn_m1911","Throw","Put"};
	magazines[] = {"vn_m1911_mag","vn_m1911_mag","vn_m61_grenade_mag","vn_m61_grenade_mag","vn_m18_white_mag","vn_m18_white_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag","vn_m14_mag"};
	items[] = {"ACE_MapTools","ACE_CableTie","ACE_CableTie","ACE_fieldDressing","ACE_packingBandage","ACE_morphine","ACE_tourniquet","ACE_fieldDressing","ACE_packingBandage","ACE_morphine","ACE_tourniquet","ACE_fieldDressing","ACE_packingBandage","ACE_morphine","ACE_tourniquet","ACE_fieldDressing","ACE_packingBandage","ACE_morphine","ACE_tourniquet"};
	linkedItems[] = {"vn_b_vest_usarmy_03","vn_b_helmet_m1_02_01","","vn_b_item_map","vn_b_item_compass","vn_b_item_watch","TFAR_anprc152","ItemGPS","","","","","","","",""};
};
// Visit https://community.bistudio.com/wiki/Arma_3_Respawn for detailed information
};
