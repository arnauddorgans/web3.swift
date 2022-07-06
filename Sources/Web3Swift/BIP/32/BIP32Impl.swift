// 
// 

import Foundation
import BigInt
import secp256k1

final class BIP32Impl: BIP32 {
//  func compute(seed: [UInt8]) throws {
//    let masterKey = try privateKeyAndChainCode(key: "Bitcoin seed".mnemonicBytes, data: seed)
//    let rootKey = rootKey(version: .mainnetPrivate,
//                          depth: 0,
//                          parentFingerprint: [0],
//                          childNumber: 0,
//                          chainCode: masterKey.chainCode,
//                          key: masterKey.privateKey)
//
//
//    let path_numbers: [UInt32] = [2147483692, 2147483708, 2147483648, 0, 0]
//    var depth: uint8 = 0
//    var private_key = masterKey.privateKey
//    var chain_code = masterKey.chainCode
//    for i in path_numbers {
//      depth += 1
//      let child_number = i
//      //let parent_fingerprint = fingerprint_from_private_key(private_key)
//      let privateKey = try SECP256K1Impl().createPrivateKey(bytes: private_key)
//      (private_key, chain_code) = try extendedPrivateKey(privateKey: privateKey.privateKey, chainCode: chain_code, childNumber: child_number)
//
//      let repKey = self.rootKey(version: .mainnetPrivate,
//                                depth: depth,
//                                parentFingerprint: [],
//                                childNumber: child_number,
//                                chainCode: chain_code,
//                                key: private_key)
//      print(String(data: .init(repKey), encoding: .utf8))
//    }
//  }
}

private extension BIP32Impl {
  func privateKeyAndChainCode(key: [UInt8], data: [UInt8]) throws -> (privateKey: [UInt8], chainCode: [UInt8]) {
    let bytes = try hmac(data, key)
    return (.init(bytes[0..<32]), .init(bytes[32..<64]))
  }
  
  func rootKey(version: BIP32Version,
               depth: UInt8,
               parentFingerprint: [UInt8],
               childNumber: UInt32,
               chainCode: [UInt8],
               key: [UInt8]) -> [UInt8] {
    let bytes = [
      version.bytes.padded(to: 4, alignment: .right),
      [depth],
      parentFingerprint.padded(to: 4, alignment: .right),
      childNumber.bytes.padded(to: 4, alignment: .right),
      chainCode.padded(to: 32, alignment: .right),
      key.padded(to: 33, alignment: .right)
    ].flatMap { $0 }
    let checksum = sha256(sha256(bytes)).prefix(4)
    return base58(bytes + checksum)
  }
  
  func serializeCurvePoint(_ point: secp256k1.Signing.XonlyKey) -> [UInt8] {
    if point.parity {
      return [0x3] + point.bytes
    } else {
      return [0x2] + point.bytes
    }
  }
  
  func extendedPrivateKey(privateKey: secp256k1.Signing.PrivateKey, chainCode: [UInt8], childNumber: UInt32) throws -> (privateKey: [UInt8], chainCode: [UInt8]) {
    var data: [UInt8]
    if childNumber >= UInt32(pow(Double(2), Double(31))) {
      // Hardened key
      data = [0x0] + privateKey.rawRepresentation.bytes.padded(to: 32, alignment: .right)
    } else {
      // Non-hardened key
      data = serializeCurvePoint(privateKey.publicKey.xonly)
    }
    data += childNumber.bytes.padded(to: 4, alignment: .right)
    let extendedPrivateKey = try privateKeyAndChainCode(key: chainCode, data: data)
    return extendedPrivateKey
  }
}

private extension String {
  var mnemonicBytes: [UInt8] {
    .init(self.decomposedStringWithCompatibilityMapping.utf8)
  }
}

extension UInt32 {
  var bytes: [UInt8] {
    withUnsafeBytes(of: bigEndian, { Array($0) })
  }
}
