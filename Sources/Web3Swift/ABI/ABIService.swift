// 
// 

import Foundation

public protocol ABIService {
  /// Encodes the function name to its ABI signature, which are the first 4 bytes of the sha3 hash of the function name including types.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth-abi.html#encodefunctionsignature
  func encodeFunctionSignature(name: String, parameters: [ABIValueType]) throws -> UnformattedData
  
  /// Encodes a parameter based on its type to its ABI representation.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth-abi.html#encodeparameter
  func encodeParameter(_ value: ABIValue) throws -> UnformattedData
  
  /// Encodes a function parameters based on its JSON interface object.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth-abi.html#encodeparameters
  func encodeParameters(_ values: [ABIValue]) throws -> UnformattedData
  
  /// Encodes a function call using its JSON interface object and given parameters.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth-abi.html#encodefunctioncall
  func encodeFunctionCall(name: String, parameters: [ABIValue]) throws -> UnformattedData
    
  /// Decodes an ABI encoded parameter to its Swift type.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth-abi.html#decodeparameter
  func decodeParameter(_ data: UnformattedData, as valueType: ABIValueType) throws -> ABIValue
  
  /// Decodes ABI encoded parameters to its Swift types.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth-abi.html#decodeparameters
  func decodeParameters(_ data: UnformattedData, as valueTypes: [ABIValueType]) throws -> [ABIValue]
}
