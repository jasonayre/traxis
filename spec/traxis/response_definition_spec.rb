require 'spec_helper'

describe Traxis::Response do
  subject { described_class }

  context "when response_definition is inherited" do
    let(:test_subject) { ::Praxis::ApiDefinition }

    let(:fake_response_klass) do
      fake = Class.new(::Traxis::Response)
      fake.stub(:response_name) { :my_fake_response_klass }
      fake.stub(:status) { 200 }
    end

    # let(:fake_response_definition_) do
    #   response_definition =
    #   response_definition.inherited
    #   response_definition
    # end

    it "registers the response definition" do
      Traxis.should_receive(:register_response)
      fake_response_klass
    end
  end
end
