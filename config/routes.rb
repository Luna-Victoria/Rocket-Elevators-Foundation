Rails.application.routes.draw do

  
  resources :interventions
  devise_for :users, :controllers => { registrations: 'registrations' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/residential' =>'home#residential'
  get '/commercial' =>'home#commercial'
  get '/quote' =>'quote#quote'
  get '/index-RocketElevators.html' =>'home#index'
  get '/index-rocketElevators-residential.html' => 'home#residential'
  get '/index-rocketElevators-commercial.html' => 'home#commercial'
  get '/index-Quote.html' => 'quote#quote'
  post '/new_quote' =>'quote#new_quote'
  post '/new_lead' =>'lead#new_lead'
  get '/chart' =>'charts#chart'
  get '/google' =>'google#google'
  get 'filter_elevators_by_column' => 'interventions#filter_elevators_by_column'
  get 'filter_columns_by_battery' => 'interventions#filter_columns_by_battery'
  get 'filter_batteries_by_building' => 'interventions#filter_batteries_by_building'
  get '/filter_buildings_by_customer' => 'interventions#filter_buildings_by_customer'
  

 
  root 'home#index'

end