require 'spec_helper'


describe User do

  admin_user = User.new
  admin_user.pid = "spec-admin-pid" #jacs pid
  admin_user.name = "John Doe"

  depositor_user = User.new
  depositor_user.pid = "any_pid"
  depositor_user.name = "Jane Doe"

  guest_user = User.new


  # Check admin permissions
  it "check to see if @admin_user is admin" do
    admin_user.admin?.should be_true
  end

  it "check to see if @depositor_user is admin" do
    depositor_user.admin?.should be_false
  end

  it "check to see if @guest_user is admin" do
    guest_user.admin?.should be_false
  end


  # Check depositor permission
  it "check to see if @admin_user is depositor" do
    admin_user.depositor?.should be_true
  end

  it "check to see if @depositor_user is depositor" do
    depositor_user.depositor?.should be_true
  end

  it "check to see if @guest_user is depositor" do
    guest_user.depositor?.should be_false
  end


  # Check attributes
  it "depositor and admin should have name" do
       admin_user.name.blank?.should be_false
       depositor_user.name.blank?.should be_false
  end

  it "guest should not have name" do
    guest_user.name.blank?.should be_true
  end










end
