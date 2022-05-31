// 
// 

import Foundation

/// An object with sync status data
/// - seealso: https://eth.wiki/json-rpc/API#returns-6
public struct SyncStatusData: Decodable {
  /// The block number where the sync started.
  @Web3Formatted<HexToNumber>
  public private(set) var startingBlock: Int
  /// The block number where the node is currently synced to.
  @Web3Formatted<HexToNumber>
  public private(set) var currentBlock: Int
  /// The estimated block number to sync to.
  @Web3Formatted<HexToNumber>
  public private(set) var highestBlock: Int
}
