// 
// 

import XCTest
@testable import Web3Swift

final class BIP32Tests: XCTestCase {
  private var bip32: BIP32!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    bip32 = BIP32Impl()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testCompute() throws {
    //try bip32.compute(seed: .init(hex: "fffcf9f6f3f0edeae7e4e1dedbd8d5d2cfccc9c6c3c0bdbab7b4b1aeaba8a5a29f9c999693908d8a8784817e7b7875726f6c696663605d5a5754514e4b484542"))
  }
}
