class Params
{
	class bluforUniform
	{
		title = "BLUFOR Uniform";
		texts[] = {"RHS MARPAT WOODLAND","RHS MARPAT DESERT","RHS OEF CP","TAS DOMINOS","VANILLA AAF","VANILLA GUERILLAS"};
		//values[] = {Uniform_MARPAT_WD,UNIFORM_MARPAT_D,UNIFORM_OEF_CP};
		values[] = {0,1,2,3,4,5};
		default = 3;
	};
	class opforUniform
	{
		title = "OPFOR Uniform";
		texts[] = {"RHS EMR SUMMER","RHS EMR DESERT","RHS FLORA","TAS PAPA JHONS","VANILLA AAF","VANILLA GUERILLAS"};
		//values[] = {UNIFORM_EMR_SUMMER,UNIFORM_EMR_DESERT,UNIFORM_FLORA};
		values[] = {0,1,2,3,4,5};
		default = 3;
	};
	class bluforWeapons
	{
		title = "BLUFOR Weapons";
		texts[] = {"CUP SMAW SPOTTING RIFLE","CUP XM8","CUP USA RANDOM","CUP RUSSIA RANDOM","RANDOM WEAPONS","RHS USA","RHS RUSSIA","RHS INDFOR","RHS G36","RHS GUERILLA","RHS M21","RHS SCAR","RHS VHS"};
		values[] = {0,1,2,3,4,11,12,13,14,15,16,17,18};
		default = 11;
	};
	class opforWeapons
	{
		title = "OPFOR Weapons";
		texts[] = {"CUP SMAW SPOTTING RIFLE","CUP XM8","CUP USA RANDOM","CUP RUSSIA RANDOM","RANDOM WEAPONS","RHS USA","RHS RUSSIA","RHS INDFOR","RHS G36","RHS GUERILLA","RHS M21","RHS SCAR","RHS VHS"};
		values[] = {0,1,2,3,4,11,12,13,14,15,16,17,18};
		default = 11;
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
		default = 45;
	};
	class Daytime
	{
		title = "Time";
		texts[] = {"Morning","Day","Evening","Night"};
		values[] = {6,12,18,0};
		default = 12;
		function = "BIS_fnc_paramDaytime";
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