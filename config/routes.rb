Rails.application.routes.draw do

    resources :players, only: [:new, :show, :create]

    root 'players#new'
end
