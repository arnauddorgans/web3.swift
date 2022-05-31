// 
// 

import Foundation
import BigInt

// MARK: UInt
public extension ABIValue {
  func uint8() throws -> UInt8 {
    guard case let .uint(size, value) = self, size == 8 else { throw SwiftCastingError() }
    return .init(value)
  }
  
  func uint16() throws -> UInt16 {
    guard case let .uint(size, value) = self, size <= 16 else { throw SwiftCastingError() }
    return .init(value)
  }
  
  func uint32() throws -> UInt32 {
    guard case let .uint(size, value) = self, size <= 32 else { throw SwiftCastingError() }
    return .init(value)
  }
  
  func bigUInt() throws -> BigUInt {
    guard case let .uint(size, value) = self, size <= 256 else { throw SwiftCastingError() }
    return .init(value)
  }
}

// MARK: Int
public extension ABIValue {
  func int8() throws -> UInt8 {
    guard case let .int(size, value) = self, size == 8 else { throw SwiftCastingError() }
    return .init(value)
  }
  
  func int16() throws -> UInt16 {
    guard case let .int(size, value) = self, size <= 16 else { throw SwiftCastingError() }
    return .init(value)
  }
  
  func int32() throws -> UInt32 {
    guard case let .int(size, value) = self, size <= 32 else { throw SwiftCastingError() }
    return .init(value)
  }
  
  func bigInt() throws -> BigInt {
    guard case let .int(size, value) = self, size <= 256 else { throw SwiftCastingError() }
    return .init(value)
  }
}

// MARK: Bool
public extension ABIValue {
  func bool() throws -> Bool {
    guard case let .bool(value) = self else { throw SwiftCastingError() }
    return value
  }
}

// MARK: Error
extension ABIValue {
  struct SwiftCastingError: Error { }
}
