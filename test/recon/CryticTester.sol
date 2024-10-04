
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.25;

import {StatefullFuzzFunctions} from "./StatefullFuzzFunctions.sol";
import {CryticAsserts} from "@chimera/CryticAsserts.sol";

// echidna . --contract CryticTester --config echidna.yaml
// medusa fuzz
contract CryticTester is StatefullFuzzFunctions, CryticAsserts {
    constructor() payable {
        setup();
    }
}
