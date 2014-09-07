module Traxis
  module Controllers
    module ActionResponses
      def collection_response_args
        {
          body: serialized_collection,
          json_root: collection_options[:json_root]
        }
      end

      def collection_response
        @collection_response ||= collection_response_class.new(
          collection_response_args
        )
      end

      def collection_response_class
        ::Traxis::Responses::Collection
      end
    end
  end
end
