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
    # Available args: start_block, end_block, sort, page, offset
    # @param sort 'asc' -> ascending order, 'des' -> descending order
    # @param start_block starting blockNo to retrieve results
    # @param end_block ending blockNo to retrieve results
    # @param page Paginated result <page number>
    # @param offset max records to return
    def normal_transactions(address, args = {})
      action = 'txlist'
      transcations(action, address, nil, args)
    end

    # Get a list of 'Internal' Transactions By Address
    # Available args: start_block, end_block, sort, page, offset
    def internal_transactions(address, args = {})
      action = 'txlistinternal'
      transcations(action, address, nil, args)
    end

    # Get a list of "ERC20 - Token Transfer Events"
    # @param contract_address Token address (set nil to get a list of all ERC20 transactions)
    # @param address Address for ERC20 transactions (optional)
    # Available args: start_block, end_block, sort, page, offset
    def token_transactions(contract_address, address = nil, args = {})
      fail Etherscan::Exception, 'contract or address must be defined' if (contract_address || address).nil?
      action = 'tokentx'
      transcations(action, address, contract_address, args)
    end

    private

    def transcations(action, address, contract_address, args)
      params = {
        module: 'account', action: action,
        address: address, contractaddress: contract_address,
        startblock: args[:start_block], endblock: args[:end_block],
        page: args[:page], offset: args[:offset], sort: args[:sort]
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
