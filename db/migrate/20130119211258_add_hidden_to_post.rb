class AddHiddenToPost < ActiveRecord::Migration
  def change
    add_column :posts, :hidden, :integer, :default => 0
  end
end
