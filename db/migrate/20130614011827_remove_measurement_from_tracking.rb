class RemoveMeasurementFromTracking < ActiveRecord::Migration
  def up
    remove_column :trackings, :measurement
  end

  def down
    add_column :trackings, :measurement, :integer
  end
end
