class CreateTrackings < ActiveRecord::Migration
  def change
    create_table :trackings do |t|
      t.integer :measurement
      t.integer :remaining
      t.integer :threshold
      t.integer :user_on_it_id
      t.integer :group_id
      t.integer :item_id

      t.timestamps
    end
  end
end
