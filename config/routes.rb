Selfstarter::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #root :to => 'preorder#index'
  root :to => 'project#index'

  get 'p/:slug'                            => 'project#detail'

  match 'p/:slug/preorder'                 => 'preorder#index', :via => [:get,:post]
  match 'p/:slug/preorder/checkout'        => 'preorder#checkout', :via => [:get,:post]
  match 'p/:slug/preorder/share/:uuid'     => 'preorder#share', :via => :get
  match 'p/:slug/preorder/ipn'             => 'preorder#ipn', :via => :post
  match 'p/:slug/preorder/prefill'         => 'preorder#prefill', :via => [:get,:post]
  match 'p/:slug/preorder/postfill'        => 'preorder#postfill', :via => [:get,:post]
end
