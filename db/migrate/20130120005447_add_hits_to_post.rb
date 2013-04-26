class AddHitsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :hits, :integer
  end
end
