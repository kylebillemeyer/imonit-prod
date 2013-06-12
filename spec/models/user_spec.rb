require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.build(:user)
    @user.save
  end

  context "A user (in general)" do
    it "should have many groups" do
      group = FactoryGirl.build(:group)
      group.users.push(@user)
      group.save

      @user.groups.count.should eq(1)
    end

    it "should have many tracking subscriptions" do
      ts = FactoryGirl.build(:tracking_subscription)
      ts.user = @user
      ts.save

      
      @user.tracking_subscriptions.count.should eq(1)
    end

    it "should have many trackings" do
      t = FactoryGirl.build(:tracking)
      t.user_on_it = @user
      t.save

      @user.trackings.count.should eq(1)
    end

    it "should delete all associated tracking subscriptions when deleted" do
      ts1 = FactoryGirl.build(:tracking_subscription)
      ts2 = FactoryGirl.build(:tracking_subscription)
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

    it "should nullify all associated 'user_on_it' from tracking when deleted" do
      t1 = FactoryGirl.build(:tracking)
      t1.user_on_it = @user
      t1.save

      @user.destroy

      Tracking.find(t1.id).user_on_it.should be_nil
    end

    it "should delete all associated groups_users entries when deleted" do
      count = GroupToUser.count

      group = FactoryGirl.build(:group)
      group.users.push(@user)
      group.save

      @user.destroy

      GroupToUser.count.should eq(count)
    end

    it "should require email address" do
      should validate_presence_of(:email)
    end
    it "should have unique email addresses" do 
      should validate_uniqueness_of(:email)
    end
    it "should not allow invalid email addresses" do
      should_not allow_value('', 'a', '@', '@a', 'a@', 'a@a', 'a@a.', 'a@.a').for(:email)
    end
    it "should allow valid email addresses" do
      should allow_value('a1@a1.a1', 'a1.a1@a1.a1').for(:email)
    end

    it "should require first name" do
      should validate_presence_of(:first)
    end
    it "should allow any character" do
      should allow_value('asd#$#%61651').for(:first)
    end

    it "should allow any character" do
      should allow_value('asd#$#%61651').for(:last)
    end
    it "should default to an empty last name" do
      user = FactoryGirl.build(:user, last: nil)
      user.default_values
      user.last.should eq('')
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