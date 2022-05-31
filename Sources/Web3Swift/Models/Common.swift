// 
// 

import Foundation

public struct Common: Encodable {
  /// The custom chain properties
  public var customChain: CustomChain
  /// mainnet, goerli, kovan, rinkeby, or ropsten
  public var baseChain: String?
  /// chainstart, homestead, dao, tangerineWhistle, spuriousDragon, byzantium, constantinople, petersburg, istanbul, berlin, or london
  public var hardfork: String?
}
