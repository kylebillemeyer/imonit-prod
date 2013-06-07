require 'spec_helper'

describe Group do
  before(:all) do
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
  end

  after(:all) do
    Group.delete_all
    User.delete_all
    Tracking.delete_all
  end
end