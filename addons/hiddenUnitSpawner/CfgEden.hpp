
class Cfg3DEN
{
    class Group
    {
        class AttributeCategories
        {
            class MAI_Attributes
            {
                displayName = "MAI";
                collapsed  = 0;

                class Attributes
                {
                    class MAI_AIgroupEnableAi
                    {
                        //--- Mandatory properties
                        displayName = "$STR_MAI_AIgroupEnableAi";
                        tooltip = "$STR_MAI_AIgroupEnableAiTip";
                        property = QGVAR(tickets);
                        control = "Checkbox";
                        expression = "_this setVariable ['%s',_value];";
                        defaultValue = "true";
                        condition = "objectBrain"; // https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Condition
                        typeName = "BOOL";
                    };
                };
            };
        };
    };
};

  			{
				displayName = "$STR_MAI_sphereDespawnDistance";
				tooltip = "$STR_MAI_sphereDespawnDistanceShort";
				defaultValue = "50";
				property = QGVAR(sphereDespawnDistance);
				expression = "_this setVariable ['%s',_value];";
				typeName = "NUMBER";
				control = "EditShort";
			};