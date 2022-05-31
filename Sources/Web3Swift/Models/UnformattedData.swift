// 
// 

import Foundation

public struct UnformattedData: Equatable {
  public let stringValue: String
  public var bytes: [UInt8] { .init(hex: stringValue) }
  
  public init(stringValue: String) {
    if stringValue.isHex {
      self.stringValue = stringValue
    } else {
      self.stringValue = stringValue.appendingHexPrefixIfNeeded()
    }
  }
  
  public init(bytes: [UInt8]) {
    self.init(stringValue: bytes.toHexString())
  }
}

// MARK: ExpressibleByArrayLiteral
extension UnformattedData: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: UInt8...) {
    self.init(bytes: elements)
  }
}

// MARK: ExpressibleByStringLiteral
extension UnformattedData: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(stringValue: value)
  }
}

// MARK: Decodable
extension UnformattedData: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    stringValue = try container.decode(String.self)
  }
}

// MARK: Encodable
extension UnformattedData: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(stringValue)
  }
}
