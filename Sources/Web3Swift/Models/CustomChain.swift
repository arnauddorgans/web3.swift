// 
// 

import Foundation

public struct CustomChain: Encodable {
  /// The name of the chain
  public var name: String?
  /// Network ID of the custom chain
  public var networkId: Int
  /// Chain ID of the custom chain
  public var chainId: Int
}
