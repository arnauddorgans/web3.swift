// 
// 

import Foundation
import BigInt

/// A transaction object
/// - seealso: https://eth.wiki/json-rpc/API#parameters-29
public struct Transaction: Decodable {
  /// Hash of the block where this transaction was in. null when its pending.
  public let blockHash: Hash?
  /// Block number where this transaction was in. null when its pending.
  @Web3Formatted<HexToNumber?>
  public private(set) var blockNumber: Int?
  /// Address of the sender.
  public let from: Address
  /// Gas provided by the sender.
  @Web3Formatted<HexToNumber>
  public var gas: Int
  /// Gas price provided by the sender in Wei.
  @Web3Formatted<HexToBN>
  public private(set) var gasPrice: BigInt
  /// Hash of the transaction.
  public let hash: Hash
  /// The data send along with the transaction.
  public let input: Data
  /// The number of transactions made by the sender prior to this one.
  @Web3Formatted<HexToNumber>
  public private(set) var nonce: Int
  /// Address of the receiver. null when its a contract creation transaction.
  public let to: Address?
  /// Integer of the transactions index position in the block. null when its pending.
  @Web3Formatted<HexToNumber?>
  public private(set) var transactionIndex: Int?
  /// Value transferred in Wei.
  @Web3Formatted<HexToBN>
  public private(set) var value: BigInt
  /// ECDSA recovery id
  public let v: Data
  /// ECDSA signature r
  public let r: Data
  /// ECDSA signature s
  public let s: Data
}
