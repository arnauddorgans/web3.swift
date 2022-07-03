// 
// 

import Foundation
import secp256k1

final class SECP256K1Impl: SECP256K1 {
  func createPrivateKey(bytes: [UInt8]) throws -> ECDSAPrivateKey {
    let privateKey = try secp256k1.Signing.PrivateKey(rawRepresentation: bytes, format: .uncompressed)
    return .init(privateKey: privateKey)
  }
  
  func address(publicKey: ECDSAPublicKey) throws -> [UInt8] {
    guard publicKey.publicKey.format == .uncompressed else { throw SECP256K1Error.invalidPublicKey }
    // First byte of serialized public key must be 0x4 (uncompressed type prefix)
    guard publicKey.bytes[0] == 0x4 else { throw SECP256K1Error.invalidPublicKey }
    // You get a public address for your account by taking the last 20 bytes of the Keccak-256 hash of the public key.
    // Type prefix must be omitted on address computation
    let encodedKey = keccak256(publicKey.bytes.dropFirst())
    return .init(encodedKey.dropFirst(encodedKey.count - 20))
  }
}

struct ECDSAPrivateKey {
  fileprivate let privateKey: secp256k1.Signing.PrivateKey

  var bytes: [UInt8] { privateKey.rawRepresentation.bytes }
  var publicKey: ECDSAPublicKey { .init(publicKey: privateKey.publicKey) }
}

struct ECDSAPublicKey {
  fileprivate let publicKey: secp256k1.Signing.PublicKey

  var bytes: [UInt8] { publicKey.rawRepresentation.bytes }
}

// MARK: Error
enum SECP256K1Error: Error {
  case invalidPublicKey
}
