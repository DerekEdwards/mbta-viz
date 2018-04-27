Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "commuter_rail#index"
  get 'index' => 'commuter_rail#index' 

end
