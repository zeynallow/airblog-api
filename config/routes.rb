Rails.application.routes.draw do
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  



  namespace :api do
    namespace :v1 do
    resources :users
    post '/auth/sign-in', to: 'auth#signIn'
    post '/auth/sign-up', to: 'auth#signUp'

    get '/profile', to: 'users#profile'

    get '/posts', to: 'posts#index'
    get '/post/:id', to: 'posts#show'

    end 
  end 

end
