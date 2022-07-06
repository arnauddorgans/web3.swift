// 
// 

import Foundation

extension Array where Element == UInt8 {
  func bits() -> [String] {
    self
      .map { String($0, radix: 2) }
      .map { String(repeating: "0", count: 8 - $0.count) + $0 }
      .flatMap { $0.map { String($0 as Character) } }
  }
  
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
  
  static func random(size: Int) -> [UInt8] {
    (0..<size).map { _ in
      .random(in: UInt8.min...UInt8.max)
    }
  }
}

enum BytePaddingAlignment {
  case left
  case right
}
