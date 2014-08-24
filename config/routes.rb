Rails.application.routes.draw do

  root to: "contacts#index"

  resources :contacts
  resources :events

  get '/subregion_options' => 'country#subregion_select'
end
