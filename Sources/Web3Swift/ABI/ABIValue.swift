// 
// 

import Foundation
import BigInt

public enum ABIValue: Equatable {
  case address(String)
  case uint(Int, BigUInt)
  case int(Int, BigInt)
  case bool(Bool)
  case bytes([UInt8])
  case sizedBytes(Int, [UInt8])
  case string(String)
  case array(ABIValueType, [ABIValue])
  case sizedArray(ABIValueType, Int, [ABIValue])
  case tuple([ABIValue])
  
  public var type: ABIValueType {
    switch self {
    case .address:        return .address
    case .bool:           return .bool
    case .bytes:          return .bytes
    case .string:         return .string
    case let .uint(size, _):
      return .uint(size)
    case let .int(size, _):
      return .int(size)
    case let .sizedBytes(size, _):
      return .sizedBytes(size)
    case let .sizedArray(valueType, size, _):
      return .sizedArray(valueType, size)
    case let .array(valueType, _):
      return .array(valueType)
    case let .tuple(values):
      return .tuple(values.map(\.type))
    }
  }
}

// MARK: UInt
public extension ABIValue {
  static func uint8(_ value: UInt8) -> ABIValue {
    .uint(8, .init(value))
  }
  
  static func uint16(_ value: UInt16) -> ABIValue {
    .uint(16, .init(value))
  }
  
  static func uint32(_ value: UInt32) -> ABIValue {
    .uint(32, .init(value))
  }
  
  static func uint256(_ value: BigUInt) -> ABIValue {
    .uint(256, value)
  }
  
  /// Alias for uint256
  static func uint(_ value: BigUInt) -> ABIValue {
    uint256(value)
  }
}

// MARK: Int
public extension ABIValue {
  static func int8(_ value: Int8) -> ABIValue {
    .int(8, .init(value))
  }
  
  static func int16(_ value: Int16) -> ABIValue {
    .int(16, .init(value))
  }
  
  static func int32(_ value: Int32) -> ABIValue {
    .int(32, .init(value))
  }
  
  static func int256(_ value: BigInt) -> ABIValue {
    .int(256, value)
  }
  
  /// Alias for int256
  static func int(_ value: BigInt) -> ABIValue {
    .int256(value)
  }
}

// MARK: Bytes
public extension ABIValue {
  static func bytes(_ data: UnformattedData) -> ABIValue {
    .bytes(data.bytes)
  }
  
  static func sizedBytes(_ bytes: [UInt8]) -> ABIValue {
    .sizedBytes(bytes.count, bytes)
  }
  
  static func sizedBytes(_ size: Int, _ data: UnformattedData) -> ABIValue {
    .sizedBytes(size, data.bytes)
  }
  
  static func sizedBytes(_ data: UnformattedData) -> ABIValue {
    .sizedBytes(data.bytes)
  }
}

// MARK: Array
public extension ABIValue {
  static func array(_ elements: [ABIValue]) -> ABIValue {
    assert(elements.count > 0, "Type inferring is not possible for empty array")
    let valueType = elements[0].type
    assert(elements.map(\.type) == .init(repeating: valueType, count: elements.count), "All array element types should be equal")
    return .array(valueType, elements)
  }
  
  static func sizedArray(_ elements: [ABIValue]) -> ABIValue {
    assert(elements.count > 0, "Type inferring is not possible for empty array")
    let valueType = elements[0].type
    assert(elements.map(\.type) == .init(repeating: valueType, count: elements.count), "All array element types should be equal")
    return .sizedArray(valueType, elements.count, elements)
  }
}
