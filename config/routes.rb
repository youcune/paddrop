Paddrop::Application.routes.draw do
  get 'sign_in' => 'sessions#sign_in', as: :sign_in
  get 'authorize' => 'sessions#authorize', as: :authorize
  get 'setting' => 'users#setting', as: :setting

  namespace :files do
    match '*not_found' => 'files#index'
  end

  match '*not_found' => 'application#render404'
end
