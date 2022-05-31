// 
// 

import Foundation
import BigInt

public struct Quantity: Equatable {
  public let bigIntValue: BigInt
  
  public var intValue: Int {
    Int(bigIntValue)
  }
}

// MARK: ExpressibleByIntegerLiteral
extension Quantity: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) {
    self.init(bigIntValue: .init(value))
  }
}

// MARK: Decodable
extension Quantity: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self)
    guard let value = BigInt(hexString: stringValue) else {
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Invalid hex string"))
    }
    bigIntValue = value
  }
}

// MARK: Encodable
extension Quantity: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(bigIntValue.hexString)
  }
}
