// 
// 

import Foundation
import BigInt

/// The transaction call object
public struct TransactionCall: Encodable {
  /// The address for the sending account.
  public var from: Address?
  /// The destination address of the message, left undefined for a contract-creation transaction.
  public var to: Address?
  /// The amount of gas to use for the transaction (unused gas is refunded).
  public var gas: Int?
  /// The price of gas for this transaction in wei, defaults to web3.eth.gasPrice.
  public var gasPrice: BigInt?
  /// The value transferred for the transaction in wei, also the endowment if it’s a contract-creation transaction.
  public var value: BigInt?
  /// Either a ABI byte string containing the data of the function call on a contract, or in the case of a contract-creation transaction the initialisation code.
  public var data: UnformattedData?
}
