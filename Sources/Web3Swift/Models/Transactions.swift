// 
// 

import Foundation

public enum Transactions {
  case objects([Transaction])
  case hashes([Hash])
}

extension Transactions {
  func objects() throws -> [Transaction] {
    switch self {
    case let .objects(transactions):
      return transactions
    case .hashes:
      throw SwiftCastingError()
    }
  }
  
  func hashes() -> [Hash] {
    switch self {
    case let .objects(transactions):
      return transactions.map(\.hash)
    case let .hashes(hashes):
      return hashes
    }
  }
}

// MARK: Decodable
extension Transactions: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    do {
      let objects = try container.decode([Transaction].self)
      self = .objects(objects)
    } catch {
      let hashes = try container.decode([Hash].self)
      self = .hashes(hashes)
    }
  }
}

// MARK: Error
extension Transactions {
  struct SwiftCastingError: Error { }
}
