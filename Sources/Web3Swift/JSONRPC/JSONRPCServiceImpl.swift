// 
// 

import Foundation

final class JSONRPCServiceImpl: JSONRPCService {
  private let environmentService: EnvironmentService
  private let jsonCoderService: JSONCoderService
  
  init(environmentService: EnvironmentService, jsonCoderService: JSONCoderService) {
    self.environmentService = environmentService
    self.jsonCoderService = jsonCoderService
  }
  
  func request<Response>(method: String, @JSONRPCParametersBuilder parameters: () -> JSONRPCParameters) async throws -> Response where Response: Decodable {
    let request = JSONRPCRequest(method: method,
                                 params: parameters(),
                                 id: UUID().uuidString)
    var urlRequest = URLRequest(url: environmentService.url)
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = try jsonCoderService.encode(request)
    let data = try await URLSession.shared.data(for: urlRequest)
    let response: JSONRPCResponse<Response> = try jsonCoderService.decode(data.0)
    return try response.result.get()
  }
}
