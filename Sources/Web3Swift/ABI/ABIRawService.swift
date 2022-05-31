// 
// 

import Foundation

protocol ABIRawService {
  func encodeRawFunctionSignature(_ signature: String) throws -> [UInt8]
  
  func encodeRaw(_ value: ABIValue) throws -> [UInt8]
  
  func decodeRaw(_ bytes: [UInt8], as valueType: ABIValueType) throws -> ABIValue
}
