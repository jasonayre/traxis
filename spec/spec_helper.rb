$:.unshift File.expand_path(__dir__)
$:.unshift File.expand_path('../lib',__dir__)
$:.unshift File.expand_path('support',__dir__)

require 'bundler'
Bundler.setup :default, :test

require 'simplecov'

require 'praxis'

require 'rack/test'
require 'rspec/its'
require 'rspec/collection_matchers'
require 'pry'

require 'praxis'
require 'helpers/base'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Helpers
  config.before(:suite) do
    Praxis::Blueprint.caching_enabled = true
    Praxis::Application.instance.setup(root:'spec/spec_app')
  end
end

require 'traxis'
Traxis.register_responses

Dir["#{File.dirname(__FILE__)}/support/*.rb"].each do |file|
  require file
end
