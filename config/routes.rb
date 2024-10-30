Rails.application.routes.draw do
  # Rutas para la salud de la aplicación
  get "up" => "rails/health#show", as: :rails_health_check

  # Rutas para PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Rutas de artículos y comentarios
  resources :articles do
    resources :comments
  end

  # Ruta raíz
  root 'welcome#index'
end
