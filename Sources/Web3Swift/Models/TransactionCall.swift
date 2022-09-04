// 
// 

import Foundation
import BigInt

/// The transaction call object
public struct TransactionCall: Encodable {
  /// The address for the sending account. Uses the web3.eth.defaultAccount property, if not specified. Or an address or index of a local wallet in web3.eth.accounts.wallet.
  public var from: Address?
  /// The destination address of the message, left undefined for a contract-creation transaction.
  public var to: Address?
  /// The value transferred for the transaction in wei, also the endowment if it’s a contract-creation transaction.
  public var value: BigInt?
  /// The amount of gas to use for the transaction (unused gas is refunded).
  public var gas: Int?
  /// The price of gas for this transaction in wei, defaults to web3.eth.gasPrice.
  public var gasPrice: BigInt?
  /// A positive unsigned 8-bit number between 0 and 0x7f that represents the type of the transaction.
  public var type: UInt8?
  /// The maximum fee per gas that the transaction is willing to pay in total
  public var maxFeePerGas: BigInt?
  /// The maximum fee per gas to give miners to incentivize them to include the transaction (Priority fee)
  public var maxPriorityFeePerGas: BigInt?
  /// A list of addresses and storage keys that the transaction plans to access
  public var accessList: [Address]?
  /// Either a ABI byte string containing the data of the function call on a contract, or in the case of a contract-creation transaction the initialisation code.
  public var data: UnformattedData?
  /// Integer of the nonce. This allows to overwrite your own pending transactions that use the same nonce.
  public var nonce: Int?
  /// Defaults to mainnet.
  public var chain: String?
  /// Defaults to london.
  public var hardfork: String?
  /// The common object
  public var common: Common?
    
    public init(from: Address? = nil,
                to: Address? = nil,
                value: BigInt? = nil,
                gas: Int? = nil,
                gasPrice: BigInt? = nil,
                type: UInt8? = nil,
                maxFeePerGas: BigInt? = nil,
                maxPriorityFeePerGas: BigInt? = nil,
                accessList: [Address]? = nil,
                data: UnformattedData? = nil,
                nonce: Int? = nil,
                chain: String? = nil,
                hardfork: String? = nil,
                common: Common? = nil) {
               self.from = from
               self.to = to
               self.value = value
               self.gas = gas
               self.gasPrice = gasPrice
               self.type = type
               self.maxFeePerGas = maxFeePerGas
               self.maxPriorityFeePerGas = maxPriorityFeePerGas
               self.accessList = accessList
               self.data = data
               self.nonce = nonce
               self.chain = chain
               self.hardfork = hardfork
               self.common = common
           }
}
