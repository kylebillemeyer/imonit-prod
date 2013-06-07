require 'spec_helper'

describe User do
  before(:all) do
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
  end

  after(:all) do
    User.delete_all
    Group.delete_all
    TrackingSubscription.delete_all
    Tracking.delete_all
  end
end