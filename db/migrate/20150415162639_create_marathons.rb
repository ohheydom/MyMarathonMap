class CreateMarathons < ActiveRecord::Migration
  def change
    create_table :marathons do |t|
      t.integer :user_id
      t.integer :state_id
      t.string :city
      t.integer :time
      t.datetime :created_at
      t.datetime :updated_at
      t.date :date_of_marathon

      t.timestamps null: false
    end
  end
end
