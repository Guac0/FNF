fnf_ui = call CBA_fnc_createNamespace;

#define MSG_ARMEDTRUCKS "Armed Trucks (4 minute respawn)"
#define MSG_BASEAA "Base AA (5 minute respawn)"
#define MSG_HELICOPTERS "Helicopters (10 minute respawn)"
#define MSG_HOWITZER "Base Howitzer (15 minute respawn)"
#define MSG_JEEPS "Jeeps (30 second respawn)"
#define MSG_RALLY "ACE Interact here to teleport to the AO"
#define MSG_SERVICEPOINT "Vehicle Repair Station"
#define MSG_PLANES "Planes (15 minute respawn)"
#define MSG_SUPPLY "ACE Arsenal"

#define ICON_AA "\A3\ui_f\data\map\vehicleicons\iconStaticAA_ca.paa"
#define ICON_APC "\A3\ui_f\data\map\vehicleicons\iconAPC_ca.paa"
#define ICON_ARTILLERY "\A3\ui_f\data\map\vehicleicons\iconStaticMortar_ca.paa"
#define ICON_CAR "\A3\ui_f\data\map\vehicleicons\iconCar_ca.paa"
#define ICON_HELICOPTER "\A3\ui_f\data\map\vehicleicons\iconHelicopter_ca.paa"
#define ICON_PLANE "\A3\ui_f\data\map\vehicleicons\iconPlane_ca.paa"
#define ICON_RALLY "\A3\ui_f\data\map\vehicleicons\iconobject_ca.paa"
#define ICON_REPAIR "\A3\ui_f\data\map\vehicleicons\pictureRepair_ca.paa"
#define ICON_SUPPLY "\A3\ui_f\data\map\vehicleicons\iconCrateWpns_ca.paa"


fnf_ui setVariable ["eastHelperTargets",[
  [OPF_supplyBox,MSG_SUPPLY,ICON_SUPPLY],
  [OPF_armedTrucks,MSG_ARMEDTRUCKS,ICON_APC],
  [OPF_baseAA_1,MSG_BASEAA,ICON_AA],
  [OPF_baseAA_2,MSG_BASEAA,ICON_AA],
  [OPF_helicopters,MSG_HELICOPTERS,ICON_HELICOPTER],
  [OPF_howitzer,MSG_HOWITZER,ICON_ARTILLERY],
  [OPF_jeeps,MSG_JEEPS,ICON_CAR],
  [OPF_rallyBase,MSG_RALLY,ICON_RALLY],
  [OPF_servicePoint,MSG_SERVICEPOINT,ICON_REPAIR]
]];

fnf_ui setVariable ["westHelperTargets",[
  [BLU_supplyBox,MSG_SUPPLY,ICON_SUPPLY],
  [BLU_armedTrucks,MSG_ARMEDTRUCKS,ICON_APC],
  [BLU_baseAA_1,MSG_BASEAA,ICON_AA],
  [BLU_baseAA_2,MSG_BASEAA,ICON_AA],
  [BLU_helicopters,MSG_HELICOPTERS,ICON_HELICOPTER],
  [BLU_howitzer,MSG_HOWITZER,ICON_ARTILLERY],
  [BLU_jeeps,MSG_JEEPS,ICON_CAR],
  [BLU_planes,MSG_PLANES,ICON_PLANE],
  [BLU_rallyBase,MSG_RALLY,ICON_RALLY],
  [BLU_servicePoint,MSG_SERVICEPOINT,ICON_REPAIR]
]];

fnf_ui setVariable ["fnf_drawHelpersHandle", (
  [{
    if (!alive player) exitWith {fnf_ui setVariable ["fnf_drawHelpersHandle", nil]};

    private _cameraPositionAGL = positionCameraToWorld[0,0,0];
    private _cameraPositionASL = AGLtoASL _cameraPositionAGL;
    private _zoom = (
          (
            [0.5,0.5]
            distance2D
            worldToScreen
            positionCameraToWorld
            [0,3,4]
          ) * (
            getResolution
            select 5
          ) / 2
    ) + 0.66666;

    {
      _x params ["_target", "_text", "_icon"];

      // referenced https://github.com/Quailsnap/WHA-Nametags
      // _targetPositionAGLTopRef = _target modelToWorldVisual (_target selectionPosition "pilot") vectorAdd [0,0, 5 + (0.5 * (_player distance _target))];
      _targetPositionAGLTopRef = getPos _target vectorAdd [0,0,5];
      // _targetPositionAGLBotRef = _target modelToWorldVisual [0,0,0] vectorAdd [0,0,((0.1 * (player distance _target)))];

      private _camDistance = _cameraPositionAGL distance _targetPositionAGLTopRef;
      private _distance = _player distance _targetPositionAGLTopRef;

      private _vectorDir = eyePos player vectorFromTo (positionCameraToWorld[0,0,1]);
      private _vectorDiff = vectorNormalized (((_vectorDir) vectorCrossProduct (vectorUp player)) vectorCrossProduct (_targetPositionAGLTopRef vectorDiff _cameraPositionAGL));
      private _targetPositionAGLTop = _targetPositionAGLTopRef vectorAdd ((_vectorDiff vectorMultiply (0.1 * _camDistance / _zoom)) vectorMultiply 1.3);
      private _targetPositionAGLBottom = _targetPositionAGLBotRef vectorAdd ((_vectorDiff vectorMultiply (0.1 * _camDistance / _zoom)) vectorMultiply -1);

      if (alive _target) then {
        switch (true) do {
          // case (player distance _target <= 15): {
          //   // drawIcon3D["", [1, 1, 1, 1], _targetPositionAGLTop, 0.5 / (getResolution select 5), 0.5 / (getResolution select 5), 0, _text, true, 0.02 / (getResolution select 5), "PuristaBold", "center"];
          //   drawIcon3D["", [1, 1, 1, 1], _targetPositionAGLTopRef, 0.5 / (getResolution select 5), 0.5 / (getResolution select 5), 0, _text, true, 0.02 / (getResolution select 5), "PuristaBold", "center"];
          // };
          case (player distance _target <= 150): {
            // drawIcon3D["", [1, 1, 1, 0.3], _targetPositionAGLTop, 0.3 / (getResolution select 5), 0.3 / (getResolution select 5), 0, "", true, 0.02 / (getResolution select 5), "PuristaBold", "center"];
            drawIcon3D[_icon, [1, 1, 1, 0.8], _targetPositionAGLTopRef, 0.3 / (getResolution select 5), 0.3 / (getResolution select 5), 0, _text, true, 0.02 / (getResolution select 5), "PuristaBold", "center"];
          };
        };
      };
    } forEach (fnf_ui getVariable format["%1HelperTargets",side (group player)]);
  }, 0] call CBA_fnc_addPerFrameHandler
  )];

true
// [fnf_drawHelpersHandle] call CBA_fnc_removePerFrameHandler;
