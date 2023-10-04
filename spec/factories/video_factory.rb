FactoryBot.define do
  factory :video do
    url { "https://www.youtube.com/watch?v=b7ChuZdHHLc" }
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
