class Params
{
	class bluforUniform
	{
		title = "BLUFOR Uniform";
		texts[] = {"RHS MARPAT WOODLAND","RHS MARPAT DESERT","RHS OEF CP"};
		//values[] = {Uniform_MARPAT_WD,UNIFORM_MARPAT_D,UNIFORM_OEF_CP};
		values[] = {0,1,2};
		default = Uniform_MARPAT_WD;
	};
	class opforUniform
	{
		title = "OPFOR Uniform";
		texts[] = {"RHS EMR SUMMER","RHS EMR DESERT","RHS FLORA"};
		//values[] = {UNIFORM_EMR_SUMMER,UNIFORM_EMR_DESERT,UNIFORM_FLORA};
		values[] = {0,1,2};
		default = UNIFORM_EMR_SUMMER;
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