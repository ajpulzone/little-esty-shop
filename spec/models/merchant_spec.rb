require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name}
    it { should define_enum_for(:status). with_values(disabled: 0, enabled: 1) }
  end

  before :each do
    @merchant1 = Merchant.create!(name: "Billy's Baby Book Barn")
    @merchant2 = Merchant.create!(name: "Candy's Child Compendium Collection")
    @item1 = @merchant1.items.create!(name: "Learn to Count, Dummy!", description: "Educational Children's Book", unit_price: 2400)
    @item2 = @merchant1.items.create!(name: "Go to Sleep Please, Mommy Just Wants to Watch Leno", description: "Baby Book", unit_price: 1500)
    @item3 = @merchant2.items.create!(name: "There ARE More Than Seven Animals But This is a Good Start", description: "Educational Children's Book", unit_price: 2100)
    @item4 = create(:item, merchant: @merchant2)
    @mary = Customer.create!(first_name: "Mary", last_name: "Mommy")
    @daniel = Customer.create!(first_name: "Daniel", last_name: "Daddy")
    @annie = Customer.create!(first_name: "Annie", last_name: "Auntie")
    @invoice1 = @mary.invoices.create!(status: 2)
    @invoice2 = @daniel.invoices.create!(status: 2)
    @invoice3 = @annie.invoices.create!(status: 2)
    @invoiceitem1 = InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price, status: 0 )
    @invoiceitem2 = InvoiceItem.create!(item: @item2, invoice: @invoice1, quantity: 1, unit_price: @item2.unit_price, status: 0 )
    @invoiceitem3 = InvoiceItem.create!(item: @item1, invoice: @invoice2, quantity: 1, unit_price: @item1.unit_price, status: 0 )
    @invoiceitem4 = InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: @item3.unit_price, status: 0 )
    @invoiceitem5 = InvoiceItem.create!(item: @item4, invoice: @invoice2, quantity: 1, unit_price: @item1.unit_price, status: 1 )
    @invoiceitem6 = InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: @item3.unit_price, status: 2 )
  end

  describe 'model methods' do
    describe '#unique_invoices' do
      it 'returns a unique list of invoices for a merchant' do
        expect(@merchant1.unique_invoices).to match([@invoice1, @invoice2])
      end
    end
    
    describe '#invoices_not_shipped' do
      it "returns a list of items for invoices that are either 'packaged' or 'pending'" do
        expect(@merchant2.invoices_not_shipped).to eq([@invoiceitem4, @invoiceitem5])
        # expect(@merchant2.invoices_not_shipped).to eq([@invoiceitem4.item, @invoiceitem5.item])
      end
    end
  end
end