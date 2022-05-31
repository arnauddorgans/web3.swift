// 
// 

import Foundation

struct JSONRPCParameters {
  typealias EncodingPart = (inout UnkeyedEncodingContainer) throws -> Void
  let encodingParts: [EncodingPart]
}

// MARK: Encodable
extension JSONRPCParameters: Encodable {
  func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    for encodingPart in encodingParts {
      try encodingPart(&container)
    }
  }
}
