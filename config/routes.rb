Rails.application.routes.draw do
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/breeds', to: 'breeds#index'
  delete 'destroy-breed', to: 'breeds#destroy'

  get '/cats', to: 'cats#index'
  delete 'destroy-cat', to: 'cats#destroy'
end
