require 'rails_helper'

RSpec.describe 'Admin' do
  before(:each) do
    @merchant = create(:merchant)
  end

  describe 'Merchant' do
    describe '#update' do
      it 'has a link to update' do
        visit "/admin/merchants/#{@merchant.id}"
        expect(page).to have_link('update merchant')
        click_link 'update merchant'
        expect(current_path).to eq("/admin/merchants/#{@merchant.id}/edit")
      end

      it 'updates a merchant' do
        visit "/admin/merchants/#{@merchant.id}/edit"
        expect(page).to have_field("Name", with: @merchant.name)
        fill_in "Name",	with: "NewFooMerchant"
        click_button 'update merchant'
        expect(current_path).to eq("/admin/merchants/#{@merchant.id}")
        expect(page).to have_content("NewFooMerchant")
      end

    end

  end

end