module Etherscan
  class Api
    attr_reader :connection

    def initialize(params = {})
      @connection = Etherscan::Client.new(params)
    end

    def get(params)
      response = connection.get(params)
      response['result']
    end
  end
end
