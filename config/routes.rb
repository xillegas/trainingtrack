Rails.application.routes.draw do
  get 'works/index'
  # get 'works/show'
  # get 'works/new'
  # get 'works/create'
  # get 'works/edit'
  # get 'works/update'
  # get 'works/destroy'
  # get 'jobs/index'
  # get 'jobs/new'
  # get 'jobs/create'
  # get 'jobs/edit'
  # get 'jobs/update'
  # get 'jobs/destroy'
  # get 'exercises/index'
  # get 'exercises/show'
  # get 'exercises/new'
  # get 'exercises/create'
  # get 'exercises/edit'
  # get 'exercises/update'
  # get 'exercises/destroy'
  root to: "pages#home"
  resources :exercises do
    resources :jobs
    resources :works, except: [:index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
