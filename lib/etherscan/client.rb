require 'faraday'

module Etherscan
  class Client
    URL     = 'https://api.etherscan.io/'.freeze
    HEADERS = {'Content-Type' => 'application/json', 'Accept' => 'application/json'}.freeze

    attr_reader :key, :url, :user_agent, :headers, :raise_exceptions
    attr_writer :adapter, :conn

    def initialize( params = {} )
      @key        = params.fetch(:key, Etherscan.config.key)
      @url        = params.fetch(:url, Etherscan.config.url || URL)
      @adapter    = params.fetch(:adapter, adapter)
      @conn       = params.fetch(:conn, conn)
      @user_agent = params.fetch(:user_agent, "etherscan/#{Etherscan::VERSION};ruby")
      @headers    = HEADERS.merge('User-Agent' => @user_agent)
      @raise_exceptions = params.fetch(:raise_exceptions, Etherscan.config.raise_exceptions || true)
      yield self if block_given?
    end

    def get(params = {})
      endpoint = 'api'
      merged_params = params.merge({apikey: key})
      response = conn.get(url) do |req|
        req.headers = headers
        req.params  = merged_params
      end
      fail Etherscan::Exception, response if raise_exceptions? && response.status != 200

      response
    end

    def conn
      @conn ||= Faraday.new(url: @url) do |conn|
        conn.request :url_encoded
        conn.adapter adapter
      end
    end

    def adapter
      @adapter ||= Faraday.default_adapter
    end

    def raise_exceptions?
      @raise_exceptions
    end
  end
end
