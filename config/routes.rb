Rails.application.routes.draw do

  root 'welcome#index'
  get 'welcome/index'

  get 'users/show'
  devise_for :users
  resources :users, only: [:show]

  resource :signups

  get '/' => "boards#new"
  get '/admin' => "signups#index"

  resources :boards, only: [:new, :create, :show, :destroy] do
    get 'share', on: :member
  end

  resources :tasks, only: [:create, :destroy, :edit, :update, :show] do
    post 'accept', on: :member
  end

end
