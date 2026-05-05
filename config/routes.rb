Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Rutas públicas (no necesitan login)
      post 'auth/register', to: 'auth#register'
      post 'auth/login',    to: 'auth#login'

      # Rutas protegidas (necesitan token)
      get 'profile', to: 'users#show'
    end
  end
end