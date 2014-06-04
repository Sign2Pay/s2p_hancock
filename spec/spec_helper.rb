
require 'simplecov'
require 'webmock/rspec'
require 'vcr'


SimpleCov.start do
  add_filter "/spec/"
end

require 's2p_hancock'
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|

  config.raise_errors_for_deprecations!

  config.before(:each) do
    DeferredGarbageCollection.start
  end

  config.after(:each) do
    DeferredGarbageCollection.reconsider
  end

end