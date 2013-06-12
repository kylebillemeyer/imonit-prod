require 'spec_helper'

describe TrackingSubscription do
  before(:each) do
    @ts = FactoryGirl.build(:tracking_subscription)
  end

  context "A tracking subscription (in general)" do
    it "should belong to a user" do
      user = FactoryGirl.build(:user)
      user.save
      @ts.user_id = user.id
      @ts.save

      @ts.user.id.should eq(user.id)
    end

    it "should belong to a tracking" do
      t = FactoryGirl.build(:tracking)
      t.save
      @ts.tracking_id = t.id
      @ts.save

      @ts.tracking.id.should eq(t.id)
    end
  end

  after(:all) do
    TrackingSubscription.delete_all
    User.delete_all
    Tracking.delete_all
  end
end