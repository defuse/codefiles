Codefiles::Application.routes.draw do

  match "/admin/login" => "user#login", :via => [:get]
  match "/admin/login" => "user#authenticate", :via => [:post]
  match "/admin/logout" => "user#logout", :via => [:post, :get]

  match "/admin" => "user#adminhome", :via => [:get]
  match "/admin/account" => "user#settings", :via => [:get]
  match "/admin/account" => "user#save_settings", :via => [:post]
  match "/admin/categories/" => "category#index", :via => [:get]
  match "/admin/categories/create" => "category#create", :via => [:post]
  match "/admin/categories/delete" => "category#delete", :via => [:post]
  match "/admin/categories/rename" => "category#rename", :via => [:post]
  match "/categories/:name" => "category_viewer#view", :via => [:get], :as => :category

  match "/admin/posts" => "post#index", :via => [:get]
  match "/admin/posts/new" => "post#new", :via => [:get]
  match "/admin/posts/new" => "post#save", :via => [:post]
  match "/admin/posts/edit/:id" => "post#edit", :via => [:get]
  match "/admin/posts/edit/:id" => "post#save", :via => [:post]
  match "/admin/posts/preview/:url_title" => "post#preview", :via => [:get]
  match "/admin/posts/delete" => "post#delete", :via => [:post]
  match "/admin/posts/hide" => "post#hide", :via => [:post]
  match "/admin/posts/unhide" => "post#unhide", :via => [:post]

  root :to => "post_viewer#latest", :via => [:get]
  match "/files" => "post_viewer#viewall", :via => [:get]
  match "/:abc/:xyz/:url_title" => "post_viewer#wp_redirect", :via => [:get]
  match "/:url_title" => "post_viewer#view", :via => [:get], :as => :post

end
