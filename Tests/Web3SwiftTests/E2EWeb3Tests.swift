// 
// 

import XCTest
@testable import Web3Swift

final class E2EWeb3Tests: XCTestCase {
  private var web3: Web3!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    web3 = try .e2e()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testGetProtocolVersion() async throws {
    _ = try await web3.eth.getProtocolVersion()
  }
  
  //  func testGetCoinbase() async throws {
  //    _ = try await web3.eth.getCoinbase()
  //  }
  
  //  func testGetHashrate() async throws {
  //    _ = try await web3.eth.getHashrate()
  //  }
  
  func testGetGasPrice() async throws {
    _ = try await web3.eth.getGasPrice()
  }
  
  func testGetFeeHistory() async throws {
    _ = try await web3.eth.getFeeHistory(blockCount: 4, newestBlockNumber: .latest, rewardPercentiles: [25, 50, 75])
  }
  
  func testGetStorageAt() async throws {
    _ = try await web3.eth.getStorageAt(address: "0x407d73d8a49eeb85d32cf465507dd71d507100c1", position: 0, blockNumber: .latest)
  }
  
  func testGetCode() async throws {
    _ = try await web3.eth.getCode(address: "0xd5677cf67b5aa051bb40496e68ad359eb97cfbf8", blockNumber: .latest)
  }
  
  func testGetAccounts() async throws {
    _ = try await web3.eth.getAccounts()
  }
  
  func testGetBlockNumber() async throws {
    _ = try await web3.eth.getBlockNumber()
  }
  
  func testGetBalance() async throws {
    _ = try await web3.eth.getBalance(address: "0x00000000219ab540356cbb839cbe05303d7705fa", blockNumber: .latest)
  }
  
  func testGetBlock() async throws {
    _ = try await web3.eth.getBlock(.latest, transactionObjects: true)
  }
  
  func testGetBlockTransactionCount() async throws {
    let count = try await web3.eth.getBlockTransactionCount(14817187)
    XCTAssertEqual(count, 188)
  }
  
  func testGetBlockUncleCount() async throws {
    let count = try await web3.eth.getBlockUncleCount(14817187)
    XCTAssertEqual(count, 1)
  }
  
  func testGetUncle() async throws {
    let uncle = try await web3.eth.getUncle(blockNumber: 14817187, uncleIndex: 0)
    XCTAssertEqual(uncle.number, 14817186)
  }
  
  func testGetTransaction() async throws {
    _ = try await web3.eth.getTransaction(hash: "0xfe01f8c27c2e34f90d3f53768944ff360a5e950d0542670361b3070a98807f7f")
  }
  
//  func testGetPendingTransactions() async throws {
//    _ = try await web3.eth.getPendingTransactions()
//  }
  
  func testGetTransactionFromBlock() async throws {
    _ = try await web3.eth.getTransactionFromBlock(14836747, indexNumber: 2)
  }
  
  func testGetTransactionReceipt() async throws {
    _ = try await web3.eth.getTransactionReceipt(hash: "0xab059a62e22e230fe0f56d8555340a29b2e9532360368f810595453f6fdd213b")
  }
  
  func testGetTransactionCount() async throws {
    let count = try await web3.eth.getTransactionCount(address: "0x11f4d0A3c12e86B4b5F39B213F7E19D048276DAe")
    XCTAssertEqual(count, 0)
  }
}
