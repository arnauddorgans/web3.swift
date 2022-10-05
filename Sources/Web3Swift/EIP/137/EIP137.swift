// 
// 

import Foundation

/// - seealso: https://eips.ethereum.org/EIPS/eip-137
protocol EIP137 {
    func namehash(_ string: String) -> [UInt8]
}
