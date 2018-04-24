require_relative 'etherscan/config'
require_relative 'etherscan/exceptions'
require_relative 'etherscan/client'
require_relative 'etherscan/tokens'
require_relative 'etherscan/engine' if defined?(Rails)

module Etherscan
  VERSION = File.read(File.expand_path('../../VERSION', __FILE__)).strip.freeze

  def self.logger
    config.logger
  end
end
