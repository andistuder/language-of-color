Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :members
  resources :members, only: [:index]

  resources :news_items, path: 'news'

  resources :contact_forms, only: [:create]

  get 'contact_forms', to: redirect('/contact')

  root 'pages#home'

  get 'about' => 'pages#about'
  get 'bibliography' => 'pages#bibliography'
  get 'contact' => 'pages#contact'
  get 'resources' => 'pages#resources'
  get 'disclaimer' => 'pages#disclaimer'
  get 'news' => 'pages#news'
end
