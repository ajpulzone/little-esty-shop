require 'rails_helper'
require 'faker'

RSpec.describe 'Merchant Dashboard' do
  
  before :each do
    @merchant1 = Merchant.create!(name:Faker::Company.name)
    visit "/merchants/#{@merchant1.id}/dashboard"
  end
  describe 'as a Merchant' do
    it "I see the name of my merchant" do
      expect(page).to have_content(@merchant1.name)
    end

  end
end