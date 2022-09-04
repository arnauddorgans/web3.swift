// 
// 

import XCTest
@testable import Web3Swift

final class ABIRawServiceTests: XCTestCase {
  private var service: ABIRawService!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    service = ABIRawServiceImpl()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  // MARK: UInt
  func testEncodeUInt() throws {
    let bytes = try service.encodeRaw(.uint(69))
    XCTAssertEqual(
      bytes.toHexString(),
      "0000000000000000000000000000000000000000000000000000000000000045"
    )
  }
  
  func testDecodeUInt() throws {
    let bytes: [UInt8] = .init(hex: "0000000000000000000000000000000000000000000000000000000000000045")
    let uint = try service.decodeRaw(bytes, as: .uint)
    XCTAssertEqual(uint, .uint(69))
  }
  
  // MARK: Int
  func testEncodeInt() throws {
    let bytes = try service.encodeRaw(.int(69))
    XCTAssertEqual(
      bytes.toHexString(),
      "0000000000000000000000000000000000000000000000000000000000000045"
    )
  }
  
  func testEncodeNegativeInt() throws {
    let bytes = try service.encodeRaw(.int(-69))
    XCTAssertEqual(
      bytes.toHexString(),
      "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbb"
    )
  }
  
  func testDecodeInt() throws {
    let bytes: [UInt8] = .init(hex: "0000000000000000000000000000000000000000000000000000000000000045")
    let uint = try service.decodeRaw(bytes, as: .int)
    XCTAssertEqual(uint, .int(69))
  }
  
  func testDecodeNegativeInt() throws {
    let bytes: [UInt8] = .init(hex: "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbb")
    let uint = try service.decodeRaw(bytes, as: .int)
    XCTAssertEqual(uint, .int(-69))
  }
  
  // MARK: Bool
  func testEncodeBool() throws {
    let bytes = try service.encodeRaw(.bool(true))
    XCTAssertEqual(
      bytes.toHexString(),
      "0000000000000000000000000000000000000000000000000000000000000001"
    )
  }
  
  func testEncodeFalseBool() throws {
    let bytes = try service.encodeRaw(.bool(false))
    XCTAssertEqual(
      bytes.toHexString(),
      "0000000000000000000000000000000000000000000000000000000000000000"
    )
  }
  
  func testDecodeBool() throws {
    let bytes: [UInt8] = .init(hex: "0000000000000000000000000000000000000000000000000000000000000001")
    let bool = try service.decodeRaw(bytes, as: .bool)
    XCTAssertEqual(bool, .bool(true))
  }
  
  func testDecodeFalseBool() throws {
    let bytes: [UInt8] = .init(hex: "0000000000000000000000000000000000000000000000000000000000000000")
    let bool = try service.decodeRaw(bytes, as: .bool)
    XCTAssertEqual(bool, .bool(false))
  }
  
  // MARK: Bytes
  func testEncodeFixedSizeBytes() throws {
    let encodedBytes = try service.encodeRaw(.sizedBytes(2, [0xff, 0x0]))
    XCTAssertEqual(
      encodedBytes.toHexString(),
      "ff00000000000000000000000000000000000000000000000000000000000000"
    )
  }
  
  func testEncodeBytes() throws {
    let encodedBytes = try service.encodeRaw(.bytes([0xff, 0x0]))
    XCTAssertEqual(
      encodedBytes.toHexString(),
      "0000000000000000000000000000000000000000000000000000000000000002ff00000000000000000000000000000000000000000000000000000000000000"
    )
  }
  
  func testDecodeFixedSizeBytes() throws {
    let bytes: [UInt8] = .init(hex: "ff00000000000000000000000000000000000000000000000000000000000000")
    let decodedBytes = try service.decodeRaw(bytes, as: .sizedBytes(2))
    XCTAssertEqual(decodedBytes, .sizedBytes(2, [0xff, 0x0]))
  }
  
  func testDecodeBytes() throws {
    let bytes: [UInt8] = .init(hex: "0000000000000000000000000000000000000000000000000000000000000002ff00000000000000000000000000000000000000000000000000000000000000")
    let decodedBytes = try service.decodeRaw(bytes, as: .bytes)
    XCTAssertEqual(decodedBytes, .bytes([0xff, 0x0]))
  }
  
