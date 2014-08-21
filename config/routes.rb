Rails.application.routes.draw do

  root to: "contacts#index"

  resources :contacts
  resources :events
end
