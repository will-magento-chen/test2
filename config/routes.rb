Rails.application.routes.draw do

  root to: "contacts#index"

  resources :contacts
  resources :events

  get '/subregion_options' => 'country#subregion_select'

  # constraints: OnlyAjaxRequest.new,
  api_version module: 'Api', path: { value: 'api' }, default: true do
    resources :contacts
    resources :comments
  end
end
