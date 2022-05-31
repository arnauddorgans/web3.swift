// 
// 

import Foundation

final class JSONCoderServiceImpl {
  private let decoder = JSONDecoder()
  private let encoder = JSONEncoder()
}

// MARK: JSONCoderService
extension JSONCoderServiceImpl: JSONCoderService {
  func encode<T>(_ value: T) throws -> Data where T: Encodable {
    try encoder.encode(value)
  }
  
  func decode<T>(_ data: Data) throws -> T where T: Decodable {
    try decoder.decode(T.self, from: data)
  }
  
  func setValue(_ value: Any, forUserInfoKey key: CodingUserInfoKey) {
    decoder.userInfo[key] = value
    encoder.userInfo[key] = value
  }
}
