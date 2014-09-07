require 'spec_helper'

describe ::Traxis do
  subject { described_class }

  its(:config) { should be_kind_of(::ActiveSupport::OrderedOptions) }
end
