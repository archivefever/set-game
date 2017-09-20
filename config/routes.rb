Rails.application.routes.draw do

    resources :players, only: [:new, :show, :create]


end
