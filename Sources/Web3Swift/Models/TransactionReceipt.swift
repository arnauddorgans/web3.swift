// 
// 

import Foundation

public struct TransactionReceipt: Decodable {
  /// TRUE if the transaction was successful, FALSE if the EVM reverted the transaction.
  @Web3Formatted<HexToBool?>
  public private(set) var status: Bool?
  /// Hash of the block where this transaction was in.
  public let blockHash: Hash
  /// Block number where this transaction was in.
  @Web3Formatted<HexToNumber?>
  public private(set) var blockNumber: Int?
  /// Hash of the transaction.
  public let transactionHash: Hash
  /// Integer of the transactions index position in the block.
  @Web3Formatted<HexToNumber?>
  public private(set) var transactionIndex: Int?
  /// Address of the sender.
  public let from: Address
  /// Address of the receiver. null when it’s a contract creation transaction.
  public let to: Address?
  /// The contract address created, if the transaction was a contract creation, otherwise null.
  public let contractAddress: Address?
  /// The total amount of gas used when this transaction was executed in the block.
  @Web3Formatted<HexToNumber>
  public private(set) var cumulativeGasUsed: Int
  /// The amount of gas used by this specific transaction alone.
  @Web3Formatted<HexToNumber>
  public private(set) var gasUsed: Int
  /// Array of log objects, which this transaction generated.
  public let logs: [Log]?
  /// The actual value per gas deducted from the senders account. Before EIP-1559, this is equal to the transaction’s gas price.
  /// After, it is equal to baseFeePerGas + min(maxFeePerGas - baseFeePerGas, maxPriorityFeePerGas).
  @Web3Formatted<HexToNumber?>
  public private(set) var effectiveGasPrice: Int?
}
