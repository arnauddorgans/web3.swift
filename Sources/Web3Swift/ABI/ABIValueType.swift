// 
// 

import Foundation

/// - seealso: https://solidity-fr.readthedocs.io/fr/latest/abi-spec.html#types
public indirect enum ABIValueType: Equatable {
  case address
  case uint(Int)
  case int(Int)
  case bool
  case string
  case bytes
  case sizedBytes(Int)
  case array(ABIValueType)
  case sizedArray(ABIValueType, Int)
  case tuple([ABIValueType])
}

// MARK: UInt
public extension ABIValueType {
  static let uint8: ABIValueType = .uint(8)
  static let uint16: ABIValueType = .uint(16)
  static let uint32: ABIValueType = .uint(32)
  static let uint256: ABIValueType = .uint(256)
  /// Alias for uint256
  static let uint: ABIValueType = .uint256
}

// MARK: Int
public extension ABIValueType {
  static let int8: ABIValueType = .int(8)
  static let int16: ABIValueType = .int(16)
  static let int32: ABIValueType = .int(32)
  static let int256: ABIValueType = .int(256)
  /// Alias for int256
  static let int: ABIValueType = .int256
}

extension ABIValueType {
  var signature: String {
    switch self {
    case .address:  return "address"
    case .bool:     return "bool"
    case .bytes:    return "bytes"
    case .string:   return "string"
    case let .uint(size):
      return "uint\(size)"
    case let .int(size):
      return "int\((size))"
    case let .sizedArray(valueType, size):
      return valueType.signature + "[\(size)]"
    case let .sizedBytes(size):
      return "bytes\(size)"
    case let .array(valueType):
      return valueType.signature + "[]"
    case let .tuple(array):
      return "(" + array.map(\.signature).joined(separator: ",") + ")"
    }
  }
  var encodedBytesSize: Int? {
    switch self {
    case .uint(_), .int(_), .bool, .address:
      return 32
    case let .sizedBytes(size):
      return size.roundedUp(toMultipleOf: 32)
    case let .sizedArray(valueType, size):
      guard let encodedBytesSize = valueType.encodedBytesSize else { return nil }
      return encodedBytesSize * size
    case let .tuple(valueTypes):
      let encodedBytesSizes = valueTypes.compactMap(\.encodedBytesSize)
      guard encodedBytesSizes.count == valueTypes.count else { return nil }
      return encodedBytesSizes.reduce(0, +)
    case .string, .array, .bytes:
      return nil
    }
  }
  
  var isDynamic: Bool {
    encodedBytesSize == nil
  }
}
