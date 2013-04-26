class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url_title
      t.string :title
      t.text :body
      t.datetime :release_date
      t.datetime :modify_date

      t.timestamps
    end
  end
end
