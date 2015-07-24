require 'rails_helper'

describe "increasing the shopping cart item count" do
  it "increases cart count number as items are added" do
    visit publications_path
    click_on "Roundabout"
    click_on "Add to cart"
    click_on "Mile Marker"
    click_on "Add to cart"
    expect(page).to have_content "Items in cart: 2"
  end
end

describe "displying appropriate info in shopping cart" do
  it "adds only the designated publications to the cart" do
    visit publications_path
    click_on "Roundabout"
    click_on "Add to cart"
    click_on "Mile Marker"
    click_on "Add to cart"
    click_on "Checkout"
    expect(page).to have_content "Roundabout"
    expect(page).to have_content "Mile Marker"
  end

  it "calculates the cost of the shopping cart" do
    visit publications_path
    click_on "Roundabout"
    click_on "Add to cart"
    click_on "Mile Marker"
    click_on "Add to cart"
    click_on "Checkout"
    expect(page).to have_content "Total: 24"
  end
end
