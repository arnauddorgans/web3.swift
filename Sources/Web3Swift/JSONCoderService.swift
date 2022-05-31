// 
// 

import Foundation

protocol JSONCoderService {
  func encode<T>(_ value: T) throws -> Data where T: Encodable
  
  func decode<T>(_ data: Data) throws -> T where T: Decodable
  
  func setValue(_ value: Any, forUserInfoKey key: CodingUserInfoKey)
}
