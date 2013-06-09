require 'spec_helper'

describe TrackingSubscription do
  before(:each) do
    @ts = TrackingSubscription.new
  end

  context "A tracking subscription (in general)" do
    it "should belong to a user" do
      user = User.new
      user.save
      @ts.user_id = user.id
      @ts.save

      @ts.user.id.should eq(user.id)
    end

    it "should belong to a tracking" do
      t = Tracking.new
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