require 'spec_helper'

describe Item do
  before(:each) do
    @item = FactoryGirl.build(:item)
    @item.save
  end

  context "An item (in general)" do
    it "should have many trackings" do
      t = FactoryGirl.build(:tracking)
      t.item = @item
      t.save

      @item.trackings.count.should eq(1)
    end

    it "should delete all associated trackings when deleted" do
      t1 = FactoryGirl.build(:tracking)
      t2 = FactoryGirl.build(:tracking)
      t1.item = @item
      t2.item = @item

      Tracking.transaction do
        @count = Tracking.count
        t1.save
        t2.save
      end

      @item.destroy

      Tracking.count.should eq(@count)
    end

    it "should require name" do
      should validate_presence_of(:name)
    end
    it "should allow any character" do
      should allow_value('asd#$#%61651').for(:name) 
    end

    it "should allow for description to be more than 256 characters" do
      should allow_value('a'*257).for(:desc)
    end  
    it "should default to an empty description" do
      item = FactoryGirl.build(:item, desc: nil)
      item.default_values
      item.desc.should eq('')
    end
  end

  after(:all) do
      Item.delete_all
      Tracking.delete_all
    end
end