_staffArr = [
	["76561197960285643",["Nemesis","Missions Team Lead", "<@203887048841625601>"]],
	["76561197961336958",["Arkor","Missions Team", "<@183748002827993088>"]],
	["76561198443204222",["Banks","Missions Team"]],
	["76561197989932191",["Anderson","Community Team/Host"]],
	["76561197969316760",["Ceb","Community Team"]],
	["76561198118254864",["Fred","Community Team"]],
	["76561198839019295",["Dusty","Community Team"]],
	["76561198011678508",["Muniz","Community Team"]],
	["76561197991996737",["IndigoFox","Technical Team Lead", "<@57217075608825856>"]],
	["76561198046962658",["Martin","Technical Team", "@<241742010548092929>"]],
	["76561198061743924",["Mallen","Technical Team", "<@262568622126399488>"]],
	["76561198136175919",["Stracotenko","Disciplinary Team Lead"]],
	["76561198046071194",["Wheaton","Disciplinary Team"]],
	["76561198066744977",["Layden","Disciplinary Team"]],
  ["76561198070280580",["Stark","Disciplinary Team"]]
];

_staffHash = createHashMapFromArray _staffArr;
missionNamespace setVariable ["fnf_staffInfo", _staffHash, true];
