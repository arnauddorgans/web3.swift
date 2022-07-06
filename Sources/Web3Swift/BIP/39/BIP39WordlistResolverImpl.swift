// 
// 

import Foundation

final class BIP39WordlistResolverImpl: BIP39WordlistResolver {
  private var cachedWords: [BIP39Wordlist: [String]] = [:]
  
  /// - seealso: https://github.com/bitcoin/bips/blob/master/bip-0039/bip-0039-wordlists.md
  func words(for wordlist: BIP39Wordlist) throws -> [String] {
    if let words = cachedWords[wordlist] {
      return words
    }
    guard let url = Bundle.module.url(forResource: wordlist.rawValue, withExtension: "bip39"),
          let string = try? String(contentsOf: url)
    else {
      throw BIP39WordlistResolverError.invalidFile
    }
    let words = string
      .components(separatedBy: .newlines)
      .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
      .filter { !$0.isEmpty }
    cachedWords[wordlist] = words
    return words
  }
}

enum BIP39WordlistResolverError: Error {
  case invalidFile
}
