require 'rails_helper'

RSpec.describe Item do
  before(:each) do
    @merchant = Merchant.create!(name: 'foo merchant')
    @item1 = @merchant.items.create!(name: 'foo item', status: 0)
    @item2 = @merchant.items.create!(name: 'bar item', status: 1)
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'instance methods' do
    describe 'enabled_items' do
      it 'has some behaviour' do
        @merchant.items.enabled_items.each do |item|
          expect(item).to eq(@item2)
        end
      end

    end
  end

end
