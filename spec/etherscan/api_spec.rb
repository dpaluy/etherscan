require 'spec_helper'

describe Etherscan::Api do
  let(:connection_mock) { instance_double('Api') }
  let(:connection_params) do
    { key: 'foobar' }
  end

  it 'initializes a valid connection' do
    expect(Etherscan::Client).to receive(:new).with(connection_params).and_return(connection_mock)
    Etherscan::Api.new(connection_params)
  end
end
