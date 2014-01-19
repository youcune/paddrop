Paddrop::Application.routes.draw do
  root to: 'sessions#root', as: :root
  get 'sign_in' => 'sessions#sign_in', as: :sign_in
  get 'authorize' => 'sessions#authorize', as: :authorize
  get 'sign_out' => 'sessions#sign_out', as: :sign_out
  put 'user' => 'users#update', as: :update_user
  get 'files/' => 'files#get'
  get 'files/*path' => 'files#get'
  post 'files/*path' => 'files#create'
  put 'files/*path' => 'files#update'
end
