Selfstarter::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #root :to => 'preorder#index'
  root :to => 'project#index'

  get 'project/:id'                 => 'project#detail'

  match '/preorder'                 => 'preorder#index', :via => [:get,:post]
  get 'preorder/checkout'
  match '/preorder/share/:uuid'     => 'preorder#share', :via => :get
  match '/preorder/ipn'             => 'preorder#ipn', :via => :post
  match '/preorder/prefill'         => 'preorder#prefill', :via => [:get,:post]
  match '/preorder/postfill'        => 'preorder#postfill', :via => [:get,:post]
end
