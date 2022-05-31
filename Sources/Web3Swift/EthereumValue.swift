////
////
//
//import Foundation
//import BigInt
//
//public struct EthereumValue {
//  public var wei: BigInt
//
//  public init(wei: BigInt) {
//    self.wei = wei
//  }
//}
//
//// MARK: Decodable
//extension EthereumValue: Decodable {
//  public init(from decoder: Decoder) throws {
//    let container = try decoder.singleValueContainer()
//    let wei = try container.decode(Quantity.self).bigIntValue
//    self.init(wei: wei)
//  }
//}
//
//// MARK: Encodable
//extension EthereumValue: Encodable {
//  public func encode(to encoder: Encoder) throws {
//    var container = encoder.singleValueContainer()
//    try container.encode(Quantity(bigIntValue: wei))
//  }
//}
//
//public extension EthereumValue {
//  func doubleValue(unit: Unit) -> Double? {
//    Double(stringValue(unit: unit))
//  }
//
//  func stringValue(unit: Unit) -> String {
//    doubleStringValue(unit: unit)
//  }
//
//  func formattedValue(unit: Unit? = nil) -> String {
//    let unit = unit ?? preferredUnit()
//    return doubleStringValue(unit: unit) + " \(unit.symbol)"
//  }
//
//  func preferredUnit() -> Unit {
//    .ether
//  }
//}
//
//extension EthereumValue: CustomStringConvertible {
//  public var description: String {
//    formattedValue()
//  }
//}
//
//private extension EthereumValue {
//  func doubleStringValue(unit: Unit) -> String {
//    var string = String(abs(wei))
//    let leadingZeroCount = max(0, (unit.power + 1) - string.count)
//    string = String(repeating: "0", count: leadingZeroCount) + string
//    let decimalOffset = -unit.power + 1
//    if decimalOffset < 0 {
//      let decimalStringIndex = string.index(before: string.index(string.endIndex, offsetBy: decimalOffset))
//      let integerPart = String(string[..<decimalStringIndex])
//      let decimalPart = String(
//        string[decimalStringIndex...].reversed()
//        .drop(while: { $0 == "0" })
//        .reversed()
//      )
//      if decimalPart.isEmpty {
//        string = integerPart
//      } else {
//        string = "\(integerPart).\(decimalPart)"
//      }
//    }
//    if wei.sign == .minus {
//      string = "-" + string
//    }
//    return string
//  }
//}
//
//public extension EthereumValue {
//  enum Unit: CaseIterable {
//    case wei
//    case gwei
//    case ether
//
//    var divider: BigInt {
//      BigInt(10).power(power)
//    }
//
//    var power: Int {
//      switch self {
//      case .wei:    return 0
//      case .gwei:   return 9
//      case .ether:  return 18
//      }
//    }
//
//    var symbol: String {
//      switch self {
//      case .wei:
//        return "wei"
//      case .gwei:
//        return "Gwei"
//      case .ether:
//        return "ETH"
//      }
//    }
//  }
//}
