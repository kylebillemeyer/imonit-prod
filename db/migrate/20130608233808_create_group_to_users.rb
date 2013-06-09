class CreateGroupToUsers < ActiveRecord::Migration
  def change
    create_table "group_to_users", :id => false do |t|
      t.column "group_id", :integer, :null => false
      t.column "user_id",  :integer, :null => false
    end
  end
end
