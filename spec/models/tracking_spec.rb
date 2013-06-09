require 'spec_helper'

describe Tracking do
  before(:each) do
    @t = Tracking.new
    @t.save
  end

  context "A tracking (in general)" do
    it "should have many tracking subscriptions" do
      ts = TrackingSubscription.new
      ts.tracking = @t
      ts.save

      @t.tracking_subscriptions.count.should eq(1)
    end

    it "should belong to a group" do
      group = Group.new
      group.save
      @t.group_id = group.id
      @t.save

      @t.group.id.should eq(group.id)
    end

    it "should belong to an item" do
      item = Item.new
      item.save
      @t.item_id = item.id
      @t.save

      @t.item.id.should eq(item.id)
    end

    it "should belong to a user on it" do
      uoi = User.new
      uoi.save
      @t.user_on_it_id = uoi.id
      @t.save

      @t.user_on_it.id.should eq(uoi.id)
    end

    it "should delete all associated tracking subscriptions when deleted" do
      ts1 = TrackingSubscription.new
      ts2 = TrackingSubscription.new
      ts1.tracking = @t
      ts2.tracking = @t

      TrackingSubscription.transaction do
        @count = TrackingSubscription.count
        ts1.save
        ts2.save
      end

      @t.destroy

      TrackingSubscription.count.should eq(@count)
    end
  end

  after(:all) do
    Tracking.delete_all
    Group.delete_all
    TrackingSubscription.delete_all
    Item.delete_all
    User.delete_all
  end
end