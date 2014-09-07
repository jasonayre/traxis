module Traxis
  module Controllers
    module Base
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

      def current_action_is_collection?
        ::Traxis::Controller::COLLECTION_ACTIONS.includes?(request.action.name)
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

      def collection_query_result
        @collection_query_result ||= begin
          collection_with_search_scopes.all
        end
      end

      def collection_with_search_scopes
        @collection_with_search_scopes ||= begin
          return collection if query_params.empty?

          query_params.map do |k,v|
            collection.__send__("#{k}", *v) if collection.respond_to?(k)
          end

          collection
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

      def method_for_find
        resource_options[:finder]
      end

      def params
        @params ||= request.params.attributes
      end

      def payload_attributes
        @payload_attributes ||= request.payload.attributes[:"#{resource_options[:json_root]}"].attributes
      end

      def query_params
        @query_params ||= request.query.with_indifferent_access
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
        collection_serializer_class.new(collection_query_result)
      end

      def serializer_class
        resource_options[:serializer]
      end

      def serialized_resource
        serializer_class.new(resource)
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
end
