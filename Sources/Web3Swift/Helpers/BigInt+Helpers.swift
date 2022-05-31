// 
// 

import Foundation
import BigInt

public extension BigInt {
  init?(hexString: String) {
    self.init(hexString.removingHexPrefix(), radix: 16)
  }
  
  var hexString: String {
    String(self, radix: 16).appendingHexPrefixIfNeeded()
  }
}
