//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./Score.sol";

interface IScore {
    function setScore(address _addr, uint256 _score) external;

    function scoreAdd(address _addr, uint256 _score) external;

    function scoreSub(address _addr, uint256 _score) external;
}

contract Teacher {
    address public scoreAddress;

    function createScoreBook() external {
        scoreAddress = address(new Score());
    }

    //  设置学生分数
    function setStudentScore(address _student, uint256 _score) external {
        IScore(scoreAddress).setScore(_student, _score);
    }
}
