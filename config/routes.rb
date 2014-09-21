Rails.application.routes.draw do

  devise_for :users
  root to: "contacts#index"

  resources :contacts
  resources :events
  resources :shopping do
    collection do
      get :start
    end
  end

  get '/subregion_options' => 'country#subregion_select'

  # constraints: OnlyAjaxRequest.new,
  api_version module: 'Api', path: { value: 'api' }, default: true do
    resources :contacts
    resources :comments
  end
end
