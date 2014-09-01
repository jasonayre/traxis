module Traxis
  module Responses
    class Base < ::Praxis::Response
    end

    class Ok < ::Traxis::Responses::Base
      include ::Traxis::Response::JSON

       self.status = 200
    end

    class Unauthorized < ::Traxis::Responses::Base
      include ::Traxis::Response::JSON
      include ::Traxis::Response::Meta
      include ::Traxis::Response::Errors

      self.status = 401

      def response_body
        @response_body = super
        @response_body[:meta][:errors] << "You are not authorized to do that!"
        @response_body
      end

      def format!
        @body = response_body
        @body
      end
    end

    class Resource < ::Traxis::Responses::Base
      include ::Traxis::Response::JSON
      self.response_name = :resource
      self.status = 200
    end

    class ResourceCreated < ::Traxis::Responses::Resource
      self.response_name = :resource_created
      self.status = 201
    end

    class ResourceDeleted < ::Traxis::Responses::Resource
      self.response_name = :resource_deleted
      self.status = 204
    end

    class ResourceError < ::Traxis::Responses::Resource
      self.response_name = :resource_error
      self.status = 422

      def initialize(errors:[], **args)
        @errors = errors
        super(**args)
      end

      def response_body
        super[:errors] = @errors
      end
    end

    class Collection < ::Traxis::Responses::Base
      include ::Traxis::Response::JSON
      include ::Traxis::Response::Meta

      self.response_name = :collection
      self.status = 200
    end
  end
end
