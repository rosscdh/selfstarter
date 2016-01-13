Selfstarter::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #root :to => 'preorder#index'
  root :to => 'project#index'

  get 'projects/:slug'                            => 'project#detail'

  match 'projects/:slug/preorder'                 => 'preorder#index', :via => [:get,:post]
  match 'projects/:slug/preorder/checkout'        => 'preorder#checkout', :via => [:get,:post]
  match 'projects/:slug/preorder/share/:uuid'     => 'preorder#share', :via => :get
  match 'projects/:slug/preorder/ipn'             => 'preorder#ipn', :via => :post
  match 'projects/:slug/preorder/prefill'         => 'preorder#prefill', :via => [:get,:post]
  match 'projects/:slug/preorder/postfill'        => 'preorder#postfill', :via => [:get,:post]
end
