class NewVideoChannel < ApplicationCable::Channel
  def subscribed
    stream_from "new_video_channel"
  end

  def unsubscribed
    # stop_all_streams
  end

end
