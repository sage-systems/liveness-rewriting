# Traffic Light
The Traffic Light case, used in Section 5 (Traffic Light) and as an example in Section 2.1 (Background - Model Checking in TLA+)

## Contents
- **TrafficLight.tla** - original unmodified specification (source below)
- **RPTrafficLight.tla** - contains the rewritten ENABLED predicates, WF, and Liveness properties tested. Run TLC on this file to reproduce our bi-implication results, or Apalache to verify that it accepts the rewritten liveness property
- **RPTrafficLight.cfg** - TLC configuration file for running our modifications
- **APRPTrafficLight.cfg** - Apalache configuration file for running our modifications
- **LICENSE** - The Apache License 2.0 under which the original specification was licensed (copyright held by the contributors)
- **NOTICE** - The Apache License 2.0 NOTICE file for the original specification

## Model Checking
**TLC**: Run TLC on RPTrafficLight.tla. We ran TLC via [the VS Code extension](https://marketplace.visualstudio.com/items?itemName=tlaplus.vscode-ide) (version 2026.5.181751), with default parameters (-workers 1 -coverage 1)

**Apalache**: Run the following terminal command from within this directory:
```
apalache-mc check --config=APRPTrafficLight.cfg --length=5 RPTrafficLight.tla
```

## Original Specification Source
TrafficLight.tla was copied from the [Apalache GitHub repository](https://github.com/apalache-mc/apalache), specifically [this file](https://github.com/apalache-mc/apalache/blob/main/docs/src/tutorials/TrafficLight.tla).
That repository was licensed under the Apache 2.0 license, thus we have included their LICENSE and NOTICE files.