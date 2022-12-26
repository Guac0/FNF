class Params
{
	class bluforUniform
	{
		title = "BLUFOR Uniform";
		texts[] = {"TAS DOMINOS","VANILLA AAF","VANILLA GUERILLAS","RHS MARPAT WOODLAND","RHS MARPAT DESERT","RHS OEF CP","RHS PMC","RHS ION BLACK","RHS M93 DESERT","RHS M93 WOODLAND","RHS UCP","RHS ISRAEL","RHS RANGERS","UNSC","Halo URF","Halo Battlejumpers"};
		//values[] = {Uniform_MARPAT_WD,UNIFORM_MARPAT_D,UNIFORM_OEF_CP};
		values[] = {0,1,2,11,12,13,14,15,16,17,18,19,20,31,32,33};
		default = 0;
	};
	class opforUniform
	{
		title = "OPFOR Uniform";
		texts[] = {"TAS PAPA JHONS","VANILLA AAF","VANILLA GUERILLAS","RHS EMR SUMMER","RHS EMR DESERT","RHS FLORA","RHS PMC","RHS ION BLACK","RHS MOUNTAIN FLORA","RHS GORKA GREEN","RHS GORKA BEREZKA","RHS SOVIET CSAT","RHS ALTIS LIZARD","UNSC","Halo URF","Halo Battlejumpers"};
		//values[] = {UNIFORM_EMR_SUMMER,UNIFORM_EMR_DESERT,UNIFORM_FLORA};
		values[] = {0,1,2,11,12,13,14,15,16,17,18,19,20,31,32,33};
		default = 0;
	};
	class bluforWeapons
	{
		title = "BLUFOR Weapons";
		texts[] = {"CUP SMAW SPOTTING RIFLE","CUP XM8","CUP USA RANDOM","CUP RUSSIA RANDOM","RANDOM WEAPONS","RHS USA","RHS RUSSIA","RHS INDFOR","RHS G36","RHS GUERILLA","RHS M21","RHS SCAR","RHS VHS","UNSC"};
		values[] = {0,1,2,3,4,11,12,13,14,15,16,17,18,31};
		default = 4;
	};
	class opforWeapons
	{
		title = "OPFOR Weapons";
		texts[] = {"CUP SMAW SPOTTING RIFLE","CUP XM8","CUP USA RANDOM","CUP RUSSIA RANDOM","RANDOM WEAPONS","RHS USA","RHS RUSSIA","RHS INDFOR","RHS G36","RHS GUERILLA","RHS M21","RHS SCAR","RHS VHS","UNSC"};
		values[] = {0,1,2,3,4,11,12,13,14,15,16,17,18,31};
		default = 4;
	};
	class magnifiedOptics
	{
		title = "Allow Magnified Optics (for non-marksman)";
		texts[] = {"No","Yes"};
		values[] = {0,1};
		default = 0;
	};
	class addNVG
	{
		title = "Give NVGs";
		texts[] = {"No","Yes","BLUFOR Only","OPFOR Only"};
		values[] = {0,1,2,3};
		default = 0;
	};
	class safeStartTimer
	{
		title = "Safe Start Duration";
		texts[] = {"None","15 Seconds","30 Seconds","45 Seconds","60 Seconds","75 Seconds","90 Seconds"};
		values[] = {1,15,30,45,60,75,90}; //havent checked what value of 0 will do so minimum time is 1
		default = 30;
	};
	class Daytime
	{
		title = "Time of Day";
		texts[] = {"Morning","Day","Evening","Night"};
		values[] = {6,12,18,0};
		default = 12;
		function = "BIS_fnc_paramDaytime";
	};
	class timeLimit
	{
		title = "Round Timer";
		texts[] = {"3 Minutes","4 Minutes","5 Minutes [Goliaths Default]","6 Minutes","7 Minutes [Titans Default]","8 Minutes","9 Minutes","10 Minutes","15 Minutes"};
		values[] = {180,240,300,360,420,480,540,600,900};
		default = 180;
	};
	class roundSwapCount
	{
		title = "Rounds Before Switching Sides";
		texts[] = {"1","2","3","4","5","Never (999)"};
		values[] = {1,2,3,4,5,999};
		default = 3;
	};
	class gameMode
	{
		title = "Gamemode";
		texts[] = {"Terminal","CTF","Destroy"};
		values[] = {0,1,2};
		default = 0;
	};
	class pointAddTime
	{
		title = "[Terminal Gamemode] Time Between Point Scores";
		texts[] = {"0.25","0.33","0.5","0.67","0.75","1","1.25","1.33","1.5","1.67","1.75","2"}; //Note: only updates visually every second, so faster values will result in skipping numbers
		values[] = {0.25,0.33,0.5,0.67,0.75,1,1.25,1.33,1.5,1.67,1.75,2};
		default = 1;
	};

	//#define DAYTIMEPERIOD_DEFAULT 12
	//#include "\a3\functions_f\Params\paramDaytimePeriod.hpp"
	
	#define WEATHER_DEFAULT	50
	#include "\a3\functions_f\Params\paramWeather.hpp"

	#define TIMEACCELERATION_DEFAULT 1
	#include "\a3\Functions_F_MP_Mark\Params\paramTimeAcceleration.hpp"

	//#define VIEW_DISTANCE_MIN 50
	//#define VIEW_DISTANCE_MAX 1250
	//#define VIEW_DISTANCE_DEFAULT 250
	//#include "\a3\Functions_F_Heli\Params\paramViewDistance.hpp"

};