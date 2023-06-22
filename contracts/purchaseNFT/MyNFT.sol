// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract MyNFT is ERC721, ERC721URIStorage {
    using Counters for Counters.Counter;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    Counters.Counter private _tokenIdCounter;
    mapping(address => bool) public role;
    uint public star;

    address internal purchase;

    modifier access(address roleAble) {
        require(role[roleAble] == true, "sender haven't access");
        _;
    }
    
    constructor(uint _star) ERC721("MyNFT", "MNFT") {
        role[msg.sender] = true;
        setStar(_star);
    }

    function setStar(uint _star) public access(msg.sender) {
        require(_star <= 5 && _star > 0, "star between 1 to 5");
        star = _star;
    }

    function getStar() view external returns(uint) {
        return star;
    }


    function setAddressPurchase(address _purchase) external access(msg.sender){
        purchase = _purchase;
        role[purchase] = true;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://";
    }

    function safeMint(address to, string calldata uri) external access(msg.sender) {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
