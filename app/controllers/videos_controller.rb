class VideosController < ApplicationController
  before_action :authenticate_user!, except: %i(index)

  # GET /videos
  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(user: current_user, url: create_params[:url])

    if @video.save
      flash[:success] = "Movie shared"
      redirect_to new_video_path
    else
      @flash_errors = @video.errors.full_messages
      flash[:danger] = "Movie failed to share, please try again"
      render :new
    end
  end

  private

  def create_params
    params.require(:video).permit(:url)
  end
end
