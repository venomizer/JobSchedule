Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  resources :jobs do
    resources :parts do
      put 'finish'
    end
    put :sort, on: :collection
    member do
      put 'finish'
      put 'activate'
    end

  end
end
