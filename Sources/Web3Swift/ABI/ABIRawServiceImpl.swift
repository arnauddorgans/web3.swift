// 
// 

import Foundation
import BigInt
import CryptoSwift

final class ABIRawServiceImpl { }

// MARK: ABIRawService
extension ABIRawServiceImpl: ABIRawService {
  /// - seealso: https://docs.soliditylang.org/en/v0.8.13/abi-spec.html#function-selector-and-argument-encoding
  func encodeRawFunctionSignature(_ signature: String) throws -> [UInt8] {
    guard let data = signature.data(using: .ascii) else { throw ABICodingError() }
    let hash = SHA3(variant: .keccak256).calculate(for: data.bytes)
    return try hash[safe: ..<4]
  }
  
  func encodeRaw(_ value: ABIValue) throws -> [UInt8] {
    switch value {
    case let .uint(_, bigUInt):
      return encodeUInt(bigUInt)
    case let .int(_, bigInt):
      return encodeInt(bigInt)
    case .bool(let bool):
      return encodeBool(bool)
    case let .sizedArray(_, _, values):
      return try encodeFixedSizeArray(values)
    case let .bytes(bytes):
      return encodeBytes(bytes)
    case let .sizedBytes(_, bytes):
      return encodeFixedSizeBytes(bytes)
    case let .string(string):
      return try encodeString(string)
    case let .array(_, values):
      return try encodeArray(values)
    case .tuple(let values):
      return try encodeTuple(values: values)
    }
  }
  
  func decodeRaw(_ bytes: [UInt8], as valueType: ABIValueType) throws -> ABIValue {
    switch valueType {
    case let .uint(size):
      return .uint(size, .init(decodeUInt(bytes)))
    case let .int(size):
      return .int(size, .init(decodeInt(bytes)))
    case .bool:
      return .bool(decodeBool(bytes))
    case let .sizedArray(valueType, size):
      return try .sizedArray(valueType, size, decodeFixedSizeArray(bytes, valueType: valueType, size: size))
    case .bytes:
      return try .bytes(decodeBytes(bytes))
    case let .sizedBytes(size):
      return try .sizedBytes(size, .init(bytes: decodeFixedSizeBytes(bytes, size: size)))
    case .string:
      return try .string(decodeString(bytes))
    case let .array(valueType):
      return try .array(valueType, decodeArray(bytes, valueType: valueType))
    case let .tuple(valueTypes):
      return try .tuple(decodeTuple(bytes, withValueTypes: valueTypes))
    }
  }
}

// MARK: UInt
extension ABIRawServiceImpl {
  func encodeUInt(_ value: BigUInt) -> [UInt8] {
    let bytes = value.serialize().bytes
    return bytes.padded(to: 32, alignment: .right)
  }
  
  func decodeUInt(_ bytes: [UInt8]) -> BigUInt {
    BigUInt(Data(bytes))
  }
}

// MARK: Int
extension ABIRawServiceImpl {
  func encodeInt(_ value: BigInt) -> [UInt8] {
    let isNegative = value.sign == .minus
    let value = isNegative ? value + 1 : value
    let uint = BigUInt(abs(value))
    return encodeUInt(uint)
      .map { isNegative ? 0xff - $0 : $0 }
  }
    
  func decodeInt(_ bytes: [UInt8]) -> BigInt {
    guard let firstByte = bytes.first else { return 0 }
    let isNegative = firstByte == 0xff
    let bytes = !isNegative ? bytes : bytes.map { 0xff - $0 }
    let uint = decodeUInt(bytes) + (isNegative ? 1 : 0)
    return BigInt(uint) * (isNegative ? -1 : 1)
  }
}

// MARK: Bool
extension ABIRawServiceImpl {
  func encodeBool(_ value: Bool) -> [UInt8] {
    encodeUInt(value ? 1 : 0)
  }
  
  func decodeBool(_ bytes: [UInt8]) -> Bool {
    decodeUInt(bytes) != 0
  }
}

// MARK: Bytes
extension ABIRawServiceImpl {
  func encodeFixedSizeBytes(_ value: [UInt8]) -> [UInt8] {
    value.padded(to: 32, alignment: .left)
  }
  
