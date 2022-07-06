// 
// 

import Foundation

protocol BIP39WordlistResolver {
  func words(for wordlist: BIP39Wordlist) throws -> [String]
}
