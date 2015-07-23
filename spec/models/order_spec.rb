require "rails_helper"

describe Order do
  it { should have_many :publications }
end
