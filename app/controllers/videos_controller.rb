class VideosController < ApplicationController
  before_action :authenticate_user!, except: %i(index new)

  # GET /videos
  def index
    @videos = Video.all.order(created_at: :desc)
  end

  def new
    if !current_user
      flash[:danger] = "Please sign in to share a video"
      redirect_to videos_path
    else
      @video = Video.new
    end
  end

  def create
    @video = Video.new(user: current_user, url: create_params[:url])

    if @video.save
      ActionCable.server.broadcast("new_video_channel", @video.as_json(include: :user))
      flash[:success] = "Video shared"
      redirect_to new_video_path
    else
      @flash_errors = @video.errors.full_messages
      flash[:danger] = "Video failed to share, please try again"
      render :new
    end
  end

  private

  def create_params
    params.require(:video).permit(:url)
  end
end
