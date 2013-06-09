require 'spec_helper'

describe Item do
  before(:each) do
    @item = Item.new(:name => 'test item', :desc => 'test description')
    @item.save
  end

  context "An item (in general)" do
    it "should have many trackings" do
      t = Tracking.new
      t.item = @item
      t.save

      @item.trackings.count.should eq(1)
    end

    it "should delete all associated trackings when deleted" do
      t1 = Tracking.new
      t2 = Tracking.new
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

    after(:all) do
      Item.delete_all
      Tracking.delete_all
    end
  end
end