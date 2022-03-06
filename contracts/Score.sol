//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "hardhat/console.sol";

contract Score {
    using SafeMath for uint256;
    // immutable ,constant.   不可修改，  constant 编译时确定。  immutable部署时确定
    address internal immutable teacher;
    /**
     * 记账本
     */
    mapping(address => uint256) public scores;

    constructor() {
        teacher = msg.sender;
    }

    // 登记分数
    function setScore(address _addr, uint256 _score)
        external
        scoreLimit(_score)
        onlyTeacher
    {
        scores[_addr] = _score;
    }

    // 加分
    function scoreAdd(address _addr, uint256 _score)
        external
        scoreLimit(_score)
        onlyTeacher
    {
        scores[_addr] = scores[_addr].add(_score);
    }

    // 减分
    function scoreSub(address _addr, uint256 _score)
        external
        scoreLimit(_score)
        onlyTeacher
    {
        scores[_addr] = scores[_addr].sub(_score);
    }

    // 查分
    function getScore(address _addr) external view returns (uint256) {
        return scores[_addr];
    }

    // 分数不能 > 100 , 小于 0
    modifier scoreLimit(uint256 _score) {
        require(_score > 0, "must > 100");
        require(_score <= 100, "can't > 100");
        _;
    }

    // 只能老师修改分数
    modifier onlyTeacher() {
        require(teacher == msg.sender, "onlyTeacher");
        _;
    }
}
