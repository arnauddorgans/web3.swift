// 
// 

import Foundation

protocol JSONRPCService {
  func request<Response>(method: String, @JSONRPCParametersBuilder parameters: () -> JSONRPCParameters) async throws -> Response where Response: Decodable
}
