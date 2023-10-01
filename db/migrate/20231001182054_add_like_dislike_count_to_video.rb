class AddLikeDislikeCountToVideo < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :like_count, :integer, default: 0
    add_column :videos, :dislike_count, :integer, default: 0
  end
end
