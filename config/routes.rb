Rails.application.routes.draw do
  filter :locale
  root "static_pages#home"

  devise_for :users, path: "auth", path_names: {sign_in: "login", sign_out: "logout"}

  namespace :admin do
    resources :course_masters
    resources :courses do
      resources :subjects
      resource :assign_trainers, only: [:edit, :update]
      resource :assign_trainees, only: [:edit, :update]
      resource :change_status_courses, only: :update
    end
    resources :roles do
      resource :allocate_permissions
    end
    resources :subjects
    resources :course_subjects do
      resources :user_subjects, only: :update do
      end
    end

    patch "status_subject/:course_subject_id/:status" => "status_subjects#update",
      as: :status_subject
  end

  resources :courses, only: :show do
    resources :subjects, only: :show
    resources :tasks
    resources :user_subjects, only: [:update, :show]
  end
  resources :users, only: [:edit, :update, :show]
  resources :subjects, only: [:show]
  resources :user_tasks
end
