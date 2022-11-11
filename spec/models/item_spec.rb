require 'rails_helper'

RSpec.describe Item, type: :model do
  
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many :bulk_discount_items}
    it { should have_many(:bulk_discounts).through(:bulk_discount_items) }
  end

  before(:each) do
    @merchant = Merchant.create!(name: 'foo merchant')
    @item1 = @merchant.items.create!(name: 'foo item', status: 0)
    @item2 = @merchant.items.create!(name: 'bar item', status: 1)
  end

end
