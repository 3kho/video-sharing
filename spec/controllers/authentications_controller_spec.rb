require "rails_helper"

RSpec.describe AuthenticationsController, type: :controller do
  describe "#create" do
    let(:email) { "test@test.com" }
    let(:password) { "123456" }

    context "new account" do
      it "create new account and sign in adn redirect" do
        post :create, params: { email: email, password: password }

        expect(response).to redirect_to(root_path)
        expect(User.last.email).to eq(email)
        expect(flash[:success]).to eq("Account created")
      end
    end

    context "sign in existing account" do
      let!(:user) { create(:user, email: email, password: password) }

      context "correct credential" do
        it "sign in" do
          post :create, params: { email: email, password: password }

          expect(response).to redirect_to(root_path)
          expect(flash[:success]).to eq("Signed in")
          expect(controller.current_user.id).to eq(user.id)
        end
      end

      context "wrong credential" do
        it "does not sign in" do
          post :create, params: { email: email, password: "#{password}aaa" }

          expect(response).to redirect_to(root_path)
          expect(flash[:danger]).to eq("Wrong password")
          expect(controller.current_user).to eq(nil)
        end
      end
    end
  end

  describe "destroy" do
    let(:email) { "test@test.com" }
    let(:password) { "123456" }

    before do
      post :create, params: { email: email, password: password }
    end

    it "sign out" do
      post :destroy
      expect(response).to redirect_to(root_path)
      expect(flash[:success]).to eq("Signed out")
    end
  end
end
