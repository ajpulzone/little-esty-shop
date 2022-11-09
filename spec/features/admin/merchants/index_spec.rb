require 'rails_helper'
require 'faker'

RSpec.describe "Admin Merchants Index Page", type: :feature do
  
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
    @invoice_3 = @customer_1.invoices.create!(status: 1, created_at: DateTime.new(2022, 10, 29, 9, 54, 9))
    @invoice_4 = @customer_1.invoices.create!(status: 2)
    @invoice_5 = @customer_1.invoices.create!(status: 2)
    @invoice_6 = @customer_2.invoices.create!(status: 0, created_at: DateTime.new(2022, 10, 31, 9, 54, 9))
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
    
    @item_1 = Item.create!(merchant_id: @merchant_1.id, name: "Candy Dispenser", description: "Dispenses Candy", unit_price: 4291)
    @item_2 = Item.create!(merchant_id: @merchant_1.id, name: "Towel", description: "100% Cotton", unit_price: 15)
    @item_3 = Item.create!(merchant_id: @merchant_2.id, name: "Bowl", description: "Ceramic, Blue", unit_price: 5)
    @item_4 = Item.create!(merchant_id: @merchant_2.id, name: "Napkin Holder", description: "Shaped Like A Taco", unit_price: 45)
    @item_5 = Item.create!(merchant_id: @merchant_2.id, name: "Rocket Ship", description: "For Trip To Space", unit_price: 10000000)
    @item_6 = Item.create!(merchant_id: @merchant_3.id, name: "TV", description: "52 Inch Flat Screen", unit_price: 90999)
    
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 738, unit_price: 4291, status: 0)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 12, unit_price: 15, status: 1)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 554, unit_price: 5, status: 2)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_2.id, quantity: 44567, unit_price: 45, status: 1)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 10000000, status: 2)
    @invoice_item_6 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_3.id, quantity: 738, unit_price: 90999, status: 2)
    @invoice_item_7 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_6.id, quantity: 738, unit_price: 90999, status: 2)

    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, result: "success")
    @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 4580251236515201, result: "success")
    @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 4354495077693036, result: "success")
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
  end

  it "has the names of each merchant in the system" do
    visit "/admin/merchants"

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
  end

  it "there are 2 sections: one for 'Enabled Merchants' and one for 'Disabled Merchants'
    and each merchant is listed in the appropriate section" do
      visit "/admin/merchants"

      within("#admin-enabled_merchants") do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_no_content(@merchant_3.name)
      end

      within("#admin-disabled_merchants") do
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_no_content(@merchant_1.name)
        expect(page).to have_no_content(@merchant_2.name)
      end
    end

  it "next to each merchants name there is a button to disable/enable that merchant" do
    visit "/admin/merchants"

    within("#enab_merchant-#{@merchant_1.id}") do
      have_button?("Disable?")
    end

    within("#enab_merchant-#{@merchant_2.id}") do
      have_button?("Disable?")
    end

    within("#disab_merchant-#{@merchant_3.id}") do
      have_button?("Enable?")
    end
  end

  it "when the button is clicked, the user is redirected back to the admin merchants index
    page and the merchant's status has changed" do
      visit "/admin/merchants"

      expect(@merchant_1.status).to eq("enabled")

      within("#enab_merchant-#{@merchant_1.id}") do
        click_button "Disable?"
        expect(current_path).to eq("/admin/merchants")
      end

      within("#admin-enabled_merchants") do
        expect(page).to have_no_content(@merchant_1.name)
      end

      within("#admin-disabled_merchants") do
        expect(page).to have_content(@merchant_1.name)
      end
    
      expect(@merchant_1.status).to eq("enabled")
    end

  it "the name of each merchant is a link, and when that link is clicked the used it taken
    to the specified merchants admin show page" do
      visit "/admin/merchants"
      
      within("#enab_merchant-#{@merchant_1.id}") do
        expect(page).to have_link("#{@merchant_1.name}")
        click_link "#{@merchant_1.name}"
      end 
      
      expect(current_path).to eq(admin_merchant_path(@merchant_1.id))
      expect(page).to have_content(@merchant_1.name)
  end

  # As an admin,
  # When I visit the admin merchants index
  # I see a link to create a new merchant.
  # When I click on the link,
  # I am taken to a form that allows me to add merchant information.
  # When I fill out the form I click ‘Submit’
  # Then I am taken back to the admin merchants index page
  # And I see the merchant I just created displayed
  # And I see my merchant was created with a default status of disabled.
  it 'has a link to create a new merchant' do
    visit "/admin/merchants"

    expect(page).to have_link('New Merchant')
  end

  it 'can create a new merchant with a default status of disabled' do
    visit "/admin/merchants"

    click_link('New Merchant')
    expect(current_path).to eq('/admin/merchants/new')

    fill_in('Merchant Name', with: 'HomeGoods')
    click_button('Add Merchant')
    new_merchant = Merchant.last

    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_content(new_merchant.name)
    expect(new_merchant.status).to eq('disabled')
  end

  it 'displays the top five merchants by total revenue' do
    visit "/admin/merchants"

    within '#top_five_merchants' do
      expect("#{@merchant_3.name}").to appear_before("#{@merchant_2.name}")
      expect("#{@merchant_2.name}").to appear_before("#{@merchant_1.name}")
    end
  end

  it "has a link to each top five merchant's show page" do
    visit "/admin/merchants"

    within "#top_five_merchant_#{@merchant_3.id}" do
      expect(page).to have_link("#{@merchant_3.name}")
      click_link("#{@merchant_3.name}")
      expect(current_path).to eq(admin_merchant_path(@merchant_3.id))
    end
  end

  it 'displays the total revenue next to each merchant name' do
    visit "/admin/merchants"

    within "#top_five_merchant_#{@merchant_3.id}" do
      expect(page).to have_content("$1,343,145.24 in sales")
    end
  end

  it 'displays the top selling date for each top 5 merchant' do
    visit "/admin/merchants"

    within "#top_five_merchant_#{@merchant_3.id}" do
      expect(page).to have_content("Top day for #{@merchant_3.name} was 10/31/22")
    end
  end
end