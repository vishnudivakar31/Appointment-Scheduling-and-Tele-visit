Rails.application.routes.draw do
  resources :appointment
  post '/appointment/:id/charts', to: 'appointment#upload_charts'
  get '/appointment/:id/charts', to: 'appointment#get_charts'
  get '/appointment/:id/charts/:chart_id', to: 'appointment#get_charts_by_id'
  post '/appointment/:id/consultation_summary', to: 'appointment#upload_summary'
  get '/appointment/:id/consultation_summary', to: 'appointment#download_summary'
end
