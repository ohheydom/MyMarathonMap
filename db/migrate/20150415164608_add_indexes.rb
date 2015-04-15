class AddIndexes < ActiveRecord::Migration
  def change
    add_index :marathons, [:user_id, :state_id]
    add_index :users, :remember_token
  end
end
