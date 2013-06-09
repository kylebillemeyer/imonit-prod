require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new(:email => 'kyle@example.com', :first => 'kyle', :last => 'billemeyer')
    @user.save
  end

  context "A user (in general)" do
    it "should have many groups" do
      group = Group.new
      group.users.push(@user)
      group.save

      @user.groups.count.should eq(1)
    end

    it "should have many tracking subscriptions" do
      ts = TrackingSubscription.new
      ts.user = @user
      ts.save

      
      @user.tracking_subscriptions.count.should eq(1)
    end

    it "should have many trackings" do
      t = Tracking.new
      t.user_on_it = @user
      t.save

      @user.trackings.count.should eq(1)
    end

    it "should delete all associated tracking subscriptions when deleted" do
      ts1 = TrackingSubscription.new
      ts2 = TrackingSubscription.new
      ts1.user = @user
      ts2.user = @user

      TrackingSubscription.transaction do
        @count = TrackingSubscription.count
        ts1.save
        ts2.save
      end

      @user.destroy

      TrackingSubscription.count.should eq(@count)
    end

    it "should delete all associated groups_users entries when deleted" do
      count = GroupToUser.count

      group = Group.new
      group.users.push(@user)
      group.save

      @user.destroy

      GroupToUser.count.should eq(count)
    end
  end

  after(:all) do
    User.delete_all
    Group.delete_all
    TrackingSubscription.delete_all
    Tracking.delete_all
    GroupToUser.delete_all
  end
end