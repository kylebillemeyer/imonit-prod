class CreateTrackings < ActiveRecord::Migration
  def change
    create_table :trackings do |t|
      t.int :measurement
      t.int :remaining
      t.int :threshold
      t.int :user_on_it

      t.timestamps
    end
  end
end
