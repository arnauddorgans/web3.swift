// 
// 

import Foundation

protocol MnemonicService {
  func mnemonic(entropy: [UInt8], using dictionary: MnemonicDictionary) throws -> [String]
  
  func secretKey(mnemonic: [String], using dictionary: MnemonicDictionary) throws -> [UInt8]
}
