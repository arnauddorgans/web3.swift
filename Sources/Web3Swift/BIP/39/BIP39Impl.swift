// 
// 

import Foundation

final class BIP39Impl: BIP39 {
  private let wordlistResolver: BIP39WordlistResolver
  
  init(wordlistResolver: BIP39WordlistResolver) {
    self.wordlistResolver = wordlistResolver
  }
  
  func mnemonic(entropy: [UInt8], using wordlist: BIP39Wordlist) throws -> [String] {
    let entropyBytes = entropy.bits()
    guard entropyBytes.count % 32 == 0 else {
      throw BIP39Error.invalidEntropy
    }
    let checksumBytes = sha256(entropy).bits().prefix(entropyBytes.count/32)
    let bytes = entropyBytes + checksumBytes
    let words = try wordlistResolver.words(for: wordlist)
    return try bytes.chunked(into: 11).map { indexBits in
      guard let index = Int(indexBits.joined(), radix: 2) else {
        throw BIP39Error.invalidIndexBits
      }
      guard words.indices.contains(index) else {
        throw BIP39Error.invalidWordlist
      }
      return words[index]
    }
  }
  
  func seed(mnemonic: [String], passphrase: String, using wordlist: BIP39Wordlist) throws -> [UInt8] {
    let words = try wordlistResolver.words(for: wordlist)
    let resolvedWords = mnemonic.compactMap { resolvedWord(for: $0, inside: words) }
    guard resolvedWords.count == mnemonic.count else {
      throw BIP39Error.invalidWord
    }
    let joinedWords = resolvedWords.joined(separator: " ")
    return try pbkdf2(joinedWords.mnemonicBytes, ("mnemonic" + passphrase).mnemonicBytes)
  }
}

private extension BIP39Impl {
  func resolvedWord(for word: String, inside words: [String]) -> String? {
    let words = words
      .filter { $0.mnemonicQuery.starts(with: word.mnemonicQuery) }
    guard words.count == 1 else {
      return words.first(where: { $0 == word })
    }
    return words.first
  }
}

// MARK: Helpers
private extension String {
  var mnemonicQuery: String {
    self.lowercased()
      .folding(options: .diacriticInsensitive, locale: .current)
      .trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  var mnemonicBytes: [UInt8] {
    .init(self.decomposedStringWithCompatibilityMapping.utf8)
  }
}

// MARK: Error
enum BIP39Error: Error {
  case invalidEntropy
  case invalidIndexBits
  case invalidWordlist
  case invalidWord
}
