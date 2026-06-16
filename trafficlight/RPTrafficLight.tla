------------------------------ MODULE RPTrafficLight ------------------------------
\* This section was copied from the original TrafficLight.tla file
VARIABLES 
    \* If true, the traffic light is green. If false, it is red.
    \* @type: Bool;
    isGreen,

    \* If true, the button has been pushed to request the light to become green, but the light has
    \* not become green since then.
    \* If false, the light has become green since the button has last been pushed
    \* or the button has never been pushed.
    \* @type: Bool;
    requestedGreen
\* End copied section

INSTANCE TrafficLight

\* ENABLED rewriting

ManualEnabled == ~isGreen /\ requestedGreen /\ vars # <<TRUE, FALSE>>

ManualEnabledNoNonStutter == ~isGreen /\ requestedGreen

BiImpliEnabled ==
    ENABLED <<SwitchToGreen>>_vars <=> ManualEnabled

BiImpliEnabledNoNonStutter ==
    ENABLED <<SwitchToGreen>>_vars <=> ManualEnabledNoNonStutter

\* WF and Liveness Rewriting

ManualWFFormula(enabled, action, variables) ==
    <>[](enabled) => []<><<action>>_variables

ManualWF == ManualWFFormula(ManualEnabled, SwitchToGreen, vars)

LivenessWithAutoWF ==
    WF_vars(SwitchToGreen) => RequestWillBeFulfilled

LivenessWithManualWF ==
    ManualWF => RequestWillBeFulfilled

\* Full, expanded version
Liveness == (<>[](ManualEnabled) => []<><<SwitchToGreen>>_vars)
                => RequestWillBeFulfilled

BiImpliWF ==
    /\ WF_vars(SwitchToGreen) => ManualWF
    /\ ManualWF => WF_vars(SwitchToGreen)

BiImpliLiveness ==
    /\ LivenessWithManualWF => LivenessWithAutoWF
    /\ LivenessWithAutoWF => LivenessWithManualWF

======