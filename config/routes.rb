Rails.application.routes.draw do
  resources :astronauts do
    collection do
      get 'export'
      post 'import'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
