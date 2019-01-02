Rails.application.routes.draw do
  resources :recipes, only: %i[index show create destroy], defaults: { format: :json }
end
