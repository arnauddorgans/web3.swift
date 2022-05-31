// 
// 

import Foundation
import BigInt

public protocol ETHService: AnyObject {
  /// The web3.eth.abi functions let you encode and decode parameters to ABI (Application Binary Interface) for function calls to the EVM (Ethereum Virtual Machine).
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#abi
  var abi: ABIService { get }
  
  /// The default block is used for certain methods. You can override it by passing in the defaultBlock as last parameter. The default value is "latest".
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#defaultblock
  var defaultBlock: BlockNumber { get set }
  
  /// Returns the ethereum protocol version of the node.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getprotocolversion
  func getProtocolVersion() async throws -> String
  
  /// Returns the coinbase address to which mining rewards will go.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getcoinbase
  func getCoinbase() async throws -> Address
  
  /// Returns the number of hashes per second that the node is mining with.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#gethashrate
  func getHashrate() async throws -> Int
  
  /// Returns the current gas price oracle. The gas price is determined by the last few blocks median gas price.
  /// - returns: Number of the current gas price in wei.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getgasprice
  func getGasPrice() async throws -> BigInt
  
  /// Transaction fee history Returns base fee per gas and transaction effective priority fee per gas history for the requested block range if available.
  /// The range between headBlock-4 and headBlock is guaranteed to be available while retrieving data from the pending block and older history are optional to support.
  /// For pre-EIP-1559 blocks the gas prices are returned as rewards and zeroes are returned for the base fee per gas.
  /// - parameter blockCount: Number of blocks in the requested range. Between 1 and 1024 blocks can be requested in a single query. Less than requested may be returned if not all blocks are available.
  /// - parameter newestBlockNumber: Highest number block of the requested range.
  /// - parameter rewardPercentiles: A monotonically increasing list of percentile values to sample from each block’s effective priority fees per gas in ascending order, weighted by gas used.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getfeehistory
  func getFeeHistory(blockCount: Int, newestBlockNumber: BlockNumber, rewardPercentiles: [Int]) async throws -> FeeHistory
  
  /// Returns a list of accounts the node controls.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getaccounts
  func getAccounts() async throws -> [String]
  
  /// Returns the current block number.
  /// - returns: The number of the most recent block.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getblocknumber
  func getBlockNumber() async throws -> Int
  
  /// Get the balance of an address at a given block.
  /// - parameter address: The address to get the balance of.
  /// - parameter blockNumber: If you pass this parameter it will not use the default block set with web3.eth.defaultBlock. Pre-defined block numbers as "earliest", "latest" and "pending" can also be used.
  /// - returns: The current balance for the given address in wei.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getbalance
  func getBalance(address: Address, blockNumber: BlockNumber) async throws -> BigInt
  
  /// Get the storage at a specific position of an address.
  /// - parameter address: The address to get the storage from.
  /// - parameter position: The index position of the storage.
  /// - parameter blockNumber: If you pass this parameter it will not use the default block set with web3.eth.defaultBlock. Pre-defined block numbers as "earliest", "latest" and "pending" can also be used.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getstorageat
  func getStorageAt(address: Address, position: Int, blockNumber: BlockNumber) async throws -> UnformattedData
  
  /// Get the code at a specific address.
  /// - parameter address: The address to get the code from.
  /// - parameter blockNumber: If you pass this parameter it will not use the default block set with web3.eth.defaultBlock. Pre-defined block numbers as "earliest", "latest" and "pending" can also be used.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getcode
  func getCode(address: Address, blockNumber: BlockNumber) async throws -> UnformattedData
  
  /// Returns a block matching the block number.
  /// - parameter blockNumber: The block number or the string "earliest", "latest" or "pending" as in the default block parameter.
  /// - parameter transactionObjects: If specified true, the returned block will contain all transactions as objects. If false it will only contains the transaction hashes.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getblock
  func getBlock(_ blockNumber: BlockNumber, transactionObjects: Bool) async throws -> Block
  
  /// Returns a block matching the block hash.
  /// - parameter blockHash: The block hash.
  /// - parameter transactionObjects: If specified true, the returned block will contain all transactions as objects. If false it will only contains the transaction hashes.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getblock
  func getBlock(_ blockHash: Hash, transactionObjects: Bool) async throws -> Block
  
  /// Returns the number of transaction in a given block.
  /// - parameter blockNumber: The block number. Or the string "earliest", "latest" or "pending" as in the default block parameter.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getblocktransactioncount
  func getBlockTransactionCount(_ blockNumber: BlockNumber) async throws -> Int
  
