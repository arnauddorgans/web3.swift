// 
// 

import Foundation
import BigInt

public enum HexToBN: Web3Formatter {
  public static func decode(from decoder: Decoder) throws -> BigInt {
    let container = try decoder.singleValueContainer()
    let hexString = try container.decode(String.self)
    return try decoder.userInfo.utils.hexToBN(hexString)
  }
}
