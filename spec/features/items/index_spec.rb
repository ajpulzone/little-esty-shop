require 'rails_helper'

RSpec.describe 'Merchants' do
  before(:each) do
    @merchant = Merchant.create!(name: 'FooMerchant')
    @item1 = @merchant.items.create!(name: 'fooItem')
    @item2 = @merchant.items.create!(name: 'barItem')

    @item3 = @merchant.items.create(name: 'boo far', status: 0)
    @item4 = @merchant.items.create(name: 'BAZ BOO', status: 1)
  end

  describe 'Items' do
    describe '#index' do
      it 'has links to each individual item' do
        visit "/merchants/#{@merchant.id}/items"
        expect(page).to have_link(@item3.name)
        expect(page).to have_link(@item4.name)
      end

      it 'links to each individual item show page' do
        visit "/merchants/#{@merchant.id}/items"
        first(:link, @item3.name).click
        expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item3.id}")
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

      it 'groups items by status' do
        visit "/merchants/#{@merchant.id}/items"
        expect(page).to have_content('ENABLED ITEMS')
        expect(page).to have_content('DISABLED ITEMS')
        within("#enabled_items") do
          expect(page).not_to have_button("enable")
          expect(page).to have_button("disable")
        end
        within("#disabled_items") do
          expect(page).to have_button("enable")
          expect(page).not_to have_button("disable")
        end
      end

      it 'can has a button to create new items' do
        visit "/merchants/#{@merchant.id}/items"
        expect(page).to have_link('Create New Item')
        click_link('Create New Item')
        expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")
      end

      it 'can add a new item' do
        visit "/merchants/#{@merchant.id}/items/new"

        fill_in "Name",	with: "Item Foo Bar"
        fill_in "Description",	with: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro."
        fill_in "Unit price",	with: 33351
        click_button('Submit')
        expect(current_path).to eq("/merchants/#{@merchant.id}/items")
        within("#disabled_items") do
          expect(page).to have_content("Item Foo Bar")
        end

      end
    end
  end
end
