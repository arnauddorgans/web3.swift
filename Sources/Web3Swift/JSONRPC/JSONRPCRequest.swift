// 
// 

import Foundation

/// - seealso: https://www.jsonrpc.org/specification#request_object
struct JSONRPCRequest<Parameters>: Encodable where Parameters: Encodable {
  /// A String specifying the version of the JSON-RPC protocol. MUST be exactly "2.0".
  let jsonrpc: String = "2.0"
  /// A String containing the name of the method to be invoked.
  let method: String
  /// A Structured value that holds the parameter values to be used during the invocation of the method. This member MAY be omitted.
  let params: Parameters
  /// An identifier established by the Client that MUST contain a String, Number, or NULL value if included.
  let id: String?
}
