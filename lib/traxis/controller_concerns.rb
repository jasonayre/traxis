module Traxis
  module ControllerConcerns
    module ConnectionRecycler
      extend ::ActiveSupport::Concern

      included do
        attr_accessor :current_connection
        before(:load_request) do |controller|
          # controller.current_connection = ActiveRecord::Base.connection_pool.checkout

          ::ActiveRecord::Base.connection_pool.with_connection do |conn|

            puts conn.pool.connections.size
          end

          # puts "connections_before: #{::ActiveRecord::Base.connection_pool.instance_variable_get("@connections").size} "

        end

        after(:response) do |controller|
          # binding.pry
          # ::ActiveRecord::Base.connection_pool.checkin(controller.current_connection)

          ::ActiveRecord::Base.connection_pool.with_connection do |conn|
            puts conn.pool.connections.size
          end

          # self.class.current_connection.checkin(controller.current_connection)

        end
      end

    end

    module Core
      extend ::ActiveSupport::Concern
      include ::Traxis::ControllerConcerns::ConnectionRecycler

      included do

      end
    end
  end
end
