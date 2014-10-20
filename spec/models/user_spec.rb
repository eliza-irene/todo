require 'spec_helper'

describe User do 
  before { @user = User.new(name: "Liz Korthof", email: "elizabeth.korthof@google.com")}

  subject {@user}

  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should be_valid }  
end

describe "validations" do
  describe "name" do
    context "not present" do 
      before { @user.name = " " }
      it { should_not be_valid }
    end

    context "too long" do
      before { @user.name = "a" * 51 }
      it { should_not be_valid }
    end
  end

  describe "email" do
    context "not present" do
    end

    context "too long" do
    end

    context "correct format" do
    end

    context "incorrect format" do
    end

    context "mixed case" do
    end

    context "when already taken" do
      before do
      end

      it { should_not be_valid }

      User.destroy_all
    end
  end
end