require 'spec_helper'

describe Traxis::Controllers::Pagination::Config do
  subject do
    described_class.new
  end

  its(:page_param) { should eq :page }
  its(:per_page_param) { should eq :per }

end
