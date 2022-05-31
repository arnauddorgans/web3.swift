// 
// 

import Foundation

final class JSONCoderServiceImpl {
  private lazy var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dataDecodingStrategy = .custom({ decoder in
      let container = try decoder.singleValueContainer()
      let string = try container.decode(String.self)
      return .init(hex: string)
    })
    return decoder
  }()
  
  private lazy var encoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.dataEncodingStrategy = .custom({ data, encoder in
      var container = encoder.singleValueContainer()
      try container.encode(data.toHexString().appendingHexPrefixIfNeeded())
    })
    return encoder
  }()
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
