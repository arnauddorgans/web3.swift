// 
// 

import Foundation

public struct Log: Decodable {
  /// Hash of the block where this log was in. null when its pending log.
  public let blockHash: Hash?
  /// Address from which this log originated.
  public let address: Address?
  /// Integer of the log index position in the block. null when its pending log.
  @Web3Formatted<HexToNumber?>
  public private(set) var logIndex: Int?
  /// Contains one or more 32 Bytes non-indexed arguments of the log.
  public let data: Data
  /// true when the log was removed, due to a chain reorganization. false if its a valid log.
  public let removed: Bool
  /// Array of 0 to 4 32 Bytes DATA of indexed log arguments.
  public let topics: [Data]
  /// The block number where this log was in. null when its pending. null when its pending log.
  @Web3Formatted<HexToNumber?>
  public private(set) var blockNumber: Int?
  /// Integer of the transactions index position log was created from. null when its pending log.
  @Web3Formatted<HexToNumber?>
  public private(set) var transactionIndex: Int?
  /// Hash of the transactions this log was created from. null when its pending log.
  public let transactionHash: Hash?
}
