Rails.application.routes.draw do
  devise_for :users

  root 'projects#index'

  resources :projects do
    resources :sprints do

    end
  end
end
