module Traxis
  module ControllerHelpers
    protected

    def association_chain
      @association_chain ||= begin_of_association_chain.all
    end

    def assign_object_attributes(object, attribute_hash)
      attribute_hash.each_pair do |k,v|
        object.__send__("#{k}=", v)
      end

      object
    end

    def begin_of_association_chain
      self.class.resource_options[:class]
    end

    def collection
      @collection ||= association_chain
    end

    def collection_serializer_class
      collection_options[:serializer]
    end

    def create_resource
      save_resource
    end

    def params
      @params ||= request.params.attributes
    end

    def payload_attributes
      @payload_attributes ||= request.payload.attributes[:"#{resource_options[:json_root]}"].attributes
    end

    def resource_class
      resource_options[:class]
    end

    def resource
      @resource ||= begin
        if request.action.name == :create
          association_chain.new(payload_attributes)
        elsif request.action.name == :update
          assign_object_attributes(resource_query_result, payload_attributes)
        else
          association_chain.__send__(resource_options[:finder], params[resource_options[:finder_param]])
        end
      end
    end

    def resource_finder
      :find
    end

    def resource_query_result
      @resource_query_result ||= association_chain.__send__(resource_options[:finder], params[resource_options[:finder_param]])
    end

    def serialized_collection
      collection_serializer_class.new(scoped_collection)
    end

    def serializer_class
      resource_options[:serializer]
    end

    def serialized_resource
      serializer_class.new(resource)
    end

    def scoped_collection
      @scoped_collection ||= begin
        return collection if request.query.blank?

        request.query.map do |k,v|
          collection.__send__("#{k}", *v)
        end
      end
    end

    def save_resource
      resource.save

      resource
    end

    def success?
      @success ||= begin
        case request.action.name
        when :create
          resource && !resource.errors.any?
        when :update
          resource && !resource.errors.any?
        when :destroy
          resource
        when :show
          resource.class == resource_options[:class]
        else
          true
        end
      end
    end

    def update_resource
      save_resource
    end
  end
end
