// 
// 

import Foundation

public enum BlockHashOrNumber {
  case hash(Hash)
  case number(BlockNumber)
  
  public static let latest: BlockHashOrNumber = .number(.latest)
  public static let earliest: BlockHashOrNumber = .number(.earliest)
  public static let pending: BlockHashOrNumber = .number(.pending)
  public static func number(_ number: Int) -> BlockHashOrNumber {
    .number(.number(number))
  }
}

// MARK: ExpressibleByStringLiteral
extension BlockHashOrNumber: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self = .hash(.init(stringLiteral: value))
  }
}

// MARK: ExpressibleByIntegerLiteral
extension BlockHashOrNumber: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) {
    self = .number(value)
  }
}
