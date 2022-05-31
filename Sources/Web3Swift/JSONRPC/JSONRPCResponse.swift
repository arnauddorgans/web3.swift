// 
// 

import Foundation

/// - seealso: https://www.jsonrpc.org/specification#response_object
struct JSONRPCResponse<Response> {
  /// A String specifying the version of the JSON-RPC protocol. MUST be exactly "2.0".
  let jsonrpc: String
  /// The value of this member is determined by the method invoked on the Server.
  let result: Result<Response, JSONRPCError>
  /// It MUST be the same as the value of the id member in the Request Object.
  let id: String?
}

// MARK: Decodable
extension JSONRPCResponse: Decodable where Response: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    jsonrpc = try container.decode(String.self, forKey: .jsonrpc)
    if container.contains(.content) {
      result = .success(try container.decode(Response.self, forKey: .content))
    } else {
      result = .failure(try container.decode(JSONRPCError.self, forKey: .error))
    }
    id = try container.decodeIfPresent(String.self, forKey: .id)
  }
}

extension JSONRPCResponse {
  enum CodingKeys: String, CodingKey {
    case jsonrpc
    case content = "result"
    case error
    case id
  }
}
