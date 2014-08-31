require 'active_support'

module Traxis
  module Response
    module JSON
      extend ::ActiveSupport::Concern

      included do
        attr_accessor :json_root
      end

      def initialize(json_root:nil, **args)
        @json_root = json_root

        super(**args)
      end

      def format!
        response_body[json_root] = @body
        @body = response_body
        @body
      end

      def handle
        headers['Content-Type'] = 'application/json'
      end

      def encode!
        @body = @body.to_json
      end

      def response_body
        @response_body ||= {}
      end
    end

    module Meta
      extend ::ActiveSupport::Concern

      def response_body
        super.merge!(:meta => {})
        @response_body
      end
    end

    module Errors
      extend ::ActiveSupport::Concern

      def response_body
        super[:meta].merge!(:errors => [])
        @response_body
      end
    end
  end
end

require 'traxis/responses'
