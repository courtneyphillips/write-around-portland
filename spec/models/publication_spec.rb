require "rails_helper"

describe Publication do
  it { should belong_to :author }
  it { should have_many :orders }
end
