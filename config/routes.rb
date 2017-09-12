Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  resources :jobs do
    post :sort, on: :collection
  end
end
