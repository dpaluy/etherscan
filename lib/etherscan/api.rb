module Etherscan
  class Api
    attr_reader :connection

    def initialize(params = {})
      @connection = Etherscan::Client.new(params)
    end
  end
end
