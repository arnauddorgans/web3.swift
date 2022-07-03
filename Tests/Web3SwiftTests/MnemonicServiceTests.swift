// 
// 

import XCTest
@testable import Web3Swift

class MnemonicServiceTests: XCTestCase {
  private var service: MnemonicService!
  private var dictionary: MnemonicDictionary!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    service = MnemonicServiceImpl()
    dictionary = try BIP39()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testMnemonic() throws {
    let entropy: [UInt8] = [0b00000000, 0b00100000, 0b00001000, 0b00000000]
    let mnemonic = try service.mnemonic(entropy: entropy, using: dictionary)
    XCTAssertEqual(["ability", "able", "abandon"], mnemonic)
  }
  
  func testMnemonicInvalidEntropy() throws {
    let entropy: [UInt8] = [0]
    XCTAssertThrowsError(try service.mnemonic(entropy: entropy, using: dictionary))
  }
  
  func testSecretKey() throws {
    let secretKey = try service.secretKey(mnemonic: ["punch", "shock", "entire", "north", "file", "identify"], using: dictionary)
    XCTAssertEqual("e1ca8d8539fb054eda16c35dcff74c5f88202b88cb03f2824193f4e6c5e87dd2e24a0edb218901c3e71e900d95e9573d9ffbf870b242e927682e381d109ae882", secretKey.toHexString())
  }
  
  func testSecretKeyInvalidWord() throws {
    let mnemonic = ["punch", "dude", "punch"]
    XCTAssertThrowsError(try service.secretKey(mnemonic: mnemonic, using: dictionary))
  }
}
