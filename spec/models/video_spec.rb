require "rails_helper"

RSpec.describe Video, type: :model do
  let(:user) { create(:user) }
  let(:url) { "https://www.youtube.com/watch?v=DdjWGbPUmrg" }
  let(:subject) { described_class.new }
  let(:api_key) { ENV["YOUTUBE_API_KEY"] }

  describe "validation" do
    it "does not valid if invalid youtube url" do
      subject.user = user
      subject.url = "123"
      expect(subject).to_not be_valid
    end

    it "valid if valid youtube url" do
      subject.user = user
      subject.url = url
      expect(subject).to be_valid
    end
  end

  describe "before_save hooks" do
    context "assign_youtube_video_id" do
      let!(:video) { create(:video, user: user, url: url, skip_callbacks: true) }

      it "assign youtube video id" do
        expect(video.youtube_video_id).to eq("DdjWGbPUmrg")
      end
    end

    context "fetch_title_and_description" do
      before do
        stub_request(:get, "https://www.googleapis.com/youtube/v3/videos?id=DdjWGbPUmrg&key=#{api_key}&part=snippet").
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

      it "calls api" do
        video = Video.new(url: url, user: user)
        video.save
        expect(video.title).to eq("Sample Video Title")
      end
    end
  end
end

# == Schema Information
#
# Table name: videos
#
#  id               :bigint           not null, primary key
#  description      :text
#  dislike_count    :integer          default(0)
#  like_count       :integer          default(0)
#  title            :string
#  url              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#  youtube_video_id :string
#
# Indexes
#
#  index_videos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
