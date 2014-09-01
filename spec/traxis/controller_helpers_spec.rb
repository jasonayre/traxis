require 'spec_helper'

describe Traxis::Controller do
  let(:request) { fake_request }

  subject do
    ::PeopleController.new(fake_request)
  end

  its(:association_chain) { should eq(::Person) }
  its(:begin_of_association_chain) { should eq(::Person)}
  its(:collection) { should be_kind_of(::ActiveRecord::Relation) }
  its(:collection_relation_name) { should eq "people" }
  its(:collection_serializer_class) { should eq(::MediaTypes::People) }
  its(:end_of_association_chain) { should eq :all }
  its(:method_for_find) { should eq :find }
end