  func encodeBytes(_ value: [UInt8]) -> [UInt8] {
    let countBytes = encodeUInt(.init(value.count))
    return countBytes + value.padded(to: 32, alignment: .left)
  }
  
  func decodeFixedSizeBytes(_ bytes: [UInt8], size: Int) throws -> [UInt8] {
    try bytes[safe: ..<size]
  }
  
  func decodeBytes(_ bytes: [UInt8]) throws -> [UInt8] {
    let count = try decodeUInt(bytes[safe: ..<32])
    let end = 32 + Int(count)
    return try bytes[safe: 32..<end]
  }
}

// MARK: String
extension ABIRawServiceImpl {
  func encodeString(_ value: String) throws -> [UInt8] {
    guard let data = value.data(using: .utf8) else { throw ABICodingError() }
    return encodeBytes(data.bytes)
  }
  
  func decodeString(_ bytes: [UInt8]) throws -> String {
    let bytes = try decodeBytes(bytes)
    guard let string = String(data: bytes.data, encoding: .utf8) else { throw ABICodingError() }
    return string
  }
}

// MARK: Array
extension ABIRawServiceImpl {
  func encodeFixedSizeArray(_ values: [ABIValue]) throws -> [UInt8] {
    try encodeTuple(values: values)
  }
  
  func encodeArray(_ values: [ABIValue]) throws -> [UInt8] {
    try encodeUInt(.init(values.count)) + encodeTuple(values: values)
  }
  
  func decodeFixedSizeArray(_ bytes: [UInt8], valueType: ABIValueType, size: Int) throws -> [ABIValue] {
    try decodeTuple(bytes, withValueTypes: .init(repeating: valueType, count: size))
  }
  
  func decodeArray(_ bytes: [UInt8], valueType: ABIValueType) throws -> [ABIValue] {
    let count = try decodeUInt(bytes[safe: ..<32])
    return try decodeTuple(bytes[safe: 32...], withValueTypes: .init(repeating: valueType, count: Int(count)))
  }
}

// MARK: Tuple
extension ABIRawServiceImpl {
  func encodeTuple(values: [ABIValue]) throws -> [UInt8] {
    let encodedValues = try values.map(encodeRaw(_:))
    let dynamicHeadPlaceholder = encodeUInt(0)
    let tempHeads = values.indices.map { index in
      values[index].type.isDynamic ? dynamicHeadPlaceholder : encodedValues[index]
    }
    let tails = values.indices.map { index in
      values[index].type.isDynamic ? encodedValues[index] : []
    }
    let tailLocation = tempHeads.map(\.count).reduce(0, +)
    let heads = try values.indices.map { index -> [UInt8] in
      guard values[index].type.isDynamic else { return tempHeads[index] }
      let location = try tailLocation + tails[safe: ..<index].map(\.count).reduce(0, +)
      return encodeUInt(.init(location))
    }
    return (heads + tails).flatMap { $0 }
  }
  
  func decodeTuple(_ bytes: [UInt8], withValueTypes valueTypes: [ABIValueType]) throws -> [ABIValue] {
    var location = 0
    var items = [Int: ABIValue]()
    var dynamicLocations = [(index: Int, location: Int)]()
    for (index, valueType) in valueTypes.enumerated() {
      let endLocation = location + (valueType.encodedBytesSize ?? 32)
      let valueBytes = try bytes[safe: location..<endLocation]
      if valueType.isDynamic {
        dynamicLocations.append((index, Int(decodeUInt(valueBytes))))
      } else {
        items[index] = try decodeRaw(valueBytes, as: valueType)
      }
      location = endLocation
    }
    for (dynamicIndex, dynamicLocation) in dynamicLocations.enumerated() {
      let dynamicBytes: [UInt8]
      if dynamicLocations.indices.contains(dynamicIndex + 1) {
        dynamicBytes = try bytes[safe: dynamicLocation.location..<dynamicLocations[dynamicIndex + 1].location]
      } else {
        dynamicBytes = try bytes[safe: dynamicLocation.location...]
      }
      items[dynamicLocation.index] = try decodeRaw(dynamicBytes, as: valueTypes[dynamicLocation.index])
    }
    return items
      .sorted(by: { $0.key < $1.key })
      .map(\.value)
  }
}
