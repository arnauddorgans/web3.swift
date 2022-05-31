// 
// 

import Foundation

public final class Web3 {
  /// The web3 eth service allows you to interact with an Ethereum blockchain and Ethereum smart contracts.
  /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html
  public let eth: ETHService
  
  public let utils: Web3Utils
  
  public init(url: URL) {
    let environmentService = EnvironmentServiceImpl(url: url)
    let utils = Web3UtilsImpl()
    let jsonCoderService = JSONCoderServiceImpl()
    jsonCoderService.setValue(utils, forUserInfoKey: .utils)
    let jsonRPCService = JSONRPCServiceImpl(environmentService: environmentService, jsonCoderService: jsonCoderService)
    let abiService = ABIServiceImpl(rawService: ABIRawServiceImpl())
    self.eth = ETHServiceImpl(abiService: abiService, jsonRPCService: jsonRPCService, utils: utils)
    self.utils = utils
  }
}
