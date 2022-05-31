// 
// 

import Foundation

/// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html#id47
public struct FeeHistory: Decodable {
  /// Lowest number block of the returned range.
  @Web3Formatted<HexToNumber>
  public private(set) var oldestBlock: Int
  /// An array of block base fees per gas. This includes the next block after the newest of the returned range, because this value can be derived from the newest block.
  /// Zeroes are returned for pre-EIP-1559 blocks.
  @Web3Formatted<[HexToNumber]>
  public private(set) var baseFeePerGas: [Int]
  /// An array of block gas used ratios. These are calculated as the ratio of gasUsed and gasLimit.
  public let gasUsedRatio: [Double]
  /// An array of effective priority fee per gas data points from a single block. All zeroes are returned if the block is empty.
  @Web3Formatted<[[HexToNumber]]>
  public private(set) var reward: [[Int]]
}
