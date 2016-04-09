Rails.application.routes.draw do
  devise_for :users

  root 'projects#index'

  resources :projects do
    resources :sprints, except: :index do
      resources :start_sprint, only: :index
      resources :finish_sprint, only: :index
    end

    resources :activities

    resources :participations
  end
end
