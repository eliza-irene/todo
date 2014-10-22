require 'spec_helper'

describe "users pages" do 

  subject { page }
  describe "signup page GET /signup" do
    before { visit signup_path}

    it { should have_title("Todo | Sign Up") }
    it { should have_selector('h1', text: "Sign Up") }

    describe "signup POST /users" do
      let(:submit) { "Done"}

      context "valid information" do
        before do
          User.destroy_all
          fill_in "Name", with: "Liz"
          fill_in "Email", with: "elizabeth.korthof@gmail.com"
          fill_in "Password", with: "foobar"
          fill_in "Password confirmation", with: "foobar"
        end

        it  "creates user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end

        describe "after submission" do
          before { click_button submit }

          it { should have_title("Todo | Liz") }
          it { should have_selector('h1', text: "Liz") }
        end
      end

      context "invalid information" do
        it "does not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end

        describe "after submission" do
          before { click_button submit}

          it {should have_title('Todo | Sign Up')}
          it {should have_content('error')}
        end
      end
    end

  describe "show page GET /users/:id" do    
    before do
      User.destroy_all
      user = FactoryGirl.create(:user, name: "Liz", email: "elizabeth.korthof@gmail.com")
      visit user_path(user.id)
    end

    it { should have_title("Todo | Liz") }
    it { should have_selector('h1', "Liz") }
    it { should have_content('p', text: "Email: elizabeth.korthof@gmail.com")}
  end

  end 
end