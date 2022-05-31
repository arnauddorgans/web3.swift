// 
// 

import Web3Swift
import Foundation
import Darwin
import XCTest

extension Web3 {
  /// Returns end-to-end web3 implementation using environment.
  static func e2e() throws -> Web3 {
    let envURL = try XCTUnwrap(getenv("WEB3_URL"), "Invalid environment")
    let url = try XCTUnwrap(URL(string: String(cString: envURL)), "Invalid URL")
    return Web3(url: url)
  }
}
