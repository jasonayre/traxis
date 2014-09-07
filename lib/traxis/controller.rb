require 'traxis/controllers/base'
require 'traxis/controllers/actions'
require 'traxis/controllers/pagination'
require 'traxis/controllers/action_responses'

module Traxis
  module Controller
    extend ::ActiveSupport::Concern
    include ::Praxis::Controller
    include ::Traxis::Controllers::Base
    include ::Traxis::Controllers::Actions
    include ::Traxis::Controllers::ActionResponses

    COLLECTION_ACTIONS = [:index, :search]
    MEMBER_ACTIONS = [:show, :create, :update, :destroy, :delete, :add, :remove]

    included do
      class_attribute :collection_options
      class_attribute :resource_options

      self.collection_options = ::ActiveSupport::OrderedOptions.new
      self.resource_options = ::ActiveSupport::OrderedOptions.new

      self.collection_options.merge!({
        :json_root => name.demodulize.underscore.pluralize
      })

      self.resource_options.merge!({
        :finder_param => :id,
        :finder => :find,
        :json_root => name.demodulize.underscore.singularize
      })
    end

    module ClassMethods
      def handles(resource_klass, collection:, resource:)
        resource_options.merge!(class: resource_klass)
        collection_options.merge!(collection)
        resource_options.merge!(resource)
      end

      def resource_class
        resource_options[:class]
      end
    end

    def collection_options
      self.class.collection_options
    end

    def resource_options
      self.class.resource_options
    end

    def resource_class
      self.class.resource_class
    end
  end
end
