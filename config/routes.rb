Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :creators
  resources :gigs
  resources :gig_payments

  put  'gigs/:id' => 'gigs#update'
end
