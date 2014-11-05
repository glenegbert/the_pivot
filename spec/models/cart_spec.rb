require 'rails_helper'

RSpec.describe Category, :type => :model do
  before do
    @item1 = Item.create(name: 'Rocky Mountain Oysters',   description: 'Traditional bull balls served thinly sliced, deep fried and with a side of cocktail sauce.', price: 6.50, status: 'active', image_file_name: "RockyMtnOysters4.jpg", store_id: 1)
    @item2 = Item.new(name: 'Flaming Cactus and Chips', description: 'Cactus from southern mexico mixed into our delicious cheese and served to your table on fire!', price: 6.00, status: 'active', image_file_name: "808-chili-cheese-nachos.jpg", store_id: 1)
  end

    let(:cart) do
    Cart.new({cart_items: {}})
  end

  it 'can create a cart' do
    expect(cart).to_not be_nil
  end

  it 'can add an item' do
      cart.add_item(@item1, 5)
      expect(cart.items.count).to eq(1)
  end

  it 'can remove an item' do
      cart.add_item(@item1, 5)
      cart.remove_item(@item1)
      expect(cart.items.count).to eq(0)
  end

  it 'can update the quantity of an item' do
    cart.add_item(@item1, 5)
    expect(cart.items[@item1].first).to eq(1)
    cart.update_quantity(@item1, 3)
    expect(cart.items[@item1].first).to eq(3)
  end

  it "can find an item" do
    expect(cart.item(@item1)).to eq(@item1)
  end

  it 'can calculate a line item price' do
    expect(cart.line_item_price(@item1, [3, "options"])).to eq(19.50)
  end

  it 'returns items from the session' do
    cart.add_item(@item1, 5)
    expect(cart.items.count).to eq(1)
  end

  it 'indicates if there are items in the cart' do
    cart.add_item(@item1, 5)
    expect(cart.empty?).to be false
  end

end
