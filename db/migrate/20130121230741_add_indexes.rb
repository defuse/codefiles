class AddIndexes < ActiveRecord::Migration
  def up
    add_index( "categories", "name", :unique => true )
    add_index( "categories_posts", "category_id" )
    add_index( "categories_posts", "post_id" )
    add_index( "posts", "url_title", :unique => true )
    add_index( "users", "name", :unique => true )
  end

  def down
    remove_index( "categories", :column => "name" )
    remove_index( "categories_posts", :column => "category_id" )
    remove_index( "categories_posts",:column => "post_id" )
    remove_index( "posts", "url_title", :column => "url_title" )
    remove_index( "users", "name",:column => "name" )
  end
end
