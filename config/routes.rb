Rails.application.routes.draw do
  get 'admin/index'
  get 'courses/index'
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'user/logout', to: 'user#logout'
  get 'user/login'
  post 'user/login', to: 'user#login_post'
  get 'user/register'
  post 'user', to: 'user#create'
  get 'user/:id', to: 'user#show', as: 'show_user'
  get 'user/:id/edit', to: 'user#edit', as: "edit_user"
  patch 'user/:id', to: 'user#update'
  delete 'user/:id', to: 'user#destroy'

  get 'coordinators', to: "user#index"

  get 'dashboard', to: "admin#index"
  get 'dashboard/coordinators', to: "admin#coordinators"
  get 'dashboard/categories', to: "admin#categories"

  resources :categories, :courses, :locations
  get 'courses/:course_id/thumbsup', to: "courses#thumbs_up", as: "thumbsup_course"
  get 'courses/:course_id/thumbsdown', to: "courses#thumbs_down", as: "thumbsdown_course"
  get 'courses/:course_id/resetvotes', to: "courses#reset_votes", as: "resetvotes_course"

  get 'api/courses/:id', to: "courses#api_course"
  get 'api/courses', to: "courses#api_courses"
  get 'api/coordinators/:id', to: "user#api_user"
  get 'api/coordinators', to: "user#api_users"


  get "contact", to: "home#contact"
  post "sendemail", to: "home#sendemail"
  root 'home#index'
end
