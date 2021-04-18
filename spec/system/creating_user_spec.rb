require 'rails_helper'

RSpec.describe "Creating User", type: :system do
  before do
    driven_by(:rack_test)
    @user = User.new(email: 'rhaegar@westeros.com', password: '123456')
  end

  it 'Registers and signs the user in' do
    visit '/users/sign_up'

    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Password confirmation')
    
    fill_in 'user_email', with: @user["email"]
    fill_in 'user_password', with: @user["password"]
    fill_in 'user_password_confirmation', with: @user["password"]

    click_button 'Sign up'

  end
end