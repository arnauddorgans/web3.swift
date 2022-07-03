// 
// 

import XCTest
@testable import Web3Swift

final class SECP256K1Tests: XCTestCase {
  var secp256k1: SECP256K1!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    secp256k1 = SECP256K1Impl()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  /// - seealso: https://betterprogramming.pub/understanding-ethereum-cryptography-3ef7429eddce
  func testPublicKeyAndAddress() throws {
    let privateKeyBytes = [UInt8](hex: "227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b")
    let privateKey = try secp256k1.createPrivateKey(bytes: privateKeyBytes)
    let address = try secp256k1.address(publicKey: privateKey.publicKey)
    XCTAssertEqual("e16c1623c1aa7d919cd2241d8b36d9e79c1be2a2", address.toHexString())
  }
}
