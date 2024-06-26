class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};
class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};
class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_init_EventHandlers {
    class CAManBase {
        class MAI_hidden_Unit_EH_init {
            init = QUOTE(call FUNC(EHinit));
        };
    };
    class AllVehicles {
        class add_EHfiredExplosives {
            exclude[] = {"Man"};
            init = QUOTE(call FUNC(EHfiredExplosives));
        };
    };
};

class Extended_Killed_EventHandlers {
    class CAManBase {
        class MAI_hidden_Unit_EH_killed {
            killed = QUOTE(call FUNC(EHkilled));
        };
    };
};