class Cfg3DEN
{
    class Object
    {
        class AttributeCategories
        {
            class MAI_HiddenUnit_Attributes
            {
                displayName = "MAI";
                collapsed  = 0;

                class Attributes
                {
                    class MAI_HiddenUnit_tickets
                    {
                        //--- Mandatory properties
                        displayName = "$STR_MAI_hiddenUnitTickets";
                        tooltip = "$STR_MAI_hiddenUnitTicketsTip";
                        property = QGVAR(tickets);
                        control = "EditShort";
                        expression = "_this setVariable ['%s',_value];";
                        defaultValue = "1";
                        condition = "objectBrain"; // https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Condition
                        typeName = "BOOL";
                    };
                };
            };
        };
    };
};