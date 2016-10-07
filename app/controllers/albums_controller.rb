class AlbumsController < ApplicationController
  before_action :require_login
  
  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to band_url(@album.band_id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def new
    @album = Album.new
    @bands = Band.all
    @current_band = Band.find_by_id(params[:band_id])
    render :new
  end

  def update
    @album = current_album

    if @album.update_attributes(album_params)
      redirect_to band_url(@album.band_id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = current_album
    band_id = @album.band_id
    @album.destroy

    redirect_to band_url(band_id)
  end

  def edit
    @album = current_album
    @current_band = Band.find_by_id(@album.band_id)
    @bands = Band.all

    render :edit
  end

  def show
    @album = current_album
    @current_band = Band.find_by_id(@album.band_id)
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :status, :name)
  end
end
