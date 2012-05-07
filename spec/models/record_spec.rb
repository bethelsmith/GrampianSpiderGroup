require 'spec_helper'

describe Record do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = {
      :date => Date.today,
      :species => "Arianella cucurbitina",
      :location => "Aberdeenshire",
      :grid_ref => "NJ40",
      :latitude => "57.087070",
      :longitude => "-2.991625"
    }
  end
  
  it "should create a new instance given valid attributes" do
    @user.records.create!(@attr)
  end
  
  describe "user associations" do
  
    before(:each) do
      @record = @user.records.create(@attr)
    end
  
    it "should have a user attribute" do
      @record.should respond_to(:user)
    end

    it "should have the right associated user" do
      @record.user_id.should == @user.id
      @record.user.should == @user
    end
  
  end
  
  describe "validations" do

    it "should require a user id" do
      Record.new(@attr).should_not be_valid
    end

    it "should require a date" do
      @user.records.build(:date => "").should_not be_valid
    end
    
    it "should require a species" do
      @user.records.build(:species => "").should_not be_valid
    end
    
    it "should require a location" do
      @user.records.build(:location => "").should_not be_valid
    end
      
    it "should require a grid reference" do
      @user.records.build(:grid_ref => "").should_not be_valid
    end
    
    it "should require a latitude" do
      @user.records.build(:latitude => "").should_not be_valid
    end
  
    it "should require a longitude" do
      @user.records.build(:longitude => "").should_not be_valid
    end
    
    it "should reject comments that are too long" do
      @user.records.build(:comments => "a" * 101).should_not be_valid
    end
    
    it "should reject grid references that are too long" do
      @user.records.build(:grid_ref => "a" * 15).should_not be_valid
    end
    
    
    it "should accept valid grid references" do
      @record = @user.records.create(@attr)
      grids = %w[SH NP1234 OF1234567890]
      grids.each do |valid_grid|
        @record.grid_ref = valid_grid
        @record.should be_valid
      end
    end
    
    it "should reject invalid grid references" do
      @record = @user.records.create(@attr)
      grids = %w[SH123 SH12D NI1234 1234]
      grids.each do |invalid_grid|
        @record.grid_ref = invalid_grid
        @record.should_not be_valid
      end
    end
  end
  
end
