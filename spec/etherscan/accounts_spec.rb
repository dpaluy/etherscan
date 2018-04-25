require 'spec_helper'

describe Etherscan::Accounts do
  let(:connection_mock) { instance_double('Client') }
  let(:connection_params) do
    { key: 'foobar' }
  end
  let(:address)  { 'address' }

  subject { Etherscan::Accounts.new(connection_params) }

  before do
    allow(Etherscan::Client).to receive(:new).with(connection_params).and_return(connection_mock)
  end

  it '#address_balance' do
    response = { 'status' => '1', 'message' => 'OK', 'result' => '8750143304924187001472' }
    params = { module: 'account', action: 'balance', address: address, tag: 'latest' }
    expect(connection_mock).to receive(:get).with(params).and_return(response)
    expected_response = subject.address_balance(address)
    expect(expected_response).to eq(response['result'])
  end

  it '#multi_address_balance' do
    balances = [
      {'account' => '0x564286362092d8e7936f0549571a803b203aaced','balance' => '6074517158469187001472'},
      {'account' => '0x198ef1ec325a96cc354c7266a038be8b5c558f67','balance' => '0'}
    ]
    addresses = balances.map {|e| e['account']}
    response = { 'status' => '1', 'message' => 'OK', 'result' => balances }
    params = { module: 'account', action: 'balancemulti', address: addresses.join(','), tag: 'latest' }
    expect(connection_mock).to receive(:get).with(params).and_return(response)
    expected_response = subject.multi_address_balance(addresses)
    expect(expected_response).to eq(response['result'])
  end

  it '#normal_transactions' do
    transactions = [
      {
        'blockNumber' => '4868696', 'timeStamp' => '1515324074', 'hash' => '0x324af15afa',
        'nonce' => '119', 'blockHash' => '0x908fa99defef9', 'transactionIndex' => '242',
        'from' => '0xfe9e8709d3215310075d67e3ed32a380ccf451c8',
        'to' => '0x564286362092d8e7936f0549571a803b203aaced',
        'value' => '100000000', 'gas' => '21000', 'gasPrice' => '50000000000',
        'isError' => '0', 'txreceipt_status' => '1',
        'input' => '0x', 'contractAddress' => '', 'cumulativeGasUsed' => '7983481',
        'gasUsed' => '21000', 'confirmations' => '634499'
      }
    ]
    response = { 'status' => '1', 'message' => 'OK', 'result' => transactions }
    params = { module: 'account', action: 'txlist', address: address, sort: 'asc' }
    expect(connection_mock).to receive(:get).with(params).and_return(response)
    expected_response = subject.normal_transactions(address)
    expect(expected_response).to eq(response['result'])
  end
end
