Rails.application.routes.draw do
  resources :pumps
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

    resources :pumps do
    end
  end

  match '/reports' => 'reports#index', via: [:get]
  match '/reports/active_jobs' => 'reports#active_jobs', via: [:get]
  match '/reports/finished_jobs' => 'reports#finished_jobs', via: [:get]
  match '/reports/job_summary/:jobNum' => 'reports#job_summary', via: [:get], as: :job_report
  match '/reports/:jobNum' => 'reports#show', via: [:get], as: :individual_report
  match '/reports/bill_of_materials/:jobNum' => 'reports#bill_of_materials', via: [:get], as: :job_bom
end
