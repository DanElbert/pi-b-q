Rails.application.routes.draw do

  resources :projects do
    get :data
  end

  root to: 'projects#index'

end
