pragma solidity ^0.6.6;
//SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
//learn more: https://docs.openzeppelin.com/contracts/3.x/erc721

import "./Data.sol";
import "./RandomNumber.sol";
// GET LISTED ON OPENSEA: https://testnets.opensea.io/get-listed/step-two

contract YourCollectible is ERC721, Ownable ,RandomNumber {

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  constructor() public ERC721("Petals", "PEL") {
    // RELEASE THE LOOGIES!
  }

  mapping (uint256 => uint256) public color;

   uint256 mintDeadline = block.timestamp + 24 hours;

  function mintItem()
      public
      returns (uint256)
  {
      require( block.timestamp < mintDeadline, "DONE MINTING");
      _tokenIds.increment();

      uint256 id = _tokenIds.current();
      _mint(msg.sender, id);

      bytes32 rr = getRandomNumber();
      fulfillRandomness(rr, 5364);

      uint256 finalResult = RandomNumber.randomResult;
      color[id] = finalResult;
      return id;
  }

  function tokenURI(uint256 id) public view override returns (string memory) {
      require(_exists(id), "not exist");
      return Data.tokenURI( ownerOf(id), id, color[id]);
  }
}




























// // SPDX-License-Identifier: MIT
// pragma solidity ^0.7.6;

// import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
// import '@openzeppelin/contracts/utils/Counters.sol';
// import '@openzeppelin/contracts/math/SafeMath.sol';

// abstract contract NFT is ERC721 {
//     using SafeMath for uint256;
//     using Counters for Counters.Counter;

//     Counters.Counter private _tokenIdTracker;

//     mapping(uint256 => uint256) public stakedBlockNumber;

//     constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
//         _setBaseURI('');
//     }

//     function _safeMint(address to, bytes memory data) internal virtual {
//         uint256 currentId = _tokenIdTracker.current();
//         super._safeMint(to, currentId, data);
//         stakedBlockNumber[currentId] = block.number;
//         _tokenIdTracker.increment();
//     }

//     function _burn(uint256 tokenId) internal virtual override {
//         super._burn(tokenId);
//         delete stakedBlockNumber[tokenId];
//     }

//     function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
//         require(_exists(tokenId), 'NFT: URI query for nonexistent token');
//         return _tokenURI(tokenId);
//     }

//     function mint() public virtual;

//     function burn(uint256 tokenId) public virtual;

//     function _tokenURI(uint256 tokenId) internal view virtual returns (string memory);
// }