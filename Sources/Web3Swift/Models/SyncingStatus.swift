// 
// 

import Foundation

/// - seealso: https://eth.wiki/json-rpc/API#returns-6
public enum SyncStatus {
  case syncing(SyncStatusData)
  case notSyncing
}

// MARK: Decodable
extension SyncStatus: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let isSyncing = try? container.decode(Bool.self), !isSyncing {
      self = .notSyncing
    } else {
      let data = try container.decode(SyncStatusData.self)
      self = .syncing(data)
    }
  }
}
