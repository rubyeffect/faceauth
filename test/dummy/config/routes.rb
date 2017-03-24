Rails.application.routes.draw do
  resources :faces
  get '/faceauth/sign_in', to: 'faces#new', as: 'new_session'
  mount Faceauth::Engine => "/faceauth"
  
end
