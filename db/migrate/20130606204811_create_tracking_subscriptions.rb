class CreateTrackingSubscriptions < ActiveRecord::Migration
  def change
    create_table :tracking_subscriptions do |t|

      t.timestamps
    end
  end
end
