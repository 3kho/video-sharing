class AddYoutubeVideoIdToVideo < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :youtube_video_id, :string
  end
end
