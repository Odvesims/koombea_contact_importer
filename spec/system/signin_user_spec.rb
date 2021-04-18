require 'rails_helper'

RSpec.describe "Signing User", type: :system do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.create :user, :rhaegar
  end

  it 'Registers and signs the user in' do
    visit '/users/sign_in'

    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    
    fill_in 'user_email', with: @user["email"]
    fill_in 'user_password', with: @user["password"]

    click_button 'Log in'

  end
end