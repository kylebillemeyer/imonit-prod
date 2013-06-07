class CreateGroupsUsers < ActiveRecord::Migration
  def change
    create_table "groups_users", :id => false do |t|
      t.column "group_id", :integer, :null => false
      t.column "user_id",  :integer, :null => false
    end
  end
end
