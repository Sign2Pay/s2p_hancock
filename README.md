[![Coverage Status](https://coveralls.io/repos/Sign2Pay/s2p_hancock/badge.png)](https://coveralls.io/r/Sign2Pay/s2p_hancock)

# S2P Hancock

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 's2p_hancock'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install s2p_hancock

## Usage

    require 's2p_hancock'
    S2PHancock.license_key = "<YOUR LICENSE KEY>"
    S2PHancock.endpoint = "<YOUR HANCOCK INSTANCE URL>"
    request = S2PHancock::Request.new(:signature_id => "534d568369702d3f640a0000")
    resp = request.process!

## Contributing

1. Fork it ( http://github.com/sign2pay/s2p_hancock/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
