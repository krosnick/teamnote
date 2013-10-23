KrosnickProj2::Application.routes.draw do
    get "log_out" => "sessions#destroy", :as => "log_out"
    get "log_in" => "sessions#new", :as => "log_in"
    get "sign_up" => "users#new", :as => "sign_up"
    get "shared" => "notes#shared", :as => "shared"
    root :to => "sessions#new" # default page is login page
    resources :users
    resources :sessions
    resources :notes do
        member do
            get 'open'
            get 'view'
        end
    end
    resources :authorizations
end
