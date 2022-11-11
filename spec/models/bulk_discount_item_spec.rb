require "rails_helper"

RSpec.describe BulkDiscountItem, type: :model do

  describe "relationships" do
    it { should belong_to :bulk_discount } 
    it { should belong_to :item }
  end
end