//// 
//// 
//
//import Foundation
//
//final class MnemonicServiceImpl: MnemonicService {
//  func mnemonic(entropy: [UInt8], using dictionary: MnemonicDictionary) throws -> [String] {
//    let entropyBytes = entropy.bytes()
//    guard entropyBytes.count % 32 == 0 else {
//      throw MnemonicError.invalidEntropy
//    }
//    let checksumBytes = sha256(entropy).bytes().prefix(entropyBytes.count/32)
//    let bytes = entropyBytes + checksumBytes
//    return try bytes.chunked(into: 11).map { indexBytes in
//      guard let index = Int(indexBytes.joined(), radix: 2) else {
//        throw MnemonicError.invalidBytes
//      }
//      guard let word = dictionary.word(atIndex: index) else {
//        throw MnemonicError.invalidWord
//      }
//      return word
//    }
//  }
//  
//  func privateKey(mnemonic: [String], using dictionary: MnemonicDictionary) throws -> [UInt8] {
//    let words = mnemonic.compactMap { dictionary.word(startingWith: $0) }
//    guard words.count == mnemonic.count else {
//      throw MnemonicError.invalidWord
//    }
//    let joinedWords = words.joined(separator: " ")
//    let seed = try pbkdf2(joinedWords.mnemonicBytes, "mnemonic".mnemonicBytes)
//    let extendedPrivateKey = try hmac(seed, "Bitcoin seed".mnemonicBytes)
//    let privateKey = extendedPrivateKey[0..<32]
//    let chainCode = extendedPrivateKey[32..<64]
//    return .init(privateKey)
//  }
//}
//
//private extension String {
//  var mnemonicBytes: [UInt8] {
//    .init(self.decomposedStringWithCompatibilityMapping.utf8)
//  }
//}
//
//// MARK: Error
//private enum MnemonicError: Error {
//  case invalidEntropy
//  case invalidBytes
//  case invalidWord
//}