  /// Returns the number of transaction in a given block.
  /// - parameter blockHash: The block hash.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getblocktransactioncount
  func getBlockTransactionCount(_ blockHash: Hash) async throws -> Int
  
  /// Returns the number of uncles in a block from a block matching the given block number.
  /// - parameter blockNumber: The block number. Or the string "earliest", "latest" or "pending" as in the default block parameter.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getblockunclecount
  func getBlockUncleCount(_ blockNumber: BlockNumber) async throws -> Int
  
  /// Returns the number of uncles in a block from a block matching the given block hash.
  /// - parameter blockHash: The block hash.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getblockunclecount
  func getBlockUncleCount(_ blockHash: Hash) async throws -> Int
  
  /// Returns a blocks uncle by a given uncle index position.
  /// - parameter blockNumber: The block number or the string "earliest", "latest" or "pending" as in the default block parameter.
  /// - parameter uncleIndex: The index position of the uncle.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getuncle
  func getUncle(blockNumber: BlockNumber, uncleIndex: Int) async throws -> Block
  
  /// Returns a blocks uncle by a given uncle index position.
  /// - parameter blockHash: The block hash.
  /// - parameter uncleIndex: The index position of the uncle.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getuncle
  func getUncle(blockHash: Hash, uncleIndex: Int) async throws -> Block
  
  /// Returns a transaction matching the given transaction hash.
  /// - parameter hash: The transaction hash.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#gettransaction
  func getTransaction(hash: Hash) async throws -> Transaction
  
  /// Returns a list of pending transactions.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getpendingtransactions
  func getPendingTransactions() async throws -> [Transaction]
  
  /// Returns a transaction based on a block number and the transaction’s index position.
  /// - parameter blockNumber: A block number or the string "earliest", "latest" or "pending" as in the default block parameter.
  /// - parameter indexNumber: The transaction’s index position.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#gettransactionfromblock
  func getTransactionFromBlock(_ blockNumber: BlockNumber, indexNumber: Int) async throws -> Transaction
  
  /// Returns a transaction based on a block hash and the transaction’s index position.
  /// - parameter blockHash: A block hash.
  /// - parameter indexNumber: The transaction’s index position.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#gettransactionfromblock
  func getTransactionFromBlock(_ blockHash: Hash, indexNumber: Int) async throws -> Transaction
  
  /// Returns the receipt of a transaction by transaction hash.
  /// - parameter hash: The transaction hash.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#gettransactionreceipt
  func getTransactionReceipt(hash: Hash) async throws -> TransactionReceipt
  
  /// Get the number of transactions sent from this address.
  /// - parameter address: The address to get the numbers of transactions from.
  /// - parameter blockNumber: If you pass this parameter it will not use the default block set with web3.eth.defaultBlock. Pre-defined block numbers as "earliest", "latest" and "pending" can also be used.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#gettransactioncount
  func getTransactionCount(address: Address, blockNumber: BlockNumber) async throws -> Int
  
  
  
  
  
  
  
  /// Executes a message call transaction, which is directly executed in the VM of the node, but never mined into the blockchain.
  /// - parameter transaction: A transaction object, see web3.eth.sendTransaction. For calls the from property is optional however it is highly recommended to explicitly set it or it may default to address(0) depending on your node or provider.
  /// - parameter blockNumber: If you pass this parameter it will not use the default block set with web3.eth.defaultBlock. Pre-defined block numbers as "earliest", "latest" and "pending" can also be used.
  func call(transaction: TransactionCall, blockNumber: BlockNumber) async throws -> UnformattedData
}

public extension ETHService {
  /// Get the balance of an address at a given block.
  /// - parameter address: The address to get the balance of.
  /// - returns: The current balance for the given address in wei.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getbalance
  func getBalance(address: Address) async throws -> BigInt {
    try await getBalance(address: address, blockNumber: defaultBlock)
  }
  
  /// Returns a block matching the block number.
  /// - parameter blockNumber: The block number or the string "earliest", "latest" or "pending" as in the default block parameter.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getblock
  func getBlock(_ blockNumber: BlockNumber, transactionObjects: Bool) async throws -> Block {
    try await getBlock(blockNumber, transactionObjects: false)
  }
  
