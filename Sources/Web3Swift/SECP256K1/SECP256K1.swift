// 
// 

import Foundation
import secp256k1

func secp256k1PrivateKey(bytes: [UInt8]) throws -> ECDSAPrivateKey {
  let privateKey = try secp256k1.Signing.PrivateKey(rawRepresentation: bytes, format: .uncompressed)
  return .init(privateKey: privateKey)
}

struct ECDSAPrivateKey {
  fileprivate let privateKey: secp256k1.Signing.PrivateKey

  var bytes: [UInt8] { privateKey.rawRepresentation.bytes }
  var publicKey: ECDSAPublicKey { .init(publicKey: privateKey.publicKey) }
}

struct ECDSAPublicKey {
  fileprivate let publicKey: secp256k1.Signing.PublicKey
  
  var isCompressed: Bool { publicKey.format == .compressed }

  var bytes: [UInt8] { publicKey.rawRepresentation.bytes }
}
