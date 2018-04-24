require 'codeclimate-test-reporter'
require 'simplecov'
require 'coveralls'

require 'webmock/rspec'

if ENV['COVERAGE']
  WebMock.disable_net_connect!(allow: 'codeclimate.com')

  Coveralls.wear!
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  #SimpleCov.start
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'etherscan'
require 'byebug'
require 'active_support/all'
require 'rspec'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.order = 'random'
end
