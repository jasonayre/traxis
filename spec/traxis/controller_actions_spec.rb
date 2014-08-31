require 'spec_helper'

describe Traxis::Controller do
  subject do
    ::PeopleController
  end

  let(:rack_input) { StringIO.new('something=given') }
  let(:env) do
    env = Rack::MockRequest.env_for('/people')
    env['rack.input'] = rack_input
    env['CONTENT_TYPE'] = 'application/json'
    env['HTTP_VERSION'] = 'HTTP/1.1'
    env
  end

  let(:context) do
    {
      params: [Attributor::AttributeResolver::ROOT_PREFIX, "params".freeze],
      headers: [Attributor::AttributeResolver::ROOT_PREFIX, "headers".freeze],
      payload: [Attributor::AttributeResolver::Data, "payload".freeze]
    }.freeze
  end

  let(:payload_hash) {
    {}
  }

  let(:request) do
    request = Praxis::Request.new(env)
    request.action = subject.actions[:create]
    request
  end

  describe "#create" do
    let!(:payload_attributes) {
      ::Attributor::Struct.new({
        'name' => "Jason"
      })
    }

    let(:rack_input) {
      StringIO.new(payload_attributes.to_json)
    }

    before do
      request.load_headers(context[:headers])
      request.load_params(context[:params])
      request.load_payload(context[:payload])
    end

    it "should create new resource" do
      expect(::Person).to receive(:create).with(payload_attributes)
      subject.new(request).create
    end
  end

end
