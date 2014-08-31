require 'spec_helper'

describe Traxis::Controller do
  subject do
    Class.new {
      include Traxis::Controller

      implements PeopleResource
    }
  end
end
