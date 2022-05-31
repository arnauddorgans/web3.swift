// 
// 

import Foundation

extension RandomAccessCollection {
  private func subSequence(fromRange range: Range<Index>) throws -> [Element] {
    guard range.lowerBound >= startIndex && range.upperBound <= endIndex else {
      throw SubSequenceError.outOfBounds
    }
    return .init(self[range])
  }
  
  subscript<Range>(safe range: Range) -> [Element] where Range: RangeExpression, Range.Bound == Index {
    get throws {
      try subSequence(fromRange: range.relative(to: self))
    }
  }
}

enum SubSequenceError: Error {
  case outOfBounds
}
