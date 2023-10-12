Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do

      post '/auth/sign-in', to: 'auth#sign_in'
      post '/auth/sign-up', to: 'auth#sign_up'
      # get '/*a', to: 'application#not_found'

      get '/profile', to: 'profile#index'
      put '/profile', to: 'profile#update'
      get '/profile/:id', to: 'profile#get_user'


      get '/posts', to: 'posts#index'
      get '/post/:id', to: 'posts#show'
      post '/post/create', to: 'posts#create'
      put '/post/:id', to: 'posts#update'
      delete '/post/:id', to: 'posts#delete'

      # get '/posts', to: 'posts#index'
      # get '/post/:id', to: 'posts#show'

    end
  end

end
