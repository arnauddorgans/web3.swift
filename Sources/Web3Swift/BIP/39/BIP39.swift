// 
// 

import Foundation

/// - seealso: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki
protocol BIP39 {
  func mnemonic(entropy: [UInt8], using wordlist: BIP39Wordlist) throws -> [String]
  
  func seed(mnemonic: [String], passphrase: String, using wordlist: BIP39Wordlist) throws -> [UInt8]
}
