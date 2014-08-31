require_relative 'resource_definitions'

class PeopleController
  include ::Traxis::Controller

  implements ::PeopleResource

  handles ::Person, :collection => {
                      :serializer => ::MediaTypes::Person,
                      :json_root => "people"
                    },
                    :resource => {
                      :serializer => ::MediaTypes::Person,
                      :json_root => "person"
                    }
end
