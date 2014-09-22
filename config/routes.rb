Rails.application.routes.draw do

  get 'users/sign_in'   => 'root#login'
  get 'users/sign_out'  => 'root#logout'
  devise_for :users
  root to: "contacts#index"

  resources :contacts
  resources :events
  resources :shopping do
    collection do
      get :start
      post :start
    end
  end

  get '/subregion_options' => 'country#subregion_select'

  # constraints: OnlyAjaxRequest.new,
  api_version module: 'Api', path: { value: 'api' }, default: true do
    resources :contacts
    resources :comments
  end
end
