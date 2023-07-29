Rails.application.routes.draw do
  root 'homes#index'

  resource :users
  resource :sessions
end
