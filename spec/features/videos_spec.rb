require "rails_helper"

RSpec.describe "the signin process" do
  shared_examples "not logged in" do |parameter|
    it "show home page with login button" do
      visit root_path

      expect(page).to have_selector("input[value='Login/Sign up']")
      expect(page).to have_selector("input[placeholder='Email']")
      expect(page).to have_selector("input[placeholder='Password']")
    end
  end

  describe "first visit" do
    include_examples "not logged in"
  end

  describe "click login sign up with empty value" do
    it "show error" do
      visit root_path

      click_button("Login/Sign up")
      expect(page).to have_content("Email can't be blank, Password can't be blank")
    end
  end

  describe "fill in email and password" do
    let(:password) { "123456" }
    let!(:user) { create(:user, email: "test@mail.com", password: password) }

    context "correct info" do
      it "sign in" do
        visit root_path
        fill_in "Email", with: user.email
        fill_in "Password", with: password
        click_on("Login/Sign up")

        expect(page).to have_content("Signed in")
      end
    end

    context "incorrect info" do
      it "sign in" do
        visit root_path
        fill_in "Email", with: user.email
        fill_in "Password", with: "#{password}abc"
        click_on("Login/Sign up")

        expect(page).to have_content("Wrong password")
      end
    end

    context "new info" do
      it "sign up" do
        visit root_path
        fill_in "Email", with: "new@mail.com"
        fill_in "Password", with: password
        click_on("Login/Sign up")

        expect(page).to have_content("Account created")
        expect(User.last.email).to eq("new@mail.com")
      end
    end
  end

  describe "sign out" do
    let(:password) { "123456" }
    let!(:user) { create(:user, email: "test@mail.com", password: password) }

    context "correct info" do
      before do
        visit root_path
        fill_in "Email", with: user.email
        fill_in "Password", with: password
        click_on("Login/Sign up")
        click_on("Sign out")
      end

      include_examples "not logged in"
    end
  end
end
