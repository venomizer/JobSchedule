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

  match '/reports' => 'reports#index', via: [:get]
  match '/reports/active_jobs' => 'reports#active_jobs', via: [:get]
  match '/reports/finished_jobs' => 'reports#finished_jobs', via: [:get]
  match '/reports/job_summary/:job_jobNum' => 'reports#job_summary', via: [:get], as: 'job_summary_report_path'
  match '/reports/Bill_of_Materials' => 'reports#bill_of_materials', via: [:get]
end
