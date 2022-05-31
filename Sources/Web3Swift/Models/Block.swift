// 
// 

import Foundation
import BigInt

/// A block object
/// - seealso: https://eth.wiki/json-rpc/API#parameters-27
/// - seealso: web3-core-helpers/src/formatters.js
public struct Block: Decodable {
  /// The block number. null when its pending block.
  @Web3Formatted<HexToNumber?>
  public private(set) var number: Int?
  /// Hash of the block. null when its pending block.
  public let hash: Hash?
  /// Hash of the parent block.
  public let parentHash: Hash
  /// Hash of the generated proof-of-work. null when its pending block.
  public let nonce: Hash?
  /// SHA3 of the uncles data in the block.
  public let sha3Uncles: Data
  /// The bloom filter for the logs of the block. null when its pending block.
  public let logsBloom: Data?
  /// The root of the transaction trie of the block.
  public let transactionsRoot: Data
  /// The root of the final state trie of the block.
  public let stateRoot: Data
  /// The root of the receipts trie of the block.
  public let receiptsRoot: Data
  /// The address of the beneficiary to whom the mining rewards were given.
  public let miner: Address
  /// Integer of the difficulty for this block.
  @Web3Formatted<HexToBN?>
  public private(set) var difficulty: BigInt?
  /// Integer of the total difficulty of the chain until this block.
  @Web3Formatted<HexToBN?>
  public private(set) var totalDifficulty: BigInt?
  /// The “extra data” field of this block.
  public let extraData: Data
  /// Integer the size of this block in bytes.
  @Web3Formatted<HexToNumber>
  public private(set) var size: Int
  /// The maximum gas allowed in this block.
  @Web3Formatted<HexToNumber>
  public private(set) var gasLimit: Int
  /// The total used gas by all transactions in this block.
  @Web3Formatted<HexToNumber>
  public private(set) var gasUsed: Int
  /// The unix timestamp for when the block was collated.
  @Web3Formatted<HexToNumber>
  public private(set) var timestamp: Int
  /// Array of transaction objects, or 32 Bytes transaction hashes depending on the last given parameter.
  public let transactions: Transactions?
  /// Array of uncle hashes
  public let uncles: [Hash]
}
