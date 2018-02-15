pragma solidity ^0.4.19;

import "./ProxyInterface.sol";

contract Proxy is ProxyInterface {

    function forward(address destination, bytes data) internal {
        assembly {
            let len := 4096
            let result := delegatecall(sub(gas, 10000), destination, add(data, 0x20), mload(data), 0, len)
            switch result case 0 { invalid() }
            return (0, len)
        }
    }
}
