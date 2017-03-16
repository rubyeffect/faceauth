Faceauth::Engine.routes.draw do
    resources :faces
    get '/faceauth/sign_in', to: 'faces#new', as: 'new_session'
end
