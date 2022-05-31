// 
// 

import Foundation
import BigInt

public enum BlockNumber {
  case number(Int)
  case latest
  case earliest
  case pending
  
  private var rawValue: String {
    switch self {
    case let .number(number):
      return BigInt(number).hexString
    case .latest:
      return "latest"
    case .earliest:
      return "earliest"
    case .pending:
      return "pending"
    }
  }
}

// MARK: ExpressibleByIntegerLiteral
extension BlockNumber: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) {
    self = .number(value)
  }
}

// MARK: Encodable
extension BlockNumber: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
