Paddrop::Application.routes.draw do
  get 'sign_in' => 'sessions#sign_in', as: :sign_in
  get 'authorize' => 'sessions#authorize', as: :authorize
  get 'setting' => 'users#setting', as: :setting
  get '*path' => 'files#routing'
  post '*path' => 'files#routing'
  put '*path' => 'files#routing'
  delete '*path' => 'files#routing'
end
