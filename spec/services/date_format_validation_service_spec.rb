require 'rails_helper'

RSpec.describe DateFormatValidationService, type: :service do

  describe "valid date format" do
    before do
      @date = DateFormatValidationService.new('2020-01-01')
      @leap_year = DateFormatValidationService.new('2020-02-29')
    end
    it "returns true for valid date" do
      expect(@date.execute).to eq(true) 
    end
    it "returns true for a date with 29 days in febraury in a leap year" do
      expect(@leap_year.execute).to eq(true) 
    end
  end

  describe "invalid date format" do
    before do
      @bad_date = DateFormatValidationService.new('20200230')
    end
    it "returns false for an invalid date" do
      expect(@bad_date.execute).to eq(false) 
    end
  end
end