  /// Returns a block matching the block hash.
  /// - parameter blockHash: The block hash.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getblock
  func getBlock(_ blockHash: Hash, transactionObjects: Bool) async throws -> Block {
    try await getBlock(blockHash, transactionObjects: false)
  }
  
  /// Get the storage at a specific position of an address.
  /// - parameter address: The address to get the storage from.
  /// - parameter position: The index position of the storage.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getstorageat
  func getStorageAt(address: Address, position: Int) async throws -> UnformattedData {
    try await getStorageAt(address: address, position: position, blockNumber: defaultBlock)
  }
  
  /// Get the code at a specific address.
  /// - parameter address: The address to get the code from.
  /// - parameter blockNumber: If you pass this parameter it will not use the default block set with web3.eth.defaultBlock. Pre-defined block numbers as "earliest", "latest" and "pending" can also be used.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#getcode
  func getCode(address: Address) async throws -> UnformattedData {
    try await getCode(address: address, blockNumber: defaultBlock)
  }
  
  /// Get the number of transactions sent from this address.
  /// - parameter address: The address to get the numbers of transactions from.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#gettransactioncount
  func getTransactionCount(address: Address) async throws -> Int {
    try await getTransactionCount(address: address, blockNumber: defaultBlock)
  }
  
  
  
  
  
  
  /// Executes a message call transaction, which is directly executed in the VM of the node, but never mined into the blockchain.
  /// - parameter transaction: A transaction object, see web3.eth.sendTransaction. For calls the from property is optional however it is highly recommended to explicitly set it or it may default to address(0) depending on your node or provider.
  func call(transaction: TransactionCall) async throws -> UnformattedData {
    try await call(transaction: transaction, blockNumber: defaultBlock)
  }
}

// MARK: Internal
protocol ETHServiceInternal: ETHService {
  func getBlock(hashOrNumber blockHashOrNumber: BlockHashOrNumber, transactionObjects: Bool) async throws -> Block
  
  func getBlockTransactionCount(hashOrNumber blockHashOrNumber: BlockHashOrNumber) async throws -> Int
  
  func getBlockUncleCount(hashOrNumber blockHashOrNumber: BlockHashOrNumber) async throws -> Int
  
  func getUncle(blockHashOrNumber: BlockHashOrNumber, uncleIndex: Int) async throws -> Block
  
  func getTransactionFromBlock(hashOrNumber blockHashOrNumber: BlockHashOrNumber, indexNumber: Int) async throws -> Transaction
}

extension ETHServiceInternal {
  func getBlock(_ blockHash: Hash, transactionObjects: Bool) async throws -> Block {
    try await getBlock(hashOrNumber: .hash(blockHash), transactionObjects: transactionObjects)
  }
  
  func getBlock(_ blockNumber: BlockNumber, transactionObjects: Bool) async throws -> Block {
    try await getBlock(hashOrNumber: .number(blockNumber), transactionObjects: transactionObjects)
  }
  
  func getBlockTransactionCount(_ blockHash: Hash) async throws -> Int {
    try await getBlockTransactionCount(hashOrNumber: .hash(blockHash))
  }
  
  func getBlockTransactionCount(_ blockNumber: BlockNumber) async throws -> Int {
    try await getBlockTransactionCount(hashOrNumber: .number(blockNumber))
  }
  
  func getBlockUncleCount(_ blockHash: Hash) async throws -> Int {
    try await getBlockUncleCount(hashOrNumber: .hash(blockHash))
  }
  
  func getBlockUncleCount(_ blockNumber: BlockNumber) async throws -> Int {
    try await getBlockUncleCount(hashOrNumber: .number(blockNumber))
  }
  
  func getUncle(blockHash: Hash, uncleIndex: Int) async throws -> Block {
    try await getUncle(blockHashOrNumber: .hash(blockHash), uncleIndex: uncleIndex)
  }
  
  func getUncle(blockNumber: BlockNumber, uncleIndex: Int) async throws -> Block {
    try await getUncle(blockHashOrNumber: .number(blockNumber), uncleIndex: uncleIndex)
  }
  
  func getTransactionFromBlock(_ blockHash: Hash, indexNumber: Int) async throws -> Transaction {
    try await getTransactionFromBlock(hashOrNumber: .hash(blockHash), indexNumber: indexNumber)
  }
  
  func getTransactionFromBlock(_ blockNumber: BlockNumber, indexNumber: Int) async throws -> Transaction {
    try await getTransactionFromBlock(hashOrNumber: .number(blockNumber), indexNumber: indexNumber)
  }
}
