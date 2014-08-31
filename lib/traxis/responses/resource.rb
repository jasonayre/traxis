module Traxis
  module Responses
    module Resource
      class Resource < ::Traxis::Response
        self.response_name = :resource
        self.status = 200

        attr_accessor :json_root

        def initialize(json_root:'resource', **args)
          @json_root = json_root

          super(**args)
        end

        def handle
          headers['Content-Type'] = 'application/json'
        end

        def encode!
          @body = @body.to_json
        end

        # Assign body to response body, allows for super extending the response body
        # for clean composition
        def format!
          response_body[json_root] = @body
          @body = response_body
          @body
        end

        def response_body
          @response_body ||= {}
        end
      end

      class Found < Resource
        self.response_name = :resource_created
        self.status = 201
      end

      class Created < Resource
        self.response_name = :resource_created
        self.status = 201
      end

      class Deleted < Resource
        self.response_name = :resource_deleted
        self.status = 204
      end

      class Error < Resource
        self.response_name = :resource_error
        self.status = 422

        def initialize(errors:[], **args)
          super(**args)

          @errors = errors
        end

        def response_body
          super[:errors] ||= @errors
        end
      end

    end
  end
end
