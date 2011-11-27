Timezoneslider::Application.routes.draw do
  resources :sliders, :except => [:new, :edit]
  root :to => 'dashboard#index'
end
