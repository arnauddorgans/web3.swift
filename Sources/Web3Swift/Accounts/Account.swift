// 
// 

import Foundation

/// The account object.
/// - seealso: https://web3js.readthedocs.io/en/v1.7.4/web3-eth-accounts.html#returns
public struct Account {
  /// The account address.
  public let address: Address
  /// The accounts private key. This should never be shared or stored unencrypted in localstorage! Also make sure to null the memory after usage.
  public let privateKey: [UInt8]
}
