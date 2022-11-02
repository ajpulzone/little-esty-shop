require 'rails_helper'
require 'faker'

RSpec.describe 'Merchant Dashboard' do
  
  before :each do
    @merchant1 = Merchant.create!(name:Faker::Company.name)
    visit "/merchants/#{@merchant1.id}/dashboard"
  end
  describe 'as a Merchant' do
    it "I see the name of my merchant" do
      expect(page).to have_content(@merchant1.name)
    end
    
    it "I see a link to my merchant items index and merchant invoices index" do
      expect(page).to have_link('Merchant Items List')
      click_link 'Merchant Items List'
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      
      visit "/merchants/#{@merchant1.id}/dashboard"
      
      expect(page).to have_link('Merchant Invoices Index')
      click_link 'Merchant Invoices Index'
      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
    end
  end
end