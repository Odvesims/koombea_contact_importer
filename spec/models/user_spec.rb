require 'rails_helper'

RSpec.describe User, type: :model do
    before do
      @user = FactoryBot.create :user, :rhaegar
    end

    describe "user creation" do
      it "can be created" do
        expect(@user).to be_valid
      end
      it "cannot be created without email or password" do
        @user.email = nil
        @user.password = nil
        expect(@user).to_not be_valid
      end
      it "cannot be created with an email already registered" do
        new_user = User.new(email: 'rhaegar@westeros.com', password: '654321')
        expect(new_user).to_not be_valid()
      end
   end
end