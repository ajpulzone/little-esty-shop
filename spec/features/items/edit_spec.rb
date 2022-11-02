require 'rails_helper'

RSpec.describe 'Merchants' do
  before(:each) do
    @merchant = Merchant.create!(name: 'FooMerchant')
    @item1 = @merchant.items.create!(name: 'fooItem', description: 'lorem ipsum dolocet', unit_price: 17_505)
    @item2 = @merchant.items.create!(name: 'barItem', description: 'lorem dolocet ipsum gotsum', unit_price: 456_789)
  end

  describe 'Items' do
    describe '#edit' do
      it "has fields for attributes" do
        visit "/merchants/#{@merchant.id}/items/#{@item1.id}/edit"
        expect(page).to have_field('Name')
        expect(page).to have_field('Description')
        expect(page).to have_field('Unit price')
      end

      it 'can update a field and submit' do
        visit "/merchants/#{@merchant.id}/items/#{@item1.id}/edit"
        fill_in "Name",	with: "Foo sometext"
        click_button("Update Item")
        expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item1.id}")
      end
    end
  end
end
