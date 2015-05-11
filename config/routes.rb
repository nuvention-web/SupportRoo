Rails.application.routes.draw do

  root 'welcome#index'
  get 'welcome/index'

  get 'users/show'
  devise_for :users
  resources :users, only: [:show]

  get '/' => "boards#new"

  resources :boards, only: [:new, :create, :show, :destroy] do
    get 'share', on: :member
    resource :invites, only: [:new, :create] do
      get 'claim'
    end
  end

  resources :tasks, only: [:create, :destroy, :edit, :update, :show] do
    post 'accept', on: :member
    post 'complete', on: :member
    post 'pin', on: :member
  end

  get 'twilio' => "messages#twilio"

end
