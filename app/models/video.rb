class Video < ApplicationRecord
  attr_accessor :skip_callbacks

  belongs_to :user

  YOUTUBE_REGEX = /\A.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/

  validates :url, presence: true, format: { with: YOUTUBE_REGEX }

  before_save :assign_youtube_video_id
  before_save :fetch_title_and_description

  private

  def assign_youtube_video_id
    self.youtube_video_id = self.url.match(YOUTUBE_REGEX)[7]
  end

  def fetch_title_and_description
    return if skip_callbacks

    response = Faraday.get("https://www.googleapis.com/youtube/v3/videos?part=snippet&id=#{self.youtube_video_id}&key=#{ENV['YOUTUBE_API_KEY']}")

    if response.status == 200
      self.title = JSON.parse(response.body)["items"][0]["snippet"]["title"]
      self.description = JSON.parse(response.body)["items"][0]["snippet"]["description"]
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
