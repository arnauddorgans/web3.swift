// 
// 

import Foundation
import CryptoSwift

func sha256<T>(_ bytes: T) -> [UInt8] where T: RandomAccessCollection, T.Element == UInt8 {
  SHA2(variant: .sha256).calculate(for: .init(bytes))
}

func keccak256<T>(_ bytes: T) -> [UInt8] where T: RandomAccessCollection, T.Element == UInt8 {
  SHA3(variant: .keccak256).calculate(for: .init(bytes))
}

func pbkdf2<T, P>(_ password: P, _ salt: T) throws -> [UInt8] where T: Collection, T.Element == UInt8, P: Collection, P.Element == UInt8 {
  try PKCS5.PBKDF2(password: .init(password), salt: .init(salt), iterations: 2048, variant: .sha2(.sha512)).calculate()
}
