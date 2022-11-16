require "rails_helper"

RSpec.describe "Bulk Discounts Index Page", type: :feature do

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
    
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 738, unit_price: 4291, status: 0)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 12, unit_price: 15, status: 1)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 554, unit_price: 5, status: 2)
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

  it "on the merchant dashboard (show page), there is a link to view all of that merchants discounts" do

    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_link("My Bulk Discounts")
  end

  it "when that link is clicked the user is taken to that merchants bulk discounts index page" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    click_link "My Bulk Discounts"

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1.id))
  end

  it "on the merchants bulk discount index page there is a list of all of the bulk discouts including
    their percentage discount and quantity thresholds" do
      visit "/merchants/#{@merchant_1.id}/bulk_discounts"

      expect(page).to have_content("Bulk Discounts for #{@merchant_1.name}")

      within("#discount-#{@bulk_discount_1.id}") do
        expect(page).to have_content(@bulk_discount_1.id)
        expect(page).to have_content(@bulk_discount_1.discount_percent)
        expect(page).to have_content(@bulk_discount_1.quantity_threshold)
      end 

      within("#discount-#{@bulk_discount_2.id}") do
        expect(page).to have_content(@bulk_discount_2.id)
        expect(page).to have_content(@bulk_discount_2.discount_percent)
        expect(page).to have_content(@bulk_discount_2.quantity_threshold)
      end

      within("#discount-#{@bulk_discount_3.id}") do
        expect(page).to have_content(@bulk_discount_3.id)
        expect(page).to have_content(@bulk_discount_3.discount_percent)
        expect(page).to have_content(@bulk_discount_3.quantity_threshold)
      end

      within("#discount-#{@bulk_discount_4.id}") do
        expect(page).to have_content(@bulk_discount_4.id)
        expect(page).to have_content(@bulk_discount_4.discount_percent)
        expect(page).to have_content(@bulk_discount_4.quantity_threshold)
      end

      within("#discount-#{@bulk_discount_5.id}") do
        expect(page).to have_content(@bulk_discount_5.id)
        expect(page).to have_content(@bulk_discount_5.discount_percent)
        expect(page).to have_content(@bulk_discount_5.quantity_threshold)
        expect(page).to have_no_content(@bulk_discount_7.id)
        expect(page).to have_no_content(@bulk_discount_8.id)
      end
  end

  it "and the id of each bulk discount listed is a link to that bulk discounts show page" do
    visit "/merchants/#{@merchant_1.id}/bulk_discounts"
      expect(page).to have_link("#{@bulk_discount_1.id}")
      expect(page).to have_link("#{@bulk_discount_2.id}")
      expect(page).to have_link("#{@bulk_discount_3.id}")
      expect(page).to have_link("#{@bulk_discount_4.id}")
      expect(page).to have_link("#{@bulk_discount_5.id}")
      expect(page).to have_no_link("#{@bulk_discount_6.id}")
      expect(page).to have_no_link("#{@bulk_discount_7.id}")

      click_link "#{@bulk_discount_1.id}"
      expect(current_path).to eq(bulk_discount_path(@bulk_discount_1.id))
      expect(current_path).to_not eq(bulk_discount_path(@bulk_discount_2.id))
  end

  it "there is a link on a merchants bulk discounts index page to create a new discount" do
    visit "/merchants/#{@merchant_1.id}/bulk_discounts"

    expect(page).to have_link "Create A New Bulk Discount"

  end

  it "when the 'Create A New Discount' link is clicked, the merchant is taken to a new page where
    there is a form to add a new bulk discount" do

      visit "/merchants/#{@merchant_1.id}/bulk_discounts"
      click_link "Create A New Bulk Discount"

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1.id))
      expect(page).to have_field(:discount_percent)
      expect(page).to have_field(:quantity_threshold)
      expect(page).to have_button("Submit")
  end

  it "when the form is filled in with valid data, and the submit button is clicked then the merchant
    is redirected back to the bulk discount index page and the new bulk discount is listed" do

      visit "/merchants/#{@merchant_1.id}/bulk_discounts/new"

      fill_in :discount_percent,	with: 20
      fill_in :quantity_threshold,	with: 50
      click_button "Submit"

      @bulk_discount = BulkDiscount.last

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1.id))
      within("#discount-#{@bulk_discount.id}") do
        expect(page).to have_content(@bulk_discount.id)
        expect(page).to have_content(@bulk_discount.discount_percent)
        expect(page).to have_content(@bulk_discount.quantity_threshold)
      end
  end

  it "if the form is not completely filled out, the bulk discount will not be created, the
    merchant will be redirected back to the new bulk discount page and there will be an alert
    'Unable to complete your request, please fill out all fields'" do

      visit "/merchants/#{@merchant_1.id}/bulk_discounts/new"

      fill_in :discount_percent,	with: 20
      fill_in :quantity_threshold,	with: ""
      click_button "Submit"

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1.id))
      expect(page).to have_content("Unable to complete your request, please fill out all fields")
    end

    it "on the bulk discounts index page there is a link next to eah bulk discount to delete it" do
      visit "/merchants/#{@merchant_1.id}/bulk_discounts"

      within("#discount-#{@bulk_discount_1.id}") do
        expect(page).to have_link "Delete Discount?"
      end 

      within("#discount-#{@bulk_discount_2.id}") do
        expect(page).to have_link "Delete Discount?"
      end

      within("#discount-#{@bulk_discount_3.id}") do
        expect(page).to have_link "Delete Discount?"
      end

      within("#discount-#{@bulk_discount_4.id}") do
        expect(page).to have_link "Delete Discount?"
      end

      within("#discount-#{@bulk_discount_5.id}") do
        expect(page).to have_link "Delete Discount?"
      end
    end

    it "when the delete link is clicked, then the merchant is redirected back to the bulk discounts
      index page and the discount is no longer listed" do
        visit "/merchants/#{@merchant_1.id}/bulk_discounts"

        expect(page).to have_content(@bulk_discount_1.id)

        within("#discount-#{@bulk_discount_1.id}") do
          click_link "Delete Discount?"
        end

        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1.id))
        expect(page).to have_no_content(@bulk_discount_1.id)
        expect(page).to have_content(@bulk_discount_2.id)
        expect(page).to have_content(@bulk_discount_3.id)
        expect(page).to have_content(@bulk_discount_4.id)
        expect(page).to have_content(@bulk_discount_5.id)
    end

    it "has a section with a header of 'Upcoming Holidays', and in this section the name and date of the 
      next 3 upcoming US holidays are listed" do
        visit "/merchants/#{@merchant_1.id}/bulk_discounts"

        within("#holidays") do
          expect(page).to have_content("Upcoming Holidays")
          expect(page).to have_content("Holiday: Thanksgiving Day, Date: 2022-11-24")
          expect(page).to have_content("Holiday: Christmas Day, Date: 2022-12-26")
          expect(page).to have_content("Holiday: New Year's Day, Date: 2023-01-02")
          expect(page).to have_no_content("Holiday: Easter, Date: 2023-04-09")
        end 
    end
end