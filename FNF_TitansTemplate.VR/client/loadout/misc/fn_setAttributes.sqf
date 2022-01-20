/*Sets player ACE attributes*/

//reset attributes
player setVariable ["ace_medical_medicClass", 0, true];
player setVariable ["ace_isEngineer", 0, true];

//give player correct attributes for role
if (pRole == ROLE_CLS) then {player setVariable ["ace_medical_medicClass", 1, true]};
if (pRole in [ROLE_CE,ROLE_CR,ROLE_P]) then {player setVariable ["ace_isEngineer", 1, true]};
