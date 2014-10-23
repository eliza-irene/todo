require 'spec_helper'

describe SessionsController, type: :controller do 
  describe "GET new" do
    it "renders :new" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    before do
      User.destroy_all
      @user = FactoryGirl.create(:user)
    end

    context "valid information" do
      it "signs in  user" do
        post :create, session: { email: @user.email, password: @user.password }
        controller.should be_signed_in
      end

      it "redirects to user#show" do
        post :create, session: { email: @user.email, password: @user.password }
        expect(response).to redirect_to(user_path(@user.id))
      end
    end

    context "invalid info" do
      it "does not sign in user" do
        post :create, session: { email: @user.email, password: "wrong-password" }
        controller.should_not be_signed_in  
      end    

      it "re-renders :new" do
        post :create, session: { email: @user.email, password: "wrong-password"}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE destroy" do
    # it "signs the user out"
    # it "redirects back to root page"
  end
end