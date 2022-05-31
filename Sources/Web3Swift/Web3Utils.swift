// 
// 

import Foundation
import BigInt

/// - seealso: web3-utils/src/utils.js
public protocol Web3Utils {
  /// Returns the BN representation of a given HEX value.
  func hexToBN(_ hexString: String) throws -> BigInt
  
  /// Returns the number representation of a given HEX value.
  func hexToNumber(_ hexString: String) throws -> Int
  
  /// Returns the HEX representation of a given number value.
  func numberToHex(_ number: Int) -> String
}
