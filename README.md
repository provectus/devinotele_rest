# DevinoteleRest

Welcome to devinotele_rest. This gem designed for usage with sms sender http://www.devinotele.com/ and their REST API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'devinotele_rest'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install devinotele_rest

## Usage
Initialize DevinoteleRest::Client with devinotele's login and password.
```ruby
client = DevinoteleRest::Client.new(login, password)
```

Send sms
```ruby
client.create(to: 'RECIPIENT_NUMBER', from: 'YOUR_NUMBER', body: 'SMS TEXT')
```
Also you may handle errors from Devinotele by rescue DevinoteleRest::RequestError

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/devinotele_rest.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
