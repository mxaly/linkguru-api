Linkguru::Application.routes.draw do
  resources :links, only: :index
end
