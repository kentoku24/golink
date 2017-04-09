Rails.application.routes.draw do
  resources :links
  get ':word', to: 'go#convert'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
