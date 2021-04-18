require 'rails_helper'

RSpec.describe CardValidationService, type: :service do
  before do
    @card = CardValidationService.new('4111111111111111')
  end

  describe "card validation" do
    it "returns a valid franchise" do
      expect(@card.execute).to eq('Visa') 
    end
  end
end