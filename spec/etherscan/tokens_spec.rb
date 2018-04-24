require 'spec_helper'

describe Etherscan::Tokens do
  let(:connection_mock) { instance_double('Client') }
  let(:connection_params) do
    { key: 'foobar' }
  end
  let(:contract) { 'contract' }
  let(:address)  { 'address' }

  subject { Etherscan::Tokens.new(connection_params) }

  before do
    allow(Etherscan::Client).to receive(:new).with(connection_params).and_return(connection_mock)
  end

  it '#total_supply' do
    response = { 'status' => '1', 'message' => 'OK', 'result' => '75974982082112433807172752' }
    params = { module: 'stats', action: 'tokensupply', contractaddress: contract }
    expect(connection_mock).to receive(:get).with(params).and_return(response)
    expected_response = subject.total_supply(contract)
    expect(expected_response).to eq(response['result'])
  end

  it '#balance' do
    response = { 'status' => '1', 'message' => 'OK', 'result' => '34080719924110000000000' }
    params = { module: 'account', action: 'tokenbalance', address: address, contractaddress: contract }
    expect(connection_mock).to receive(:get).with(params).and_return(response)
    expected_response = subject.balance(address, contract)
    expect(expected_response).to eq(response['result'])
  end
end
