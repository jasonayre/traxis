require "traxis/version"
require "active_support"
require "active_support/all"

module Traxis
  # Because praxis is using inherited hook,responses arent registered
  # i.e. response.response_name is nil, as rest of class
  # (where assignment is made) hasn't been loaded yet
  def self.register_response(klass)
    ::Praxis::ApiDefinition.define do |api|
      api.response_template klass.response_name do
        status klass.status
      end
    end

    if !klass.subclasses.empty?
      klass.subclasses.each do |subklass|
        ::Traxis.register_response(subklass)
      end
    end
  end

  def self.register_responses
    ::Traxis::Response.subclasses.each do |klass|
      ::Traxis.register_response(klass)
    end
  end
end

require "traxis/response"

::Traxis.register_responses

require "traxis/controller"
