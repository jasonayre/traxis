module Traxis
  class Response < ::Praxis::Response

    def self.inherited(klass)
      super

      ::Traxis.register_response(klass)
    end
  end
end
