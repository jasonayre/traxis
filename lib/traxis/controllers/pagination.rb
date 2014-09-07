module Traxis
  module Controllers
    module Pagination
      class Config < ::ActiveSupport::OrderedOptions
        def initialize(*args)
          self[:page_param] = :page
          self[:per_page_param] = :per

          super(*args)
        end
      end

      module Pageable
        extend ::ActiveSupport::Concern

        included do
          collection_options.merge!({
            :page_param => (::Traxis.config.pagination.try(:page_param) || :page),
            :per_page_param => (::Traxis.config.pagination.try(:per_page_param) || :per)
          })
        end

        def collection_query_result
          super.paginate({
            :page => params[page_param_key],
            :per_page => params[per_page_param_key]
          })
        end

        def page_param_key
          self.class.collection_options[:page_param]
        end

        def per_page_param_key
          self.class.collection_options[:per_page_param]
        end

        def pagination_params
          @pagination_params ||= query_params.extract(page_param_key, per_page_param_key)
        end
      end
    end
  end
end
