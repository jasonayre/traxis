require_relative 'media_types'

class PeopleResource
  include Praxis::ResourceDefinition

  description 'People resource'

  media_type ::MediaTypes::Person

  version '1.0'

  routing do
    prefix "/people"
  end

  action :index do
    description 'index description'
    routing do
      get ''
    end
  end

  action :create do
    description 'create description'
    routing do
      post ''
    end

    payload do
      attribute :name, String, required: true
    end

    response :resource_created, media_type: 'application/json'
    response :resource_error
  end

  action :show do
    description 'show description'
    routing do
      get '/:id'
    end
    params do
      attribute :id, Integer, required: true
    end
  end

end
