require "traxis/version"
require "active_support"
require "active_support/all"
require "traxis/response"
require "traxis/responses"

module Traxis
  def self.bootstrap!
    load_concerns if concerns.any?
    load_responses if responses.any?
    register_responses
  end

  def self.controllers
    @controllers ||=::Dir[root.join('app', 'controllers', '**', '*_controller', '*.rb')]
  end

  def self.load_concerns
    concerns.each do |path|
      require path
    end
  end

  def self.concerns
    @concerns ||= ::Dir[root.join('app', '**', '*concerns', '*.rb')]
  end

  def self.eager_require_directory(*args)
    ::Dir[::Traxis.root.join(*args)].each do |path|
      require path
    end
  end

  def self.load_responses
    responses.each do |path|
      require path
    end
  end

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
    ::Traxis::Responses::Base.subclasses.each do |klass|
      ::Traxis.register_response(klass)
    end
  end

  def self.responses
    @responses ||=::Dir[root.join('app', '**', '*responses', '*.rb')]
  end

  def self.root
    ::Praxis::Application.instance.root
  end
end

::Traxis.bootstrap! if ::Traxis.root

require "traxis/controller"
