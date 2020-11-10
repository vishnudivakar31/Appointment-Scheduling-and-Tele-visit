Rails.application.routes.draw do
  resources :appointment
  post '/appointment/:id/charts', to: 'appointment#upload_charts'
  get '/appointment/:id/charts', to: 'appointment#get_charts'
  get '/appointment/:id/charts/:chart_id', to: 'appointment#get_charts_by_id'
  post '/appointment/:id/consultation_summary', to: 'appointment#upload_summary'
  get '/appointment/:id/consultation_summary', to: 'appointment#download_summary'
  post '/appointment/:id/billing_codes', to: 'appointment#create_billing_codes'
  get '/appointment/:id/billing_codes', to: 'appointment#get_billing_codes'
  get '/appointment/:id/report', to: 'appointment#report'
  get '/cancelled_appointments', to: 'cancelled_appointment#show'
end
