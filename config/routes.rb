Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :members
  resources :members, only: [:index, :show, :edit, :update, :destroy] do
  end

  resources :news_items, path: 'news'

  resources :resources do
    member do
      get 'download'
    end
  end

  resources :contact_forms, only: [:create]

  get 'contact_forms', to: redirect('/contact')

  root 'pages#home'

  get 'about' => 'pages#about'
  get 'bibliography' => 'pages#bibliography'
  get 'contact' => 'pages#contact'
  get 'disclaimer' => 'pages#disclaimer'
  get 'privacy-statement' => 'pages#privacy_statement'
end
