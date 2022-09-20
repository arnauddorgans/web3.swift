// 
// 

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class NetworkingServiceImpl: NetworkingService {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func request(_ httpRequest: HTTPRequest) async throws -> Data {
        var urlRequest = URLRequest(url: httpRequest.url)
        for (key, value) in httpRequest.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        urlRequest.httpMethod = httpRequest.method
        urlRequest.httpBody = httpRequest.body
        let data = try await urlSession.request(urlRequest)
        return data.0
    }
}

private extension URLSession {
    func request(_ urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = dataTask(with: urlRequest) { data, response, error in
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

private enum URLSessionError: Error {
    case unknown
}
