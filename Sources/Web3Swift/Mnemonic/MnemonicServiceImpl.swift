// 
// 

import Foundation

final class MnemonicServiceImpl: MnemonicService {
  func mnemonic(entropy: [UInt8], using dictionary: MnemonicDictionary) throws -> [String] {
    let entropyBytes = entropy.bytes()
    guard entropyBytes.count % 32 == 0 else {
      throw MnemonicError.invalidEntropy
    }
    let checksumBytes = sha256(entropy).bytes().prefix(entropyBytes.count/32)
    let bytes = entropyBytes + checksumBytes
    return try bytes.chunked(into: 11).map { indexBytes in
      guard let index = Int(indexBytes.joined(), radix: 2) else {
        throw MnemonicError.invalidBytes
      }
      guard let word = dictionary.word(atIndex: index) else {
        throw MnemonicError.invalidWord
      }
      return word
    }
  }
  
  func secretKey(mnemonic: [String], using dictionary: MnemonicDictionary) throws -> [UInt8] {
    guard mnemonic.allSatisfy(dictionary.contains(word:)) else {
      throw MnemonicError.invalidWord
    }
    return try pbkdf2(mnemonic.joined(separator: " ").decomposedStringWithCompatibilityMapping.utf8,
                      "mnemonic".decomposedStringWithCompatibilityMapping.utf8)
  }
}

// MARK: Error
private enum MnemonicError: Error {
  case invalidEntropy
  case invalidBytes
  case invalidWord
}
