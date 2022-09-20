// 
// 

import Foundation

final class JSONRPCServiceImpl: JSONRPCService {
    private let networkingService: NetworkingService
    private let environmentService: EnvironmentService
    private let jsonCoderService: JSONCoderService
    
    init(environmentService: EnvironmentService,
         jsonCoderService: JSONCoderService,
         networkingService: NetworkingService) {
        self.environmentService = environmentService
        self.jsonCoderService = jsonCoderService
        self.networkingService = networkingService
    }
    
    func request<Response>(method: String, @JSONRPCParametersBuilder parameters: () -> JSONRPCParameters) async throws -> Response where Response: Decodable {
        let request = JSONRPCRequest(method: method,
                                     params: parameters(),
                                     id: UUID().uuidString)
        let httpRequest = HTTPRequest(
            url: environmentService.url,
            method: "POST",
            headers: ["Content-Type": "application/json"],
            body: try jsonCoderService.encode(request)
        )
        let data = try await networkingService.request(httpRequest)
        let response: JSONRPCResponse<Response> = try jsonCoderService.decode(data)
        return try response.result.get()
    }
}
