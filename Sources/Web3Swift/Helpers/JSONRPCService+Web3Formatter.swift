// 
// 

import Foundation

extension JSONRPCService {
  func request<T>(method: String, formatter: T.Type, @JSONRPCParametersBuilder parameters: () -> JSONRPCParameters) async throws -> T.Value where T: Web3Formatter {
    let web3formatted: Web3Formatted<T> = try await request(method: method, parameters: parameters)
    return web3formatted.wrappedValue
  }
}
