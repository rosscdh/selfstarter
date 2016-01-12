Selfstarter::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #root :to => 'preorder#index'
  root :to => 'project#index'

  get 'p/:id'                       => 'project#detail'

  match 'p/:id/preorder'                 => 'preorder#index', :via => [:get,:post]
  match 'p/:id/preorder/checkout'          => 'preorder#checkout', :via => [:get,:post]
  match 'p/:id/preorder/share/:uuid'     => 'preorder#share', :via => :get
  match 'p/:id/preorder/ipn'             => 'preorder#ipn', :via => :post
  match 'p/:id/preorder/prefill'         => 'preorder#prefill', :via => [:get,:post]
  match 'p/:id/preorder/postfill'        => 'preorder#postfill', :via => [:get,:post]
end
