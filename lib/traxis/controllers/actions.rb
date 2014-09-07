module Traxis
  module Controllers    
    module Actions
      def create(**params)
        if create_resource.errors.any?
          ::Traxis::Responses::ResourceError.new(:body => serialized_resource, :json_root => resource_options[:json_root], :errors => resource.errors)
        else
          ::Traxis::Responses::ResourceCreated.new(:body => serialized_resource, :json_root => resource_options[:json_root])
        end
      end

      def destroy(id:)
        ::Traxis::Responses::ResourceDeleted.new(:body => serialized_resource, :json_root => resource_options[:json_root])
      end

      def index(**params)
        ::Traxis::Responses::Collection.new(:body => serialized_collection, :json_root => collection_options[:json_root])
      end

      def show(id:)
        ::Traxis::Responses::Resource.new(:body => serialized_resource, :json_root => resource_options[:json_root])
      end

      def update(id:, **params)
        if update_resource.errors.any?
          ::Traxis::Responses::ResourceError.new(:body => serialized_resource, :json_root => resource_options[:json_root], :errors => resource.errors)
        else
          ::Traxis::Responses::Resource.new(:body => serialized_resource, :json_root => resource_options[:json_root])
        end
      end
    end
  end
end
