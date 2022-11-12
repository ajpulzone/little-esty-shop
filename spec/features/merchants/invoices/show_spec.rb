require 'rails_helper'

RSpec.describe 'the merchant invoices show page' do
  describe "Little Esty Shop Group Project Testing" do
    before :each do
      @merchant1 = Merchant.create!(name: "Billy's Baby Book Barn")
      @merchant2 = Merchant.create!(name: "Candy's Child Compendium Collection")
      @item1 = @merchant1.items.create!(name: "Learn to Count, Dummy!", description: "Educational Children's Book", unit_price: 2400)
      @item2 = @merchant1.items.create!(name: "Go to Sleep Please, Mommy Just Wants to Watch Leno", description: "Baby Book", unit_price: 1550)
      @item3 = @merchant2.items.create!(name: "There ARE More Than Seven Animals But This is a Good Start", description: "Educational Children's Book", unit_price: 2100)
      @mary = Customer.create!(first_name: "Mary", last_name: "Mommy")
      @daniel = Customer.create!(first_name: "Daniel", last_name: "Daddy")
      @annie = Customer.create!(first_name: "Annie", last_name: "Auntie")
      @invoice1 = @mary.invoices.create!(status: 2)
      @invoice2 = @daniel.invoices.create!(status: 2)
      @invoice3 = @annie.invoices.create!(status: 2)
      @invoiceitem1 = InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price, status: 0 )
      @invoiceitem2 = InvoiceItem.create!(item: @item2, invoice: @invoice1, quantity: 2, unit_price: @item2.unit_price, status: 0 )
      @invoiceitem3 = InvoiceItem.create!(item: @item1, invoice: @invoice2, quantity: 1, unit_price: @item1.unit_price, status: 0 )
      @invoiceitem4 = InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: @item3.unit_price, status: 0 )
      @invoiceitem5 = InvoiceItem.create!(item: @item3, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price, status: 0 )
    end

    it 'displays the id/status/date/customer name related to the invoice' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content("Invoice ##{@invoice1.id}")
      expect(page).to have_content("Status: in progress")
      expect(page).to have_content("Created on: #{@invoice1.created_at.strftime('%A, %B%e, %Y')}")
      expect(page).to have_content("#{@mary.first_name} #{@mary.last_name}")
    end

    it 'display name/quantity/price/status for all invoice items' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      within "#invoice_item_#{@invoiceitem1.id}" do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@invoiceitem1.quantity)
        expect(page).to have_content("Unit Price: $24.00")
        expect(page).to have_content(@invoiceitem1.status)
      end

      within "#invoice_item_#{@invoiceitem2.id}" do
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@invoiceitem2.quantity)
        expect(page).to have_content("Unit Price: $15.50")
        expect(page).to have_content(@invoiceitem2.status)
      end
    end

    it 'display the total revenue for items sold on this invoice' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content("Total Revenue: $55.00")
    end

    it 'displays the invoice item current status as a select field' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      within "#invoice_item_#{@invoiceitem1.id}" do
        expect(page).to have_selector('#invoice_item_status')
        expect(page).to have_content('pending')
        expect(page).to have_button('Update Item Status')
      end

      within "#invoice_item_#{@invoiceitem2.id}" do
        expect(page).to have_selector('#invoice_item_status')
        expect(page).to have_content('pending')
        expect(page).to have_button('Update Item Status')
      end
    end

    it 'can update the status of an invoice item' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      within "#invoice_item_#{@invoiceitem1.id}" do
        page.select('packaged', from: :invoice_item_status)
        click_button('Update Item Status')

        expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
        expect(page).to have_content(@invoiceitem1.status)
      end
    end
  end 

  describe "Bulk Discounts Project Testing" do

    before(:each) do
      @merchant_1 = Merchant.create!(name: "Target", status: 1)
      @merchant_2 = Merchant.create!(name: "Amazon", status: 1)
      @merchant_3 = Merchant.create!(name: "Fred Meyer", status: 0)

      @customer_1 = Customer.create!(first_name: "Luke", last_name: "Harison")
      @customer_2 = Customer.create!(first_name: "Angela", last_name: "Leizer")
      @customer_3 = Customer.create!(first_name: "Matt", last_name: "Sorry")
      @customer_4 = Customer.create!(first_name: "Drake",last_name: "Pointer")
      @customer_5 = Customer.create!(first_name: "Fannie", last_name: "May")
      @customer_6 = Customer.create!(first_name: "Lorelai", last_name: "Gillmore")
      @customer_7 = Customer.create!(first_name: "Simon", last_name: "Garfunkle")
    
      @invoice_1 = @customer_1.invoices.create!(status: 0)
      @invoice_2 = @customer_1.invoices.create!(status: 0)
      @invoice_3 = @customer_1.invoices.create!(status: 1)
      @invoice_4 = @customer_1.invoices.create!(status: 2)
      @invoice_5 = @customer_1.invoices.create!(status: 2)
      @invoice_6 = @customer_2.invoices.create!(status: 0)
      @invoice_7 = @customer_2.invoices.create!(status: 0)
      @invoice_8 = @customer_3.invoices.create!(status: 0)
      @invoice_9 = @customer_3.invoices.create!(status: 0)
      @invoice_10 = @customer_3.invoices.create!(status: 2)
      @invoice_11 = @customer_3.invoices.create!(status: 0)
      @invoice_12 = @customer_4.invoices.create!(status: 1)
      @invoice_13 = @customer_4.invoices.create!(status: 1)
      @invoice_14 = @customer_4.invoices.create!(status: 2)
      @invoice_15 = @customer_5.invoices.create!(status: 0)
      @invoice_16 = @customer_5.invoices.create!(status: 0)
      @invoice_17 = @customer_6.invoices.create!(status: 1)
      @invoice_18 = @customer_6.invoices.create!(status: 2)
      @invoice_19 = @customer_6.invoices.create!(status: 2)
      @invoice_20 = @customer_7.invoices.create!(status: 0)
      
      @item_1 = Item.create!(merchant_id: @merchant_1.id, name: "Candy Dispenser", description: "Dispenses Candy", unit_price: 4291, status: 0)
      @item_2 = Item.create!(merchant_id: @merchant_1.id, name: "Towel", description: "100% Cotton", unit_price: 15, status: 1)
      @item_3 = Item.create!(merchant_id: @merchant_2.id, name: "Bowl", description: "Ceramic, Blue", unit_price: 5, status: 1)
      @item_4 = Item.create!(merchant_id: @merchant_2.id, name: "Napkin Holder", description: "Shaped Like A Taco", unit_price: 45, status: 1)
      @item_5 = Item.create!(merchant_id: @merchant_2.id, name: "Rocket Ship", description: "For Trip To Space", unit_price: 10000000, status: 1)
      @item_6 = Item.create!(merchant_id: @merchant_3.id, name: "TV", description: "52 Inch Flat Screen", unit_price: 90999, status: 0)
      
      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 56, unit_price: 203, status: 0)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 12, unit_price: 150, status: 1)
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 30, unit_price: 5, status: 2)
      @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_2.id, quantity: 44567, unit_price: 45, status: 1)
      @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 10000000, status: 2)
      @invoice_item_6 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_3.id, quantity: 738, unit_price: 90999, status: 2)

      @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, result: "success")
      @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 4580251236515201, result: "success")
      @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 4354495077693036, result: "failed")
      @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 4515551623735607, result: "failed")
      @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 4844518708741275, result: "failed")
      @transaction_6 = @invoice_6.transactions.create!(credit_card_number: 4203696133194408, result: "success")
      @transaction_7 = @invoice_7.transactions.create!(credit_card_number: 4801647818676136, result: "success")
      @transaction_8 = @invoice_8.transactions.create!(credit_card_number: 4540842003561938, result: "success")
      @transaction_9 = @invoice_9.transactions.create!(credit_card_number: 4140149827486249, result: "success")
      @transaction_10 = @invoice_10.transactions.create!(credit_card_number: 4923661117104166, result: "failed")
      @transaction_11 = @invoice_11.transactions.create!(credit_card_number: 4800749911485986, result: "success")
      @transaction_12 = @invoice_12.transactions.create!(credit_card_number: 4017503416578382, result: "failed")
      @transaction_13 = @invoice_13.transactions.create!(credit_card_number: 4536896898764278, result: "failed")
      @transaction_14 = @invoice_14.transactions.create!(credit_card_number: 4411510861233607, result: "failed")
      @transaction_15 = @invoice_15.transactions.create!(credit_card_number: 4869639160798434, result: "success")
      @transaction_16 = @invoice_16.transactions.create!(credit_card_number: 4738848761455352, result: "success")
      @transaction_17 = @invoice_17.transactions.create!(credit_card_number: 4214497729954420, result: "failed")
      @transaction_18 = @invoice_18.transactions.create!(credit_card_number: 4436110257010678, result: "failed")
      @transaction_19 = @invoice_19.transactions.create!(credit_card_number: 4332881798016631, result: "failed")
      @transaction_20 = @invoice_20.transactions.create!(credit_card_number: 4886443388914010, result: "success")

      @bulk_discount_1 = @merchant_1.bulk_discounts.create!(discount_percent: 10, quantity_threshold: 15)
      @bulk_discount_2 = @merchant_1.bulk_discounts.create!(discount_percent: 15, quantity_threshold: 10)
      @bulk_discount_3 = @merchant_1.bulk_discounts.create!(discount_percent: 20, quantity_threshold: 25)
      @bulk_discount_4 = @merchant_1.bulk_discounts.create!(discount_percent: 25, quantity_threshold: 30)
      @bulk_discount_5 = @merchant_1.bulk_discounts.create!(discount_percent: 100, quantity_threshold: 50)
      @bulk_discount_6 = @merchant_2.bulk_discounts.create!(discount_percent: 5, quantity_threshold: 10)
      @bulk_discount_7 = @merchant_2.bulk_discounts.create!(discount_percent: 30, quantity_threshold: 15)
      @bulk_discount_8 = @merchant_2.bulk_discounts.create!(discount_percent: 35, quantity_threshold: 20)
      @bulk_discount_9 = @merchant_3.bulk_discounts.create!(discount_percent: 50, quantity_threshold: 30)
    end
  
    it "a merchants invoice show page has the total revenue for the merchant from this invoice (not including discounts)
      and has the total discounted revenue for the merchant from this invoice which includes bulk discounts in the
      calculation " do
        visit merchant_invoice_path(@merchant_1.id, @invoice_1.id)

        expect(@merchant_1.invoice_1.total_revenue).to eq(131.68)
        
      # end

    end
  end
end