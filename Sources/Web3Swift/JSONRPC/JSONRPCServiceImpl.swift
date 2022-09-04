// 
// 

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

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
    let data = try await URLSession.shared.request(urlRequest)
    let response: JSONRPCResponse<Response> = try jsonCoderService.decode(data.0)
    return try response.result.get()
  }
}

extension URLSession {
    func request(_ urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    continuation.resume(with: .failure(error))
                } else if let data = data, let response = response {
                    continuation.resume(with: .success((data, response)))
                } else {
                    continuation.resume(with: .failure(URLSessionError.unknown))
                }
            }
            task.resume()
        }
    }
}

enum URLSessionError: Error {
    case unknown
}
