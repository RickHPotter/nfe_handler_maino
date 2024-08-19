# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  root "invoices#new"

  resources :invoices, except: %i[edit update]
  resources :reports, except: %i[edit update] do
    member do
      get :download_excel
    end
  end

  mount Sidekiq::Web => "/sidekiq"
end
