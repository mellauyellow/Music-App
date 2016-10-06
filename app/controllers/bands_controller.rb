class BandsController < ApplicationController
  def index
    @bands = Band.all

    render :index
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def new
    @band = Band.new
    render :new
  end

  def update
    @band = current_band
    if @band.update_attributes(band_params)
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  def edit
    @band = current_band

    render :edit
  end

  def show
    @band = current_band
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
