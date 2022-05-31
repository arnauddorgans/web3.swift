// 
// 

import Foundation

public protocol Web3Optional {
  static var none: Self { get }
}

extension Optional: Web3Optional { }
