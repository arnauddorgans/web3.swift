// 
// 

import XCTest
@testable import Web3Swift

final class AccountsServiceTests: XCTestCase {
  private var accounts: AccountsService!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    accounts = AccountsServiceImpl()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testCreate() throws {
    XCTAssertNoThrow(try accounts.create())
  }
  
  func testPrivateKeyToAccount() throws {
    let privateKey: [UInt8] = .init(hex: "0x3c4cf049f83a5870ab31c396a0d46783c3e3974da1364ea5a2477548d36b5f8f")
    let account = try accounts.privateKeyToAccount(privateKey)
    XCTAssertEqual(account.address, "0xbbec2620cb01adae3f96e1fa39f997f06bfb7ca0")
  }
}
