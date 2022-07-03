// 
// 

import Foundation

protocol SECP256K1 {
  func createPrivateKey(bytes: [UInt8]) throws -> ECDSAPrivateKey
  
  #warning("Address is Ethereum related not SECP256K1")
  func address(publicKey: ECDSAPublicKey) throws -> [UInt8]
}
