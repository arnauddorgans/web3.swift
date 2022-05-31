// 
// 

import Foundation

@resultBuilder
enum JSONRPCParametersBuilder {
  static func buildBlock(_ component: [JSONRPCParameters.EncodingPart]...) -> [JSONRPCParameters.EncodingPart] {
    component.flatMap { $0 }
  }
  
  static func buildExpression<T>(_ expression: T) -> [JSONRPCParameters.EncodingPart] where T: Encodable {
    [{ try $0.encode(expression) }]
  }
  
  static func buildOptional(_ component: [JSONRPCParameters.EncodingPart]?) -> [JSONRPCParameters.EncodingPart] {
    component ?? []
  }
  
  static func buildFinalResult(_ component: [JSONRPCParameters.EncodingPart]) -> JSONRPCParameters {
    JSONRPCParameters(encodingParts: component)
  }
}
