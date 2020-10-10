Rails.application.routes.draw do
  resources :televisit, except: [:index, :update]
  put '/televisit/:id', to: 'televisit#end'
  get '/televisit/:id/start', to: 'televisit#start'
  get '/televisit/:id/end', to: 'televisit#end'
  post '/televisit/:id/charts', to: 'televisit#add_charts'
  post '/televisit/:id/consulation_notes', to: 'televisit#add_consulation_notes'
end
