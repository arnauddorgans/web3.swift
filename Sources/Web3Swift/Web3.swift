// 
// 

import Foundation

public final class Web3 {
    /// The web3 eth service allows you to interact with an Ethereum blockchain and Ethereum smart contracts.
    /// - seealso: https://web3js.readthedocs.io/en/v1.7.3/web3-eth.html
    public let eth: ETHService
    
    public let utils: Web3Utils
    
    public init(url: URL, networkingService: NetworkingService) {
        let environmentService = EnvironmentServiceImpl(url: url)
        let utils = Web3UtilsImpl()
        let jsonCoderService = JSONCoderServiceImpl()
        jsonCoderService.setValue(utils, forUserInfoKey: .utils)
        let jsonRPCService = JSONRPCServiceImpl(environmentService: environmentService,
                                                jsonCoderService: jsonCoderService,
                                                networkingService: networkingService)
        let accountsService = AccountsServiceImpl()
        let abiService = ABIServiceImpl(rawService: ABIRawServiceImpl())
        self.eth = ETHServiceImpl(accountsService: accountsService,
                                  abiService: abiService,
                                  jsonRPCService: jsonRPCService,
                                  utils: utils)
        self.utils = utils
    }
}

public extension Web3 {
    convenience init(url: URL) {
        self.init(url: url, networkingService: NetworkingServiceImpl(urlSession: .shared))
    }
}
