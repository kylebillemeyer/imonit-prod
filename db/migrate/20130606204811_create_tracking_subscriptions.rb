class CreateTrackingSubscriptions < ActiveRecord::Migration
  def change
    create_table :tracking_subscriptions do |t|
      t.integer :user_id
      t.integer :tracking_id

      t.timestamps
    end
  end
end
