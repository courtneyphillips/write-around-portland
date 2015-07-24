require 'rails_helper'

def add_items_to_cart
  visit publications_path
  click_on "Roundabout"
  click_on "Add to cart"
  click_on "Mile Marker"
  click_on "Add to cart"
end

describe "increasing the shopping cart item count" do
  it "increases cart count number as items are added" do
    add_items_to_cart
    expect(page).to have_content "2 items in cart"
  end
end

describe "displying appropriate info in shopping cart" do
  it "adds only the designated publications to the cart" do
    add_items_to_cart
    click_on "Checkout"
    expect(page).to have_content "Roundabout"
    expect(page).to have_content "Mile Marker"
  end

  it "calculates the cost of the shopping cart" do
    add_items_to_cart
    click_on "Checkout"
    expect(page).to have_content "Total: $24.00"
  end

  # it "updates the total when the quantity for a publication changes", js: true do
  #   roundabout = Publication.find_by(title: "Roundabout")
  #   add_items_to_cart
  #   click_on "Checkout"
  #   fill_in roundabout.id, with: 5
  #   expect(page).to have_content "Total: $72.00"
  # end
end
