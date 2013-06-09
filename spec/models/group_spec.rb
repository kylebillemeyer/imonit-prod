require 'spec_helper'

describe Group do
  before(:each) do
    @group = Group.new(:desc => 'test description')
    @group.save
  end

  context "A group (in general)" do
    it "should have many users" do
      user = User.new
      user.groups.push(@group)
      user.save

      @group.users.count.should eq(1)
    end

    it "should have many trackings" do
      t = Tracking.new
      t.group = @group
      t.save

      @group.trackings.count.should eq(1)
    end

    it "should delete all associated trackings when deleted" do
      t1 = Tracking.new
      t2 = Tracking.new
      t1.group = @group
      t2.group = @group

      Tracking.transaction do
        @count = Tracking.count
        t1.save
        t2.save
      end

      @group.destroy

      Tracking.count.should eq(@count)
    end

    it "should delete all associated groups_users entries when deleted" do
      count = GroupToUser.count

      user = User.new
      user.groups.push(@group)
      user.save

      @group.destroy

      GroupToUser.count.should eq(count)
    end
  end

  after(:all) do
    Group.delete_all
    User.delete_all
    Tracking.delete_all
    GroupToUser.delete_all
  end
end