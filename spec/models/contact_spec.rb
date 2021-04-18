require 'rails_helper'

RSpec.describe Contact, type: :model do

  describe "valid creation" do

    before do
      @valid_contact = FactoryBot.build :contact, :aerys
      @empty_contact = FactoryBot.build :contact, :robert
    end
    
    it "can be created" do
      expect(@valid_contact).to be_valid
    end

    it "cant be created because of empty values" do
      expect(@empty_contact).to_not be_valid
    end

  end

  describe "test validations" do
    before do
      @invalid_contact = FactoryBot.build :contact, :lyanna
    end

    it "fails name validation because of wrong format" do
      expect(@invalid_contact.name_format).to eq(false)
    end

    it "fails date validation because of wrong format" do
      expect(@invalid_contact.date_format).to eq(false)
    end

    it "fails phone validation because of wrong format" do
      expect(@invalid_contact.phone_format).to eq(false)
    end

    it "fails email validaton because of wrong format" do
      expect(@invalid_contact.email_format).to eq(false)
    end

  end
  
end