//just signals the code in fn_newRoundClient to do the side swapping whenever it is next run
//intended to be manually called from admin options in fn_adminDiary or fn_adminGui
TAS_currentRoundCount = 0;
TAS_doSwitchSides = true;
publicVariable "TAS_currentRoundCount";
publicVariable "TAS_doSwitchSides";