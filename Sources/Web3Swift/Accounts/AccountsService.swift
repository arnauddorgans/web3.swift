// 
// 

import Foundation

public protocol AccountsService {
  /// Generates an account object with private key and public key.
  func create() throws -> Account
  
  /// Creates an account object from a private key.
  func privateKeyToAccount(_ privateKey: [UInt8]) throws -> Account
}
