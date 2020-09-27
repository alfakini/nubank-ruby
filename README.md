# nubank-ruby (deprecated)

[![Gem Version](https://badge.fury.io/rb/nubank.svg)](https://badge.fury.io/rb/nubank)
[![Build Status](https://travis-ci.org/alfakini/nubank-ruby.svg?branch=master)](https://travis-ci.org/alfakini/nubank-ruby)
[![Coverage Status](https://coveralls.io/repos/github/alfakini/nubank-ruby/badge.svg?branch=master)](https://coveralls.io/github/alfakini/nubank-ruby?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/27524f316fb71a98e522/maintainability)](https://codeclimate.com/github/alfakini/nubank-ruby/maintainability)

`deprecation note`: Nubank now has an option that lets you export CSV files that solves the same problem that made me create this gem.

This gem provides a wrapper to Nubank's public API.

It does not have any official support from Nubank nor is endorsed by them. This code is provided as is, I can't give you any guarantee that Nubank won't change the API calls in the future or you block your access accidentaly by overloading their API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nubank'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install nubank
```

## Usage

tl;dr:

```ruby
require 'nubank'
nubank = Nubank.new('<CPF>', '<PASSWORD>')
nubank.login
nubank.events # => [{"description":"Táxi do Zé","category":"transaction","amount ...
nubank.account # => {"payment_method":{"account_id":"<ACCOUNT-ID>","kind":"bolet ...
nubank.bills_summary # => [{"state":"open","summary":{"payments":"55","interest_ ...
```

### Login

Autenticates in the service using your cpf and password. Returns the list of account's services available.

```ruby
nubank = Nubank.new('<CPF>', '<PASSWORD>')
nubank.login
```

### Account

Returns account's details like balance, interest rate, cards, payment method and links.

```ruby
nubank.account
```

### Bills summary

Returns informations about past, present and future bills.

```ruby
nubank.bills_summary
```

### Events feed

The main source of information. Here you will get information about transactions and notifications.

```ruby
nubank.events
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alfakini/nubank-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in this gem, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/alfakini/nubank-ruby/blob/master/CODE_OF_CONDUCT.md).
