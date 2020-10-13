Rails.application.routes.draw do
  resources :televisit, except: [:index, :update]
  put '/televisit/:id', to: 'televisit#end'
  get '/televisit/:id/start', to: 'televisit#start'
  get '/televisit/:id/end', to: 'televisit#end'
end
