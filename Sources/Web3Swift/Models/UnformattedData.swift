// 
// 

import Foundation

public struct UnformattedData: Equatable {
  public let hexString: String
  
  public init(hexString: String) {
    self.hexString = hexString.appendingHexPrefixIfNeeded()
  }
}

public extension UnformattedData {
  var bytes: [UInt8] { .init(hex: hexString) }
  var data: Data { bytes.data }
  
  init(bytes: [UInt8]) {
    self.init(hexString: bytes.toHexString())
  }
  
  init(data: Data) {
    self.init(bytes: data.bytes)
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
    self.init(hexString: value)
  }
}

// MARK: Decodable
extension UnformattedData: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    hexString = try container.decode(String.self)
  }
}

// MARK: Encodable
extension UnformattedData: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(hexString)
  }
}
