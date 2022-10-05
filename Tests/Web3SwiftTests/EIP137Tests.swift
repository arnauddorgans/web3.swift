// 
// 

import XCTest
@testable import Web3Swift

final class EIP137Tests: XCTestCase {
    private var eip137: EIP137Impl!
    
    override func setUpWithError() throws {
        eip137 = .init()
    }
    
    func testNamehash() throws {
        XCTAssertEqual(
            eip137.namehash("").toHexString(),
            "0000000000000000000000000000000000000000000000000000000000000000"
        )
        XCTAssertEqual(
            eip137.namehash("eth").toHexString(),
            "93cdeb708b7545dc668eb9280176169d1c33cfd8ed6f04690a0bcc88a93fc4ae"
        )
        XCTAssertEqual(
            eip137.namehash("foo.eth").toHexString(),
            "de9b09fd7c5f901e23a3f19fecc54828e9c848539801e86591bd9801b019f84f"
        )
    }
}
