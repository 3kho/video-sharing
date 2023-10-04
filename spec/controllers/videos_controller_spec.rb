require "rails_helper"

RSpec.describe VideosController, type: :controller do
  describe "index" do
    let!(:user) { create(:user) }
    let(:videos) { create_list(:video, 5, user: user, skip_callbacks: true) }

    it "load videos" do
      get :index

      expect(controller.instance_variable_get(:@videos)).to match_array(videos)
    end
  end

  describe "create" do
    let!(:user) { create(:user) }
    let(:url) { "https://www.youtube.com/watch?v=cZINeaDjisY" }
    let(:api_key) { ENV["YOUTUBE_API_KEY"] }

    context "logged in" do
      before do
        stub_request(:get, "https://www.googleapis.com/youtube/v3/videos?id=cZINeaDjisY&key=#{api_key}&part=snippet").
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

        sign_in user
      end

      it "create video" do
        post :create, params: { video: { url: url } }

        expect(flash[:success]).to eq("Video shared")
        expect(user.videos.last.url).to eq(url)
      end

      it "does not create video when error" do
        post :create, params: { video: { url: "123" } }
        expect(flash[:danger]).to eq("Video failed to share, please try again")
        expect(user.videos.count).to eq(0)
      end
    end
  end
end
