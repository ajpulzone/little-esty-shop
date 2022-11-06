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
    
    it "I see the names of the top 5 customers who have conducted the largest
    number of successful transactions with my merchant And next to each
    customer name I see the number of successful transactions they have
    conducted with my merchant" do
      merchant = create(:merchant)
      merchant2 = create(:merchant)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      item_3 = create(:item, merchant: merchant)
      item_4 = create(:item, merchant: merchant2)
      
      customer1 = create(:customer)
      customer2 = create(:customer)
      customer3 = create(:customer)
      customer4 = create(:customer)
      customer5 = create(:customer)
      customer6 = create(:customer)
      customer7 = create(:customer)
      
      customer1_invoice = create(:invoice, customer: customer1)
      customer2_invoice = create(:invoice, customer: customer2)
      customer3_invoice = create(:invoice, customer: customer3)
      customer4_invoice = create(:invoice, customer: customer4)
      customer5_invoice = create(:invoice, customer: customer5)
      customer6_invoice = create(:invoice, customer: customer6)
      customer7_invoice = create(:invoice, customer: customer7)
      customer7_invoice2 = create(:invoice, customer: customer7)
      
      customer1_transactions = create_list(:transaction, 2, invoice: customer1_invoice, result: 'failed')
      customer2_transactions = create_list(:transaction, 4, invoice: customer2_invoice, result: 'success')
      customer3_transactions = create_list(:transaction, 3, invoice: customer3_invoice, result: 'success')
      customer4_transactions = create_list(:transaction, 2, invoice: customer4_invoice, result: 'success')
      customer5_transactions = create_list(:transaction, 6, invoice: customer5_invoice, result: 'success')
      customer6_transactions = create_list(:transaction, 5, invoice: customer6_invoice, result: 'success')
      customer7_transactions = create_list(:transaction, 7, invoice: customer7_invoice, result: 'success')
      customer7_transactions2 = create_list(:transaction, 2, invoice: customer7_invoice2, result: 'success')
      
      customer1_invoice_item = create(:invoice_item, invoice: customer1_invoice, item: item_1, status: 0)
      customer2_invoice_item = create(:invoice_item, invoice: customer2_invoice, item: item_2, status: 1)
      customer3_invoice_item = create(:invoice_item, invoice: customer3_invoice, item: item_3, status: 2)
      customer4_invoice_item = create(:invoice_item, invoice: customer4_invoice, item: item_1, status: 0)
      customer5_invoice_item = create(:invoice_item, invoice: customer5_invoice, item: item_2, status: 1)
      customer6_invoice_item = create(:invoice_item, invoice: customer6_invoice, item: item_3, status: 2)
      customer7_invoice_item = create(:invoice_item, invoice: customer7_invoice, item: item_3, status: 2)
      customer7_invoice_item2 = create(:invoice_item, invoice: customer7_invoice2, item: item_4, status: 2)
      
      visit "/merchants/#{merchant.id}/dashboard"
      
      within("#favorite_customers") do
        expect(page).to have_content("#{customer7.first_name} #{customer7.last_name} Completed Transactions: #{customer7_transactions.count}")
        expect(page).to_not have_content("#{customer1.first_name} #{customer1.last_name}")
        expect(page).to_not have_content("#{customer4.first_name} #{customer4.last_name}")
      end
    end
  end
end