# bcastFolklore
The Folklore Reliable Broadcast Algorithm case, used in Section 7 (Folklore Reliable Broadcast Algorithm)

## Contents
- **bcastFolklore.tla** - original unmodified specification (source below)
- **RPbcastFolklore.tla** - contains the rewritten ENABLED predicates, WF, and Liveness properties tested. Run TLC on this file to reproduce our bi-implication results, or Apalache to verify that it accepts the rewritten liveness property. Contains incorrect versions of rewrites at the bottom.
- **RPbcastFolklore.cfg** - TLC configuration file for running our modifications. Contains commented out incorrect properties.
- **APRPbcastFolklore.cfg** - Apalache configuration file for running our modifications
- **LICENSE** - The MIT License under which the original specification was licensed (Copyright (c) 2016: The TLA+ project and other contributors: https://github.com/tlaplus/Examples/graphs/contributors)

## Model Checking
**TLC**: Run TLC on RPbcastFolklore.tla. We ran TLC via [the VS Code extension](https://marketplace.visualstudio.com/items?itemName=tlaplus.vscode-ide) (version 2026.5.181751), with default parameters (-workers 1 -coverage 1)

**Apalache**: Run the following terminal command from within this directory:
```
apalache-mc check --config=APRPbcastFolklore.cfg --length=5 RPbcastFolklore.tla
```

## Original Specification Source
The original specification was copied from the [TLA+ Examples GitHub repository](https://github.com/tlaplus/Examples), specifically [this folder](https://github.com/tlaplus/Examples/tree/master/specifications/bcastFolklore).
That repository was licensed under the MIT license, thus we have included their LICENSE file. Thanh Hai Tran, Igor Konnov, and Josef Widderis are mentioned as the authors of this specification.