------------------------------ MODULE RPbcastFolklore ------------------------------
\* This section was copied from the original APbcastFolklore.tla file from the repository
(* Apalache type annotations for bcastFolklore.tla, applied via INSTANCE
   so the original spec remains free of tool-specific idiosyncrasies. *)

EXTENDS Naturals

CONSTANTS
  \* @type: Int;
  N,
  \* @type: Int;
  T,
  \* @type: Int;
  F

VARIABLES
  \* @type: Set(Int);
  Corr,
  \* @type: Int;
  nCrashed,
  \* @type: Int -> Str;
  pc,
  \* @type: Int -> Set(<<Int, Str>>);
  rcvd,
  \* @type: Set(<<Int, Str>>);
  sent

\* End copied section

INSTANCE bcastFolklore 

Action == \E self \in Corr: /\ Receive(self)
                            /\  \/ UponV1(self)                                             
                                \/ UponAccept(self)
                                \/ UNCHANGED << pc, sent, nCrashed, Corr >>

\* ENABLED Rewriting

ManualEnabledGuardOnly == \E self \in Corr:  
    /\  /\ pc[self] # "CR"
        /\ \E msgs \in SUBSET (Proc \times M):
                /\ msgs \subseteq sent
                /\ rcvd[self] \subseteq msgs
    /\  \/ pc[self] = "V1"                                              
        \/ (pc[self] = "V0" \/ pc[self] = "V1")   
        \/ TRUE              

ManualEnabledNested ==
    \E self \in Corr:
        /\ pc[self] # "CR"
        /\ \E msgs \in SUBSET (Proc \times M):
            /\ msgs \subseteq sent
            /\ rcvd[self] \subseteq msgs
            /\  \/  /\  pc[self] = "V1"
                    /\  vars # << [pc EXCEPT ![self] = "AC"] , [rcvd EXCEPT ![self] = msgs ], sent \cup { <<self, "ECHO">> }, nCrashed, Corr >>
                \/  /\  (pc[self] = "V0" \/ pc[self] = "V1")
                    /\  [rcvd EXCEPT ![self] = msgs ][self] # {}
                    /\ vars # << [pc EXCEPT ![self] = "AC"] , [rcvd EXCEPT ![self] = msgs ], sent \cup { <<self, "ECHO">> }, nCrashed, Corr >>
                \/ vars # << pc, [rcvd EXCEPT ![self] = msgs ], sent, nCrashed, Corr >>

BiImpliEnabledNested == 
    ENABLED <<Action>>_vars <=> ManualEnabledNested

\* WF and Liveness Rewriting

ManualWFFormula(enabled, action, variables) ==
    <>[](enabled) => []<><<action>>_variables

Liveness == UnforgLtl /\ Unforg /\ CorrLtl /\ RelayLtl

ManualWF == ManualWFFormula(ManualEnabledNested, Action, vars)

LivenessWithManualWF == ManualWF => Liveness

LivenessWithAutoWF == WF_vars(Action) => Liveness

BiImpliSystemWF ==
    /\ WF_vars(Action) => ManualWF
    /\ ManualWF => WF_vars(Action)

BiImpliLiveness == 
    /\ LivenessWithAutoWF => LivenessWithManualWF
    /\ LivenessWithManualWF => LivenessWithAutoWF

\* Incorrect rewrites and properties that will fail if you model check them
ManualEnabledNoNonStutter ==
    \E self \in Corr:
        /\ pc[self] # "CR"
        /\ \E msgs \in SUBSET (Proc \times M):
            /\ msgs \subseteq sent
            /\ rcvd[self] \subseteq msgs
            /\  \/  /\  pc[self] = "V1"
                    \* /\  vars # << [pc EXCEPT ![self] = "AC"] , [rcvd EXCEPT ![self] = msgs ], sent \cup { <<self, "ECHO">> }, nCrashed, Corr >>
                \/  /\  (pc[self] = "V0" \/ pc[self] = "V1")
                    /\  [rcvd EXCEPT ![self] = msgs ][self] # {}
                    \* /\ vars # << [pc EXCEPT ![self] = "AC"] , [rcvd EXCEPT ![self] = msgs ], sent \cup { <<self, "ECHO">> }, nCrashed, Corr >>
                \* \/ vars # << pc, [rcvd EXCEPT ![self] = msgs ], sent, nCrashed, Corr >>
                \/ TRUE

ManualEnabledNoPrimedGuard ==
    \E self \in Corr:
        /\ pc[self] # "CR"
        /\ \E msgs \in SUBSET (Proc \times M):
            /\ msgs \subseteq sent
            /\ rcvd[self] \subseteq msgs
            /\  \/  /\  pc[self] = "V1"
                    /\  vars # << [pc EXCEPT ![self] = "AC"] , [rcvd EXCEPT ![self] = msgs ], sent \cup { <<self, "ECHO">> }, nCrashed, Corr >>
                \/  /\  (pc[self] = "V0" \/ pc[self] = "V1")
                    \* /\  [rcvd EXCEPT ![self] = msgs ][self] # {}
                    /\ vars # << [pc EXCEPT ![self] = "AC"] , [rcvd EXCEPT ![self] = msgs ], sent \cup { <<self, "ECHO">> }, nCrashed, Corr >>
                \/ vars # << pc, [rcvd EXCEPT ![self] = msgs ], sent, nCrashed, Corr >>

BiImpliEnabledNoNonStutter == 
    ENABLED <<Action>>_vars <=> ManualEnabledNoNonStutter

BiImpliEnabledNoPrimedGuard == 
    ENABLED <<Action>>_vars <=> ManualEnabledNoPrimedGuard

=============================================================================
