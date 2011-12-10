Timezoneslider::Application.routes.draw do
  resources :sliders, :except => [:new, :edit]
  get "timezones/search"
  root :to => 'dashboard#index'
end
