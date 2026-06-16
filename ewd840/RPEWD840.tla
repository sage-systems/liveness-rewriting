------------------------------ MODULE RPEWD840 ------------------------------
\* This section was copied from the original APEWD840.tla file from the repository
(* Apalache type annotations for EWD840.tla, applied via INSTANCE so the
   original spec remains free of tool-specific idiosyncrasies. *)

EXTENDS Naturals

CONSTANT
  \* @type: Int;
  N

VARIABLES
  \* @type: Int -> Bool;
  active,
  \* @type: Int -> Str;
  color,
  \* @type: Int;
  tpos,
  \* @type: Str;
  tcolor

\* End copied section

INSTANCE EWD840

\* ENABLED rewriting

ManualEnabledInitiateProbe ==
  /\ tpos = 0
  /\ tcolor = "black" \/ color[0] = "black"
  /\ vars # <<active, [color EXCEPT ![0] = "white"], N-1, "white">>

ManualEnabledPassTokens ==
    \E i \in Node \ {0} :
        /\ tpos = i
        /\ ~ active[i] \/ color[i] = "black" \/ tcolor = "black"
        /\ vars # <<active, [color EXCEPT ![i] = "white"], i-1, IF color[i] = "black" THEN "black" ELSE tcolor>>

ManualEnabledSystem == ManualEnabledInitiateProbe \/ ManualEnabledPassTokens

ManualEnabledInitiateProbeNoNonStutter ==
  /\ tpos = 0
  /\ tcolor = "black" \/ color[0] = "black"

ManualEnabledPassTokensNoNonStutter ==
    \E i \in Node \ {0} :
        /\ tpos = i
        /\ ~ active[i] \/ color[i] = "black" \/ tcolor = "black"

ManualEnabledSystemNoNonStutter == ManualEnabledInitiateProbeNoNonStutter \/ ManualEnabledPassTokensNoNonStutter

BiImpliInitiateProbe ==
    ENABLED <<InitiateProbe>>_vars <=> ManualEnabledInitiateProbe

BiImpliPassTokens == 
    ENABLED <<\E i \in Node \ {0} : PassToken(i)>>_vars <=> ManualEnabledPassTokens

BiImpliSystem == 
    ENABLED <<System>>_vars <=> ManualEnabledSystem

BiImpliSystemNoNonStutter == 
    ENABLED <<System>>_vars <=> ManualEnabledSystemNoNonStutter

\* WF and Liveness Rewriting

ManualWFFormula(enabled, action, variables) ==
    <>[](enabled) => []<><<action>>_variables

ManualWFSystem == ManualWFFormula(ManualEnabledSystem, System, vars)

LivenessWithManualWF == ManualWFSystem => Liveness

LivenessWithAutoWF == WF_vars(System) => Liveness

BiImpliSystemWF ==
    /\ WF_vars(System) => ManualWFSystem
    /\ ManualWFSystem => WF_vars(System)

BiImpliLiveness == 
    /\ LivenessWithAutoWF => LivenessWithManualWF
    /\ LivenessWithManualWF => LivenessWithAutoWF

==============================================================================
