// 
// 

import Foundation

extension CodingUserInfoKey {
  static let utils: CodingUserInfoKey = .init(rawValue: "web3_utils")!
}

extension Dictionary where Key == CodingUserInfoKey {
  var utils: Web3Utils! { self[.utils] as? Web3Utils }
}
