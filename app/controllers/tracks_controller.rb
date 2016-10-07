class TracksController < ApplicationController
  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to album_url(@track.album_id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def new
    @track = Track.new
    @current_album = Album.find_by_id(params[:album_id])
    @albums = Album.where(band_id: @current_album.band.id)
    render :new
  end

  def update
    @track = current_track

    if @track.update_attributes(track_params)
      redirect_to album_url(@track.album_id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = current_track
    album_id = @track.album_id
    @track.destroy

    redirect_to album_url(album_id)
  end

  def edit
    @track = current_track
    @current_album = Album.find_by_id(@track.album_id)
    @albums = Album.where(band_id: @current_album.band.id)

    render :edit
  end

  def show
    @track = current_track
    # @current_album = Album.find_by(params[:band_id])
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :status, :name)
  end
end
