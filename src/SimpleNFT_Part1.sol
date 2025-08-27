// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/utils/Strings.sol";

contract SimpleNFT_Part1 {
    using Strings for uint256;

    string public name = "SimpleNFT";
    string public symbol = "SNFT";

    string private _baseTokenURI =
        "ipfs://bafybeifztalyymbpucrr2xga6avd4seziqpasq4a4or6urpcxobyog2qfi/";

    uint256 public totalSupply;

    uint256 public price = 0.025 ether;

    mapping(address => uint256) private _balances;

    mapping(uint256 => address) private _owners;

    mapping(uint256 => address) private _tokenApprovals;

    mapping(address => mapping(address => bool)) private _operatorApprovals;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );

    event Approval(
        address indexed _owner,
        address indexed _approved,
        uint256 indexed _tokenId
    );

    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approval
    );

    function mint(address _to) external payable returns (uint256) {
        require(msg.value==price,"Invalid amount sent!");
        uint256 tokenId = totalSupply++;
        _balances[_to] += 1;
        _owners[tokenId] = _to;
        emit Transfer(address(0), _to, tokenId);
        return tokenId;
    }

    function balanceOf(address _owner) external view returns (uint256) {
        return _balances[_owner];
    }

    // returns the address that owns the _tokenId
    function ownerOf(uint256 _tokenId) external view returns (address) {
        return _owners[_tokenId];
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external {
        require(
            _isApprovedOrOwned(msg.sender, _tokenId),
            "Token id is not owned or approved"
        );
        require(_from != address(0), "Transfer from zero address");
        require(_to != address(0), "Transfer to zero address");
        require(
            _owners[_tokenId] == _from,
            "Transfer of token that is not owned by the user"
        );

        _tokenApprovals[_tokenId] = address(0); // clear the approval

        _balances[_from] -= 1;
        _balances[_to] += 1;
        _owners[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }
}
