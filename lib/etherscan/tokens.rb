require_relative 'api'

module Etherscan
  class Tokens < Etherscan::Api
    def total_supply(contract_address)
      params = {
        module: 'stats', action: 'tokensupply',
        contractaddress: contract_address
      }
      get(params)
    end

    def balance(address, contract_address)
      params = {
        module: 'account', action: 'tokenbalance',
        address: address, contractaddress: contract_address
      }
      get(params)
    end
  end
end
