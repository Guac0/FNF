Saving = 0;
disabledAI = 1;
enableDebugConsole[] = {
  "76561197960285643",\
	"76561197961336958",\
	"76561197967346068",\
	"76561197969316760",\
	"76561197977759652",\
	"76561197989932191",\
	"76561197991996737",\
	"76561198011678508",\
	"76561198046071194",\
	"76561198046962658",\
	"76561198058373929",\
	"76561198060054975",\
	"76561198061743924",\
	"76561198068436818",\
	"76561198097983515",\
	"76561198118254864",\
	"76561198136175919",\
	"76561198142848471",\
	"76561198144278271",\
	"76561198839019295",\
	"76561198043984507",\
	"76561198071074788",\
	"76561198066744977",\
	"76561198443204222",\
  "76561198070280580"\
};

respawn = 3;
respawnDialog = 1;
respawnDelay = 15;
respawnOnStart = 1;
joinUnassigned = 0;

allowProfileGlasses = 0;

disableChannels[] = {2};

onPauseScript[] = {\
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
