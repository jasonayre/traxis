require 'traxis/controllers/pagination'

module Traxis
  class Config < ::ActiveSupport::OrderedOptions
    def initialize(*args)
      self[:pagination] = ::Traxis::Controllers::Pagination::Config.new
      super(*args)
    end
  end
end
