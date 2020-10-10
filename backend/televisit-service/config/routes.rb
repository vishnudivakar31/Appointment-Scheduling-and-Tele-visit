Rails.application.routes.draw do
  resources :televisit, except: [:index, :update]
  put '/televisit/:id', to: 'televisit#end'
  patch '/televisit/:id', to: 'televisit#end'
end
