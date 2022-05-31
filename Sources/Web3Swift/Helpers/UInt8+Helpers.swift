// 
// 

import Foundation

extension Array where Element == UInt8 {
  func padded(to multipleOf: Int,
              withByte byte: UInt8 = 0x0,
              alignment: BytePaddingAlignment) -> [UInt8] {
    let count = count.roundedUp(toMultipleOf: multipleOf)
    let bytes: [UInt8] = .init(repeating: byte, count: count - self.count)
    switch alignment {
    case .left:   return self + bytes
    case .right:  return bytes + self
    }
  }
  
  var data: Data { .init(self) }
}

enum BytePaddingAlignment {
  case left
  case right
}
