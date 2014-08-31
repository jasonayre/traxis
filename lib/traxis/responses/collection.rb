module Traxis
  module Responses
    module Collection
      class Response < ::Traxis::Response
        self.response_name = :collection
        self.status = 200

        attr_accessor :json_root

        def initialize(json_root:'records', **args)
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
    end
  end
end
