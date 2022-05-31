// 
// 

import Foundation

public enum HexToBool: Web3Formatter {
  public static func decode(from decoder: Decoder) throws -> Bool {
    let number = try HexToNumber.decode(from: decoder)
    switch number {
    case 0: return false
    case 1: return true
    default:
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Given value \"\(number)\" is not a valid bool number."))
    }
  }
}
