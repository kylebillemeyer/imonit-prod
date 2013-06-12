require 'spec_helper'

describe Group do
  before(:each) do
    @group = FactoryGirl.build(:group)
    @group.save
  end

  context "A group (in general)" do
    it "should have many users" do
      user = FactoryGirl.build(:user)
      user.groups.push(@group)
      user.save

      @group.users.count.should eq(1)
    end

    it "should have many trackings" do
      t = FactoryGirl.build(:tracking)
      t.group = @group
      t.save

      @group.trackings.count.should eq(1)
    end

    it "should delete all associated trackings when deleted" do
      t1 = FactoryGirl.build(:tracking)
      t2 = FactoryGirl.build(:tracking)
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

      user = FactoryGirl.build(:user)
      user.groups.push(@group)
      user.save

      @group.destroy

      GroupToUser.count.should eq(count)
    end

    it "should require name" do
      should validate_presence_of(:name) 
    end

    it "should allow any character" do
      should allow_value('asd#$#%61651').for(:name)
    end

    it "should allow for a description of more than 256 characters" do
      should allow_value('a'*257).for(:desc)
    end

    it "should default to an empty description" do
      group = FactoryGirl.build(:group, desc: nil)
      group.default_values
      group.desc.should eq('')
    end
  end

  after(:all) do
    Group.delete_all
    User.delete_all
    Tracking.delete_all
    GroupToUser.delete_all
  end
end