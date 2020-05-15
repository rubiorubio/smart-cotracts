pragma solidity ^0.6.1;

library SafeMath{
    function add(uint256 _a,uint256 _b) internal pure returns(uint256) {
        uint256 _c = _a +_b;
        require(_c>=_a, "SafeMath: addition overflow");
        return _c;
    }
    function sub(uint256 _a, uint256 _b) internal pure returns(uint256) {
        require(_a>= _b, "SafeMath: subtraction overflow");
        uint256 _c = _a - _b;
        return _c;
    }
    function mul(uint256 _a,uint256 _b ) internal pure returns (uint256) {
        if (_a == 0) {
            return 0;
        }
        uint256 _c = _a * _b;
        require(_c / _a == _b, "SafeMath: multiplication overflow");
        return _c;
    }
    function div(uint256 _a,uint256 _b) internal pure returns(uint256) {
        // Solidity onlyautomatically assserts when dividing by 0
        require(_b > 0, "SafeMath: division by zero");
        uint256 _c = _a/_b;
        // assert(a == b * c + a % b ); // There is no case in wich this does not hold
        return _c;
    }
    function mod(uint256 _a, uint256 _b) internal pure returns(uint256) {
        require(_b != 0, "SafeMath: modulo by zero");
        return _a % _b;
    }
}