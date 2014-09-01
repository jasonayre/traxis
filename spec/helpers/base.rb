module Helpers
  def fake_rack_input
    StringIO.new('something=given')
  end

  def fake_env
    env = Rack::MockRequest.env_for('/people')
    env['rack.input'] = fake_rack_input
    env['CONTENT_TYPE'] = 'application/json'
    env['HTTP_VERSION'] = 'HTTP/1.1'
    env
  end

  def fake_context
    {
      params: [Attributor::AttributeResolver::ROOT_PREFIX, "params".freeze],
      headers: [Attributor::AttributeResolver::ROOT_PREFIX, "headers".freeze],
      payload: [Attributor::AttributeResolver::Data, "payload".freeze]
    }.freeze
  end

  def fake_request
    request = Praxis::Request.new(fake_env)
  end

  def fake_request_with_payload
    fake_request.payload = fake_payload_attributes
  end

  def fake_payload_attributes
    ::Attributor::Struct.new({
      'name' => "Jason"
    })
  end

  def fake_rack_input_hash
    StringIO.new(fake_payload_attributes.to_json)
  end
end
