Paddrop::Application.routes.draw do
  root to: 'sessions#root', as: :root
  get 'sign_in' => 'sessions#sign_in', as: :sign_in
  get 'authorize' => 'sessions#authorize', as: :authorize
  get 'files/' => 'files#get'
  get 'files/*path' => 'files#get'
  post 'files/*path' => 'files#create'
  put 'files/*path' => 'files#update'
  delete 'files/*path' => 'files#routing'
end
