require 'rails_helper'

RSpec.describe 'Merchants' do
  before(:each) do
    @merchant = Merchant.create!(name: 'FooMerchant')
    @item1 = @merchant.items.create!(name: 'fooItem', description: 'lorem ipsum dolocet', unit_price: 17_505)
    @item2 = @merchant.items.create!(name: 'barItem', description: 'lorem dolocet ipsum gotsum', unit_price: 456_789)
  end

  describe 'Items' do
    describe '#show' do
      it "lists the item's attributes" do
        visit "/merchants/#{@merchant.id}/items/#{@item1.id}"
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item1.description)
        expect(page).to have_content(@item1.unit_price)
      end

      it 'has a link to update the item' do
        visit "/merchants/#{@merchant.id}/items/#{@item1.id}"
        expect(page).to have_link('Update Item')
      end

      it 'update button redirects to edit page' do
        visit "/merchants/#{@merchant.id}/items/#{@item1.id}"
        click_link('Update Item')
        expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item1.id}/edit")
      end
    end
  end
end
