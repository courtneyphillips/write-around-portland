require "rails_helper"

describe Publication do
  it { should belong_to :author }

end
