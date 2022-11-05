require 'rails_helper'
require 'faker'

RSpec.describe 'Merchant Dashboard' do
  
  before :each do
    @merchant1 = Merchant.create!(name:Faker::Company.name)
  end
  describe 'as a Merchant' do
    it "I see the name of my merchant" do
      visit "/merchants/#{@merchant1.id}/dashboard"
      expect(page).to have_content(@merchant1.name)
    end
    
    it "I see a link to my merchant items index and merchant invoices index" do
      visit "/merchants/#{@merchant1.id}/dashboard"
      expect(page).to have_link('Merchant Items List')
      click_link 'Merchant Items List'
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      
      visit "/merchants/#{@merchant1.id}/dashboard"
      
      expect(page).to have_link('Merchant Invoices Index')
      click_link 'Merchant Invoices Index'
      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
    end
    
    it "I see a section for 'Items Ready to Ship' In that section I see a list
    of the names of all of my items that have been ordered and have not yet
    been shipped, And next to each Item I see the id of the invoice that
    ordered my item And each invoice id is a link to my merchant's invoice show
    page" do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      item_3 = create(:item, merchant: merchant)
      customer1 = create(:customer)
      customer2 = create(:customer)
      customer3 = create(:customer)
      customer1_invoice = create(:invoice, customer: customer1)
      customer2_invoice = create(:invoice, customer: customer2)
      customer3_invoice = create(:invoice, customer: customer3)
      
      customer1_invoice_item = create(:invoice_item, invoice: customer1_invoice, item: item_1, status: 0)
      customer2_invoice_item = create(:invoice_item, invoice: customer2_invoice, item: item_2, status: 1)
      customer3_invoice_item = create(:invoice_item, invoice: customer3_invoice, item: item_3, status: 2)
      
      visit "/merchants/#{merchant.id}/dashboard"
      
      expect(page).to have_content('Items Ready to Ship')
      within("#dashboard-items_to_ship") do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to_not have_content(item_3.name)
        
        expect(page).to have_link(customer1_invoice.id)
        expect(page).to have_link(customer2_invoice.id)
        expect(page).to_not have_link(customer3_invoice.id)
      end
      
      click_link "#{customer1_invoice.id}"
      
      expect(current_path).to eq("/merchants/#{merchant.id}/invoices/#{customer1_invoice.id}")
    end
    
    xit "I see the names of the top 5 customers who have conducted the largest
    number of successful transactions with my merchant And next to each
    customer name I see the number of successful transactions they have
    conducted with my merchant" do
      merchant = create(:merchant)
      
    end
  end
end