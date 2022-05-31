// 
// 

import Foundation

@propertyWrapper
public struct Web3Formatted<T> where T: Web3Formatter {
  public var wrappedValue: T.Value
  
  public init(wrappedValue: T.Value) {
    self.wrappedValue = wrappedValue
  }
}

extension Web3Formatted: Decodable {
  public init(from decoder: Decoder) throws {
    let value = try T.decode(from: decoder)
    self.init(wrappedValue: value)
  }
}

extension Optional: Web3Formatter where Wrapped: Web3Formatter {
  public typealias Value = Wrapped.Value?
  
  public static func decode(from decoder: Decoder) throws -> Wrapped.Value? {
    try Wrapped.decode(from: decoder)
  }
}

extension Array: Web3Formatter where Element: Web3Formatter {
  public static func decode(from decoder: Decoder) throws -> [Element.Value] {
    var container = try decoder.unkeyedContainer()
    var elements = [Element.Value]()
    while !container.isAtEnd {
      let decoder = try container.superDecoder()
      let value = try Element.decode(from: decoder)
      elements.append(value)
    }
    return elements
  }
}

extension KeyedDecodingContainer {
  /// - seealso: https://forums.swift.org/t/using-property-wrappers-with-codable/29804/12
  public func decode<T>(_ type: Web3Formatted<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Web3Formatted<T> where T: Web3Optional, T.Value: Web3Optional {
    guard contains(key) && (try? decodeNil(forKey: key)) != true else { return type.init(wrappedValue: .none) }
    return try type.init(from: superDecoder(forKey: key))
  }
}
