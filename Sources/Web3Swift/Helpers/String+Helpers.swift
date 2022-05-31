// 
// 

import Foundation

extension String {
  var isHex: Bool {
    starts(with: "0x", by: { $0.lowercased() == $1.lowercased() })
  }
  
  func appendingHexPrefixIfNeeded() -> String {
    !isHex ? "0x" + self : self
  }
  
  func removingHexPrefix() -> String {
    isHex ? String(dropFirst(2)) : self
  }
}
