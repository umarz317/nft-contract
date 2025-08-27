import "forge-std/Test.sol";
import "../src/SimpleNFT.sol";

contract SimpleNFTTest is Test {
    SimpleNFT public nft;
    address user1 = address(0x1);
    address user2 = address(0x2);

    function setUp() public {
        nft = new SimpleNFT();
    }

    function testMint() public{
        uint256 tokenId = nft.mint(user1);
        assertEq(tokenId,0);
        assertEq(nft.ownerOf(tokenId),user1);
        assertEq(nft.balanceOf(user1),1);
    }

    function testTransfer() public{
        uint256 tokenId = nft.mint(user1);
        vm.prank(user1);
        nft.transferFrom(user1, user2, tokenId);
        assertEq(nft.ownerOf(tokenId),user2);
    }

    function testApproval() public{
        uint256 tokenId = nft.mint(user1);
        vm.prank(user1);
        nft.approve(user2,tokenId);
        assertEq(nft.getApproved(tokenId),user2);
    }

    function testTransferFail() public{
        uint256 tokenId = nft.mint(user1);
        vm.prank(user2);
        nft.transferFrom(user1, user2, tokenId);
    }
}
