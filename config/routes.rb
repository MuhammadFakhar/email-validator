Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :valid_emails, only: [:index] do
    collection do
      get :search
    end
  end

  root "valid_emails#index"
end
