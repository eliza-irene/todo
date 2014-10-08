require 'spec_helper'

describe "static pages" do

subject { page }

  describe "home page" do 
    before { visit home_path }
    it { should have_selector('h1', "Welcome")}
    it { should have_title("Todo | Home") }
  end

  describe "about" do 
    before { visit about_path }
    it { should have_selector('h1', "About Me")}
    it { should have_title("Todo | About Me") }
  end

  describe "help" do
    before { visit help_path }
    it { should have_selector('h1', "Help / FAQ")}
    it { should have_title("Todo | Help") }
  end
end