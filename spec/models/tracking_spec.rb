require 'spec_helper'
require 'enumerize/integrations/rspec.rb'

describe Tracking do
  before(:each) do
    @t = FactoryGirl.build(:tracking)
    @t.save
  end

  context "A tracking (in general)" do
    it "should have many tracking subscriptions" do
      ts = FactoryGirl.build(:tracking_subscription)
      ts.tracking = @t
      ts.save

      @t.tracking_subscriptions.count.should eq(1)
    end

    it "should belong to a group" do
      group = FactoryGirl.build(:group)
      group.save
      @t.group_id = group.id
      @t.save

      @t.group.id.should eq(group.id)
    end

    it "should belong to an item" do
      item = FactoryGirl.build(:item)
      item.save
      @t.item_id = item.id
      @t.save

      @t.item.id.should eq(item.id)
    end

    it "should belong to a user on it" do
      uoi = FactoryGirl.build(:user)
      uoi.save
      @t.user_on_it_id = uoi.id
      @t.save

      @t.user_on_it.id.should eq(uoi.id)
    end

    it "should delete all associated tracking subscriptions when deleted" do
      ts1 = FactoryGirl.build(:tracking_subscription)
      ts2 = FactoryGirl.build(:tracking_subscription)
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

    it "should require remaining" do
      should validate_presence_of(:remaining) 
    end
    it "should not allow negative numbers" do
      should_not allow_value(-1).for(:remaining)
    end

    it "should require threshold" do
      should validate_presence_of(:threshold)
    end
    it "should not allow negative numbers" do
      should_not allow_value(-1).for(:threshold)
    end

    it "should require measurement" do
      should validate_presence_of(:measurement)
    end
    it "should be enumerated" do
      should enumerize(:measurement).in(:count, :cm, :in, :ft, :m, :yd, :lbs, :fl_oz, :g, :oz, :kg, :lbs, :liters, :gal).with_default(:count) 
    end

    it "should be optional" do
      should allow_value(nil).for(:user_on_it)
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