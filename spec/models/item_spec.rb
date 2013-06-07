require 'spec_helper'

describe Item do
  before(:all) do
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

    after(:all) do
      Item.delete_all
      Tracking.delete_all
    end
  end
end