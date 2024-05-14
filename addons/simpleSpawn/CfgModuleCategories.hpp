class CfgFactionClasses
{
	class NO_CATEGORY;
	class mai_Modules: NO_CATEGORY
	{
		displayName = "Armaforces - mai";
		//side = 7;
	};
};

class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit; // Default edit box (i.e., text input field)
			class Combo; // Default combo box (i.e., drop-down menu)
			class Checkbox; // Default checkbox (returned value is Bool)
			class CheckboxNumber; // Default checkbox (returned value is Number)
			class ModuleDescription; // Module description
			class Units; // Selection of units on which the module is applied
		};
		// Description base classes, for more information see below
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
	class GVAR(Module): Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Simple Spawn"; // Name displayed in the menu
		category = "mai_Modules";

		// Name of function triggered once conditions are met
		function = QFUNC(initCall);
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 0;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 0;
		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isDisposable = 1;
		// // 1 to run init function in Eden Editor as well
		is3DEN = 1;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		//curatorInfoType = "RscDisplayAttributeModuleNuke";

		// Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
		class Attributes: AttributesBase
		{
			// Arguments shared by specific module type (have to be mentioned in order to be present)
			class GVAR(activationDistance): Default
  			{
				displayName = "$STR_mai_activationDistance";
				tooltip = "$STR_mai_activationDistanceShort";
				defaultValue = "750";
				property = "activation";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class GVAR(deactivation): Default
  			{
				displayName = "$STR_mai_deactivation";
				tooltip = "$STR_mai_deactivationShort";
				defaultValue = "-1";
				property = "deactivation";
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class GVAR(includeAir): Checkbox
            {
                displayName = "$STR_mai_includeAir";
                tooltip = "$STR_mai_includeAirShort";
                property = "includeAir";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
			class GVAR(interval): Default
  			{
				displayName = "$STR_mai_interval";
				tooltip = "$STR_mai_intervalShort";
				defaultValue = "0.1";
				property = "interval";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class GVAR(unitsPerInterval): Default
  			{
				displayName = "$STR_mai_unitsPerInterval";
				tooltip = "$STR_mai_unitsPerIntervalShort";
				defaultValue = "1";
				property = "unitsPerInterval";
				expression = "_this setVariable ['%s',_value max 0];";
				typeName = "NUMBER";
				control = "EditShort";
			};
			class GVAR(deleteVehicles): Checkbox
            {
                displayName = "$STR_mai_deleteVehicles";
                tooltip = "$STR_mai_deleteVehiclesShort";
                property = "deleteVehicles";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
			class GVAR(checkBuildings): Checkbox
            {
                displayName = "$STR_mai_checkBuildings";
                tooltip = "$STR_mai_checkBuildingsShort";
                property = "checkBuildings";
                defaultValue = "true";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
            class GVAR(activateCondition)
            {
                displayName = "$STR_mai_activateCondition";
                tooltip = "$STR_mai_activateConditionShort";
                property = "activateCondition";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "'true'";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
			class GVAR(deleteTrigger): Checkbox
            {
                displayName = "$STR_mai_deleteTrigger";
                tooltip = "$STR_mai_deleteTriggerShort";
                property = "deleteTrigger";
                defaultValue = "false";
				expression = "_this setVariable ['%s', _value];";
                typeName = "BOOL";
            };
            class executionCodeUnit
            {
                displayName = "$STR_mai_executionCodeUnit";
                tooltip = "$STR_mai_executionCodeUnitShort";
                property = "executionCodeUnit";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
            class executionCodePatrol
            {
                displayName = "$STR_mai_executionCodePatrol";
                tooltip = "$STR_mai_executionCodePatrolShort";
                property = "executionCodePatrol";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
            class executionCodeVehicle
            {
                displayName = "$STR_mai_executionCodeVehicle";
                tooltip = "$STR_mai_executionCodeVehicleShort";
                property = "executionCodeVehicle";
                control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',compile _value];";
                defaultValue = "''";
                value = 0;
                validate = "none";
                wikiType = "[[String]]";
            };
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "Simple spawn for AI. AI will be only spawned when AI will be closer than set distance. Only one unit from group need to be synchronized. Supports vehicles – Vehicle will stay, but crew will be spawned. Synchronize vehicle or unit."; // Short description, will be formatted as structured text
			sync[] = {"LocationArea_F"}; // Array of synced entities (can contain base classes)

			class LocationArea_F
			{
				description[] = { // Multi-line descriptions are supported
					"First line",
					"Second line"
				};
				position = 1; // Position is taken into effect
				direction = 0; // Direction is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 0; // Multiple entities of this type can be synced
				synced[] = {"AnyBrain"}; // Pre-define entities like "AnyBrain" can be used. See the list below
			};
		};
	};
};
