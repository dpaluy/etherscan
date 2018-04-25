require_relative 'api'

module Etherscan
  class Accounts < Etherscan::Api
    def address_balance(address)
      params = {
        module: 'account', action: 'balance',
        address: address, tag: 'latest'
      }
      get(params)
    end

    def multi_address_balance(addresses)
      fail Etherscan::Exception, 'up to 20 accounts in a single batch' if addresses.size > 20
      params = {
        module: 'account', action: 'balancemulti',
        address: addresses.join(','), tag: 'latest'
      }
      get(params)
    end

    # Get a list of 'Normal' Transactions By Address
    # if page is not defined Returns up to 10000 last transactions
    # @param sort 'asc' -> ascending order, 'des' -> descending order
    # @param start_block starting blockNo to retrieve results
    # @param end_block ending blockNo to retrieve results
    # @param page Paginated result <page number>
    # @param offset max records to return
    def normal_transactions(address, sort='asc', page=nil, offset=nil, start_block=nil, end_block=nil)
      action = 'txlist'
      contract_address = nil
      transcations(action, address, contract_address, start_block, end_block, sort, page, offset)
    end

    # Get a list of 'Internal' Transactions By Address
    def internal_transactions(address, sort='asc', page=nil, offset=nil, start_block=nil, end_block=nil)
      action = 'txlistinternal'
      contract_address = nil
      transcations(action, address, contract_address, start_block, end_block, sort, page, offset)
    end

    # Get a list of "ERC20 - Token Transfer Events"
    # @param contract_address Token address (set nil to get a list of all ERC20 transactions)
    # @param address Address for ERC20 transactions (optional)
    def token_transactions(contract_address, address=nil, sort='asc',
                           page=nil, offset=nil, start_block=nil, end_block=nil)
      fail Etherscan::Exception, 'contract or address must be defined' if (contract_address || address).nil?
      action = 'tokentx'
      transcations(action, address, contract_address, start_block, end_block, sort, page, offset)
    end

    private

    def transcations(action, address, contract_address, start_block, end_block, sort, page, offset)
      params = {
        module: 'account', action: action,
        address: address, contractaddress: contract_address, sort: sort,
        startblock: start_block, endblock: end_block,
        page: page, offset: offset
      }.select {|_, v| !v.nil? }
      get(params)
    end
  end
end

__END__

Transaction returns the following parameters:

nonce
hash
cumulativeGasUsed
gasUsed
timeStamp
blockHash
value (in wei)
input
gas
isInternalTx
contractAddress
confirmations
gasPrice
transactionIncex
to
from
isError
blockNumber
