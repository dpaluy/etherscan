# EtherScan API gem

[![Gem Version](https://badge.fury.io/rb/etherscan_api.png)](http://badge.fury.io/rb/etherscan_api)
[![Build Status](https://travis-ci.org/dpaluy/etherscan.svg?branch=master)](https://travis-ci.org/dpaluy/etherscan)
[![Maintainability](https://api.codeclimate.com/v1/badges/75848a6693e61972e5f3/maintainability)](https://codeclimate.com/github/dpaluy/etherscan/maintainability)
[![Dependency Status](https://gemnasium.com/badges/github.com/dpaluy/etherscan.svg)](https://gemnasium.com/github.com/dpaluy/etherscan)

Ruby Gem for the EtherScan API https://etherscan.io/apis

## Installation

Add this line to your application's Gemfile:

`gem 'etherscan_api', require: 'etherscan'`

And then execute:

`$ bundle`

Or install it yourself using:

`$ gem install etherscan_api`

## Usage

Get your api key: https://etherscan.io/myapikey

```
# config/initializers/etherscan.rb
EtherScan.configure do |config|
  config.key = 'my_api_key'
end
```

```
etherscan = Etherscan::Tokens.new

# Get ERC20-Token TotalSupply by ContractAddress
contract_address = '0x1f573d6fb3f13d689ff844b4ce37794d79a7ff1c'
etherscan.total_supply(contract_address)

# Get ERC20-Token Account Balance for TokenContractAddress
contract_address = '0x1f573d6fb3f13d689ff844b4ce37794d79a7ff1c'
address = '0xb36efd48c9912bd9fd58b67b65f7438f6364a256'
etherscan.balance(address, contract_address)
```

## Contributing to etherscan

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2018 David Paluy. See [LICENSE.txt](LICENSE.txt) for
further details.
