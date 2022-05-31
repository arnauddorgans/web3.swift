// 
// 

import Foundation

struct JSONRPCError: Error, Decodable {
  /// A Number that indicates the error type that occurred.
  let code: Int
  /// A String providing a short description of the error.
  let message: String
}

// MARK: LocalizedError
extension JSONRPCError: LocalizedError {
  var errorDescription: String? { message }
}
