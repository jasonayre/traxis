require "traxis/version"
require "traxis/response"

module Traxis
  def self.register_response(klass)
    ::Praxis::ApiDefinition.define do |api|
      api.response_template klass.response_name do
        status klass.status
      end
    end
  end
end
