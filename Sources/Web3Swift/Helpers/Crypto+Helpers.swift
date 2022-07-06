// 
// 

import Foundation
import CryptoSwift
import BigInt

func sha256<T>(_ bytes: T) -> [UInt8] where T: RandomAccessCollection, T.Element == UInt8 {
  SHA2(variant: .sha256).calculate(for: .init(bytes))
}

func keccak256<T>(_ bytes: T) -> [UInt8] where T: RandomAccessCollection, T.Element == UInt8 {
  SHA3(variant: .keccak256).calculate(for: .init(bytes))
}

func hmac<D, K>(_ data: D, _ key: K) throws -> [UInt8] where D: Collection, D.Element == UInt8, K: Collection, K.Element == UInt8 {
  try HMAC(key: .init(key), variant: .sha2(.sha512))
    .authenticate(.init(data))
}

func pbkdf2<P, S>(_ password: P, _ salt: S) throws -> [UInt8] where S: Collection, S.Element == UInt8, P: Collection, P.Element == UInt8 {
  try PKCS5.PBKDF2(password: .init(password), salt: .init(salt), iterations: 2048, variant: .sha2(.sha512)).calculate()
}

/// - seealso: https://en.bitcoin.it/wiki/Base58Check_encoding
func base58<T>(_ bytes: T) -> [UInt8] where T: RandomAccessCollection, T.Element == UInt8 {
  let alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".utf8.map { $0 }
  var bigInt = BigUInt(.init(bytes))
  var output: [UInt8] = []
  while bigInt > 0 {
    let (quotient, remainder) = bigInt.quotientAndRemainder(dividingBy: .init(alphabet.count))
    output.insert(alphabet[Int(remainder)], at: 0)
    bigInt = quotient
  }
  let leadingZeroBytes = bytes.prefix(while: { $0 == 0x0 }).count
  let prefix: [UInt8] = .init(repeating: alphabet[0], count: leadingZeroBytes)
  output.insert(contentsOf: prefix, at: 0)
  return output
}
