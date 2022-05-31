// 
// 

import Foundation
import BigInt

final class Web3UtilsImpl: Web3Utils {  
  func hexToBN(_ hexString: String) throws -> BigInt {
    guard hexString.isHex, let bigInt = BigInt(hexString: hexString) else {
      throw Web3UtilsError(message: "Given value \"\(hexString)\" is not a valid hex string.")
    }
    return bigInt
  }
  
  func hexToNumber(_ hexString: String) throws -> Int {
    let bigInt = try hexToBN(hexString)
    return Int(bigInt)
  }
  
  func numberToHex(_ number: Int) -> String {
    BigInt(number).hexString
  }
}

// MARK: Error
private struct Web3UtilsError: Error, LocalizedError {
  let message: String
  
  var errorDescription: String? { message }
}
