require 'logger'

module Etherscan

  class Config
    attr_accessor :key, :secret, :url, :logger, :raise_exceptions

    def logger
      @logger ||= Logger.new(STDERR)
    end
  end

  def self.configure
    yield config
  end

  def self.config
    @config ||= Config.new
  end

end
