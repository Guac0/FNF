class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit;					// Default edit box (i.e., text input field)
			class Combo;				// Default combo box (i.e., drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Boolean)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
		};
		// Description base classes, for more information see below
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
	class fnf_ModuleAddEmplacements: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Add Emplacements to Buildings"; // Name displayed in the menu
		icon = "\A3\ui_f\data\map\markers\nato\n_support.paa"; // Map icon. Delete this entry to use the default icon
		category = "fnf_eden";

		// Name of function triggered once conditions are met
		function = "fnf_eden_fnc_spawnEmplacements";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 0;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 0;
		// 1 if modules is to be disabled once it is activated (i.e., repeated trigger activation won't work)
		isDisposable = 1;
		// 1 to run init function in Eden Editor as well
		is3DEN = 0;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		// curatorInfoType = "RscDisplayAttributeModuleNuke";

		// Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
		class Attributes: AttributesBase
		{
			// Arguments shared by specific module type (have to be mentioned in order to be present)
			// class Units: Units
			// {
			// 	property = "myTag_ModuleNuke_Units";
			// };
			// Module specific arguments
			class SpawnCount: Combo
			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "fnf_ModuleAddEmplacements_count";
				displayName = "Number of Static Weapons"; // Argument label
				tooltip = "How many static weapons will be spawned"; // Tooltip description
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "2"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
				class Values
				{
					class spawn1 {name = "1 gun"; value = 1;}; // Listbox item
					class spawn2 {name = "2 guns"; value = 2;};
					class spawn3 {name = "3 guns"; value = 3;};
					class spawn4 {name = "4 guns"; value = 4;};
					class spawn5 {name = "5 guns"; value = 5;};
				};
			};
			// class Name: Edit
			// {
			// 	displayName = "Name";
			// 	tooltip = "Name of the nuclear device";
			// 	// Default text filled in the input box
			// 	// Because it is an expression, to return a String one must have a string within a string
			// 	defaultValue = """Tsar Bomba""";
			// };
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "Spawn static weapons inside X buildings within 100m to aid in defense.<br/>Positions will be marked on the map with semi-transparent orange dots."; // Short description, will be formatted as structured text
			sync[] = {}; // Array of synced entities (can contain base classes)

			// class LocationArea_F
			// {
			// 	description[] = { // Multi-line descriptions are supported
			// 		"First line",
			// 		"Second line"
			// 	};
			// 	position = 1; // Position is taken into effect
			// 	direction = 1; // Direction is taken into effect
			// 	optional = 1; // Synced entity is optional
			// 	duplicate = 1; // Multiple entities of this type can be synced
			// 	synced[] = {"AnyStaticObject"}; // Pre-define entities like "AnyBrain" can be used. See the list below
			// };
		};
	};


	class fnf_ModuleArtilleryBarrage: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Add ambient artillery"; // Name displayed in the menu
		icon = "\A3\ui_f\data\map\markers\nato\n_art.paa"; // Map icon. Delete this entry to use the default icon
		category = "fnf_eden";

		// Name of function triggered once conditions are met
		function = "fnf_eden_fnc_artilleryBarrage";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 0;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 0;
		// 1 if modules is to be disabled once it is activated (i.e., repeated trigger activation won't work)
		isDisposable = 1;
		// 1 to run init function in Eden Editor as well
		is3DEN = 0;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		// curatorInfoType = "RscDisplayAttributeModuleNuke";

		// Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
		class Attributes: AttributesBase
		{
			// Arguments shared by specific module type (have to be mentioned in order to be present)
			// class Units: Units
			// {
			// 	property = "myTag_ModuleNuke_Units";
			// };
			// Module specific arguments
			// class Markers: Edit
			// {
			// 	control = "Edit";
			// 	property = "fnf_ModuleArtilleryBarrage_Markers";
			// 	displayName = "Target Markers";
			// 	tooltip = "Array of markers to spawn artillery on (randomized)";
			// 	// Default text filled in the input box
			// 	// Because it is an expression, to return a String one must have a string within a string
			// 	defaultValue = "'[""artilleryMark_1"",""artilleryMark_2""]'";
			// };
			class StartDelay: Edit
			{
				control = "Edit";
				property = "fnf_ModuleArtilleryBarrage_StartDelay";
				displayName = "Delay to start (s)";
				tooltip = "How many seconds after mission init to begin barrage";
				// Default text filled in the input box
				// Because it is an expression, to return a String one must have a string within a string
				defaultValue = "'300'";
			};
			class Duration: Edit
			{
				control = "Edit";
				property = "fnf_ModuleArtilleryBarrage_duration";
				displayName = "Duration of barrage (s)";
				tooltip = "How many seconds after mission init to begin barrage";
				// Default text filled in the input box
				// Because it is an expression, to return a String one must have a string within a string
				defaultValue = "'300'";
			};
			class Interval: Edit
			{
				control = "Edit";
				property = "fnf_ModuleArtilleryBarrage_interval";
				displayName = "Round interval (s)";
				tooltip = "This value determines how frequently rounds will land (0 to this seconds)";
				// Default text filled in the input box
				// Because it is an expression, to return a String one must have a string within a string
				defaultValue = "'10'";
			};
			class ShellType: Combo
			{
				control = "Combo";
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "fnf_ModuleArtilleryBarrage_shellType";
				displayName = "Type of shell"; // Argument label
				tooltip = "What rounds will be used"; // Tooltip description
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "'Sh_155mm_AMOS'"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
				class Values
				{
					class 82mm {name = "82mm Mortar"; value = "Sh_82mm_AMOS";}; // Listbox item
					class 155mm {name = "155mm Howitzer"; value = "Sh_155mm_AMOS";};
				};
			};
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "Spawn an artillery barrage X seconds after mission start.<br/>Create one or more triggers, then Sync this module to them to define the areas in which shells from this module will fall."; // Short description, will be formatted as structured text
			sync[] = {"EmptyDetector"}; // Array of synced entities (can contain base classes)

			// class LocationArea_F
			// {
			// 	description[] = { // Multi-line descriptions are supported
			// 		"First line",
			// 		"Second line"
			// 	};
			// 	position = 1; // Position is taken into effect
			// 	direction = 1; // Direction is taken into effect
			// 	optional = 1; // Synced entity is optional
			// 	duplicate = 1; // Multiple entities of this type can be synced
			// 	synced[] = {"AnyStaticObject"}; // Pre-define entities like "AnyBrain" can be used. See the list below
			// };
		};
	};
};