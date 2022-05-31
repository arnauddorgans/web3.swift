// 
// 

import Foundation

public protocol Web3Formatter {
  associatedtype Value
  
  static func decode(from decoder: Decoder) throws -> Value
}
