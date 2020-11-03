Rails.application.routes.draw do
  resources :ping, only: [:index]
end
