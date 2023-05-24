// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts@4.8.2/token/ERC20/IERC20.sol";

/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * The default value of {decimals} is 18. To change this, you should override
 * this function so it returns a different value.
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract presale {

    uint private _amount;
    uint private _start;
    uint private _end; 
    address private _admin;
    uint private _totalSupply;
    address private USDT;
    address private BYD;
    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(address _USDT, address _BYD) {
        _amount = 10000;
        _start = 0;
        _end = 0;
        _admin = msg.sender;
        USDT = _USDT;
        BYD = _BYD;
        _totalSupply = 0;
    }
    modifier onlyAdmin() {
        require (msg.sender != _admin);
        _;      
    }
    function start() external  onlyAdmin{
            _start = block.timestamp;
            _end = _start + 5*3600;
    }
    function sale() external  {
        if(_start < block.timestamp && block.timestamp < _end && _amount < 10*10**8) {
            IERC20(USDT).transferFrom(msg.sender,_admin, 10*10**8);
            IERC20(BYD).transfer(msg.sender, 10*10**8);
            _totalSupply += 10*10**8;
            _amount -= 10*10**8;
        }           
    }
    function widthdraw() external  {
        if(_end < block.timestamp) {
            IERC20(USDT).transfer(_admin,_totalSupply);
        }
    }

    /**
     * @dev Returns the name of the token.
     */
}
