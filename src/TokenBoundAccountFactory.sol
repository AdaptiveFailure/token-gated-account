// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

// Utils
import "@thirdweb-dev/contracts/smart-wallet/utils/BaseAccountFactory.sol";

// Smart wallet implementation
import {TokenBoundAccount} from "./TokenBoundAccount.sol";

contract TokenBoundAccountFactory is BaseAccountFactory {
    /// @notice Emitted when a new Token Bound Account is created.
    event TokenBoundAccountCreated(address indexed account, bytes indexed data);

    /*///////////////////////////////////////////////////////////////
                            Constructor
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Executes once when a contract is created to initialize state variables
     *
     * @param _entrypoint - 0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789
     */
    constructor(
        IEntryPoint _entrypoint
    )
        BaseAccountFactory(
            address(new TokenBoundAccount(_entrypoint, address(this)))
        )
    {}

    /*///////////////////////////////////////////////////////////////
                            Internal functions
    //////////////////////////////////////////////////////////////*/

    /// @notice Generates a salt for the new Account using the erc-721 token data.
    function _generateSalt(
        address,
        bytes calldata _data
    ) internal view virtual override returns (bytes32) {
        return keccak256(abi.encode(_data));
    }

    /// @notice Deploys a new Account for admin.
    function _initializeAccount(
        address _account,
        address _admin,
        bytes calldata _data
    ) internal override {
        TokenBoundAccount(payable(_account)).initialize(_admin, _data);
        emit TokenBoundAccountCreated(_account, _data);
    }
}
