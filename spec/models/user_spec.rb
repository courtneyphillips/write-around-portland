require "rails_helper"

describe User do
  it { should have_many :publications }

end
