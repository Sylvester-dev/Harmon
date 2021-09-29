pragma solidity >=0.6.0 <0.7.0;

import 'base64-sol/base64.sol';
import "@openzeppelin/contracts/utils/Strings.sol";
import './HexStrings.sol';
import './ToColor.sol';


library Data {

  using Strings for uint256;
  using HexStrings for uint160;
  using ToColor for bytes3;

  function generateSVGofTokenById(address owner, uint256 tokenId, bytes3 color) internal pure returns (string memory) {

    string memory svg = string(abi.encodePacked(

      '<svg width="114" height="106" viewBox="0 0 114 106" fill="none" xmlns="http://www.w3.org/2000/svg">',
          '<g id="g5117">',
          '<path id="path5113" d="M108.112 81.0692C87.4285 113.633 64.0019 79.3057 64.0019 79.3057C64.0019 79.3057 60.2789 120.575 25.9229 99.8389C-7.50775 79.6528 27.8497 59.3086 27.8497 59.3086C27.8497 59.3086 -13.6474 56.5388 5.50093 24.32C23.6042 -6.14428 49.6107 26.0835 49.6107 26.0835C49.6107 26.0835 50.3619 -14.4548 87.6897 5.54927C126.89 26.5527 85.7629 46.0806 85.7629 46.0806C85.7629 46.0806 129.339 47.6401 108.112 81.0692Z" fill="#',
          color.toColor(),
          '"/>',
          '<path id="path5123" d="M75.1669 48.4492C75.1669 53.2001 73.113 57.7565 69.4571 61.1159C65.8012 64.4753 60.8427 66.3626 55.6724 66.3626C50.5022 66.3626 45.5437 64.4753 41.8877 61.1159C38.2318 57.7565 36.1779 53.2001 36.1779 48.4492C36.1779 43.6982 38.2318 39.1419 41.8877 35.7825C45.5437 32.423 50.5022 30.5357 55.6724 30.5357C60.8427 30.5357 65.8012 32.423 69.4571 35.7825C73.113 39.1419 75.1669 43.6982 75.1669 48.4492Z" fill="#FEF708"/>',
          '</g>',
       '</svg>'
    ));

    return svg;
  }

  function tokenURI(address owner, uint256 tokenId, bytes3 color) internal pure returns (string memory) {

      string memory name = string(abi.encodePacked('Petal #',tokenId.toString()));
      string memory description = string(abi.encodePacked('This Petal is the color #',color.toColor(),'!!!'));
      string memory image = Base64.encode(bytes(generateSVGofTokenById(owner, tokenId, color)));

      return
          string(
              abi.encodePacked(
                'data:application/json;base64,',
                Base64.encode(
                    bytes(
                          abi.encodePacked(
                              '{"name":"',
                              name,
                              '", "description":"',
                              description,
                              '", "external_url":"https://burnyboys.com/token/',
                              tokenId.toString(),
                              '", "attributes": [{"trait_type": "color", "value": "#',
                              color.toColor(),
                              '"}',
                              '], "owner":"',
                              (uint160(owner)).toHexString(20),
                              '", "image": "',
                              'data:image/svg+xml;base64,',
                              image,
                              '"}'
                          )
                        )
                    )
              )
          );
  }

  function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
      if (_i == 0) {
          return "0";
      }
      uint j = _i;
      uint len;
      while (j != 0) {
          len++;
          j /= 10;
      }
      bytes memory bstr = new bytes(len);
      uint k = len;
      while (_i != 0) {
          k = k-1;
          uint8 temp = (48 + uint8(_i - _i / 10 * 10));
          bytes1 b1 = bytes1(temp);
          bstr[k] = b1;
          _i /= 10;
      }
      return string(bstr);
  }

}