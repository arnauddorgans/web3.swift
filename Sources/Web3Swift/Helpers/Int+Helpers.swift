// 
// 

import Foundation

extension Int {
  func roundedUp(toMultipleOf multipleOf: Int) -> Int {
    Swift.max(Int((Double(self)/Double(multipleOf)).rounded(.up)), 1) * multipleOf
  }
}
