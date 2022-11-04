require 'rails_helper'

RSpec.describe 'Merchants' do
  before(:each) do
    @merchant = Merchant.create!(name: 'FooMerchant')
    @item1 = @merchant.items.create!(name: 'fooItem')
    @item2 = @merchant.items.create!(name: 'barItem')

    @item3 = @merchant.items.create(name: 'boo far', status: 0)
    @item3 = @merchant.items.create(name: 'BAZ BOO', status: 1)
  end

  describe 'Items' do
    describe '#index' do
      it 'has links to each individual item' do
        visit "/merchants/#{@merchant.id}/items"
        expect(page).to have_link(@item1.name)
        expect(page).to have_link(@item2.name)
      end

      it 'links to each individual item show page' do
        visit "/merchants/#{@merchant.id}/items"
        first(:link, @item1.name).click
        expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item1.id}")
      end

      it 'has buttons to toggle between enabled/disabled items' do
        visit "/merchants/#{@merchant.id}/items"
        expect(page).to have_button('enable')
        first(:button, 'enable').click
        expect(current_path).to eq("/merchants/#{@merchant.id}/items")
        expect(page).to have_button('disable')
        first(:button, 'disable').click
        expect(current_path).to eq("/merchants/#{@merchant.id}/items")
        expect(page).to have_button('enable')
      end

      it 'has some behaviour' do
        visit "/merchants/#{@merchant.id}/items"
        expect(page).to have_content('ENABLED ITEMS')
        expect(page).to have_content('DISABLED ITEMS')
      end


    end
  end
end
