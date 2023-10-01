class VideosController < ApplicationController
  # GET /videos
  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
  end
end
