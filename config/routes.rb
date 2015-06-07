Rails.application.routes.draw do

  get 'errors/file_not_found'

  get 'errors/unprocessable'

  get 'errors/internal_server_error'

  root 'welcome#index'
  get 'welcome/index'
  
  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all


  get 'users/show'
  devise_for :users
  resources :users, only: [:show]

  get '/' => "boards#new"

  resources :boards, only: [:new, :create, :show, :destroy] do
    get 'share', on: :member
    get 'supporters', on: :member
    resource :invites, only: [:new, :create] do
      get 'claim'
    end
  end

  resources :tasks, only: [:create, :destroy, :edit, :update, :show] do
    post 'accept', on: :member
    post 'complete', on: :member
    post 'pin', on: :member
  end

  get 'twilio' => "messages#twilio_receive"

end
