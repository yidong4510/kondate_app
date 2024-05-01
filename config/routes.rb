Rails.application.routes.draw do
  root 'rakutens#index'
  get "fetch_recipe", to: "rakutens#fetch_recipe"
end
