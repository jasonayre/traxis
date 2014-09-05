require 'traxis/controller_helpers'
require 'traxis/controller_actions'
require 'traxis/controller_concerns'
module Traxis
  module Controller
    extend ::ActiveSupport::Concern
    include ::Praxis::Controller
    include ::Traxis::ControllerHelpers
    include ::Traxis::ControllerActions
    include ::Traxis::ControllerConcerns::Core

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
