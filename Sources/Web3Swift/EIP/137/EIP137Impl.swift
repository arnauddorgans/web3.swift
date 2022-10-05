// 
// 

import Foundation

final class EIP137Impl: EIP137 {
    func namehash(_ string: String) -> [UInt8] {
        if string.isEmpty {
            return [0x0].padded(to: 32, alignment: .right)
        }
        let (label, _, remainder) = string.partition(".")
        return keccak256(namehash(remainder) + keccak256(Data(label.utf8)))
    }
}

private extension String {
    func partition(_ separator: String) -> (before: String, separator: String, after: String) {
        if let range = range(of: separator) {
            return (String(self[..<range.lowerBound]), String(self[range]), String(self[range.upperBound...]))
        }
        return (self, "", "")
    }
}
