// 
// 

import Foundation

public enum HexToNumber: Web3Formatter {
  public static func decode(from decoder: Decoder) throws -> Int {
    let container = try decoder.singleValueContainer()
    let hexString = try container.decode(String.self)
    return try decoder.userInfo.utils.hexToNumber(hexString)
  }
}
