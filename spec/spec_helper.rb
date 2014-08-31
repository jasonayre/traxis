$:.unshift File.expand_path(__dir__)
$:.unshift File.expand_path('../lib',__dir__)
$:.unshift File.expand_path('support',__dir__)

require 'bundler'
Bundler.setup :default, :test

require 'simplecov'

require 'praxis'
require 'traxis'
require 'rack/test'
require 'rspec/its'
require 'rspec/collection_matchers'
require 'pry'

Dir["#{File.dirname(__FILE__)}/support/*.rb"].each do |file|
  require file
end
