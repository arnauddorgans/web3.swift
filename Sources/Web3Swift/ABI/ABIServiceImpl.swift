// 
// 

import Foundation

final class ABIServiceImpl {
  private let rawService: ABIRawService
  
  init(rawService: ABIRawService) {
    self.rawService = rawService
  }
}

// MARK: ABIService
extension ABIServiceImpl: ABIService {
  func encodeFunctionSignature(name: String, parameters: [ABIValueType]) throws -> UnformattedData {
    let signature = name + ABIValueType.tuple(parameters).signature
    let bytes = try rawService.encodeRawFunctionSignature(signature)
    return .init(bytes: bytes)
  }
  
  func encodeParameter(_ value: ABIValue) throws -> UnformattedData {
    let bytes = try rawService.encodeRaw(.tuple([value]))
    return .init(bytes: bytes)
  }
  
  func encodeParameters(_ values: [ABIValue]) throws -> UnformattedData {
    let bytes = try rawService.encodeRaw(.tuple(values))
    return .init(bytes: bytes)
  }
  
  func encodeFunctionCall(name: String, parameters: [ABIValue]) throws -> UnformattedData {
    let signature = try encodeFunctionSignature(name: name, parameters: parameters.map(\.type))
    let bytes = try signature.bytes + encodeParameters(parameters).bytes
    return .init(bytes: bytes)
  }
  
  func decodeParameter(_ data: Data, as valueType: ABIValueType) throws -> ABIValue {
    guard case let .tuple(values) = try rawService.decodeRaw(data.bytes, as: .tuple([valueType])) else { throw ABICodingError() }
    return values[0]
  }
  
  func decodeParameters(_ data: Data, as valueTypes: [ABIValueType]) throws -> [ABIValue] {
    guard case let .tuple(values) = try rawService.decodeRaw(data.bytes, as: .tuple(valueTypes)) else { throw ABICodingError() }
    return values
  }
}
