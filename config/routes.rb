Rails.application.routes.draw do
  root to: 'rakutens#index'
  get "rakutens", to: "rakutens#index"
end
