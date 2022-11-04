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
      items_1 = create_list(:item, 5, merchant: merchant)
      items_2 = create_list(:item, 5, merchant: merchant)
      customer1 = create(:customer)
      customer2 = create(:customer)
      customer1_invoice = create(:invoice, customer: customer1)
      customer2_invoice = create(:invoice, customer: customer2)
      
      customer1_invoice_items = []
      customer2_invoice_items = []
      for i in 0..4 do
        customer1_invoice_items << create(:invoice_item, invoice: customer1_invoice, item: items_1[i])
        customer2_invoice_items << create(:invoice_item, invoice: customer2_invoice, item: items_2[i])
      end
      visit "/merchants/#{merchant.id}/dashboard"
      
      expect(page).to have_content('Items Ready to Ship')
      
      not_shipped = customer1_invoice_items.select {|item| item.status != 2}.concat(customer2_invoice_items.select {|item| item.status != 2})
      # require "pry"; binding.pry
      within("#dashboard-items_to_ship") do
        not_shipped.size.times do
          i = 0
          expect(page).to have_content(not_shipped[i].item.name)
          expect(page).to have_link(not_shipped[i].item.id)
          i += 1
        end
      end
      
      click_link "#{not_shipped.first.item.id}"
      
      # Filepath for merchant invoice show page?
      expect(current_path).to eq("/merchants/invoices/#{not_shipped.first.item.id}")
    end
    
    xit "I see the names of the top 5 customers who have conducted the largest
    number of successful transactions with my merchant And next to each
    customer name I see the number of successful transactions they have
    conducted with my merchant" do
      merchant = create(:merchant)
      
    end
  end
end