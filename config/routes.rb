Rails.application.routes.draw do
  resources :candidates  do
    member do
      post :vote
    end
  end
  # get '/hello.php' , to: 'candidates#index'
  # post '/candidates/:id/vote', to: 'candidates#vote'
end
