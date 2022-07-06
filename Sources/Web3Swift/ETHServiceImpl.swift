// 
// 

import Foundation
import BigInt

final class ETHServiceImpl {
  private let accountsService: AccountsService
  private let abiService: ABIService
  private let jsonRPCService: JSONRPCService
  private let utils: Web3Utils
  
  var defaultBlock: BlockNumber = .latest
  
  init(accountsService: AccountsService,
       abiService: ABIService,
       jsonRPCService: JSONRPCService,
       utils: Web3Utils) {
    self.accountsService = accountsService
    self.abiService = abiService
    self.jsonRPCService = jsonRPCService
    self.utils = utils
  }
}

extension ETHServiceImpl: ETHServiceInternal {
  var accounts: AccountsService { accountsService }
  var abi: ABIService { abiService }
      
  func getProtocolVersion() async throws -> String {
    try await jsonRPCService.request(method: "eth_protocolVersion") { }
  }
  
  func getCoinbase() async throws -> Address {
    try await jsonRPCService.request(method: "eth_coinbase") { }
  }
  
  func getHashrate() async throws -> Int {
    try await jsonRPCService.request(method: "eth_hashrate", formatter: HexToNumber.self) { }
  }
  
  func getGasPrice() async throws -> BigInt {
    try await jsonRPCService.request(method: "eth_gasPrice", formatter: HexToBN.self) { }
  }
  
  func getFeeHistory(blockCount: Int, newestBlockNumber: BlockNumber, rewardPercentiles: [Int]) async throws -> FeeHistory {
    try await jsonRPCService.request(method: "eth_feeHistory") {
      blockCount
      newestBlockNumber
      rewardPercentiles
    }
  }
  
  func getAccounts() async throws -> [String] {
    try await jsonRPCService.request(method: "eth_accounts") { }
  }
  
  func getBlockNumber() async throws -> Int {
    try await jsonRPCService.request(method: "eth_blockNumber", formatter: HexToNumber.self) { }
  }
  
  func getBalance(address: Address, blockNumber: BlockNumber) async throws -> BigInt {
    try await jsonRPCService.request(method: "eth_getBalance", formatter: HexToBN.self) {
      address
      blockNumber
    }
  }
  
  func getStorageAt(address: Address, position: Int, blockNumber: BlockNumber) async throws -> UnformattedData {
    try await jsonRPCService.request(method: "eth_getStorageAt") {
      address
      utils.numberToHex(position)
      blockNumber
    }
  }
  
  func getCode(address: Address, blockNumber: BlockNumber) async throws -> UnformattedData {
    try await jsonRPCService.request(method: "eth_getCode") {
      address
      blockNumber
    }
  }
  
  func getBlock(hashOrNumber blockHashOrNumber: BlockHashOrNumber, transactionObjects: Bool) async throws -> Block {
    switch blockHashOrNumber {
    case let .hash(hash):
      return try await jsonRPCService.request(method: "eth_getBlockByHash") {
        hash
        transactionObjects
      }
    case let .number(number):
      return try await jsonRPCService.request(method: "eth_getBlockByNumber") {
        number
        transactionObjects
      }
    }
  }
  
  func getBlockTransactionCount(hashOrNumber blockHashOrNumber: BlockHashOrNumber) async throws -> Int {
    switch blockHashOrNumber {
    case let .hash(hash):
      return try await jsonRPCService.request(method: "eth_getBlockTransactionCountByHash", formatter: HexToNumber.self) {
        hash
      }
    case let .number(number):
      return try await jsonRPCService.request(method: "eth_getBlockTransactionCountByNumber", formatter: HexToNumber.self) {
        number
      }
    }
  }
  
  func getBlockUncleCount(hashOrNumber blockHashOrNumber: BlockHashOrNumber) async throws -> Int {
    switch blockHashOrNumber {
    case let .hash(hash):
      return try await jsonRPCService.request(method: "eth_getUncleCountByBlockHash", formatter: HexToNumber.self) {
        hash
      }
    case let .number(number):
      return try await jsonRPCService.request(method: "eth_getUncleCountByBlockNumber", formatter: HexToNumber.self) {
        number
      }
    }
  }
  
  func getUncle(blockHashOrNumber: BlockHashOrNumber, uncleIndex: Int) async throws -> Block {
    switch blockHashOrNumber {
    case let .hash(hash):
      return try await jsonRPCService.request(method: "eth_getUncleByBlockHashAndIndex") {
        hash
        utils.numberToHex(uncleIndex)
      }
    case let .number(number):
      return try await jsonRPCService.request(method: "eth_getUncleByBlockNumberAndIndex") {
        number
        utils.numberToHex(uncleIndex)
      }
    }
  }
  
  func getTransaction(hash: Hash) async throws -> Transaction {
    try await jsonRPCService.request(method: "eth_getTransactionByHash") {
      hash
    }
  }
  
  func getPendingTransactions() async throws -> [Transaction] {
    try await jsonRPCService.request(method: "eth_pendingTransactions") { }
  }
  
  func getTransactionFromBlock(hashOrNumber blockHashOrNumber: BlockHashOrNumber, indexNumber: Int) async throws -> Transaction {
    switch blockHashOrNumber {
    case let .hash(hash):
      return try await jsonRPCService.request(method: "eth_getTransactionByBlockHashAndIndex") {
        hash
        utils.numberToHex(indexNumber)
      }
    case let .number(blockNumber):
      return try await jsonRPCService.request(method: "eth_getTransactionByBlockNumberAndIndex") {
        blockNumber
        utils.numberToHex(indexNumber)
      }
    }
  }
  
  func getTransactionReceipt(hash: Hash) async throws -> TransactionReceipt {
    try await jsonRPCService.request(method: "eth_getTransactionReceipt") {
      hash
    }
  }
  
  func getTransactionCount(address: Address, blockNumber: BlockNumber) async throws -> Int {
    try await jsonRPCService.request(method: "eth_getTransactionCount", formatter: HexToNumber.self) {
      address
      blockNumber
    }
  }
  
  func call(transaction: TransactionCall, blockNumber: BlockNumber) async throws -> UnformattedData {
    try await jsonRPCService.request(method: "eth_call") {
      transaction
      blockNumber
    }
  }
  
  func eth_syncing() async throws -> SyncStatus {
    try await jsonRPCService.request(method: "eth_syncing") { }
  }
}
