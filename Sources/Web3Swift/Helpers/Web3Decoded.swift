// 
// 

import Foundation

@propertyWrapper
public final class Web3Decoded<T> {
  public var wrappedValue: T
  
  public init<S>(_ keyPath: (Web3Utils) -> (S) -> T) {
    fatalError()
  }
  
  public init<S>(_ keyPath: (Web3Utils) -> (S) throws -> T) {
    fatalError()
  }
}
