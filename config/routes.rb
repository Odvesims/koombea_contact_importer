Rails.application.routes.draw do
  devise_for :users do get '/users/sign_out' => 'devise/sessions#destroy' end
  root 'home#index'
  resources :contacts
  resources :failed_contacts
  resources :uploaded_files do
    post 'process_file', on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
