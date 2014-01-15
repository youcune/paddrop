Paddrop::Application.routes.draw do
  resources :users, only: [:new]
  get 'users/create'
  get 'files' => 'files#index'
end
