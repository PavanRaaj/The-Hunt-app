Rails.application.routes.draw do
 
  # resources :manager
  get 'manager/index', as: 'manager'
  get 'manager/add_jobs', to: 'manager#show', as: 'manager_job'
  match 'manager/add_job', to: 'manager#add_job', via: :post
  delete '/delete_job/:id' => 'manager#delete_job'
  get "manager/applicants"

  get 'interviewee/index', as: 'interviwee' 
  get 'interviewee/list_jobs'
  get '/search_job', to: 'interviewee#search_job'
  get "interviewee/application_form/:id", to: 'interviewee#new_applicant' 
  match 'interviewee/applicants_details/:id', to: 'interviewee#applicants_details', via: :post
  get "interviewee/:id", to: "interviewee#show"
  

  post "/job_delete/add/:job_id", to: "manager#bulk_delete_add", as: :job_delete_add
  delete "/job_delete", to: "manager#bulk_delete", as: :job_delete
  resources :job, only: [:index, :new, :create, :destroy] 
  

  resources :password_resets
  
  get 'page/reviews', to: 'page#new_review', as: 'review'
  match 'page/review_details', to: 'page#review_details', via: :post
  
  resources :sessions, only: [:new, :create, :destroy]  
  get 'signup', to: 'users#new', as: 'signup'  
  get 'login', to: 'sessions#new', as: 'login'  
  get 'logout', to: 'sessions#destroy', as: 'logout'  
  resources :users do
    member do
      get :confirm_email
    end
  end

 

  
  root 'users#new' 

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
