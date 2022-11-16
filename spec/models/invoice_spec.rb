require 'rails_helper'

RSpec.describe Invoice, type: :model do

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:bulk_discounts).through(:items) }
  end

  describe 'enums' do
    it { should define_enum_for(:status) }
  end

  describe "Group Project Testing" do
    before :each do
      @merchant1 = Merchant.create!(name: "Billy's Baby Book Barn")
      @merchant2 = Merchant.create!(name: "Candy's Child Compendium Collection")
      @item1 = @merchant1.items.create!(name: "Learn to Count, Dummy!", description: "Educational Children's Book", unit_price: 2400)
      @item2 = @merchant1.items.create!(name: "Go to Sleep Please, Mommy Just Wants to Watch Leno", description: "Baby Book", unit_price: 1500)
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

    describe 'model methods' do
      describe '#formatted_date' do
        it "displays the date as 'Weekday, Month Day, Year'" do
          expect(@invoice1.formatted_date).to eq(@invoice1.created_at.strftime('%A, %B%e, %Y'))
        end
      end

      describe '#numerical_date' do
        it "displays the date as 'Weekday, Month Day, Year'" do
          expect(@invoice1.numerical_date).to eq(@invoice1.created_at.strftime('%-m/%-e/%y'))
        end
      end

      describe "#incomplete_invoices" do
      
        before(:each) do
          @customer_1 = Customer.create!(first_name: "Luke", last_name: "Harison")
          
          @merchant_1 = Merchant.create!(name: "Target")
          @merchant_2 = Merchant.create!(name: "Amazon")
          @merchant_3 = Merchant.create!(name: "Fred Meyer")

          @invoice_4 = @customer_1.invoices.create!(status: 0)
          @invoice_5 = @customer_1.invoices.create!(status: 0)
          @invoice_6 = @customer_1.invoices.create!(status: 1)
          @invoice_7 = @customer_1.invoices.create!(status: 2)
          
          @item_1 = Item.create!(merchant_id: @merchant_1.id, name: "Candy Dispenser", description: "Dispenses Candy", unit_price: 4291)
          @item_2 = Item.create!(merchant_id: @merchant_1.id, name: "Towel", description: "100% Cotton", unit_price: 15)
          @item_3 = Item.create!(merchant_id: @merchant_2.id, name: "Bowl", description: "Ceramic, Blue", unit_price: 5)
          @item_4 = Item.create!(merchant_id: @merchant_2.id, name: "Napkin Holder", description: "Shaped Like A Taco", unit_price: 45)
          @item_5 = Item.create!(merchant_id: @merchant_2.id, name: "Rocket Ship", description: "For Trip To Space", unit_price: 10000000)
          @item_6 = Item.create!(merchant_id: @merchant_3.id, name: "TV", description: "52 Inch Flat Screen", unit_price: 90999)
          
          @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id, quantity: 738, unit_price: 4291, status: 0)
          @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_4.id, quantity: 12, unit_price: 15, status: 2)
          @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_4.id, quantity: 554, unit_price: 5, status: 2)
          @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_5.id, quantity: 44567, unit_price: 45, status: 2)
          @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 10000000, status: 2)
          @invoice_item_6 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_6.id, quantity: 738, unit_price: 90999, status: 2)
        end
        
        it "returns a list of all unique invoices that have items that have not been shipped from newest to oldest based on when
          the invoice was created " do
            expect(Invoice.incomplete_invoices).to eq([@invoice1, @invoice2, @invoice3, @invoice_4])
            expect(Invoice.incomplete_invoices).to_not include(@invoice_5, @invoice_6)    
        end 

        describe "#total_revenue" do
          it "should return the toal revenue that will be generated by the specified invoice" do
            expect(@invoice_4.total_revenue).to eq(4311)
            expect(@invoice_5.total_revenue).to eq(10000045)
            expect(@invoice_6.total_revenue).to_not eq(4311)
          end 
        end
    end 
  end 

    describe "Solo Project Testing" do

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

      describe "#total_invoice_revenue" do
        it "should return the total amount of revenue earned on this invoice before discounts" do
          expect(@invoice_1.total_invoice_revenue).to eq(3169708)
          expect(@invoice_2.total_invoice_revenue).to eq(12005515) 
          expect(@invoice_3.total_invoice_revenue).to eq(67157262)
        end
      end

      describe "#total_invoice_discounts" do
        it "should return the total amount of discounts applied to invoice" do
          expect(@invoice_1.total_invoice_discounts).to eq(3167754)
          expect(@invoice_2.total_invoice_discounts).to eq(701930)
          expect(@invoice_3.total_invoice_discounts).to eq(33578631)
        end
      end 

      describe "#total_discounted_revenue" do
        it "should return the total revenue of an invoice after all discounts are applied" do
          expect(@invoice_1.total_discounted_revenue).to eq(1954)
          expect(@invoice_2.total_discounted_revenue).to eq(11303585)
          expect(@invoice_3.total_discounted_revenue).to eq(33578631)
        end
      end
    end 
  end 
end