  // MARK: String
  func testEncodeString() throws {
    let bytes = try service.encodeRaw(.string("Hello !"))
    XCTAssertEqual(bytes.toHexString(), "000000000000000000000000000000000000000000000000000000000000000748656c6c6f202100000000000000000000000000000000000000000000000000")
  }
  
  func testDecodeString() throws {
    let bytes: [UInt8] = .init(hex: "000000000000000000000000000000000000000000000000000000000000000748656c6c6f202100000000000000000000000000000000000000000000000000")
    let string = try service.decodeRaw(bytes, as: .string)
    XCTAssertEqual(string, .string("Hello !"))
  }
  
  // MARK: Array
  func testEncodeFixedSizeArray() throws {
    let bytes = try service.encodeRaw(.sizedArray(.int, 2, [.int(1), .int(-1)]))
    XCTAssertEqual(bytes.toHexString(), "0000000000000000000000000000000000000000000000000000000000000001ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
  }
  
  func testEncodeArray() throws {
    let bytes = try service.encodeRaw(.array(.int, [.int(1), .int(-1)]))
    XCTAssertEqual(bytes.toHexString(), "00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000001ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
  }
  
  func testDecodeFixedSizeArray() throws {
    let bytes: [UInt8] = .init(hex: "0000000000000000000000000000000000000000000000000000000000000001ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
    let fixedSizeArray = try service.decodeRaw(bytes, as: .sizedArray(.int, 2))
    XCTAssertEqual(fixedSizeArray, .sizedArray(.int, 2, [.int(1), .int(-1)]))
  }
  
  func testDecodeArray() throws {
    let bytes: [UInt8] = .init(hex: "00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000001ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
    let array = try service.decodeRaw(bytes, as: .array(.int))
    XCTAssertEqual(array, .array(.int, [.int(1), .int(-1)]))
  }
    

    // MARK: Address
    func testEncodeAddress() throws {
        let bytes = try service.encodeRaw(.address("0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb"))
        XCTAssertEqual(bytes.toHexString(), "000000000000000000000000b47e3cd837ddf8e4c57f05d70ab865de6e193bbb")
    }
    
    func testDecodeAddress() throws {
        let bytes: [UInt8] = .init(hex: "000000000000000000000000b47e3cd837ddf8e4c57f05d70ab865de6e193bbb")
        let address = try service.decodeRaw(bytes, as: .address)
        XCTAssertEqual(address, .address("0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb"))
    }

  
  // MARK: Tuple
  func testEncodeTypleWithDynamicAndStatic() throws {
    let bytes = try service.encodeRaw(.tuple([
      .bool(true),
      .array([.array([.uint(1), .uint(2)]), .array([.uint(3)])]),
      .uint8(3),
      .array([.string("one"), .string("two"), .string("three")])
    ]))
    XCTAssertEqual(
      bytes.toHexString(),
      "00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000001800000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000000036f6e650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000374776f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000057468726565000000000000000000000000000000000000000000000000000000"
    )
  }
  
  func testDecodeTupleWithDynamicAndStatic() throws {
    let bytes: [UInt8] = .init(hex: "00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000001800000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000000036f6e650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000374776f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000057468726565000000000000000000000000000000000000000000000000000000")
    let tuple = try service.decodeRaw(bytes, as: .tuple([
      .bool,
      .array(.array(.uint)),
      .uint(8),
      .array(.string)
    ]))
    guard case let .tuple(values) = tuple else { return XCTFail() }
    XCTAssertEqual(values, [
      .bool(true),
      .array([.array([.uint(1), .uint(2)]), .array([.uint(3)])]),
      .uint8(3),
      .array([.string("one"), .string("two"), .string("three")])
    ])
  }
  
  // MARK: Function Signature
  func testEncodeRawMethodID() throws {
    XCTAssertEqual(
      try service.encodeRawFunctionSignature("myMethod(uint256,string)").toHexString(),
      "24ee0097"
    )
  }
}
