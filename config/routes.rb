Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :members
  resources :members, only: [:index]

  root 'pages#home'

  get 'about' => 'pages#about'
  get 'bibliography' => 'pages#bibliography'
  get 'contact' => 'pages#contact'
  get 'resources' => 'pages#resources'
  get 'disclaimer' => 'pages#disclaimer'
  get 'news' => 'pages#news'
end
