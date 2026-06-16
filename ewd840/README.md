# EWD840
The EWD840 Termination Detection Algorithm case, used in Section 6 (EWD840 Termination Detection Algorithm)

## Contents
- **EWD840.tla**, **SyncTerminationDetection.tla** - original unmodified specification (source below)
- **RPEWD840.tla** - contains the rewritten ENABLED predicates, WF, and Liveness properties tested. Run TLC on this file to reproduce our bi-implication results, or Apalache to verify that it accepts the rewritten liveness property
- **RPEWD840.cfg** - TLC configuration file for running our modifications
- **APRPEWD840.cfg** - Apalache configuration file for running our modifications
- **LICENSE** - The MIT License under which the original specification was licensed (Copyright (c) 2016: The TLA+ project and other contributors: https://github.com/tlaplus/Examples/graphs/contributors)

## Model Checking
**TLC**: Run TLC on RPEWD840.tla. We ran TLC via [the VS Code extension](https://marketplace.visualstudio.com/items?itemName=tlaplus.vscode-ide) (version 2026.5.181751), with default parameters (-workers 1 -coverage 1)

**Apalache**: Run the following terminal command from within this directory:
```
apalache-mc check --config=APRPEWD840.cfg --length=5 RPEWD840.tla
```

## Original Specification Source
The original specification was copied from the [TLA+ Examples GitHub repository](https://github.com/tlaplus/Examples), specifically [this folder](https://github.com/tlaplus/Examples/tree/master/specifications/ewd840).
That repository was licensed under the MIT license, thus we have included their LICENSE file. Stephan Merz is mentioned as an author of this specification.