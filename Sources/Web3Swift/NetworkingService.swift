// 
// 

import Foundation

public struct HTTPRequest {
    public let url: URL
    public let method: String
    public let headers: [String: String]
    public let body: Data?
}

public protocol NetworkingService {
    func request(_ httpRequest: HTTPRequest) async throws -> Data
}
