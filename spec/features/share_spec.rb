require "rails_helper"

RSpec.describe "share video" do
  let(:password) { "123456" }
  let!(:user) { create(:user, email: "test@mail.com", password: password) }
  let(:api_key) { ENV["YOUTUBE_API_KEY"] }

  describe "share video" do
    before do
      stub_request(:get, "https://www.googleapis.com/youtube/v3/videos?id=6UuLD-0lndY&key=#{api_key}&part=snippet").
        to_return(status: 200, body: {
          "items": [
            {
              "snippet": {
                "title": "Sample Video Title",
                "description": "Sample Video Description"
              }
            }
          ]
        }.to_json
      )
    end

    it "correctly share video" do
      visit root_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
      click_on("Login/Sign up")

      visit new_video_path
      fill_in "video_url", with: "https://www.youtube.com/watch?v=6UuLD-0lndY"
      click_on "Submit"

      expect(page).to have_content "Video shared"
    end

    context "invalid url" do
      it "does not share video" do
        visit root_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: password
        click_on("Login/Sign up")

        visit new_video_path
        fill_in "video_url", with: "aa"
        click_on "Submit"

        expect(page).to have_content "Video failed to share, please try again"
      end
    end
  end
end
