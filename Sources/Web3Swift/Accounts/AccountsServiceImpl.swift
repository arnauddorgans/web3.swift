// 
// 

import Foundation

final class AccountsServiceImpl: AccountsService {
  
  /// - seealso: https://github.com/VictorTaelin/eth-lib/blob/master/lib/account.js
  func create() throws -> Account {
    let innerHex = keccak256(.random(size: 32) + .random(size: 32))
    let middleHex = (.random(size: 32) + innerHex) + .random(size: 32)
    let outerHex = keccak256(middleHex)
    return try privateKeyToAccount(outerHex)
  }
  
  func privateKeyToAccount(_ privateKey: [UInt8]) throws -> Account {
    let privateKey = try secp256k1PrivateKey(bytes: privateKey)
    let address = try privateKeyToAddress(privateKey)
    return .init(address: "0x" + address.toHexString(), privateKey: privateKey.bytes)
  }
}

private extension AccountsServiceImpl {
  func privateKeyToAddress(_ privateKey: ECDSAPrivateKey) throws -> [UInt8] {
    guard !privateKey.publicKey.isCompressed else { throw AccountError.invalidPublicKey }
    // First byte of serialized public key must be 0x4 (uncompressed type prefix)
    guard privateKey.publicKey.bytes[0] == 0x4 else { throw AccountError.invalidPublicKey }
    // You get a public address for your account by taking the last 20 bytes of the Keccak-256 hash of the public key.
    // Type prefix must be omitted on address computation
    let encodedKey = keccak256(privateKey.publicKey.bytes.dropFirst())
    return .init(encodedKey.dropFirst(encodedKey.count - 20))
  }
}

// MARK: Error
enum AccountError: Error {
  case invalidPublicKey
}
