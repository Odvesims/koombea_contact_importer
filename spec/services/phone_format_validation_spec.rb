require 'rails_helper'

RSpec.describe PhoneFormatValidationService, type: :service do

  describe "validate phone format" do
    before do
      @first_phone = PhoneFormatValidationService.new('(+57) 320 432 05 09')
      @second_phone = PhoneFormatValidationService.new('(+82) 123-4323-05-09')
    end

    it "returns true for valid phone" do
      expect(@first_phone.execute).to eq(true) 
    end

    it "returns false for invalid phone" do
      expect(@second_phone.execute).to eq(false) 
    end
    
  end
end