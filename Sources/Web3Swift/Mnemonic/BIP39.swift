// 
// 

import Foundation

/// - seealso: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki
final class BIP39: MnemonicDictionary {
  let words: [String]
  
  init() throws {
    guard let url = Bundle.module.url(forResource: "bip39-english", withExtension: "txt"),
          let string = try? String(contentsOf: url)
    else {
      throw BIP39Error.invalidLanguageFile
    }
    self.words = string
      .components(separatedBy: .newlines)
      .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
      .filter { !$0.isEmpty }
  }
}

// MARK: Error
private enum BIP39Error: Error {
  case invalidLanguageFile
}
