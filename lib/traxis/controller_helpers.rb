module Traxis
  module ControllerHelpers
    protected

    def association_chain
      @association_chain ||= begin
        if begin_of_association_chain.kind_of?(::ActiveRecord::Relation)
          begin_of_association_chain.all
        else
          begin_of_association_chain
        end
      end
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

    def build_resource
      if association_chain != resource_class
        association_chain.__send__(collection_relation_name).new(payload_attributes)
      else
        association_chain.new(payload_attributes)
      end
    end


    ### If begin of association chain is an instance of ar model, i.e. current_user
    ### send the collection relation name, i.e. current_user.posts.all
    def collection
      @collection ||= begin
        unless begin_of_association_chain.respond_to?(:all)
          association_chain.__send__(collection_relation_name).all
        else
          association_chain.all
        end
      end
    end

    def collection_relation_name
      @collection_relation_name ||= resource_class.name.demodulize.underscore.pluralize
    end

    def collection_serializer_class
      collection_options[:serializer]
    end

    def create_resource
      save_resource
    end

    def end_of_association_chain
      :all
    end

    def method_for_find
      resource_options[:finder]
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
          build_resource
        elsif request.action.name == :update
          assign_object_attributes(resource_query_result, payload_attributes)
        else
          resource_query_result
        end
      end
    end

    def resource_query_result
      @resource_query_result ||= begin
        unless association_chain.respond_to?(method_for_find)
          association_chain.__send__(collection_relation_name)
                           .__send__(method_for_find, params[resource_options[:finder_param]])
        else
          association_chain.__send__(method_for_find, params[resource_options[:finder_param]])
        end
      end
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

        collection.__send__(end_of_association_chain)
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
