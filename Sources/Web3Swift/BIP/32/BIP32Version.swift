// 
// 

import Foundation

enum BIP32Version: String {
  case mainnetPublic = "0x0488B21E"
  case mainnetPrivate = "0x0488ADE4"
  case testnetPublic = "0x043587CF"
  case testnetPrivate = "0x04358394"
  
  var bytes: [UInt8] {
    .init(hex: rawValue)
  }
}
